table 51525567 "Compassionate Check Setup"
{
    DataClassification = CustomerContent;
    LookupPageId = "Compassionate Check Setup";
    DrillDownPageId = "Compassionate Check Setup";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }

        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
        }

        field(3; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Code") { Clustered = true; }
    }
}
