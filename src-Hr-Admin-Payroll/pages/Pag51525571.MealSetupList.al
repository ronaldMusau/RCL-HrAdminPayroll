page 52211573 "Meal Setup List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Meal Setup";
    UsageCategory = Lists;
    SourceTableView = SORTING(Code) ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("GL Account"; Rec."GL Account")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
    }

    actions
    {
    }
}
