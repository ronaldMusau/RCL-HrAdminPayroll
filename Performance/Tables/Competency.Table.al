
Table 52211694 "Competency"
{
    DrillDownPageID = Competencies;
    LookupPageID = Competencies;

    fields
    {
        field(1; "No."; Code[50])
        {

        }
        field(2; Description; Code[100])
        {

        }
        field(3; "Competency Summary"; Text[255])
        {

        }
        field(4; "Competency Category"; Code[50])
        {

            TableRelation = "Competency Category";
        }
        field(5; Blocked; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

