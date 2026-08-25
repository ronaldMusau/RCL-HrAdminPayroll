page 52211622 "WB Dept Target Objective Card"
{
    ApplicationArea = All;
    Caption = 'Department Objective Card';
    PageType = Card;
    SourceTable = "WB Dept Target Objective";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the parent departmental plan number.';
                }
                field("Objective No"; Rec."Objective No")
                {
                    ApplicationArea = All;
                    Editable = false;
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

            part(TargetLines; "Target Lines List Part")
            {
                ApplicationArea = All;
                Caption = 'Action Plan Lines';
                SubPageLink = "Document No" = field("Document No"), "Objective No" = field("Objective No");
            }
        }
    }
}
