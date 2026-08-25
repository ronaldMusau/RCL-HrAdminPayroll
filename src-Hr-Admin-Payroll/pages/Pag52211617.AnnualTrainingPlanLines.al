page 52211617 "Annual Training Plan Lines"
{
    PageType = ListPart;
    SourceTable = "Annual Training Plan Line";
    Caption = 'Courses';
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Course No."; Rec."Course No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Course Title"; Rec."Course Title") { ApplicationArea = All; Editable = false; }
                field("Course Budget"; Rec."Course Budget") { ApplicationArea = All; Editable = false; }
                field("Date Added"; Rec."Date Added") { ApplicationArea = All; Editable = false; }
                field("Added By"; Rec."Added By") { ApplicationArea = All; Editable = false; }
            }
        }
    }
}


