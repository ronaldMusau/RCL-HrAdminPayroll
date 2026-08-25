page 51525411 "Ongoing Trainings"
{
    ApplicationArea = All;
    Caption = 'Ongoing Trainings';
    PageType = List;
    SourceTable = "Training Schedules";
    UsageCategory = Lists;
    CardPageId = "Training Schedule Card";
    SourceTableView = Where(Status = const(Ongoing));
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the schedule number.';
                }
                field("Training Request No."; Rec."Training Request No.")
                {
                    Caption = 'Request No.';
                    ToolTip = 'Specifies the linked Training Request.';
                }
                field("Training No."; Rec."Training No.")
                {
                    Caption = 'Event Title';
                    ToolTip = 'Specifies the event title entered by HR.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'Scheduled Date';
                    ToolTip = 'Specifies the scheduled start date.';
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'Completion Date';
                    ToolTip = 'Specifies the scheduled end date.';
                }
                field("Participants Count"; Rec."Participants Count")
                {
                    ToolTip = 'Specifies the number of participants.';
                }
            }
        }
    }
}