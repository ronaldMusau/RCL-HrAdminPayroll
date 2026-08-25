page 52211621 "WB Dept Target Objectives"
{
    ApplicationArea = All;
    Caption = 'Department Objectives';
    PageType = ListPart;
    SourceTable = "WB Dept Target Objective";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Objective No"; Rec."Objective No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the objective identifier.';
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the objective.';
                }
                field("Goal Statement"; Rec."Goal Statement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the goal statement.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OpenObjectiveCard)
            {
                ApplicationArea = All;
                Caption = 'Open Objective';
                Image = EditLines;

                trigger OnAction()
                begin
                    Page.Run(Page::"WB Dept Target Objective Card", Rec);
                end;
            }
        }
    }
}
