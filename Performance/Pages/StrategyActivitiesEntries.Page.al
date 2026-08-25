#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211822 "Strategy Activities Entries"
{
    PageType = List;
    SourceTable = "Strategy Sub_Activity Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("External Document No"; Rec."External Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Strategic Plan ID"; Rec."Strategic Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Theme ID"; Rec."Theme ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Objective ID"; Rec."Objective ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Strategy ID"; Rec."Strategy ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                field("Posting Date"; Rec."Posting Date")
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
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Q1 Achieved Target"; Rec."Q1 Achieved Target")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Q2 Achieved Target"; Rec."Q2 Achieved Target")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Q3 AchievedTarget"; Rec."Q3 AchievedTarget")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q3 Achieved Target';
                    Editable = false;
                }
                field("Q4 Achieved Target"; Rec."Q4 Achieved Target")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Remaining Targets"; Rec."Remaining Targets")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Achieved Weight(%)"; Rec."Achieved Weight(%)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Variance; Rec.Variance)
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

