
Page 52211738 "Proficiency Evalulation"
{
    PageType = ListPart;
    SourceTable = "Proficiency Evaluation Result";

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
                field("Competency Template ID"; Rec."Competency Template ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Competency Code"; Rec."Competency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Competency Description"; Rec."Competency Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Competency Category';
                    Editable = false;
                    Visible = true;
                }
                field("Competency Category"; Rec."Competency Category")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Desired Proficiency Direction"; Rec."Desired Proficiency Direction")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Profiency Rating Scale"; Rec."Profiency Rating Scale")
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
                    Enabled = false;
                }
                field("AppraiserReview Qty"; Rec."AppraiserReview Qty")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Final/Actual Qty"; Rec."Final/Actual Qty")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Competency Appraisal"; Rec."Competency Appraisal")
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


