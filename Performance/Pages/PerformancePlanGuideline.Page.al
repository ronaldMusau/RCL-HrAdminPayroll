#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211727 "Performance Plan Guideline"
{
    PageType = Card;
    SourceTable = "Performance Plan Guideline";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Performance Mgt Plan ID"; Rec."Performance Mgt Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Policy/Guideline ID"; Rec."Policy/Guideline ID")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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

