page 51525463 "Job Requirement Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Job Requirement";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Qualification Type"; Rec."Qualification Type")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        QualTypes: Page "Qualification Types";
                        QualRec: Record "Qualification Types";
                    begin
                        QualTypes.LookupMode(true);
                        if QualTypes.RunModal() = Action::LookupOK then begin
                            QualTypes.GetRecord(QualRec);
                            Rec."Qualification Type" := QualRec.Code;
                        end;
                    end;
                }
                field(Level; Rec.Level)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    Visible = false;
                }
                field(Qualification; Rec.Qualification)
                {
                }
            }
        }
    }

    actions
    {
    }
}