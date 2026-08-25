table 52211548 "Portal Doc Distribution"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Document Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Rules & Regulations".Code;
        }
        field(3; "Document Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Send To"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "All Employees","By Department","Individual Employee";
            OptionCaption = 'All Employees,By Department,Individual Employee';
        }
        field(5; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(6; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(7; "Sent Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sent By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "File Extension"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Attachment ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Code", "Employee No.")
        {
        }
        key(Key3; "Document Code", "Department Code")
        {
        }
    }
}
