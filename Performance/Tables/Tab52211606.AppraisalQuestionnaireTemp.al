#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211697 "Appraisal Questionnaire Temp"
{
    // DrillDownPageID = "Appraisal Questionnaire Temp";
    // LookupPageID = "Appraisal Questionnaire TempC";

    fields
    {
        field(1; "Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Template Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General Assessment,360-Degree Peer Review';
            OptionMembers = "General Assessment","360-Degree Peer Review";
        }
        field(4; "General Instructions"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Global?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Primary Responsibility Center"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(7; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Blocked; Boolean)
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

