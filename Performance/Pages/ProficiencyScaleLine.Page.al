#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211701 "Proficiency Scale Line"
{
    PageType = ListPart;
    SourceTable = "Proficiency Scale Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Proficiency Scale ID"; Rec."Proficiency Scale ID")
                {
                    ApplicationArea = Basic;
                }
                field("Level ID"; Rec."Level ID")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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
                field("General Recommendations"; Rec."General Recommendations")
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

