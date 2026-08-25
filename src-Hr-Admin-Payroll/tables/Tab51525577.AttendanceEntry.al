table 51525577 "Attendance Entry"
{
    Caption = 'Attendance Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "AC-No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Emp.Reset();
                Emp.SetRange("Biometric ID", "AC-No.");
                if Emp.FindFirst() then begin
                    "Staff Name" := Emp.FullName();
                    Department := Emp."Responsibility Center Name";
                end;
            end;
        }
        field(3; "Department"; Text[50])
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(4; "Staff Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Clock In"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Clock Out"; Time)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Work Time" := "Clock Out" - "Clock In";
            end;
        }
        field(8; "Work Time"; Duration)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "AC-No.", "Staff Name", "Clock In", "Clock Out", "Work Time") { }
    }
    var
        Emp: Record Employee;
}
