#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211695 "Competency Per Template"
{
    DrillDownPageID = "Competency Performance Temps";
    LookupPageID = "Competency Performance Temps";

    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Competency Proficiency Scale"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Competency Scoring Model"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Weighted Performance,Weighted Proficiency';
            OptionMembers = "Weighted Performance","Weighted Proficiency";
        }
        field(5; "General Instructions"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Global?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Primary Responsibility Center"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(8; "Job Title"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Job Grade"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scales".Scale;
        }
        field(10; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Total Assigned Weight %"; Decimal)
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

