#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211728 "Evaluation Training needs"
{
    DrillDownPageID = "Evaluation Training Needs";
    LookupPageID = "Evaluation Training Needs";

    fields
    {
        field(1; "Perfomance Evaluation No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Evaluation".No;
        }
        field(2; "Training Need Number"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Training Need Category"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Evaluation Needs Category".Code;
        }
        field(4; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Training Duration"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Duration';
        }
        field(6; "Appraisee's Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Supervisor's Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Course"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Courses Setup";

            trigger OnValidate()
            var
                Courses: Record "Training Courses Setup";
            begin
                if Course <> '' then begin
                    Courses.get(Course);
                    Description := Courses.Descritpion;
                end else begin
                    Description := '';
                end;
            end;
        }
        field(9; "Evaluation Type"; Option)
        {
            OptionMembers = "Standard","Self";
        }
    }

    keys
    {
        key(Key1; "Perfomance Evaluation No", "Training Need Number", "Training Need Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

