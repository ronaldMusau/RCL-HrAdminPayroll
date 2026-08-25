report 51525391 "Leave Balance Summary"
{
    Caption = 'Leave Balance Summary';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep51525391.LeaveBalanceSummary.rdlc';
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
            column(LeavePeriodFilter; LeavePeriod) { }

            dataitem(Employee; Employee)
            {
                RequestFilterFields = "No.", "Responsibility Center";
                DataItemTableView = SORTING("No.");

                column(EmployeeNo; "No.") { }
                column(EmployeeName; FullName) { }
                column(Department; "Global Dimension 2 Code") { }
                column(JobTitle; "Job Title") { }
                column(TotalAllocated; TotalAllocated) { }
                column(TotalAccrued; TotalAccrued) { }
                column(TotalCarryForward; TotalCarryForward) { }
                column(TotalTaken; TotalTaken) { }
                column(TotalBalance; TotalBalance) { }
                dataitem("Employee Leave Application"; "Employee Leave Application")
                {
                    DataItemLink = "Employee No" = field("No.");
                    RequestFilterFields = "Leave Type";
                    column(Leave_Type; "Leave Type")
                    {
                    }
                }
                trigger OnAfterGetRecord()
                var
                    LedgerEntry: Record "HR Leave Ledger Entries";
                begin
                    TotalAllocated := 0;
                    TotalAccrued := 0;
                    TotalCarryForward := 0;
                    TotalTaken := 0;
                    TotalBalance := 0;

                    // Allocation
                    LedgerEntry.Reset();
                    LedgerEntry.SetRange("Staff No.", "No.");
                    LedgerEntry.SetRange("Leave Period", LeavePeriod);
                    LedgerEntry.SetRange("Leave Entry Type", LedgerEntry."Leave Entry Type"::Positive);
                    LedgerEntry.SetRange(IsMonthlyAccrued, false);
                    if (StartDate <> 0D) and (EndDate <> 0D) then begin
                        LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    end;
                    LedgerEntry.CalcSums("No. of days");
                    TotalAllocated := LedgerEntry."No. of days";

                    // Accrued
                    LedgerEntry.Reset();
                    LedgerEntry.SetRange("Staff No.", "No.");
                    LedgerEntry.SetRange("Leave Period", LeavePeriod);
                    LedgerEntry.SetRange(IsMonthlyAccrued, true);
                    if (StartDate <> 0D) and (EndDate <> 0D) then begin
                        LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    end;
                    LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    LedgerEntry.CalcSums("No. of days");
                    TotalAccrued := LedgerEntry."No. of days";

                    // Carry Forward
                    LedgerEntry.Reset();
                    LedgerEntry.SetRange("Staff No.", "No.");
                    LedgerEntry.SetRange("Leave Period", LeavePeriod);
                    LedgerEntry.SetFilter("Leave Type", 'CF|CARRY FORWARD');
                    LedgerEntry.SetRange("Leave Entry Type", LedgerEntry."Leave Entry Type"::Positive);
                    if (StartDate <> 0D) and (EndDate <> 0D) then begin
                        LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    end;
                    TotalCarryForward := LedgerEntry."No. of days";

                    // Taken
                    LedgerEntry.Reset();
                    LedgerEntry.SetRange("Staff No.", "No.");
                    LedgerEntry.SetRange("Leave Period", LeavePeriod);
                    LedgerEntry.SetRange("Leave Entry Type", LedgerEntry."Leave Entry Type"::Negative);
                    if (StartDate <> 0D) and (EndDate <> 0D) then begin
                        LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    end;
                    LedgerEntry.CalcSums("No. of days");
                    TotalTaken := Abs(LedgerEntry."No. of days");

                    TotalBalance := TotalAllocated + TotalAccrued + TotalCarryForward - TotalTaken;

                    if (TotalAllocated = 0) and (TotalAccrued = 0) and
                       (TotalCarryForward = 0) and (TotalTaken = 0) then
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                begin
                    if LeavePeriod = '' then
                        Error('Please specify a Leave Period before printing.');
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
                    field("Leave Period"; LeavePeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Period';
                        ShowMandatory = true;
                        TableRelation = "HR Leave Periods"."Period Code";
                        ToolTip = 'Select the leave period to report on.';
                    }
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Enter the start date of the month to report on. Leave blank to report on the full leave period.';
                    }
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Enter the end date of the month to report on. Leave blank to report on the full leave period.';
                    }
                }
            }
        }
        actions { }
    }

    var
        LeavePeriod: Code[20];
        StartDate: Date;
        EndDate: Date;
        TotalAllocated: Decimal;
        TotalAccrued: Decimal;
        TotalCarryForward: Decimal;
        TotalTaken: Decimal;
        TotalBalance: Decimal;
}
