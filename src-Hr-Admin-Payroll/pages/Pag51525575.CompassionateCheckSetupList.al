page 52211569 "Compassionate Check Setup"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Compassionate Check Setup";
    SourceTableView = SORTING("Code");

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec."Code")
                {
                }
                field("Description"; Rec."Description")
                {
                }
                field("Amount"; Rec."Amount")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Grades)
            {
                Caption = 'Setup Lines';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Compass Check Setup Lines";
                RunPageLink = "Setup Code" = FIELD("Code");
            }
        }
    }
}
