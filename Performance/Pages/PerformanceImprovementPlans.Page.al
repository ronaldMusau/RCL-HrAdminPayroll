#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211731 "Performance Improvement Plans"
{
    ApplicationArea = Basic;
    CardPageID = "Performance Improvement Plan";
    PageType = List;
    SourceTable = "Performance Improvement Plan";
    UsageCategory = Lists;

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
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Primary Evaluation ID"; Rec."Primary Evaluation ID")
                {
                    ApplicationArea = Basic;
                }
                field("Original PIP"; Rec."Original PIP")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("PIP Template ID"; Rec."PIP Template ID")
                {
                    ApplicationArea = Basic;
                }
                field("PIP Start Date"; Rec."PIP Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("PIP End Date"; Rec."PIP End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                }
                field("Immediate Supervisor No."; Rec."Immediate Supervisor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Immediate Supervisor Name"; Rec."Immediate Supervisor Name")
                {
                    ApplicationArea = Basic;
                }
                field("Personal Scorecard ID"; Rec."Personal Scorecard ID")
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    ApplicationArea = Basic;
                }
                // field(Directorate; Rec.Directorate)
                // {
                //     ApplicationArea = Basic;
                // }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field("Blocked?"; Rec."Blocked?")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Last Review Date"; Rec."Last Review Date")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Review Type"; Rec."Performance Review Type")
                {
                    ApplicationArea = Basic;
                }
                field("Final PIP Outcome"; Rec."Final PIP Outcome")
                {
                    ApplicationArea = Basic;
                }
                field("Final PIP Verdict Code"; Rec."Final PIP Verdict Code")
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

