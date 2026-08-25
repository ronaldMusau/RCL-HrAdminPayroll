table 51525476 Districts
{
    Caption = 'Districts';
    DataClassification = ToBeClassified;
    LookupPageId = Districts;

    fields
    {
        field(1; Name; Code[50])
        {
            Caption = 'Name';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; Province; Code[50])
        {
            Caption = 'Province';
            TableRelation = "Provinces".Name WHERE("Country/Region Code" = FIELD("Country/Region Code"));
        }
        field(4; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;
        }
    }
    keys
    {
        key(PK; Name, Province, "Country/Region Code")
        {
            Clustered = true;
        }
    }
}