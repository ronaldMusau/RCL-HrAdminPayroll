table 51525477 Sectors
{
    Caption = 'Sectors';
    DataClassification = ToBeClassified;
    LookupPageId = Sectors;

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
        field(3; District; Code[50])
        {
            Caption = 'District';
            TableRelation = "Districts".Name WHERE(
                Province = FIELD(Province),
                "Country/Region Code" = FIELD("Country/Region Code"));
        }
        field(4; Province; Code[50])
        {
            Caption = 'Province';
            TableRelation = "Provinces".Name WHERE("Country/Region Code" = FIELD("Country/Region Code"));
        }
        field(5; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;
        }
    }
    keys
    {
        key(PK; Name, District, Province, "Country/Region Code")
        {
            Clustered = true;
        }
    }
}