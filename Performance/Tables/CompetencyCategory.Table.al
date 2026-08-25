#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211689 "Competency Category"
{
    LookupPageId = "Competency Categories";
    DrillDownPageId = "Competency Categories";

    fields
    {
        field(1; "Code"; Code[50])
        {

        }
        field(2; Description; Text[100])
        {

        }
        field(3; Blocked; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

