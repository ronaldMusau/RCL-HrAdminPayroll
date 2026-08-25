table 51525479 Villages
{
    Caption = 'Villages';
    DataClassification = ToBeClassified;
    LookupPageId = Villages;

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
        field(3; Cell; Code[50])
        {
            Caption = 'Cell';
            TableRelation = "Cells".Name WHERE(
                Sector = FIELD(Sector),
                District = FIELD(District),
                Province = FIELD(Province),
                "Country/Region Code" = FIELD("Country/Region Code"));
        }
        field(4; Sector; Code[50])
        {
            Caption = 'Sector';
            TableRelation = "Sectors".Name WHERE(
                District = FIELD(District),
                Province = FIELD(Province),
                "Country/Region Code" = FIELD("Country/Region Code"));
        }
        field(5; District; Code[50])
        {
            Caption = 'District';
            TableRelation = "Districts".Name WHERE(
                Province = FIELD(Province),
                "Country/Region Code" = FIELD("Country/Region Code"));
        }
        field(6; Province; Code[50])
        {
            Caption = 'Province';
            TableRelation = "Provinces".Name WHERE("Country/Region Code" = FIELD("Country/Region Code"));
        }
        field(7; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;
        }
    }
    keys
    {
        key(PK; Name, Cell, Sector, District, Province, "Country/Region Code")
        {
            Clustered = true;
        }
    }
}