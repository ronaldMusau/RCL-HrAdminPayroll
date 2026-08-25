table 51525455 "Medical Information"
{
    DrillDownPageId = "Medical Information Setup";
    LookupPageId = "Medical Information Setup";

    fields
    {
        field(1; Description; Code[50])
        {
        }
        field(2; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}