codeunit 51525320 "HR Leave Balance API"
{


    // trigger OnRun()
    // begin
    //     Error('Use GetEmployeeLeaveBalance() procedure directly.');
    // end;

    procedure GetEmployeeLeaveBalance(EmployeeNo: Code[20]; LeaveType: Code[60]): Text
    var
        HREmployee: Record Employee;
        LeavePeriod: Code[60];
        JsonResult: Text;
    begin

        if EmployeeNo = '' then
            exit(BuildErrorJson('Employee No. is required.'));

        if not HREmployee.Get(EmployeeNo) then
            exit(BuildErrorJson(StrSubstNo('Employee %1 not found.', EmployeeNo)));


        LeavePeriod := GetCurrentLeavePeriod();
        if LeavePeriod = '' then
            exit(BuildErrorJson('No active leave period found.'));


        JsonResult := CalcAndBuildJson(HREmployee, LeaveType, LeavePeriod);
        exit(JsonResult);
    end;


    procedure GetEmployeeLeaveBalanceByPeriod(EmployeeNo: Code[20]; LeaveType: Code[60]; LeavePeriod: Code[60]): Text
    var
        HREmployee: Record Employee;
    begin
        if EmployeeNo = '' then
            exit(BuildErrorJson('Employee No. is required.'));

        if not HREmployee.Get(EmployeeNo) then
            exit(BuildErrorJson(StrSubstNo('Employee %1 not found.', EmployeeNo)));

        if LeavePeriod = '' then
            exit(BuildErrorJson('Leave Period is required.'));

        exit(CalcAndBuildJson(HREmployee, LeaveType, LeavePeriod));
    end;


    procedure GetCurrentLeavePeriod(): Code[60]
    var
        LeavePeriodRec: Record "HR Leave Periods";
    begin
        LeavePeriodRec.Reset();
        LeavePeriodRec.SetRange(Closed, false);
        LeavePeriodRec.SetCurrentKey("Starting Date");
        if LeavePeriodRec.FindLast() then
            exit(LeavePeriodRec."Period Code");
        exit('');
    end;


    local procedure CalcAndBuildJson(HREmployee: Record Employee; LeaveType: Code[60]; LeavePeriod: Code[60]): Text
    var
        Lentries: Record "HR Leave Ledger Entries";
        Lentriess: Record "HR Leave Ledger Entries";

        FullName: Text[80];
        CarryForward: Decimal;
        MonthlyAccrueds: Decimal;
        AllocatedLeaveDays: Decimal;
        ReinbursedLeaves: Decimal;
        TotalLeavesTaken: Decimal;
        Adjustments: Decimal;
        TotalLeaves: Decimal;
        Balance: Decimal;

        JsonTxt: TextBuilder;
    begin
        // ── Full name ────────────────────────────────────────────────
        FullName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
        FullName := FullName.Trim();


        CarryForward := 0;
        if (LeaveType = 'ANNUAL') or (LeaveType = 'CARRY FORWARD') or (LeaveType = '') then begin
            Lentries.Reset();
            Lentries.SetRange("Staff No.", HREmployee."No.");
            Lentries.SetFilter("Leave Type", 'CARRY FORWARD');
            Lentries.SetFilter("Leave Period", LeavePeriod);
            if Lentries.FindSet() then begin
                Lentries.CalcSums("No. of days");
                CarryForward := Round(Lentries."No. of days", 0.5, '=');
            end;
        end;


        MonthlyAccrueds := 0;
        if LeaveType = 'ANNUAL' then begin
            Lentriess.Reset();
            Lentriess.SetRange("Staff No.", HREmployee."No.");
            Lentriess.SetFilter(IsMonthlyAccrued, '%1', true);
            Lentriess.SetFilter("Leave Period", LeavePeriod);
            Lentriess.SetFilter("Document No.", 'ACCRUE');
            if Lentriess.FindSet() then begin
                Lentriess.CalcSums("No. of days");
                MonthlyAccrueds := Round(Lentriess."No. of days", 0.1, '=');
            end;
        end;

        // ── 3. Allocated Leave Days (Positive, non-adjustment) ───────
        AllocatedLeaveDays := 0;
        Lentries.Reset();
        Lentries.SetRange("Staff No.", HREmployee."No.");
        Lentries.SetFilter("Leave Entry Type", '%1', Lentries."Leave Entry Type"::Positive);
        Lentries.SetFilter("Leave Type", LeaveType);
        Lentries.SetFilter("Leave Period", LeavePeriod);
        Lentries.SetFilter(Adjustment, '%1', false);
        if Lentries.FindSet() then begin
            Lentries.CalcSums("No. of days");
            AllocatedLeaveDays := Round(Lentries."No. of days", 0.5, '=');
        end;

        // ── 4. Reimbursed Leaves ─────────────────────────────────────
        ReinbursedLeaves := 0;
        Lentries.Reset();
        Lentries.SetRange("Staff No.", HREmployee."No.");
        Lentries.SetFilter("Leave Entry Type", '%1', Lentries."Leave Entry Type"::Reimbursement);
        Lentries.SetFilter("Is For Annual Leave", '%1', true);
        Lentries.SetFilter("Leave Period", LeavePeriod);
        if Lentries.FindSet() then begin
            Lentries.CalcSums("No. of days");
            ReinbursedLeaves := Round(Lentries."No. of days", 0.1, '=');
        end;

        // ── 5. Total Leaves Taken (Negative, non-adjustment) ─────────
        TotalLeavesTaken := 0;
        Lentries.Reset();
        Lentries.SetRange("Staff No.", HREmployee."No.");
        Lentries.SetFilter("Leave Entry Type", '%1', Lentries."Leave Entry Type"::Negative);
        Lentries.SetFilter("Leave Period", LeavePeriod);
        Lentries.SetFilter("Leave Type", LeaveType);
        Lentries.SetFilter(Adjustment, '%1', false);
        if Lentries.FindSet() then begin
            Lentries.CalcSums("No. of days");
            TotalLeavesTaken := -Round(Lentries."No. of days", 0.05, '=');
        end;

        // ── 6. Adjustments ───────────────────────────────────────────
        Adjustments := 0;
        Lentries.Reset();
        Lentries.SetRange("Staff No.", HREmployee."No.");
        Lentries.SetFilter("Leave Period", LeavePeriod);
        Lentries.SetFilter("Leave Type", LeaveType);
        Lentries.SetFilter(Adjustment, '%1', true);
        if Lentries.FindSet() then begin
            Lentries.CalcSums("No. of days");
            Adjustments := -Round(Lentries."No. of days", 0.05, '=');
        end;

        TotalLeavesTaken := TotalLeavesTaken + Adjustments;

        // ── 7. Totals & Balance ───────────────────────────────────────
        TotalLeaves := AllocatedLeaveDays + CarryForward + ReinbursedLeaves;
        Balance := TotalLeaves - TotalLeavesTaken;

        // ── Build JSON ───────────────────────────────────────────────
        JsonTxt.Clear();
        JsonTxt.Append('{');
        JsonTxt.Append('"success": true,');
        JsonTxt.Append('"message": "Leave balance retrieved successfully",');
        JsonTxt.Append('"data": {');
        JsonTxt.Append(StrSubstNo('"employeeNo": "%1",', EscapeJson(HREmployee."No.")));
        JsonTxt.Append(StrSubstNo('"employeeName": "%1",', EscapeJson(FullName)));
        JsonTxt.Append(StrSubstNo('"jobTitle": "%1",', EscapeJson(HREmployee."Job Title")));
        JsonTxt.Append(StrSubstNo('"contractType": "%1",', EscapeJson(Format(HREmployee."Contract Type"))));
        JsonTxt.Append(StrSubstNo('"currentLeavePeriod": "%1",', EscapeJson(LeavePeriod)));
        JsonTxt.Append(StrSubstNo('"leaveType": "%1",', EscapeJson(LeaveType)));
        JsonTxt.Append(StrSubstNo('"leaveDaysCarriedForward": %1,', Format(CarryForward, 0, 9)));
        JsonTxt.Append(StrSubstNo('"monthlyAccruedDays": %1,', Format(MonthlyAccrueds, 0, 9)));
        JsonTxt.Append(StrSubstNo('"allocatedLeaveDays": %1,', Format(AllocatedLeaveDays, 0, 9)));
        JsonTxt.Append(StrSubstNo('"reimbursedLeaveDays": %1,', Format(ReinbursedLeaves, 0, 9)));
        JsonTxt.Append(StrSubstNo('"totalLeaveDays": %1,', Format(TotalLeaves, 0, 9)));
        JsonTxt.Append(StrSubstNo('"takenLeaveDays": %1,', Format(TotalLeavesTaken, 0, 9)));
        JsonTxt.Append(StrSubstNo('"leaveBalance": %1', Format(Balance, 0, 9)));
        JsonTxt.Append('}');
        JsonTxt.Append('}');

        exit(JsonTxt.ToText());
    end;


    local procedure BuildErrorJson(ErrorMessage: Text): Text
    var
        JsonTxt: TextBuilder;
    begin
        JsonTxt.Clear();
        JsonTxt.Append('{');
        JsonTxt.Append('"success": false,');
        JsonTxt.Append(StrSubstNo('"message": "%1",', EscapeJson(ErrorMessage)));
        JsonTxt.Append('"data": null');
        JsonTxt.Append('}');
        exit(JsonTxt.ToText());
    end;

    local procedure EscapeJson(InputText: Text): Text
    begin
        InputText := InputText.Replace('\', '\\');
        InputText := InputText.Replace('"', '\"');
        InputText := InputText.Replace('/', '\/');
        InputText := InputText.Replace(ControlChar(8), '\b');   // backspace
        InputText := InputText.Replace(ControlChar(12), '\f');  // form feed
        InputText := InputText.Replace(ControlChar(10), '\n');  // newline
        InputText := InputText.Replace(ControlChar(13), '\r');  // carriage return
        InputText := InputText.Replace(ControlChar(9), '\t');   // tab
        exit(InputText);
    end;

    local procedure ControlChar(CharCode: Integer): Text
    var
        C: Char;
    begin
        C := CharCode;
        exit(Format(C));
    end;
}
