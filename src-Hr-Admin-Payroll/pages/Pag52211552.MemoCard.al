page 52211552 "Memo Card"
{
    PageType = Card;
    SourceTable = "Memo Header";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    // Editable = false;
                }
                field("Requestor User ID"; Rec."Requestor User ID")
                {
                    Caption = 'Requestor';
                }
                field("Requestor Name"; Rec."Requestor Name")
                {

                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                    Caption = 'Document Date';
                }
                field("Department Code"; Rec."Department Code")
                {

                }
                field("Purpose"; Rec.Purpose)
                {

                }
                field("Activity Date"; Rec."Activity Date")
                {

                }
                field("End Date"; Rec."End Date")
                {

                }

                field(Status; Rec."Approval Status")
                {
                    Editable = false;
                }
            }

            part("Memo Lines"; "Memo Lines")
            {
                Caption = 'Memo Lines';
                SubPageLink = "Doc No" = field("No.");
            }
            part("Memo attendees"; "Memo Attenders")
            {
                Caption = 'Attendees';
                SubPageLink = "Doc No" = field("No.");
                // Visible = false;
            }
            part(DocAttach; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                SubPageLink =
                    "Table ID" = const(Database::"Memo Header"),
                    "No." = field("No.");
                Visible = false;
            }

        }

        area(FactBoxes)
        {
            part(ApprovalEntries; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(51525558), "Document No." = field("No.");
            }
        }

    }




    actions
    {
        area(Processing)
        {
            // 1️⃣ Your real actions (logic)
            action(MyAttachment)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;

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
            action(MyAttachment2)
            {
                ApplicationArea = All;
                Caption = 'View Attachments';
                Image = Attach;
                Visible = false;

                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                    DocAttachRec: Record "Document Attachment";
                begin
                    DocAttachRec.SetRange("Table ID", DATABASE::"Memo Header");
                    DocAttachRec.SetRange("No.", Rec."No.");

                    DocumentAttachmentDetails.SetTableView(DocAttachRec);
                    DocumentAttachmentDetails.RunModal();
                end;

            }
            action(MySendApproval)
            {
                Caption = 'Send Approval Request';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    VarVariant := Rec;
                    if (Rec."Approval Status" <> Rec."Approval Status"::Open) and (Rec."Approval Status" <> Rec."Approval Status"::Rejected) then
                        Error('Document Status has to be open');
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                    Rec.Get(Rec."No.");
                    Message('Approval request has been sent successfully.');
                    CurrPage.Update(true);
                end;
            }
            action(MyCancelApproval)
            {
                Caption = 'Cancel Approval Request';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Rec."Approval Status" <> Rec."Approval Status"::Released then begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        Message('Approval request has been Canceled');
                        Rec.Get(Rec."No.");
                        if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then begin
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec.Modify();
                            CurrPage.Update(true);
                        end;
                    end;
                end;
            }
            action(MyApprovals)
            {
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::Open;
                    Rec.Modify();
                    CurrPage.Update(true);
                end;
            }


            action("Post Doc")
            {
                Caption = 'Post';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.posted := true;
                    Rec.Modify();
                    SendEmailToAttendees();
                    Message('Memo posted and attendees have been notified via email.');
                end;
            }
            action(PrintMemoReport)
            {
                ApplicationArea = All;
                Caption = 'Print Memo Report';
                Image = Print;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    MemoHeader: Record "Memo Header";
                begin
                    RecRef.GetTable(Rec);
                    Report.RunModal(Report::"Memo Report", true, true, MemoHeader);
                end;
            }


        }
        area(Promoted)
        {
            // 2️⃣ Group that uses actionref
            group(AttachDocument)
            {
                Caption = 'Attachments';

                actionref(Attachment; MyAttachment) { }
                actionref(Attachment2; MyAttachment2) { }

            }
            group(Approvall)
            {
                Caption = 'Approval';

                actionref(MySendApprovalRef; MySendApproval) { }
                actionref(MyApprovalRef; MyCancelApproval) { }
                actionref(MyApprovalsRef; MyApprovals) { }
                actionref(ReopenRef; Reopen) { }

            }
            group(Post)
            {
                Caption = 'Post';

                actionref(MyPostRef; "Post Doc") { }

            }
            group(Report)
            {
                Caption = 'Report';

                actionref(MyReportRef; PrintMemoReport) { }

            }

        }


    }
    var
        VarVariant: Variant;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CustomApprovals: Codeunit "Custom Approvals Mgmt HR";
        RecRef: RecordRef;

    local procedure SendEmailToAttendees()
    var
        MemoAttenders: Record "Memo Attenders";
        Employee: Record Employee;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailSubject: Text;
        EmailBody: Text;
    begin
        MemoAttenders.Reset();
        MemoAttenders.SetRange("Doc No", Rec."No.");
        if MemoAttenders.FindSet() then begin
            repeat
                if Employee.Get(MemoAttenders."Employee No") then begin
                    if Employee."Company E-Mail" <> '' then begin
                        EmailSubject := 'Memo Notification - ' + Rec."No.";
                        EmailBody := '<html><body>';
                        EmailBody += '<p>Dear ' + Employee."Full Name" + ',</p>';
                        EmailBody += '<p>You have been listed as an attendee for the following memo:</p>';
                        EmailBody += '<ul>';
                        EmailBody += '<li><strong>Memo No:</strong> ' + Rec."No." + '</li>';
                        EmailBody += '<li><strong>Purpose:</strong> ' + Rec.Purpose + '</li>';
                        EmailBody += '<li><strong>Activity Date:</strong> ' + Format(Rec."Activity Date") + '</li>';
                        if Rec."End Date" <> 0D then
                            EmailBody += '<li><strong>End Date:</strong> ' + Format(Rec."End Date") + '</li>';
                        EmailBody += '<li><strong>Department:</strong> ' + Rec."Department Code" + '</li>';
                        EmailBody += '</ul>';
                        EmailBody += '<p>Please take note of this activity.</p>';
                        EmailBody += '<p>Best regards,<br/>' + Rec."Requestor Name" + '</p>';
                        EmailBody += '</body></html>';

                        EmailMessage.Create(Employee."Company E-Mail", EmailSubject, EmailBody, true);
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    end;
                end;
            until MemoAttenders.Next() = 0;
        end;
    end;
}















/*  area(Navigation)
 {
     group(Attachments)
     {
         Caption = 'Attachments';

         action(DocAttachments)
         {
             Caption = 'Attachments';
             Image = Attach;

             trigger OnAction()
             var
                 DocumentAttachmentDetails: Page "Document Attachment Details";
                 RecRef: RecordRef;
             begin
                 RecRef.GetTable(Rec);
                 DocumentAttachmentDetails.OpenForRecRef(RecRef);
             end;
         }
     }
 } */




