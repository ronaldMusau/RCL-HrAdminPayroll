page 52211567 "Compassionate Checks List"
{
    ApplicationArea = All;
    CardPageID = "Compassionate Checks Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Compassionate Checks";
    SourceTableView = SORTING("No.") ORDER(descending);
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field("Amount"; Rec."Amount")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Remarks"; Rec."Remarks")
                {
                }
            }
        }
    }
}
