#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211726 "Evaluation PIP"
{
    DrillDownPageID = "Evaluation Improvement Plan";
    LookupPageID = "Evaluation Improvement Plan";

    fields
    {
        field(1; "Perfomance Evaluation No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Evaluation".No;
        }
        field(2; "PIP Number"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "PIP Category"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Evaluation PIP Category".Code;

            trigger OnValidate()
            begin
                EvaluationPIPCategory.Reset();
                EvaluationPIPCategory.SetRange(Code, "PIP Category");
                if EvaluationPIPCategory.Find('-') then begin
                    Description := EvaluationPIPCategory.Description;
                end
            end;
        }
        field(4; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Perfomance Evaluation No", "PIP Number", "PIP Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        EvaluationPIPCategory: Record "Evaluation PIP Category";
}

