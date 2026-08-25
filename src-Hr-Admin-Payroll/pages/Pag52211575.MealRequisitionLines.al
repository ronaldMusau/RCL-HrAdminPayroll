page 52211575 "Meal Requisition Lines"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Meal Requisition Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No"; Rec."Line No") { }
                field("Meal Code"; Rec."Meal Code") 
                { 
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description) { }
                field(Quantity; Rec.Quantity) { }
                field(Amount; Rec.Amount) { }
            }
        }
    }

    actions
    {
    }
}
