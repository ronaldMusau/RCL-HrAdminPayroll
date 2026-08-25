table 52211547 "Emp Document Category"
{
    Caption = 'Employee Document Category';
    DrillDownPageID = "Emp Document Category List";
    LookupPageID = "Emp Document Category List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Required; Boolean)
        {
            Caption = 'Required';
            DataClassification = ToBeClassified;
        }
        field(4; "Allow Employee Upload"; Boolean)
        {
            Caption = 'Allow Employee Upload';
            DataClassification = ToBeClassified;
        }
        field(5; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
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
        fieldgroup(DropDown; Code, Description)
        {
        }
    }
}
