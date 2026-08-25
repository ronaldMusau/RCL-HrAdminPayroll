#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211826 "Perfomance Scale Line"
{
    PageType = ListPart;
    SourceTable = "Perfomance Scale Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Performance Scale ID"; Rec."Performance Scale ID")
                {
                    ApplicationArea = Basic;
                }
                field("Perfomance Grade"; Rec."Perfomance Grade")
                {
                    ApplicationArea = Basic;
                }
                field("Default Score Value"; Rec."Default Score Value")
                {
                    ApplicationArea = Basic;
                }
                field("Behavioral Indicator"; Rec."Behavioral Indicator")
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit Target (%)"; Rec."Lower Limit Target (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit Target (%)"; Rec."Upper Limit Target (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit Criteria Value"; Rec."Lower Limit Criteria Value")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit Criteria Value"; Rec."Upper Limit Criteria Value")
                {
                    ApplicationArea = Basic;
                }
                field("Criteria Value Range Span"; Rec."Criteria Value Range Span")
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

