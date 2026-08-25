page 52211571 "Loan Application List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Loan Application";
    CardPageID = "Loan Application Card";
    UsageCategory = Lists;
    SourceTableView = SORTING("Loan No") ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                }
                field("Amount Requested"; Rec."Amount Requested")
                {
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                }
                field(Instalment; Rec.Instalment)
                {
                }
                field("Loan Status"; Rec."Loan Status")
                {
                }
            }
        }
    }
}
