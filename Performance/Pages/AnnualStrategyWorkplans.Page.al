#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211683 "Annual Strategy Workplans"
{
    Caption = 'Annual Workplans';
    CardPageID = "Annual Strategy Workplan Card1";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Annual Strategy Workplan";
    SourceTableView = where("Approval Status" = filter(Open | "Pending Approval"),
                            "Annual Strategy Type" = const(Organizational));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Year Reporting Code"; Rec."Year Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

