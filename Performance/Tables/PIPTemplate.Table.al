#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211709 "PIP Template"
{

    fields
    {
        field(1; "Template ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Due Date Calculation"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Performance Rating Scale"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Template ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

