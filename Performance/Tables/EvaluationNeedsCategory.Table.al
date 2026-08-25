#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211729 "Evaluation Needs Category"
{
    DrillDownPageID = "Evaluation Needs Category";
    LookupPageID = "Evaluation Needs Category";

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Desription; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Policy Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Summary"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

