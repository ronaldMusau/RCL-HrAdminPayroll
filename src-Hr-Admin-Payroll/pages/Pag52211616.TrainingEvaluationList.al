page 52211616 "Training Evaluation List"
{
    PageType = List;
    SourceTable = "Training Evaluation";
    Caption = 'Training Evaluations';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Training No."; Rec."Training No.")
                {
                    ApplicationArea = All;
                }
                field("Training Title"; Rec."Training Title")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Date"; Rec."Evaluation Date")
                {
                    ApplicationArea = All;
                }
                field("Overall Rating"; Rec."Overall Rating")
                {
                    ApplicationArea = All;
                }
                field("Trainer Rating"; Rec."Trainer Rating")
                {
                    ApplicationArea = All;
                }
                field("Course Content Rating"; Rec."Course Content Rating")
                {
                    ApplicationArea = All;
                }
                field("Venue Rating"; Rec."Venue Rating")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Submitted By"; Rec."Submitted By")
                {
                    ApplicationArea = All;
                }
                field("Submitted On"; Rec."Submitted On")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
