codeunit 51525321 "Accrue Leave Monthly"
{
    trigger OnRun()
    var
        Employee: Record Employee;
        LeaveTypes: Record "Leave Types";
        LeaveLedger: Record "HR Leave Ledger Entries";
        LeavePeriods: Record "HR Leave Periods";
        EntryNo: Integer;
        MonthlyDays: Decimal;
        CurrentPeriod: Code[20];
        PostingDate: Date;
        AlreadyAccrued: Boolean;
    begin
        // Use today as posting date
        PostingDate := Today();

        // Get current open leave period
        LeavePeriods.Reset();
        LeavePeriods.SetRange(Closed, false);
        LeavePeriods.SetCurrentKey("Starting Date");
        if not LeavePeriods.FindLast() then
            Error('No active leave period found.');
        CurrentPeriod := LeavePeriods."Period Code";

        // Get next entry no
        LeaveLedger.Reset();
        if LeaveLedger.FindLast() then
            EntryNo := LeaveLedger."Entry No." + 1
        else
            EntryNo := 1;

        // Get ANNUAL leave type
        LeaveTypes.Reset();
        LeaveTypes.SetRange(Code, 'ANNUAL');
        if not LeaveTypes.FindFirst() then
            Error('ANNUAL leave type not found.');
        if LeaveTypes.Days = 0 then
            Error('ANNUAL leave type has 0 days configured.');

        MonthlyDays := Round(LeaveTypes.Days / 12, 0.01);

        // Loop through all active employees
        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindSet() then begin
            repeat
                // Check if already accrued this month
                AlreadyAccrued := false;
                LeaveLedger.Reset();
                LeaveLedger.SetRange("Staff No.", Employee."No.");
                LeaveLedger.SetRange("Document No.", 'ACCRUE');
                LeaveLedger.SetRange("Leave Period", CurrentPeriod);
                LeaveLedger.SetRange("Leave Type", 'ANNUAL');
                LeaveLedger.SetRange("Posting Date",
                    CalcDate('<-CM>', PostingDate),
                    CalcDate('<CM>', PostingDate));
                if LeaveLedger.FindFirst() then
                    AlreadyAccrued := true;

                if not AlreadyAccrued then begin
                    LeaveLedger.Init();
                    LeaveLedger."Entry No." := EntryNo;
                    LeaveLedger."Staff No." := Employee."No.";
                    LeaveLedger."Staff Name" := Employee."First Name" + ' ' + Employee."Last Name";
                    LeaveLedger."Leave Period" := CurrentPeriod;
                    LeaveLedger."Leave Type" := 'ANNUAL';
                    LeaveLedger."Leave Entry Type" := LeaveLedger."Leave Entry Type"::Positive;
                    LeaveLedger."Document No." := 'ACCRUE';
                    LeaveLedger."No. of days" := MonthlyDays;
                    LeaveLedger."Posting Date" := PostingDate;
                    LeaveLedger."Leave Posting Description" := 'Monthly Leave Accrual - ' + Format(PostingDate, 0, '<Month Text> <Year4>');
                    LeaveLedger.IsMonthlyAccrued := true;
                    LeaveLedger.Adjustment := false;
                    LeaveLedger."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    LeaveLedger."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    LeaveLedger."User ID" := UserId();
                    LeaveLedger.Insert(true);
                    EntryNo += 1;
                end;
            until Employee.Next() = 0;
        end;
    end;

    procedure RunForDate(PostingDateParam: Date)
    var
        Employee: Record Employee;
        LeaveTypes: Record "Leave Types";
        LeaveLedger: Record "HR Leave Ledger Entries";
        LeavePeriods: Record "HR Leave Periods";
        EntryNo: Integer;
        MonthlyDays: Decimal;
        CurrentPeriod: Code[20];
        AlreadyAccrued: Boolean;
    begin
        LeavePeriods.Reset();
        LeavePeriods.SetRange(Closed, false);
        LeavePeriods.SetCurrentKey("Starting Date");
        if not LeavePeriods.FindLast() then
            Error('No active leave period found.');
        CurrentPeriod := LeavePeriods."Period Code";

        LeaveLedger.Reset();
        if LeaveLedger.FindLast() then
            EntryNo := LeaveLedger."Entry No." + 1
        else
            EntryNo := 1;

        LeaveTypes.Reset();
        LeaveTypes.SetRange(Code, 'ANNUAL');
        if not LeaveTypes.FindFirst() then
            Error('ANNUAL leave type not found.');
        if LeaveTypes.Days = 0 then
            Error('ANNUAL leave type has 0 days configured.');

        MonthlyDays := Round(LeaveTypes.Days / 12, 0.01);

        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindSet() then begin
            repeat
                AlreadyAccrued := false;
                LeaveLedger.Reset();
                LeaveLedger.SetRange("Staff No.", Employee."No.");
                LeaveLedger.SetRange("Document No.", 'ACCRUE');
                LeaveLedger.SetRange("Leave Period", CurrentPeriod);
                LeaveLedger.SetRange("Leave Type", 'ANNUAL');
                LeaveLedger.SetRange("Posting Date",
                    CalcDate('<-CM>', PostingDateParam),
                    CalcDate('<CM>', PostingDateParam));
                if LeaveLedger.FindFirst() then
                    AlreadyAccrued := true;

                if not AlreadyAccrued then begin
                    LeaveLedger.Init();
                    LeaveLedger."Entry No." := EntryNo;
                    LeaveLedger."Staff No." := Employee."No.";
                    LeaveLedger."Staff Name" := Employee."First Name" + ' ' + Employee."Last Name";
                    LeaveLedger."Leave Period" := CurrentPeriod;
                    LeaveLedger."Leave Type" := 'ANNUAL';
                    LeaveLedger."Leave Entry Type" := LeaveLedger."Leave Entry Type"::Positive;
                    LeaveLedger."Document No." := 'ACCRUE';
                    LeaveLedger."No. of days" := MonthlyDays;
                    LeaveLedger."Posting Date" := PostingDateParam;
                    LeaveLedger."Leave Posting Description" := 'Monthly Leave Accrual - ' + Format(PostingDateParam, 0, '<Month Text> <Year4>');
                    LeaveLedger.IsMonthlyAccrued := true;
                    LeaveLedger.Adjustment := false;
                    LeaveLedger."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    LeaveLedger."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    LeaveLedger."User ID" := UserId();
                    LeaveLedger.Insert(true);
                    EntryNo += 1;
                end;
            until Employee.Next() = 0;
        end;
    end;
}
