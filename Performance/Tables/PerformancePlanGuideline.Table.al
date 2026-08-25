#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211703 "Performance Plan Guideline"
{

    fields
    {
        field(1; "Performance Mgt Plan ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Management Plan";
        }
        field(2; "Policy/Guideline ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Policy & Guideline".Code;
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Performance Mgt Plan ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

