page 52211587 "PIP Setup"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "PIP Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Cutoff Score"; Rec."Cutoff Score") { }
                field("PIP Nos"; Rec."PIP Nos") { }
                field("Notify HR"; Rec."Notify HR") { }
                field("HR Email"; Rec."HR Email") { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.FindFirst() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
