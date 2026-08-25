#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211728 "Performance Diary Logs"
{
    ApplicationArea = Basic;
    Caption = 'Performance Reports';
    CardPageID = "Performance Logs Card";
    Editable = false;
    PageType = List;
    SourceTable = "Performance Diary Log";
    SourceTableView = where(Posted = const(false),
                            "Approval Status" = filter(Open | "Pending Approval"));
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

