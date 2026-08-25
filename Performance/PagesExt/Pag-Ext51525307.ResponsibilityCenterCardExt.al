pageextension 52211625 "Responsibility Center Card Ext" extends "Responsibility Center Card"
{
    layout
    {
        addlast(Content)
        {
            field("Operating Unit Type"; Rec."Operating Unit Type")
            {
                ApplicationArea = Basic;
            }
        }
    }
}
