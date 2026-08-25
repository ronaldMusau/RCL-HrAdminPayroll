#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211692 "Perfomance Evaluation Temps"
{
    ApplicationArea = Basic;
    CardPageID = "Perfomance Evaluation Template";
    PageType = List;
    SourceTable = "Perfomance Evaluation Template";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("General Instructions"; Rec."General Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("Global?"; Rec."Global?")
                {
                    ApplicationArea = Basic;
                }
                field("Primary Responsibility Center"; Rec."Primary Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Type"; Rec."Evaluation Type")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Rating Model"; Rec."Performance Rating Model")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Rating Scale"; Rec."Performance Rating Scale")
                {
                    ApplicationArea = Basic;
                }
                field("Proficiency Rating Scale"; Rec."Proficiency Rating Scale")
                {
                    ApplicationArea = Basic;
                }
                field("Total Score Model"; Rec."Total Score Model")
                {
                    ApplicationArea = Basic;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Default Competency A_Template"; Rec."Default Competency A_Template")
                {
                    ApplicationArea = Basic;
                }
                field("General A_Questionnaire"; Rec."General A_Questionnaire")
                {
                    ApplicationArea = Basic;
                }
                field("Peer Reviewer FB_Questionnaire"; Rec."Peer Reviewer FB_Questionnaire")
                {
                    ApplicationArea = Basic;
                }
                field("Total Allocated Weight (%)"; Rec."Total Allocated Weight (%)")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
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

