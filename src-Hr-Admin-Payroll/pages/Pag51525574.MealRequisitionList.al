page 52211574 "Meal Requisition List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Meal Requisition Header";
    CardPageId = "Meal Requisition Card";
    UsageCategory = Lists;
    SourceTableView = SORTING("Requisition No") ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Requisition No"; Rec."Requisition No") { }
                field("Request Date"; Rec."Request Date") { }
                field("Employee No"; Rec."Employee No") { }
                field("Employee Name"; Rec."Employee Name") { }
                field(Status; Rec.Status) { }
                field("Total Amount"; Rec."Total Amount") { }
            }
        }
    }

    actions
    {
    }
}
