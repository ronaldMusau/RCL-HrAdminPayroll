report 51525394 "Attendance Report"
{
    ApplicationArea = All;
    Caption = 'Attendance Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Attendance Report.rdlc';
    dataset
    {
        dataitem(AttendanceEntry; "Attendance Entry")
        {
            //RequestFilterFields = "AC-No.";
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(ACNo; "AC-No.")
            {
            }
            column(StaffName; "Staff Name")
            {
            }
            column(Department; Department)
            {
            }
            column(Date; "Date")
            {
            }
            column(ClockIn; "Clock In")
            {
            }
            column(ClockOut; "Clock Out")
            {
            }
            column(WorkTime; "Work Time")
            {
            }
            column(WorkTimeSeconds; WorkTimeSeconds)
            { }
            column(StartDateFilter; StartDate) { }
            column(EndDateFilter; EndDate) { }
            trigger OnPreDataItem()
            begin
                // Apply date range filter before data is fetched
                if (StartDate <> 0D) or (EndDate <> 0D) then begin
                    if StartDate <> 0D then
                        SetFilter("Date", '>=%1', StartDate);
                    if EndDate <> 0D then
                        SetFilter("Date", '<=%1', EndDate);
                    if (StartDate <> 0D) and (EndDate <> 0D) then
                        SetRange("Date", StartDate, EndDate);
                end;
                if ACNoFilter <> '' then
                    SetRange("AC-No.", ACNoFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                WorkTimeSeconds := "Work Time" / 1000;  // convert ms → seconds
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    Caption = 'Date Filter';

                    field(StartDateField; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Specifies the start date for the attendance report.';
                    }
                    field(EndDateField; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the end date for the attendance report.';
                    }
                }
                group(EmployeeFilter)
                {
                    Caption = 'Employee Filter';
                    ShowCaption = true;

                    field(ACNoField; ACNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'AC-No.';
                        ToolTip = 'Type or look up an employee AC number to filter the report.';
                        // NO TableRelation here — that was causing the error

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            AttEntry: Record "Attendance Entry";
                            TempAttEntry: Record "Attendance Entry" temporary;
                        begin
                            // Build distinct AC-No. list into a temp table
                            AttEntry.Reset();
                            if AttEntry.FindSet() then
                                repeat
                                    TempAttEntry.Init();
                                    TempAttEntry."Entry No." := AttEntry."Entry No.";
                                    TempAttEntry."AC-No." := AttEntry."AC-No.";
                                    TempAttEntry."Staff Name" := AttEntry."Staff Name";
                                    TempAttEntry.Department := AttEntry.Department;
                                    if TempAttEntry.Insert(false) then;
                                until AttEntry.Next() = 0;

                            // Show the lookup page with the temp data
                            TempAttEntry.Reset();
                            if Page.RunModal(Page::"Attendance Entry Admin", TempAttEntry) = Action::LookupOK then begin
                                ACNoFilter := TempAttEntry."AC-No.";
                                Text := ACNoFilter;
                                exit(true);
                            end;
                            exit(false);
                        end;

                        trigger OnValidate()
                        var
                            AttEntry: Record "Attendance Entry";
                        begin
                            if ACNoFilter <> '' then begin
                                AttEntry.SetRange("AC-No.", ACNoFilter);
                                if AttEntry.IsEmpty() then
                                    Error('AC-No. "%1" does not exist in Attendance Entry.', ACNoFilter);
                            end;
                        end;
                    }
                }

            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";
        WorkTimeSeconds: Decimal;
        StartDate: Date;
        EndDate: Date;
        ACNoFilter: Code[20];
}
