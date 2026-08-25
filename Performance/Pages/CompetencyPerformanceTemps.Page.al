
Page 52211707 "Competency Performance Temps"
{
    ApplicationArea = Basic;
    CardPageID = "Competency Performance Temp";
    Editable = false;
    PageType = List;
    SourceTable = "Competency Per Template";
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
        }
    }

    actions
    {
    }
}


