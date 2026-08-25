page 52211578 "Target Lines List Part"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Target Lines";
    Caption = 'Target Lines';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Objective No"; Rec."Objective No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Action; Rec.Action)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
                field("Responsible Person Name"; Rec."Responsible Person Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Resources Needed"; Rec."Resources Needed")
                {
                    ApplicationArea = All;
                }
                field(Timelines; Rec.Timelines)
                {
                    ApplicationArea = All;
                }
                field("Success Measures"; Rec."Success Measures")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CalculateAchievement)
            {
                ApplicationArea = All;
                Caption = 'Recalculate Achievement';
                Image = Calculate;

                trigger OnAction()
                begin
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
