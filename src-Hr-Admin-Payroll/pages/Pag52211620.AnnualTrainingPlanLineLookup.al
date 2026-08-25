page 52211620 "ATP Line Lookup"
{
    PageType = List;
    SourceTable = "Annual Training Plan Line";
    Caption = 'Course Selection';
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Course No."; Rec."Course No.")
                {
                    ApplicationArea = All;
                    Caption = 'Course No.';
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = All;
                    Caption = 'Course Title';
                }
                field("Course Budget"; Rec."Course Budget")
                {
                    ApplicationArea = All;
                    Caption = 'Budget';
                }
                field("Plan No."; Rec."Plan No.")
                {
                    ApplicationArea = All;
                    Caption = 'Plan No.';
                    Visible = false;
                }
            }
        }
    }
}
