page 51525408 "Training Schedule Card"
{
    ApplicationArea = All;
    Caption = 'Training Schedule Card';
    PageType = Card;
    SourceTable = "Training Schedules";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Training Request No."; Rec."Training Request No.")
                {
                    ApplicationArea = All;
                    Caption = 'Training Request No.';
                    ToolTip = 'Links this schedule to an approved Training Request and auto-populates participants.';
                }
                field("Training No."; Rec."Training No.")
                {
                    Caption = 'Event Title';
                    Editable = EnableEditing;
                    ToolTip = 'Specifies the value of the Training No. field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Participants Count"; Rec."Participants Count")
                {
                    Editable = false;
                }
                field("Participants Emailed"; Rec."Participants Emailed")
                {
                    Editable = false;
                }
                field("Participants Emailed On"; Rec."Participants Emailed On")
                {
                    Editable = false;
                }
            }
            part("Training Schedule Lines"; "Training Schedule Lines")
            {
                Caption = 'Participants';
                SubPageLink = "Schedule No." = FIELD("No.");
                UpdatePropagation = Both;
                Editable = SubpartEditable;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
            action("Additional Instructors")
            {
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Additional Instructors";
                RunPageLink = "Class No." = field("No.");
            }
            action("Notify Participants")
            {
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    TrainSchedLines: Record "Training Schedule Lines";
                    Email: Codeunit "Email";
                    EmailMessage: Codeunit "Email message";
                    emailhdr: Text;
                    emailbody: Text;
                    Window: Dialog;
                    TotalCount: Integer;
                    Percentage: Integer;
                    Counter: Integer;
                    Emp: Record Employee;
                    EmailsSent: Integer;

                /*filePath: Text;
                exportFile: File;
                dataOutStream: OutStream;*/
                begin
                    EmailsSent := 0;

                    if Rec."Participants Emailed" then
                        if not Confirm('The participants were already notified on ' + Format(Rec."Participants Emailed On") + '. Do you still want to email them?') then exit;
                    Window.Open('Notifying participant: #1##');

                    TrainSchedLines.Reset();
                    TrainSchedLines.SetRange("Schedule No.", Rec."No.");
                    if TrainSchedLines.FindSet() then begin
                        repeat
                            Window.Update(1, TrainSchedLines."Emp No." + ' : ' + TrainSchedLines."Employee Name");

                            Emp.Reset();
                            Emp.SetRange("No.", TrainSchedLines."Emp No.");
                            if Emp.FindFirst() then begin
                                if Emp."Company E-Mail" <> '' then begin
                                    emailbody := 'Dear ' + TrainSchedLines."Employee Name" + ',<br>';
                                    emailbody := emailbody + '<p>Kindly note that you are a participant of this training: <strong>' + Rec."Training Title" + '</strong> which has been scheduled to take place on <strong>' + Format(Rec."Start Date") + '</strong>. Kindly prepare accordingly.<br>';
                                    emailbody := emailbody + 'Kind Regards.<br><br>';
                                    EmailMessage.Create(Emp."Company E-Mail", 'Training Schedule: ' + Rec."Training Title", emailbody, true);
                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                    EmailsSent += 1;
                                end;
                            end;
                        until TrainSchedLines.Next() = 0;
                    end;

                    Window.Close;
                    if EmailsSent > 0 then begin
                        Rec."Participants Emailed" := true;
                        Rec."Participants Emailed On" := CurrentDateTime;
                        Rec.Modify;
                        Message('Participant(s) Notified Successfully!!');
                    end else
                        Error('Notifications not sent! Try again later.');
                end;
            }
            action(PostSchedule)
            {
                Caption = 'Post';
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Open;
                trigger OnAction()
                begin
                    if not Confirm('Post this Training Schedule? Status will change to Ongoing.') then
                        exit;
                    Rec.Status := Rec.Status::Ongoing;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(CompleteSchedule)
            {
                Caption = 'Complete';
                ApplicationArea = All;
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Ongoing;
                trigger OnAction()
                begin
                    if not Confirm('Mark this Training Schedule as Completed?') then
                        exit;
                    Rec.Status := Rec.Status::Completed;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(ReopenSchedule)
            {
                Caption = 'Reopen';
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (Rec.Status = Rec.Status::Ongoing) or
                          (Rec.Status = Rec.Status::Completed);
                trigger OnAction()
                begin
                    if not Confirm('Reopen this Training Schedule? Status will reset to Open.') then
                        exit;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status := Rec.Status::Open;
    end;

    trigger OnAfterGetRecord()
    begin
        EnableEditing := Rec.Status = Rec.Status::Open;
        CurrPage.Editable := (Rec.Status = Rec.Status::Open) or
                             (Rec.Status = Rec.Status::Ongoing);
        SubpartEditable := (Rec.Status = Rec.Status::Open) or
                           (Rec.Status = Rec.Status::Ongoing);
        CurrPage."Training Schedule Lines".PAGE.SetOngoing(
            Rec.Status = Rec.Status::Ongoing);
    end;

    trigger OnOpenPage()
    var
        TrainingMasterRec: Record "Training Master Plan Header";
    begin
        CurrPage.Editable(true);
        EnableEditing := true;
        if TrainingMasterRec.IsAReadOnlyUser() then
            EnableEditing := false;
    end;

    var
        Classes: Record "Training Schedules";
        Participants: Record "Training Schedule Lines";
        OtherParticipants: Record "Training Schedule Lines";
        ParticipantInit: Record "Training Schedule Lines";
        EmpRec: Record Employee;
        EnableEditing: Boolean;
        SubpartEditable: Boolean;
        Window: Dialog;


    procedure UpdateRecords()
    var
        LineNo: Integer;
        TrainingMasterRec: Record "Training Master Plan Header";
        OldEmpNo: Code[50];
        NewEmpNo: Code[50];
        Update: Boolean;
        DocAttachments: Record "Document Attachment";
        DocAttachmentsInit: Record "Document Attachment";
    begin
        Window.Open('Processing: ##');
        Classes.Reset();
        Classes.SetRange("Legacy Data", true);
        if Classes.FindSet() then
            repeat
                //LineNo := 0;
                Participants.Reset();
                Participants.SetRange("Schedule No.", Classes."No.");
                //Participants.SetRange("Emp No.",'WB ');
                if Participants.FindSet() then
                    repeat
                        Window.Update(0, Participants."Emp No.");
                        Update := true;
                        //LineNo += 1;
                        //Participants."Line No." := LineNo;
                        if StrPos(Participants."Emp No.", 'WB ') <> 0 then begin
                            OldEmpNo := Participants."Emp No.";
                            NewEmpNo := 'WB' + DelChr(CopyStr(Participants."Emp No.", 3), '=', ' ');
                            OtherParticipants.Reset();
                            OtherParticipants.SetRange("Schedule No.", Classes."No.");
                            OtherParticipants.SetRange("Emp No.", NewEmpNo);
                            if OtherParticipants.FindFirst() then begin
                                Update := false;
                                if (OtherParticipants."Certificate Serial No." = '') and (OtherParticipants."Certificate Link" = '') then begin
                                    OtherParticipants.delete();
                                    Update := true;
                                end;
                            end;
                            //Participants."Emp No." := NewEmpNo;
                            EmpRec.Reset();
                            EmpRec.SetRange("No.", NewEmpNo);
                            if EmpRec.FindFirst() then begin
                                Participants."Employee Name" := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                                Participants."Department Code" := EmpRec."Responsibility Center";
                                Participants."Job Title" := EmpRec."Job Title";
                                Participants.Section := EmpRec."Sub Responsibility Center";
                            end;
                            //Participants.Validate("Emp No.");
                            //Participants.updateParticipantType();
                            if Update then begin
                                //Delete then add as a new entry
                                //Participants.Rename(NewEmpNo, Classes."No."); //Participants.Modify();
                                ParticipantInit.Init();
                                ParticipantInit.TransferFields(Participants);
                                ParticipantInit."Emp No." := NewEmpNo;
                                ParticipantInit.updateParticipantType();
                                Participants.Delete();
                                ParticipantInit.Insert();

                                //Cater for attachments
                                DocAttachments.Reset();
                                DocAttachments.SetRange("Table ID", Database::"Training Schedule Lines");
                                DocAttachments.SetRange("No.", Classes."No." + '-' + OldEmpNo);
                                if DocAttachments.FindSet() then
                                    repeat
                                        DocAttachments."No." := Classes."No." + '-' + NewEmpNo;
                                        DocAttachments.Modify();
                                    until DocAttachments.Next() = 0;
                            end;
                        end;
                    until Participants.Next() = 0;
            //Classes.Validate("Start Date");
            //Classes.Validate(Status);
            until Classes.Next() = 0;
        Window.Close();
    end;
}
