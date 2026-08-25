page 52211815 "Appr. Performance Diary Logs"
{
    ApplicationArea = Basic;
    Caption = 'Approved Performance Reports';
    CardPageID = "Performance Logs Card";
    Editable = false;
    PageType = List;
    SourceTable = "Performance Diary Log";
    SourceTableView = where(Posted = const(false),
                            "Approval Status" = filter(Released));
    UsageCategory = History;

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
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Incidence Date"; Rec."Incidence Date")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Entry Type"; Rec."Performance Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field("Diary Source"; Rec."Diary Source")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Personal Scorecard ID"; Rec."Personal Scorecard ID")
                {
                    ApplicationArea = Basic;
                }
                field("Goal ID"; Rec."Goal ID")
                {
                    ApplicationArea = Basic;
                }
                field("Objective ID"; Rec."Objective ID")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Case ID"; Rec."Disciplinary Case ID")
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

