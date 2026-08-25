table 51525454 "Medical History"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = true;
        }
        field(6; "Line No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; Description; Text[220])
        {
        }
        field(3; Results; Text[250])
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; Remarks; Text[250])
        {
        }
        field(7; "Certificate Type"; Code[20])
        {
            TableRelation = "Medical Information".Description;
        }
        field(8; "Issue Date"; Date)
        {
        }
        field(9; "Expiry Date"; Date)
        {
            trigger OnValidate()
            begin
                if ("Expiry Date" <> 0D) and ("Issue Date" <> 0D) and ("Expiry Date" < "Issue Date") then
                    Error('Expiry Date must be on or after Issue Date.');
            end;
        }
        field(10; "Notification Days"; Integer)
        {
            InitValue = 30;
        }
        field(11; Notified; Boolean)
        {
            Editable = false;
        }
        field(12; "Certificate No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Line No.")
        {
            Clustered = true;
        }
        key(K2; "Employee No", "Expiry Date")
        {
        }
    }

    fieldgroups
    {
    }
}
