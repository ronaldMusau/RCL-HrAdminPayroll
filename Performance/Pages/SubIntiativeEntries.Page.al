#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211770 "Sub Intiative Entries"
{
    PageType = List;
    SourceTable = Sub_Strategy_Activity;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Strategic Plan ID"; Rec."Strategic Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Theme ID"; Rec."Theme ID")
                {
                    ApplicationArea = Basic;
                }
                field("Objective ID"; Rec."Objective ID")
                {
                    ApplicationArea = Basic;
                }
                field("Strategy ID"; Rec."Strategy ID")
                {
                    ApplicationArea = Basic;
                }
                field("Activity ID"; Rec."Activity ID")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Entry Description"; Rec."Entry Description")
                {
                    ApplicationArea = Basic;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field("Year Reporting Code"; Rec."Year Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Quarter Reporting Code"; Rec."Quarter Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Planning Date"; Rec."Planning Date")
                {
                    ApplicationArea = Basic;
                }
                field("Primary Department"; Rec."Primary Department")
                {
                    ApplicationArea = Basic;
                }
                // field("Primary Department"; Rec."Primary Division")
                // {
                //     ApplicationArea = Basic;
                // }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = Basic;
                }
                field("External Document No"; Rec."External Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Region Code"; Rec."Region Code")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Contract ID"; Rec."Performance Contract ID")
                {
                    ApplicationArea = Basic;
                }
                field("Annual Workplan"; Rec."Annual Workplan")
                {
                    ApplicationArea = Basic;
                    // Caption = 'ADAK Annual Workplan';
                }
                field("Board PC ID"; Rec."Board PC ID")
                {
                    ApplicationArea = Basic;
                }
                field("CEO PC ID"; Rec."CEO PC ID")
                {
                    ApplicationArea = Basic;
                }
                field("Functional PC ID"; Rec."Functional PC ID")
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    ApplicationArea = Basic;
                }
                field("Reversed Entry No"; Rec."Reversed Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("CEOs PC ID"; Rec."CEOs PC ID")
                {
                    ApplicationArea = Basic;
                }
                field("Department/Center PC ID"; Rec."Department/Center PC ID")
                {
                    ApplicationArea = Basic;
                }
                field("Sub Initiative No."; Rec."Sub Initiative No.")
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

