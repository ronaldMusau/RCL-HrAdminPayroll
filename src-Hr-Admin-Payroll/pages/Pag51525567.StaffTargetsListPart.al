page 51525567 "Staff Targets ListPart"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Staff Target Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    Visible = true;
                    Editable = false;
                }
                field("Department Target No"; Rec."Department Target No")
                {
                }
                field("Objective Code"; Rec."Objective Code")
                {
                }
                field(Objective; Rec.Objective)
                {
                }
                field("Success Measure"; Rec."Success Measure")
                {
                }
                field("Specific Action Plan"; Rec."Specific Action Plan")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                    ShowMandatory = true;
                }
                field("Due Date Description"; Rec."Due Date Description")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        //FRED 5/3/23 Limit modification to within set dates
        HrAppraissalPeriods.Reset;
        HrAppraissalPeriods.SetRange(Code, Rec.Period);
        if HrAppraissalPeriods.FindFirst then begin
            if (HrAppraissalPeriods."Allow Edits From" <> 0D) and (HrAppraissalPeriods."Allow Edits To" <> 0D) then begin
                if (Today < HrAppraissalPeriods."Allow Edits From") or (Today > HrAppraissalPeriods."Allow Edits To") then begin
                    Error('You are no longer allowed to modify this target because the working date is outside the allowable modification dates for this period!');
                end;
            end;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        HrAppraissalPeriods.Reset();
        HrAppraissalPeriods.SetRange(Open, true);
        if HrAppraissalPeriods.FindFirst() then
            Rec.Period := HrAppraissalPeriods.Code
        else
            Error('There are no open periods!');
        if TargetObjectives.Get(Rec."Doc No") then begin
            Rec."Staff No" := TargetObjectives."Staff No";
            Rec."Department Code" := TargetObjectives.Department;

            DeptTargetHeader.SetRange(Period, Rec.Period);
            DeptTargetHeader.SetRange("Department Code", Rec."Department Code");
            if DeptTargetHeader.FindFirst() then
                Rec."Department Target No" := DeptTargetHeader.No;
        end;
        //FRED 5/3/23 Limit modification to within set dates
        if Rec.Period <> '' then begin
            HrAppraissalPeriods.Reset;
            HrAppraissalPeriods.SetRange(Code, Rec.Period);
            if HrAppraissalPeriods.FindFirst then begin
                if (HrAppraissalPeriods."Allow Edits From" <> 0D) and (HrAppraissalPeriods."Allow Edits To" <> 0D) then begin
                    if (Today < HrAppraissalPeriods."Allow Edits From") or (Today > HrAppraissalPeriods."Allow Edits To") then begin
                        Error('You are no longer allowed to modify this target because the working date is outside the allowable modification dates for this period!');
                    end;
                end;
            end;
        end;
    end;

    var
        HrAppraissalPeriods: Record "HR Appraisal Periods";
        TargetObjectives: Record "Staff Target Objectives";
        DeptTargetHeader: Record "WB Departmental Targets";
}