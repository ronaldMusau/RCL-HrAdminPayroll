page 52211619 "Annual Training Plan List"
{
    PageType = List;
    SourceTable = "Annual Training Plan";
    Caption = 'Training Master Plans';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Annual Training Plan Card";

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Title"; Rec."Title") { ApplicationArea = All; }
                field("Fiscal Year"; Rec."Fiscal Year") { ApplicationArea = All; }
                field("Approval Status"; Rec."Approval Status") { ApplicationArea = All; }
                field("Extra Budget"; Rec."Extra Budget") { ApplicationArea = All; }
                field("Total Budget"; Rec."Total Budget") { ApplicationArea = All; }
                field("Total Committed"; Rec."Total Committed") { ApplicationArea = All; }
                field("Total Used"; Rec."Total Used") { ApplicationArea = All; }
                field("Balance"; Rec."Balance") { ApplicationArea = All; }
                field("Created By"; Rec."Created By") { ApplicationArea = All; }
                field("Created Date"; Rec."Created Date") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewPlan)
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = New;
                RunObject = Page "Annual Training Plan Card";
                RunPageMode = Create;
            }
        }
    }
}
