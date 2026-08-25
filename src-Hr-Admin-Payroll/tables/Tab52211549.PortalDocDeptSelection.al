table 52211549 "Portal Doc Dept Selection"
{
    TableType = Temporary;
    fields
    {
        field(1; "Department Code"; Code[20]) { }
        field(2; "Department Name"; Text[100]) { }
        field(3; Selected; Boolean) { }
    }
    keys { key(Key1; "Department Code") { Clustered = true; } }
}
