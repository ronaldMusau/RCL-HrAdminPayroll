#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211687 "PC Goal Hub"
{
    DrillDownPageID = "Aligned Business Goals";
    LookupPageID = "Aligned Business Goals";

    fields
    {
        field(1; "Goal ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Performance Contract ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No;
        }
        field(3; "Goal Description"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Aligned-To Strategic Plan ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans".Code;
        }
        field(5; "Aligned-To PC ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Aligned-To PC Goal ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Goal ID", "Performance Contract ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

