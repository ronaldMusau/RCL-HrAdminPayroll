#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211690 "Competency Proficiency Scale"
{
    DrillDownPageID = "Competency Proficiency Scales";
    LookupPageID = "Competency Proficiency Scales";

    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Competency Scoring Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Weighted Performance,Weighted Proficiency';
            OptionMembers = "Weighted Performance","Weighted Proficiency";
        }
        field(4; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Created On"; Date)
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

