
Page 52211711 "Objectives and Outcomes"
{
    PageType = ListPart;
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
                    Editable = false;
                }
                field("Departmental Objective"; Rec."Departmental Objective")
                {
                    ApplicationArea = Basic;
                    //  Visible = false;
                }
                field("Outcome Perfomance Indicator"; Rec."Outcome Perfomance Indicator")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Key Performance Indicator"; Rec."Key Performance Indicator")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Desired Perfomance Direction"; Rec."Desired Perfomance Direction")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                    Visible = false;
                }
                field("Target Qty"; Rec."Target Qty")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Weight %"; Rec."Weight %")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("AppraiserReview Qty"; Rec."AppraiserReview Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Achieved/Appraisee Qty';
                    // Visible = false;
                }
                field("Final/Actual Qty"; Rec."Final/Actual Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Final/Appraiser Qty';
                    Visible = false;
                }
                field("Achieved Result"; Rec."Achieved Result")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Performance Appraisal"; Rec."Performance Appraisal")
                {
                    ApplicationArea = Basic;
                }
                field(Reasons; Rec.Reasons)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Related Information")
            {
                Caption = 'Related Information';

                action("Sub Objectives and Outcomes")
                {
                    ApplicationArea = Basic;
                    Image = Agreement;
                    Promoted = true;
                    RunObject = Page "Sub Objectives and Outcomes";
                    RunPageLink = "Performance Evaluation ID" = field("Performance Evaluation ID"),
                                  "Scorecard ID" = field("Scorecard ID"),
                                  "Intiative No" = field("Intiative No");
                }
            }
        }
    }
}



