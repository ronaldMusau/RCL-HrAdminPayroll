table 51525580 "PIP Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Cutoff Score"; Decimal)
        {
            Caption = 'Cutoff Score (%)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(3; "PIP Nos"; Code[20])
        {
            Caption = 'PIP Nos.';
            TableRelation = "No. Series";
        }
        field(4; "Notify HR"; Boolean)
        {
            Caption = 'Notify HR';
        }
        field(5; "HR Email"; Text[100])
        {
            Caption = 'HR Email';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}
