page 51525384 "Departmental Target Card"
{
    ApplicationArea = All;
    Caption = 'Departmental Target Card';
    PageType = Card;
    SourceTable = "WB Departmental Targets";

    layout
    {
        area(content)
        {
            group("Plan Header")
            {
                Caption = 'Plan Header';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
            }

            part(Objectives; "WB Dept Target Objectives")
            {
                ApplicationArea = All;
                Caption = 'Objectives';
                SubPageLink = "Document No" = field(No);
            }
        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        HrAppraissalPeriods.Reset();
        HrAppraissalPeriods.SetRange(Open, true);
        if HrAppraissalPeriods.FindFirst() then
            Rec.Period := HrAppraissalPeriods.Code
        else
            Error('There are no open periods!');

        EmpRec.Reset();
        EmpRec.SetRange("User ID", UserId);
        EmpRec.SetFilter("Responsibility Center", '<>%1', '');
        if EmpRec.FindFirst() then begin
            Rec."Department Code" := EmpRec."Responsibility Center";
            Rec."Department Name" := EmpRec."Responsibility Center Name";
            Rec.Validate("Department Code");
        end else
            Error('Kindly ask the HR department to update your employee card with a user ID and department!');
    end;

    var
        HrAppraissalPeriods: Record "HR Appraisal Periods";
        EmpRec: Record Employee;
}