
Table 52211680 "Performance Indicator"
{
    DrillDownPageID = "Performance Indicators";
    LookupPageID = "Performance Indicators";

    fields
    {
        field(1; KPI; Code[50])
        {

            Description = 'KPI';
        }
        field(2; Description; Text[250])
        {

            Description = 'Perfomance Indicator';
        }
        field(3; "Unit of Measure"; Code[100])
        {

            TableRelation = "Unit of Measure".Code;
        }
        // field(4; "Directorate Code"; Code[20])
        // {
        //     TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Directorate));
        // }
        field(5; "Department Code"; Code[20])
        {
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
    }

    keys
    {
        key(Key1; KPI)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

