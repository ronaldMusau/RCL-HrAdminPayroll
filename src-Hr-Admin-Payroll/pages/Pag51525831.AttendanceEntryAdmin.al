page 51525821 "Attendance Entry Admin"
{
    ApplicationArea = All;
    Caption = 'Time & Attendance';
    PageType = List;
    SourceTable = "Attendance Entry";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field("AC-No."; Rec."AC-No.") { }
                field("Department"; Rec.Department)
                {
                    Visible = false;
                }
                field("Staff Name"; Rec."Staff Name") { }
                field("Date"; Rec.Date) { }
                field("Clock In"; Rec."Clock In") { }
                field("Clock Out"; Rec."Clock Out") { }
                field("Work Time"; Rec."Work Time") { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Attendance Report")
            {
                Caption = 'Time and Attendance Report';
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Report;
                Image = PrintReport;
                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("AC-No.", Rec."AC-No.");
                    Report.Run(Report::"Attendance Report", true, true, Rec);
                end;
            }
        }
    }
}
