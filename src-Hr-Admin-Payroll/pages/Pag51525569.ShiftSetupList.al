page 52211577 "Shift Setup List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Shift Setup";
    Caption = 'Shift Setup';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field("Night Shift"; Rec."Night Shift")
                {
                    ToolTip = 'Specifies the value of the Night Shift field.', Comment = '%';
                }
            }
        }
    }
}
