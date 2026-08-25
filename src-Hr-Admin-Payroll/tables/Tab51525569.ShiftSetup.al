table 51525569 "Shift Setup"
{
    Caption = 'Shift Setup';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Shift Setup List";
    LookupPageId = "Shift Setup List";
    
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(4; "End Time"; Time)
        {
            Caption = 'End Time';
        }
        field(5; "Night Shift"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
