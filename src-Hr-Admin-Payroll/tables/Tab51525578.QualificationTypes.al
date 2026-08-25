table 51525578 "Qualification Types"
{
    Caption = 'Qualification Types';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Qualification Types";
    fields
    {
        field(1; "Code"; Code[200])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[250])
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
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description) { }
    }
}
