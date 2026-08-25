page 52211702 "Training Needs Projection"
{
    ApplicationArea = All;
    Caption = 'Training Needs Projection';
    PageType = Card;
    SourceTable = "Training Needs Lines";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Source field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field("No. of Linked Objectives"; Rec."No. of Linked Objectives")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the No. of Linked Objectives field.', Comment = '%';
                }
                field("Training Header No."; Rec."Training Header No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Training Header No. field.', Comment = '%';
                }
            }
        }
    }
}
