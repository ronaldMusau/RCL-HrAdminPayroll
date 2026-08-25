table 52211739 "Corporate Objectives"
{
    Caption = 'Corporate Objectives';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Corporate Objectives";
    LookupPageId = "Corporate Objectives";

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[600])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}