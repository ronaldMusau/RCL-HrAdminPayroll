report 51525385 "Leave Liability Report"
{
    Caption = 'Leave Liability Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep51525385.LeaveLiabilityReport.rdlc';
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where(status = const(Active));

            column(No_Employee; "No.")
            {
            }
            column(FirstName_Employee; Employee.FullName())
            {
            }
            column(ResponsibilityCenterName_Employee; "Responsibility Center Name")
            {
            }
            column(AssignedGrossPay_Employee; "Assigned Gross Pay")
            {
            }
            column(LeaveBalance; LeaveBalance)
            {
            }
            column(ExpectedAmount; ExpectedAmount)
            {
            }
            column(PostingDate;PostingDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LeaveTypes.Reset();
                LeaveTypes.SetRange("Annual Leave", true);
                LeaveTypes.FindFirst();
                LeaveBalance := GetLeaveBalance(PostingDate, Employee."No.");
                ExpectedAmount := LeaveBalance * Employee."Assigned Gross Pay"/30;
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(PostingDate; PostingDate)
                    {
                        ToolTip = 'This is the date as at which the leave balance is calculated.';
                    }
                    field(LeavePeriod; LeavePeriod)
                    {
                        ToolTip = 'This is the leave period for which the leave balance is calculated.';
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
    trigger OnPreReport()
    begin
        if PostingDate = 0D then
            Error('Posting Date cannot be empty.');
        if LeavePeriod = '' then
            Error('Leave Period cannot be empty.');
    end;

    trigger OnInitReport()
    begin
        PostingDate := Today();
        LeavePeriod := '';
        HrLeavePeriods.Reset();
        HrLeavePeriods.SetRange(Closed, false);
        if HrLeavePeriods.FindFirst() then
            LeavePeriod := HrLeavePeriods."Period Code";
    end;

    var
        LeaveTypes: Record "Leave Types";
        LeaveBalance: Decimal;
        PostingDate: Date;
        HrLeavePeriods: Record "HR Leave Periods";
        LeavePeriod: Code[60];
        ExpectedAmount: Decimal;

    procedure GetLeaveBalance(PostingD: Date; EmpNo: Code[20]): Decimal
    var
        Lentries: Record "HR Leave Ledger Entries";
        Balance: Decimal;

    begin

        Balance := 0;
        Lentries.Reset;
        Lentries.SetRange("Staff No.", EmpNo);
        Lentries.SetFilter(Lentries."Leave Type", 'CF|ANNUAL|SPECIAL|CARRY FORWARD');
        Lentries.SetFilter(Lentries."Leave Period", LeavePeriod);
        Lentries.SetRange("Posting Date", HrLeavePeriods."Starting Date", PostingDate);
        if Lentries.FindSet then begin
            Lentries.CalcSums("No. of days");
            Balance := Round((Lentries."No. of days"), 0.5, '=');
        end;
        exit(Balance);
    end;
}
