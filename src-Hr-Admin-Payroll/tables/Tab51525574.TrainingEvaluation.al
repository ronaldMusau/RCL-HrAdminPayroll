table 51525574 "Training Evaluation"
{
    Caption = 'Training Evaluation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Training No."; Code[50])
        {
            Caption = 'Training No.';
            TableRelation = "Training Schedules"."No.";
        }
        field(3; "Training Title"; Text[250])
        {
            Caption = 'Training Title';
            Editable = false;
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if Emp.Get("Employee No.") then
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Last Name";
            end;
        }
        field(5; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(6; "Evaluation Date"; Date)
        {
            Caption = 'Evaluation Date';
        }
        field(7; "Overall Rating"; Integer)
        {
            Caption = 'Overall Rating (1-5)';
            MinValue = 1;
            MaxValue = 5;
        }
        field(8; "Trainer Rating"; Integer)
        {
            Caption = 'Trainer Rating (1-5)';
            MinValue = 1;
            MaxValue = 5;
        }
        field(9; "Course Content Rating"; Integer)
        {
            Caption = 'Course Content Rating (1-5)';
            MinValue = 1;
            MaxValue = 5;
        }
        field(10; "Venue Rating"; Integer)
        {
            Caption = 'Venue Rating (1-5)';
            MinValue = 1;
            MaxValue = 5;
        }
        field(11; Comments; Text[2000])
        {
            Caption = 'Comments';
        }
        field(12; "Submitted By"; Code[50])
        {
            Caption = 'Submitted By';
            Editable = false;
        }
        field(13; "Submitted On"; DateTime)
        {
            Caption = 'Submitted On';
            Editable = false;
        }
        field(14; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(K2; "Training No.", "Employee No.")
        { }
    }

    trigger OnInsert()
    begin
        "Submitted By" := UserId;
        "Submitted On" := CurrentDateTime;
    end;
}
