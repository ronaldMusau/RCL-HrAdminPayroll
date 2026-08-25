#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211682 "Strategic Initiatives"
{
    PageType = ListPart;
    SourceTable = "Strategic Initiative";

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
                    Caption = 'Key Result Area';
                }
                field("Goal ID"; Rec."Goal ID")
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
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Framework"; Rec."Strategy Framework")
                {
                    ApplicationArea = Basic;
                }
                field("Framework Perspective"; Rec."Framework Perspective")
                {
                    ApplicationArea = Basic;
                }
                field("Perfomance Indicator"; Rec."Perfomance Indicator")
                {
                    ApplicationArea = Basic;
                    // Caption = 'KPI';
                    Caption = 'Output Indicator';
                }
                field("Expected Output"; Rec."Expected Output")
                {
                    ApplicationArea = Basic;
                }
                field("Key Perfromance Indicator"; Rec."Key Perfromance Indicator")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Outcomes; Rec.Outcomes)
                {
                    ApplicationArea = Basic;
                }
                field("Desired Perfomance Direction"; Rec."Desired Perfomance Direction")
                {
                    ApplicationArea = Basic;
                }
                field("Source Of Fund"; Rec."Source Of Fund")
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("CSP Planned Target"; Rec."CSP Planned Target")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collective Budget"; Rec."Collective target")
                {
                    ApplicationArea = BASIC;
                    Caption = 'Planned Budget';
                    Editable = false;
                }
                field("Total Posted Planned Target"; Rec."Total Posted Planned Target")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Posted Planned Target';
                    Visible = false;
                }
                field("Total Achieved Target"; Rec."Total Achieved Target")
                {
                    ApplicationArea = Basic;
                }
                field("Total Posted Planned Budget"; Rec."Total Posted Planned Budget")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Posted Planned Budget';
                    Visible = false;
                }
                field("Total Usage Budget"; Rec."Total Usage Budget")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Primary Department"; Rec."Primary Department")
                {
                    ApplicationArea = Basic;
                    Caption = 'Primary Department';
                }
                field("Primary Department Name"; Rec."Primary Department Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Caption = 'Primary Department Name';
                }
                // field("Primary Division"; Rec."Primary Division")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Primary Division';
                //     Visible = false;
                // }
                // field("Primary Division Name"; Rec."Primary Division Name")
                // {
                //     ApplicationArea = Basic;
                //     Enabled = false;
                //     Caption = 'Primary Division Name';
                //     Visible = false;
                // }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Line Functions")
            {
                action("Implementation Period")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Strategic Int Planning Lines";
                    RunPageLink = "Strategic Plan ID" = field("Strategic Plan ID"),
                                  "Theme ID" = field("Theme ID"),
                                  "Objective ID" = field("Objective ID"),
                                  "Strategy ID" = field("Strategy ID"),
                                  Code = field(Code),
                                  "Primary Department" = field("Primary Department");
                }
            }
        }
    }
}

#pragma implicitwith restore

