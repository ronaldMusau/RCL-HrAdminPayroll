report 51525390 "Employee Leave Statement"
{
    Caption = 'Employee Leave Statement';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep51525390.EmployeeLeaveStatement.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(CompanyInformation; "Company Information")
        {
            column(Logo; Picture) { }
            column(CompanyName; Name) { }
            column(CompanyAddress; Address) { }
            column(CompanyPhone; "Phone No.") { }

            dataitem(Employee; Employee)
            {
                RequestFilterFields = "No.", "Global Dimension 2 Code";
                column(EmployeeNo; "No.") { }
                column(EmployeeName; FullName) { }
                column(Department; "Global Dimension 2 Code") { }
                column(JobTitle; "Job Title") { }
                column(LeavePeriodFilter; LeavePeriod) { }

                dataitem(LeaveTypeLoop; "Leave Types")
                {
                    DataItemTableView = SORTING(Code);
                    column(LeaveTypeCode; Code) { }
                    column(LeaveTypeDesc; Description) { }
                    column(AllocationDays; AllocationDays) { }
                    column(AccruedDays; AccruedDays) { }
                    column(CarryForwardDays; CarryForwardDays) { }
                    column(DaysTaken; DaysTaken) { }
                    column(ClosingBalance; ClosingBalance) { }

                    trigger OnAfterGetRecord()
                    var
                        LedgerEntry: Record "HR Leave Ledger Entries";
                    begin
                        AllocationDays := 0;
                        AccruedDays := 0;
                        CarryForwardDays := 0;
                        DaysTaken := 0;
                        ClosingBalance := 0;

                        // Allocation (Positive, not accrual)
                        LedgerEntry.Reset();
                        LedgerEntry.SetRange("Staff No.", Employee."No.");
                        LedgerEntry.SetRange("Leave Period", LeavePeriod);
                        LedgerEntry.SetRange("Leave Type", Code);
                        LedgerEntry.SetRange("Leave Entry Type", LedgerEntry."Leave Entry Type"::Positive);
                        LedgerEntry.SetRange(IsMonthlyAccrued, false);
                        if (StartDate <> 0D) and (EndDate <> 0D) then begin
                            LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                        end;

                        LedgerEntry.CalcSums("No. of days");
                        AllocationDays := LedgerEntry."No. of days";

                        // Monthly Accrued
                        LedgerEntry.Reset();
                        LedgerEntry.SetRange("Staff No.", Employee."No.");
                        LedgerEntry.SetRange("Leave Period", LeavePeriod);
                        LedgerEntry.SetRange("Leave Type", Code);
                        LedgerEntry.SetRange(IsMonthlyAccrued, true);
                        if (StartDate <> 0D) and (EndDate <> 0D) then begin
                            LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                        end;
                        LedgerEntry.CalcSums("No. of days");
                        AccruedDays := LedgerEntry."No. of days";

                        // Carry Forward — only on ANNUAL row
                        CarryForwardDays := 0;
                        if UpperCase(Code) in ['ANNUAL', 'ANNUAL LEAVE', ''] then begin
                            LedgerEntry.Reset();
                            LedgerEntry.SetRange("Staff No.", Employee."No.");
                            LedgerEntry.SetRange("Leave Period", LeavePeriod);
                            LedgerEntry.SetFilter("Leave Type", 'CF|CARRY FORWARD');
                            LedgerEntry.SetRange("Leave Entry Type", LedgerEntry."Leave Entry Type"::Positive);
                            if (StartDate <> 0D) and (EndDate <> 0D) then begin
                                LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                            end;
                            LedgerEntry.CalcSums("No. of days");
                            CarryForwardDays := LedgerEntry."No. of days";
                        end;

                        // Days Taken (Negative)
                        LedgerEntry.Reset();
                        LedgerEntry.SetRange("Staff No.", Employee."No.");
                        LedgerEntry.SetRange("Leave Period", LeavePeriod);
                        LedgerEntry.SetRange("Leave Type", Code);
                        LedgerEntry.SetRange("Leave Entry Type", LedgerEntry."Leave Entry Type"::Negative);
                        if (StartDate <> 0D) and (EndDate <> 0D) then begin
                            LedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                        end;
                        LedgerEntry.CalcSums("No. of days");
                        DaysTaken := Abs(LedgerEntry."No. of days");

                        ClosingBalance := AllocationDays + AccruedDays + CarryForwardDays - DaysTaken;

                        if (AllocationDays = 0) and (AccruedDays = 0) and
                           (CarryForwardDays = 0) and (DaysTaken = 0) then
                            CurrReport.Skip();
                    end;
                }

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
        AllocationDays: Decimal;
        AccruedDays: Decimal;
        CarryForwardDays: Decimal;
        DaysTaken: Decimal;
        ClosingBalance: Decimal;
        LeaveTypeDescription: Text[100];
}
