#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211710 "Appraisal Questionnaire Temp C"
{
    PageType = Card;
    SourceTable = "Appraisal Questionnaire Temp";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Template Category"; Rec."Template Category")
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
                field("Effective Date"; Rec."Effective Date")
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

