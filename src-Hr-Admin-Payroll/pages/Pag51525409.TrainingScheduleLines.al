page 51525409 "Training Schedule Lines"
{
    ApplicationArea = All;
    Caption = 'Participants';
    PageType = ListPart;
    SourceTable = "Training Schedule Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Emp No."; Rec."Emp No.")
                {
                    ToolTip = 'Specifies the value of the Emp No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    Caption = 'Course';
                    ToolTip = 'Specifies the course name for this participant.';
                }
                field(Trainer; Rec.Trainer)
                {
                    ApplicationArea = All;
                    Caption = 'Trainer Name';
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                    Caption = 'Venue';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Certificate Expiry Date"; Rec."Certificate Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Notification Days"; Rec."Notification Days")
                {
                    ApplicationArea = All;
                }
                field("Permit Type"; Rec."Permit Type")
                {
                    ApplicationArea = All;
                }
                field(Attended; Rec.Attended)
                {
                    ApplicationArea = All;
                    Editable = IsOngoing;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DuplicateLine)
            {
                Caption = 'Duplicate Line';
                ApplicationArea = All;
                Image = Copy;

                trigger OnAction()
                var
                    NewLine: Record "Training Schedule Lines";
                begin
                    NewLine := Rec;
                    NewLine."Line No." := 0;
                    NewLine.Insert(true);
                    CurrPage.Update(false);
                    Message('Line duplicated successfully.');
                end;
            }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Certificates';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                    TrainingScheduleLines: Record "Training Schedule Lines";
                begin
                    CurrPage.SetSelectionFilter(TrainingScheduleLines);
                    if TrainingScheduleLines.FindFirst() then begin
                        RecRef.GetTable(TrainingScheduleLines);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        //DocumentAttachmentDetails.SetFilters(FALSE, TrainingScheduleLines."Schedule No." + '-' + TrainingScheduleLines."Emp No." + '-' + Format(TrainingScheduleLines."Line No."));
                        DocumentAttachmentDetails.RunModal;
                    end;
                end;
            }
        }
    }

    var
        IsOngoing: Boolean;

    procedure SetOngoing(Value: Boolean)
    begin
        IsOngoing := Value;
    end;
}