#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211691 "Proficiency Scale Line"
{

    fields
    {
        field(1; "Proficiency Scale ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Competency Proficiency Scale".Code;
        }
        field(2; "Level ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Default Score Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Behavioral Indicator"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "General Recommendations"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Proficiency Scale ID", "Level ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

