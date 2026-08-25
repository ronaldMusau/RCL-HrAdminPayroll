#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211739 "Sub Objectives/Intiatives"
{
    PageType = ListPart;
    SourceTable = "Sub PC Objective";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Initiative No."; Rec."Initiative No.")
                {
                    ApplicationArea = Basic;
                }
                field("Sub-Indicator"; Rec."Sub Initiative No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Sub-Initiative"; Rec."Objective/Initiative")
                {
                    NotBlank = true;
                    ApplicationArea = Basic;
                }
                field("Outcome Perfomance Indicator"; Rec."Outcome Perfomance Indicator")
                {
                    ApplicationArea = Basic;
                }

                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Target; Rec."Imported Annual Target Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Target';
                }
                field("Assigned Weight (%)"; Rec."Assigned Weight (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Individual Achieved Targets"; Rec."Individual Achieved Targets")
                {
                    ApplicationArea = Basic;
                }
                field("Completion Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        PCObjective: Record "PC Objective";
}

#pragma implicitwith restore

