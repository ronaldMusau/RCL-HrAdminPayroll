page 51525830 "Attendance Entry List"
{
    ApplicationArea = All;
    Caption = 'Attendance Entry List';
    PageType = List;
    SourceTable = "Attendance Entry";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.") { }
                field("AC-No."; Rec."AC-No.") { }
                field("Department"; Rec.Department) { }
                field("Staff Name"; Rec."Staff Name") { }
                field("Date"; Rec.Date) { }
                field("Clock In"; Rec."Clock In") { }
                field("Clock Out"; Rec."Clock Out") { }
                field("Work Time"; Rec."Work Time") { }
            }
        }
    }
    trigger OnOpenPage()
    begin
        AttendanceEntry.Reset();
        if AttendanceEntry.FindSet() then begin
            repeat
                Emp.Reset();
                Emp.SetRange("Biometric ID", AttendanceEntry."AC-No.");
                if Emp.FindFirst() then begin
                    AttendanceEntry."Staff Name" := Emp.FullName();
                    AttendanceEntry.Department := Emp."Responsibility Center Name";
                    AttendanceEntry.Modify();
                end;
            until AttendanceEntry.Next() = 0;
        end;
        Rec."Work Time" := Rec."Clock Out" - Rec."Clock In";
    end;

    var
        Emp: Record Employee;
        AttendanceEntry: Record "Attendance Entry";
}
