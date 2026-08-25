#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211808 "Objectives and Outcomes-Self S"
{
    PageType = List;
    SourceTable = "Objective Evaluation Result";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Performance Evaluation ID"; Rec."Performance Evaluation ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    // Caption = 'Annual Performance Evaluation ID';
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Scorecard ID"; Rec."Scorecard ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Scorecard Line No"; Rec."Scorecard Line No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Objective/Initiative"; Rec."Objective/Initiative")
                {
                    ApplicationArea = Basic;
                }
                field("Outcome Perfomance Indicator"; Rec."Outcome Perfomance Indicator")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Desired Perfomance Direction"; Rec."Desired Perfomance Direction")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Rating Scale"; Rec."Performance Rating Scale")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Scale Type"; Rec."Scale Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Target Qty"; Rec."Target Qty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Self-Review Qty"; Rec."Self-Review Qty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("AppraiserReview Qty"; Rec."AppraiserReview Qty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Final/Actual Qty"; Rec."Final/Actual Qty")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

