page 52211570 "Compass Check Setup Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Compassionate Check Setup Line";

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Job Grade"; Rec."Job Grade")
                {
                }
                field("Amount"; Rec."Amount")
                {
                }
            }
        }
    }
}
