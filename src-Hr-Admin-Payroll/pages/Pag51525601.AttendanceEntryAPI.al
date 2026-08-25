page 51525831 "Attendance Entry API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'attendanceEntryAPI';
    DelayedInsert = true;
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    PageType = API;
    SourceTable = "Attendance Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(EntryNo; Rec."Entry No.") { }
                field(ACNo; Rec."AC-No.") { }
                field(Department; Rec.Department) { }
                field(StaffName; Rec."Staff Name") { }
                field(Date; Rec.Date) { }
                field(ClockIn; Rec."Clock In") { }
                field(ClockOut; Rec."Clock Out") { }
                field(WorkTime; Rec."Work Time") { }
            }
        }
    }
}
