table 51525475 Provinces
{
    Caption = 'Provinces';
    DataClassification = ToBeClassified;
    LookupPageId = Provinces;

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
        field(3; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                // Optionally clear lower-level fields if country changes
            end;
        }
    }
    keys
    {
        key(PK; Name, "Country/Region Code")
        {
            Clustered = true;
        }
    }
}