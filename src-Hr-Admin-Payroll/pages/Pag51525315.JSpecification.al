page 51525315 "J. Specification"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Company Jobs";
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("Job ID"; Rec."Job ID")
                {
                    Editable = true;
                    TableRelation = "Company Jobs";
                    trigger OnValidate()
                    var
                        CompJobs: Record "Company Jobs";
                    begin
                        if CompJobs.Get(Rec."Job ID") then begin
                            Rec."Job Description" := CompJobs."Job Description";
                        end;
                    end;
                }
                field("Job Description"; Rec."Job Description")
                {
                    Editable = false;
                }
                field("Total Score"; Rec."Total Score")
                {
                    Visible = false;
                }
            }
            label(Control1000000006)
            {
                CaptionClass = Text19024070;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(KPA; "Job Requirement Lines")
            {
                SubPageLink = "Job Id" = FIELD("Job ID");
            }
            part("Educational Needs"; "Job Education Needs")
            {
                Caption = 'Educational Needs';
                SubPageLink = "Job ID" = FIELD("Job ID");
                Visible = false;
            }
            part("Professional Certifications"; "Job Education Needs")
            {
                Caption = 'Professional Certifications';
                SubPageLink = "Job ID" = FIELD("Job ID");
                Visible = false;
            }
            part(Membership; "Job Professional Bodies")
            {
                Caption = 'Membership';
                SubPageLink = "Job ID" = FIELD("Job ID");
                Visible = false;
            }
            /*part("Job Questionnaires"; "Posittion Questionnaires")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
                Visible = false;
            }*/
        }
    }

    actions
    {
    }

    var
        Text19024070: Label 'Job Specification';
}