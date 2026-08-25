table 52211738 "Strategic Goals"
{
    Caption = 'Strategic Goals';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Strategic Plan ID"; Code[250])
        {
            Caption = 'Strategic Plan ID';
        }
        field(2; "Theme ID"; Code[2048])
        {
            Caption = 'Theme ID';
        }
        field(3; "Goal ID"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[2048])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Strategic Plan ID", "Theme ID", "Goal ID")
        {
            Clustered = true;
        }
    }
}
