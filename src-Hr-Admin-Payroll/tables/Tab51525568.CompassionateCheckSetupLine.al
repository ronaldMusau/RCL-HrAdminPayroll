table 51525568 "Compassionate Check Setup Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Setup Code"; Code[20])
        {
            Caption = 'Setup Code';
            NotBlank = true;
            TableRelation = "Compassionate Check Setup"."Code";
        }
        field(2; "Job Grade"; Code[20])
        {
            Caption = 'Job Grade';
            NotBlank = true;
            TableRelation = "Salary Scales";
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
        key(PK; "Setup Code", "Job Grade")
        {
            Clustered = true;
        }
    }
}
