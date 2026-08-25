table 52211550 "Portal Doc Emp Selection"
{
    TableType = Temporary;
    fields
    {
        field(1; "Employee No."; Code[20]) { }
        field(2; "Employee Name"; Text[100]) { }
        field(3; "Department Code"; Code[20]) { }
        field(4; Selected; Boolean) { }
    }
    keys { key(Key1; "Employee No.") { Clustered = true; } }
}
