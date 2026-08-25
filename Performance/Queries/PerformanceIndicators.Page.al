
Page 52211687 "Performance Indicators"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Performance Indicator";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(KPI; Rec.KPI)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                // field("Directorate Code"; Rec."Directorate Code")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Department Code"; Rec."Department Code")
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



