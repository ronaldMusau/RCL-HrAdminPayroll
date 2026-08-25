page 52211553 "Memo List"
{

    PageType = List;
    SourceTable = "Memo Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Memo Card";
    SourceTableView = where("Approval Status" = filter(Open | "Pending Approval" | Rejected));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { }
                field("Purpose"; Rec.Purpose) { }
                field("Activity Date"; Rec."Activity Date") { }
                field(Department; Rec."Department Code") { }
                field(Status; Rec."Approval Status") { }
            }
        }
    }
}
