#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211674 "Strategy"
{
    DrillDownPageID = Strategies;
    LookupPageID = Strategies;

    fields
    {
        field(1; "Strategic Plan ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans".Code;
        }
        field(2; "Theme ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Theme"."Theme ID";
        }
        field(3; "Objective ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Objective"."Objective ID";
        }
        field(4; "Strategy ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. of Strategic Activities"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Goal ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Goals"."Goal ID";
        }
    }

    keys
    {
        key(Key1; "Strategic Plan ID", "Strategy ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

