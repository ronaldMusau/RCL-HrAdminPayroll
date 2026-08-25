table 52211742 "Additional Targets"
{
    Caption = 'Additional Targets';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[250])
        {
            Caption = 'Code';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(3; "Additional Target"; Text[2048])
        {
            Caption = 'Additional Target';
        }
        field(4; "Target Qty"; Decimal)
        {
            Caption = 'Target Qty';
        }
        field(5; "Results Achieved"; Decimal)
        {
            Caption = 'Results Achieved';
        }
        field(6; "Perfomance Appraisal"; Decimal)
        {
            Caption = 'Perfomance Appraisal';
        }
        field(7; Reasons; Text[2048])
        {
            Caption = 'Reasons';
        }
    }
    keys
    {
        key(PK; "Code", "Line No")
        {
            Clustered = true;
        }
    }
}
