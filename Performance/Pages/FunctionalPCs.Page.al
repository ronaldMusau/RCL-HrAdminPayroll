#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211785 "Functional PCs"
{
    Caption = 'Functional PCs';
    CardPageID = "Functional Pc";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Annual Strategy Workplan";
    SourceTableView = where("Annual Strategy Type" = filter("Functional PC"),
                            "Approval Status" = filter(Open | "Pending Approval"));

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
                // field("Primary Directorate"; "Primary Directorate")
                field("Primary Department"; Rec."Primary Department")
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                }
                // field(Department; Department)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Department';
                // }
                field("Department Name"; Rec."Department Name")
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

