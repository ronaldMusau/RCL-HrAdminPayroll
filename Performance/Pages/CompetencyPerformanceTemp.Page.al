
Page 52211735 "Competency Performance Temp"
{
    PageType = Card;
    SourceTable = "Competency Per Template";

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
                field("Competency Proficiency Scale"; Rec."Competency Proficiency Scale")
                {
                    ApplicationArea = Basic;
                }
                field("Competency Scoring Model"; Rec."Competency Scoring Model")
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
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Job Grade"; Rec."Job Grade")
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
                field("Total Assigned Weight %"; Rec."Total Assigned Weight %")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control16; "Competency Template Line")
            {
                SubPageLink = "Competency Template ID" = field(Code);
            }
        }
    }

    actions
    {
    }
}


