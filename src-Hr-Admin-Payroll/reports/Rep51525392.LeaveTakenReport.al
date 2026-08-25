report 51525392 "Leave Taken Report"
{
    Caption = 'Leave Taken Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep51525392.LeaveTakenReport.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(CompanyInformation; "Company Information")
        {
            column(Logo; Picture) { }
            column(CompanyName; Name) { }
            column(CompanyAddress; Address) { }
            column(CompanyPhone; "Phone No.") { }
            column(PrintDate; Format(Today, 0, '<Day,2>/<Month,2>/<Year4>')) { }

            dataitem(LeaveApplication; "Employee Leave Application")
            {
                RequestFilterFields = "Employee No", "Leave Type", "Start Date", "End Date", "Leave Period";
                DataItemTableView = SORTING("Employee No", "Start Date")
                    WHERE(Status = FILTER(Released | Posted));

                column(ApplicationNo; "Application No") { }
                column(EmployeeNo; "Employee No") { }
                column(EmployeeName; "Employee Name") { }
                column(Department; "Department Code") { }
                column(LeaveType; "Leave Type") { }
                column(StartDate; Format("Start Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                column(EndDate; Format("End Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                column(ResumptionDate; Format("Resumption Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                column(DaysApplied; "Days Applied") { }
                column(ApprovedDays; EffectiveDays) { }
                column(Status; Format(Status)) { }
                column(Posted; Posted) { }
                column(LeavePeriod; "Leave Period") { }

                trigger OnAfterGetRecord()
                begin
                    if "Approved Days" > 0 then
                        EffectiveDays := "Approved Days"
                    else
                        EffectiveDays := "Days Applied";
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Filters';
                }
            }
        }
        actions { }
    }

    var
        EffectiveDays: Decimal;
}
