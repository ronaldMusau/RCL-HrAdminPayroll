
Page 52211708 "Competency Template Line"
{
    PageType = ListPart;
    SourceTable = "Competency Template Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Competency Template ID"; Rec."Competency Template ID")
                {
                    ApplicationArea = Basic;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic;
                }
                field("Competency Code"; Rec."Competency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Competency Description"; Rec."Competency Description")
                {
                    ApplicationArea = Basic;
                }
                field("Competency Category"; Rec."Competency Category")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Weight %"; Rec."Weight %")
                {
                    ApplicationArea = Basic;
                }
                field("Job Grade"; Rec."Job Grade")
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



