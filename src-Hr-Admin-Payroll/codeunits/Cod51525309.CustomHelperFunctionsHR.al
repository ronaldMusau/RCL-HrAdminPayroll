codeunit 51525309 "Custom Helper Functions HR"
{
    procedure FnCheckSupervisor(EmpNo: Code[40])
    var
        EmployeeRec: Record Employee;
    begin
        IF EmpNo <> '' THEN BEGIN
            EmployeeRec.RESET;
            EmployeeRec.SETRANGE("No.", EmpNo);
            IF EmployeeRec.FINDFIRST THEN BEGIN
                IF EmployeeRec."Manager No." = '' THEN
                    ERROR('Kindly request the HR Department to set for you (%1) a supervisor in the Employee Card! %1', EmpNo);
            END;
        end;
    end;

    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email message";
        Text1: Label 'LEAVE APPLICATION';

    procedure FnSendEmails(StaffNo: Code[40]; DocumentNo: Code[40]; NumberOfDaysApplied: Integer; RelieversName: Text[100]; ApplicantsName: Text[100]; FromDate: Date; ToDate: Date)
    var
        UserSetup: Record "User Setup";
        EmpRec: Record Employee;
    begin
        EmpRec.Reset;
        EmpRec.SetRange("No.", StaffNo);
        if EmpRec.FindFirst then begin
            if EmpRec."Company E-Mail" <> '' then begin
                EmailMessage.Create(EmpRec."Company E-Mail", Text1,
                'Dear ' + RelieversName + '. You have been selected as a reliever for ' + ApplicantsName + 'on leave application:' +
                Format(DocumentNo) + ', from ' + Format(FromDate) + ' to ' + Format(ToDate) + '.', false);
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                //MESSAGE('Mail Sent');
            end;
        end;
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;

    procedure UpdatePortalApprovalRecords(ApprovalDocNo: Code[40]; EmpNo: Code[40])
    var
        EmployeeRec: Record Employee;
        ManagerNo: Code[20];
        LeaveApplicationRec: Record "Employee Leave Application";
    begin
        IF ApprovalDocNo <> '' THEN BEGIN
            ApprovalEntry.RESET;
            ApprovalEntry.SETRANGE("Document No.", ApprovalDocNo);
            ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                ApprovalEntry."Web Portal Approval" := TRUE;
                EmployeeRec.RESET;
                EmployeeRec.SETRANGE("No.", EmpNo);
                IF EmployeeRec.FINDFIRST THEN BEGIN
                    IF EmployeeRec."Manager No." = '' THEN
                        ERROR('You must set the supervisor for Employee No. %1', EmpNo);
                    ApprovalEntry."Sender Employee No" := EmpNo;
                    ApprovalEntry."Sender Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";

                    ManagerNo := EmployeeRec."Manager No.";
                    //If supervisor is on leave and has a reliever, pass it to the reliever
                    LeaveApplicationRec.Reset();
                    LeaveApplicationRec.SetRange("Employee No", ManagerNo);
                    LeaveApplicationRec.SetRange(Status, LeaveApplicationRec.Status::Released);
                    LeaveApplicationRec.SetFilter("Start Date", '<=%1', Today);
                    LeaveApplicationRec.SetFilter("Resumption Date", '>=%1', Today);
                    LeaveApplicationRec.SetFilter("Duties Taken Over By", '<>%1', '');
                    if LeaveApplicationRec.FindFirst() then
                        ManagerNo := LeaveApplicationRec."Duties Taken Over By";

                    Employee.RESET;
                    Employee.SETRANGE("No.", ManagerNo);
                    IF Employee.FINDFIRST THEN BEGIN
                        ApprovalEntry."Approver Employee No" := ManagerNo;//Employee."Manager No.";
                        ApprovalEntry."Approver Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    END ELSE
                        ERROR('Supervisor with employee No. %1 not found!', EmpNo);
                END ELSE
                    ERROR('Employee No. %1 not found!', EmpNo);
                ApprovalEntry.MODIFY;
            END;
        END;
    end;


    var
        BaseAttachmentsMgmt: Codeunit "Base Attachments Management";
        MimeType: Text;
        FileExt: Text;

    procedure SendLeaveApprovalEmail(ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20])
    var
        HRLeaveApplication: Record "Employee Leave Application";
        HrSetup: Record "Human Resources Setup";
        LeaveTypes: Record "Leave Types";
        Requester: Record Employee;
        Approver: Record Employee;
        DocAttachments: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        SharePointHandler: Codeunit SharePointHandler;
        OutStr: OutStream;
        InStr: InStream;
        AttachmentName: Text;
        Subject: Text;
        Body: Text;
        ApprovalEntry2: Record "Approval Entry";
        ApproverDisplayName: Text;
        ApproverUser: Record "User Setup";
        ApproverUserRec: Record User;
    begin
        HrSetup.Get();
        Subject := 'Leave Approval Request';
        Body := 'Your ' + Format(ApprovalEntry."Document Type") +
                ' Request No ' + ApprovalEntry."Document No." + ' has been Approved.';

        // Get Requester
        // if ApprovalEntry."Sender Employee No" <> '' then
        //     Requester.Get(ApprovalEntry."Sender Employee No");
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Application No", ApprovalEntry."Document No.");
        if HRLeaveApplication.FindFirst() then begin
            Requester.Get(HRLeaveApplication."Employee No");
            Clear(EmailMessage);
            EmailMessage.Create(Requester."Company E-Mail", Subject, '', true);
        end;
        // Clear(EmailMessage);
        // EmailMessage.Create(Requester."Company E-Mail", Subject, '', true);

        // CC Approver
        // if ApprovalEntry."Approver Employee No" <> '' then begin
        //     Approver.Get(ApprovalEntry."Approver Employee No");
        //     if Approver."Company E-Mail" <> '' then
        //         EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, Approver."Company E-Mail");
        // end;
        // CC All Approvers
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", ApprovalEntry."Document No.");
        ApprovalEntry2.SetFilter("Approver Employee No", '<>%1', '');
        if ApprovalEntry2.FindSet() then
            repeat
                if Approver.Get(ApprovalEntry2."Approver Employee No") then
                    if Approver."Company E-Mail" <> '' then
                        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, Approver."Company E-Mail");
            until ApprovalEntry2.Next() = 0;
        // CC HR
        if (HrSetup."HR Department Email" <> '') then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."HR Department Email");

        // CC Payroll for Maternity
        if (HRLeaveApplication."Leave Type" = 'MATERNITY') and (HrSetup."Payroll Administrator Email" <> '') then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."Payroll Administrator Email");

        // CC Leave Type Notification
        LeaveTypes.Reset();
        LeaveTypes.SetRange(Code, HRLeaveApplication."Leave Type");
        LeaveTypes.SetFilter("Notification Email", '<>%1', '');
        if LeaveTypes.FindFirst() then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, LeaveTypes."Notification Email");

        //Build Structured Body
        EmailMessage.AppendToBody('Dear ' + Requester.FullName + ',<br><br>');
        EmailMessage.AppendToBody(Body + '<br><br>');
        EmailMessage.AppendToBody('<table border="1">');
        EmailMessage.AppendToBody('<tr><td>Staff Name:</td><td>' + HRLeaveApplication."Employee Name" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Company:</td><td>' + CompanyName + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Employee Code:</td><td>' + HRLeaveApplication."Employee No" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Submitted:</td><td>' + Format(ApprovalEntry."Date-Time Sent for Approval") + '</td></tr>');
        HRLeaveApplication.CalcFields("Leave balance");
        EmailMessage.AppendToBody('<tr><td>Leave Type:</td><td>' + HRLeaveApplication."Leave Type" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Days Applied:</td><td>' + Format(HRLeaveApplication."Days Applied") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Current Balance:</td><td>' + Format(HRLeaveApplication.GetLeaveTypeBalance()) + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Date From:</td><td>' + Format(HRLeaveApplication."Start Date") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Date To:</td><td>' + Format(HRLeaveApplication."End Date") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Resumption Date:</td><td>' + Format(HRLeaveApplication."Resumption Date") + '</td></tr>');
        EmailMessage.AppendToBody('</table><br><br>');

        // Workflow History
        EmailMessage.AppendToBody('Approval Workflow History.<br>');
        EmailMessage.AppendToBody('<table border="0.1"><tr><td>Sequence:</td><td>Approver</td><td>Status</td><td>Comment(s)</td></tr>');
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", DocumentNo);
        if ApprovalEntry2.FindSet() then
            repeat
                EmailMessage.AppendToBody('<tr><td>' + Format(ApprovalEntry2."Sequence No.") +
                                          '</td><td>' + ApprovalEntry2."Approver ID" +
                                          '</td><td>' + Format(ApprovalEntry2.Status) +
                                          '</td><td>' + Format(ApprovalEntry2."Approval Comments") + '</td></tr>');
            until ApprovalEntry2.Next() = 0;
        EmailMessage.AppendToBody('</table><br><br>');

        // ESS Portal Link
        EmailMessage.AppendToBody('<a href="https://ess.rwandaircatering.rw/" target="_blank">Click https://ess.rwandaircatering.rw/</a> to access ESS portal.<br>');
        EmailMessage.AppendToBody('<p><strong>Note:</strong> This is a system generated email. Please do not reply.</p>');

        // Attachments
        // DocAttachments.Reset();
        // DocAttachments.SetRange("Table ID", Database::"Employee Leave Application");
        // DocAttachments.SetRange("No.", ApprovalEntry."Document No.");
        // if DocAttachments.FindSet() then
        //     repeat
        //         TempBlob.CreateOutStream(OutStr);
        //         Clear(InStr);
        //         if DocAttachments."Document Reference ID".HasValue then begin
        //             DocAttachments."Document Reference ID".ExportStream(OutStr);
        //             TempBlob.CreateInStream(InStr);
        //         end else
        //             SharePointHandler.DownloadFileFromSharePointNoTableReturnStream(
        //                 DocAttachments."SharePoint File ID",
        //                 DocAttachments."File Name",
        //                 InStr);
        //         AttachmentName := 'Support Doc - ' + DocAttachments."File Name";
        //         if DocAttachments."File Extension" <> '' then
        //             AttachmentName += '.' + DocAttachments."File Extension";
        //       //  BaseAttachmentsMgmt.GetMimeType(AttachmentName, MimeType, FileExt);
        //         EmailMessage.AddAttachment(AttachmentName, MimeType, InStr);
        //         Clear(OutStr);
        //         Clear(InStr);
        //     until DocAttachments.Next() = 0;

        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Error('Failed to send Approved email.');
    end;


    procedure SendLeaveRejectedEmail(ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20])
    var
        HRLeaveApplication: Record "Employee Leave Application";
        HrSetup: Record "Human Resources Setup";
        LeaveTypes: Record "Leave Types";
        Requester: Record Employee;
        Approver: Record Employee;
        DocAttachments: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        SharePointHandler: Codeunit SharePointHandler;
        OutStr: OutStream;
        InStr: InStream;
        AttachmentName: Text;
        Subject: Text;
        Body: Text;
        ApprovalEntry2: Record "Approval Entry";
    begin
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Application No", ApprovalEntry."Document No.");
        if not HRLeaveApplication.FindFirst() then
            exit;
        HrSetup.Get();
        Subject := 'Leave Request Status';
        Body := 'Your ' + Format(ApprovalEntry."Document Type") +
                ' Request No ' + ApprovalEntry."Document No." + ' has been Rejected.';

        // Get Requester
        // if ApprovalEntry."Sender Employee No" <> '' then
        //     Requester.Get(ApprovalEntry."Sender Employee No");

        Requester.Get(HRLeaveApplication."Employee No");
        Clear(EmailMessage);
        EmailMessage.Create(Requester."Company E-Mail", Subject, '', true);

        // CC Approver
        // if ApprovalEntry."Approver Employee No" <> '' then begin
        //     Approver.Get(ApprovalEntry."Approver Employee No");
        //     if Approver."Company E-Mail" <> '' then
        //         EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, Approver."Company E-Mail");
        // end;
        // CC All Approvers
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", ApprovalEntry."Document No.");
        ApprovalEntry2.SetFilter("Approver Employee No", '<>%1', '');
        if ApprovalEntry2.FindSet() then
            repeat
                if Approver.Get(ApprovalEntry2."Approver Employee No") then
                    if Approver."Company E-Mail" <> '' then
                        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, Approver."Company E-Mail");
            until ApprovalEntry2.Next() = 0;

        // CC HR (still relevant for rejected)
        if (HrSetup."HR Department Email" <> '') then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."HR Department Email");

        // CC Leave Type Notification
        LeaveTypes.Reset();
        LeaveTypes.SetRange(Code, HRLeaveApplication."Leave Type");
        LeaveTypes.SetFilter("Notification Email", '<>%1', '');
        if LeaveTypes.FindFirst() then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, LeaveTypes."Notification Email");

        // Structured Body
        EmailMessage.AppendToBody('Dear ' + Requester.FullName + ',<br><br>');
        EmailMessage.AppendToBody(Body + '<br><br>');
        EmailMessage.AppendToBody('<table border="1">');
        EmailMessage.AppendToBody('<tr><td>Staff Name:</td><td>' + HRLeaveApplication."Employee Name" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Company:</td><td>' + CompanyName + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Employee Code:</td><td>' + HRLeaveApplication."Employee No" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Submitted:</td><td>' + Format(ApprovalEntry."Date-Time Sent for Approval") + '</td></tr>');
        HRLeaveApplication.CalcFields("Leave balance");
        EmailMessage.AppendToBody('<tr><td>Leave Type:</td><td>' + HRLeaveApplication."Leave Type" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Days Applied:</td><td>' + Format(HRLeaveApplication."Days Applied") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Current Balance:</td><td>' + Format(HRLeaveApplication.GetLeaveTypeBalance()) + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Date From:</td><td>' + Format(HRLeaveApplication."Start Date") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Date To:</td><td>' + Format(HRLeaveApplication."End Date") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Resumption Date:</td><td>' + Format(HRLeaveApplication."Resumption Date") + '</td></tr>');
        EmailMessage.AppendToBody('</table><br><br>');

        // Workflow History
        EmailMessage.AppendToBody('Approval Workflow History.<br>');
        EmailMessage.AppendToBody('<table border="0.1"><tr><td>Sequence:</td><td>Approver</td><td>Status</td><td>Comment(s)</td></tr>');
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", DocumentNo);
        if ApprovalEntry2.FindSet() then
            repeat
                EmailMessage.AppendToBody('<tr><td>' + Format(ApprovalEntry2."Sequence No.") +
                                          '</td><td>' + ApprovalEntry2."Approver ID" +
                                          '</td><td>' + Format(ApprovalEntry2.Status) +
                                          '</td><td>' + Format(ApprovalEntry2."Approval Comments") + '</td></tr>');
            until ApprovalEntry2.Next() = 0;
        EmailMessage.AppendToBody('</table><br><br>');

        // ESS Portal Link
        EmailMessage.AppendToBody('<a href="https://ess.rwandaircatering.rw/" target="_blank">Click https://ess.rwandaircatering.rw/</a> to access ESS portal.<br>');
        EmailMessage.AppendToBody('<p><strong>Note:</strong> This is a system generated email. Please do not reply.</p>');

        // // Attachments
        // DocAttachments.Reset();
        // DocAttachments.SetRange("Table ID", Database::"Employee Leave Application");
        // DocAttachments.SetRange("No.", ApprovalEntry."Document No.");
        // if DocAttachments.FindSet() then
        //     repeat
        //         TempBlob.CreateOutStream(OutStr);
        //         Clear(InStr);
        //         if DocAttachments."Document Reference ID".HasValue then begin
        //             DocAttachments."Document Reference ID".ExportStream(OutStr);
        //             TempBlob.CreateInStream(InStr);
        //         end else
        //             // SharePointHandler.DownloadFileFromSharePointNoTableReturnStream(
        //             //     DocAttachments."SharePoint File ID",
        //             //     DocAttachments."File Name",
        //             //     InStr);
        //         AttachmentName := 'Support Doc - ' + DocAttachments."File Name";
        //         if DocAttachments."File Extension" <> '' then
        //             AttachmentName += '.' + DocAttachments."File Extension";
        //         //BaseAttachmentsMgmt.GetMimeType(AttachmentName, MimeType, FileExt);
        //         EmailMessage.AddAttachment(AttachmentName, MimeType, InStr);
        //         Clear(OutStr);
        //         Clear(InStr);
        //     until DocAttachments.Next() = 0;

        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Error('Failed to send Rejected email.');
    end;

    procedure SendLeaveSubmittedEmail(ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20])
    var
        HRLeaveApplication: Record "Employee Leave Application";
        HrSetup: Record "Human Resources Setup";
        LeaveTypes: Record "Leave Types";
        Requester: Record Employee;
        Approver: Record Employee;
        DocAttachments: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        SharePointHandler: Codeunit SharePointHandler;
        OutStr: OutStream;
        InStr: InStream;
        AttachmentName: Text;
        Subject: Text;
        Body: Text;
        ApprovalEntry2: Record "Approval Entry";
    begin
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Application No", ApprovalEntry."Document No.");
        if not HRLeaveApplication.FindFirst() then
            exit;
        HrSetup.Get();
        Subject := 'Leave Request Status';
        Body := 'Your ' + Format(ApprovalEntry."Document Type") +
                ' Request No ' + ApprovalEntry."Document No." + ' has been submitted for approval.';

        // Get Requester
        // if ApprovalEntry."Sender Employee No" <> '' then
        //     Requester.Get(ApprovalEntry."Sender Employee No");

        Requester.Get(HRLeaveApplication."Employee No");
        Clear(EmailMessage);
        EmailMessage.Create(Requester."Company E-Mail", Subject, '', true);

        // Clear(EmailMessage);
        // EmailMessage.Create(Requester."Company E-Mail", Subject, '', true);

        //  CC all approvers with Open entries
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", DocumentNo);
        ApprovalEntry2.SetRange(Status, ApprovalEntry2.Status::Open); // only current pending approvers

        if ApprovalEntry2.FindSet() then
            repeat
                if ApprovalEntry2."Approver Employee No" <> '' then begin
                    Approver.Get(ApprovalEntry2."Approver Employee No");
                    if Approver."Company E-Mail" <> '' then
                        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, Approver."Company E-Mail");
                end;
            until ApprovalEntry2.Next() = 0;

        // CC HR (optional for tracking)
        if (HrSetup."HR Department Email" <> '') then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."HR Department Email");

        // CC Leave Type Notification
        LeaveTypes.Reset();
        LeaveTypes.SetRange(Code, HRLeaveApplication."Leave Type");
        LeaveTypes.SetFilter("Notification Email", '<>%1', '');
        if LeaveTypes.FindFirst() then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, LeaveTypes."Notification Email");

        //  Structured Body
        EmailMessage.AppendToBody('Dear ' + Requester.FullName + ',<br><br>');
        EmailMessage.AppendToBody(Body + '<br><br>');
        EmailMessage.AppendToBody('<table border="1">');
        EmailMessage.AppendToBody('<tr><td>Staff Name:</td><td>' + HRLeaveApplication."Employee Name" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Company:</td><td>' + CompanyName + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Employee Code:</td><td>' + HRLeaveApplication."Employee No" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Submitted:</td><td>' + Format(ApprovalEntry."Date-Time Sent for Approval") + '</td></tr>');
        HRLeaveApplication.CalcFields("Leave balance");
        EmailMessage.AppendToBody('<tr><td>Leave Type:</td><td>' + HRLeaveApplication."Leave Type" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Days Applied:</td><td>' + Format(HRLeaveApplication."Days Applied") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Current Balance:</td><td>' + Format(HRLeaveApplication.GetLeaveTypeBalance()) + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Date From:</td><td>' + Format(HRLeaveApplication."Start Date") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Date To:</td><td>' + Format(HRLeaveApplication."End Date") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Resumption Date:</td><td>' + Format(HRLeaveApplication."Resumption Date") + '</td></tr>');
        EmailMessage.AppendToBody('</table><br><br>');

        // Workflow History
        EmailMessage.AppendToBody('Approval Workflow History.<br>');
        EmailMessage.AppendToBody('<table border="0.1"><tr><td>Sequence:</td><td>Approver</td><td>Status</td><td>Comment(s)</td></tr>');
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", DocumentNo);
        if ApprovalEntry2.FindSet() then
            repeat
                EmailMessage.AppendToBody('<tr><td>' + Format(ApprovalEntry2."Sequence No.") +
                                          '</td><td>' + ApprovalEntry2."Approver ID" +
                                          '</td><td>' + Format(ApprovalEntry2.Status) +
                                          '</td><td>' + Format(ApprovalEntry2."Approval Comments") + '</td></tr>');
            until ApprovalEntry2.Next() = 0;
        EmailMessage.AppendToBody('</table><br><br>');

        // ESS Portal Link
        EmailMessage.AppendToBody('<a href="https://ess.rwandaircatering.rw/" target="_blank">Click https://ess.rwandaircatering.rw/</a> to access ESS portal.<br>');
        EmailMessage.AppendToBody('<p><strong>Note:</strong> This is a system generated email. Please do not reply.</p>');

        // // Attachments
        // DocAttachments.Reset();
        // DocAttachments.SetRange("Table ID", Database::"Employee Leave Application");
        // DocAttachments.SetRange("No.", ApprovalEntry."Document No.");
        // if DocAttachments.FindSet() then
        //     repeat
        //         TempBlob.CreateOutStream(OutStr);
        //         Clear(InStr);
        //         if DocAttachments."Document Reference ID".HasValue then begin
        //             DocAttachments."Document Reference ID".ExportStream(OutStr);
        //             TempBlob.CreateInStream(InStr);
        //         end else
        //             // SharePointHandler.DownloadFileFromSharePointNoTableReturnStream(
        //             //     DocAttachments."SharePoint File ID",
        //             //     DocAttachments."File Name",
        //             //     InStr);
        //         AttachmentName := 'Support Doc - ' + DocAttachments."File Name";
        //         if DocAttachments."File Extension" <> '' then
        //             AttachmentName += '.' + DocAttachments."File Extension";
        //         //BaseAttachmentsMgmt.GetMimeType(AttachmentName, MimeType, FileExt);
        //         // EmailMessage.AddAttachment(AttachmentName, MimeType, InStr);
        //         Clear(OutStr);
        //         Clear(InStr);
        //     until DocAttachments.Next() = 0;

        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Error('Failed to send Submitted email.');
    end;

    procedure SendLeaveIntermediateApprovalEmail(ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20])
    var
        HRLeaveApplication: Record "Employee Leave Application";
        HrSetup: Record "Human Resources Setup";
        LeaveTypes: Record "Leave Types";
        Requester: Record Employee;
        Approver: Record Employee;
        ApprovalEntry2: Record "Approval Entry";
        DocAttachments: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        SharePointHandler: Codeunit SharePointHandler;
        OutStr: OutStream;
        InStr: InStream;
        AttachmentName: Text;
        Subject: Text;
        Body: Text;
    begin
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange("Application No", ApprovalEntry."Document No.");
        if not HRLeaveApplication.FindFirst() then
            exit;
        HrSetup.Get();
        Subject := 'Leave Request Update';
        Body := 'Your ' + Format(ApprovalEntry."Document Type") +
                ' Request No ' + ApprovalEntry."Document No." +
                ' has been approved by ' + ApprovalEntry."Approver Name" +
                ', pending further approval.';

        // Get Requester

        Requester.Get(HRLeaveApplication."Employee No");
        Clear(EmailMessage);
        EmailMessage.Create(Requester."Company E-Mail", Subject, '', true);

        // if ApprovalEntry."Sender Employee No" <> '' then
        //     Requester.Get(ApprovalEntry."Sender Employee No");

        // Clear(EmailMessage);
        // EmailMessage.Create(Requester."Company E-Mail", Subject, '', true);

        // CC next approvers (Open entries)
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", DocumentNo);
        ApprovalEntry2.SetRange(Status, ApprovalEntry2.Status::Open);
        if ApprovalEntry2.FindSet() then
            repeat
                if ApprovalEntry2."Approver Employee No" <> '' then begin
                    Approver.Get(ApprovalEntry2."Approver Employee No");
                    if Approver."Company E-Mail" <> '' then
                        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, Approver."Company E-Mail");
                end;
            until ApprovalEntry2.Next() = 0;

        // CC HR
        if (HrSetup."HR Department Email" <> '') then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."HR Department Email");

        // CC Leave Type Notification
        LeaveTypes.Reset();
        LeaveTypes.SetRange(Code, HRLeaveApplication."Leave Type");
        LeaveTypes.SetFilter("Notification Email", '<>%1', '');
        if LeaveTypes.FindFirst() then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, LeaveTypes."Notification Email");

        // Structured Body
        EmailMessage.AppendToBody('Dear ' + Requester.FullName + ',<br><br>');
        EmailMessage.AppendToBody(Body + '<br><br>');
        EmailMessage.AppendToBody('<table border="1">');
        EmailMessage.AppendToBody('<tr><td>Staff Name:</td><td>' + HRLeaveApplication."Employee Name" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Company:</td><td>' + CompanyName + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Employee Code:</td><td>' + HRLeaveApplication."Employee No" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Approved By:</td><td>' + ApprovalEntry."Approver Name" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Comment:</td><td>' + ApprovalEntry."Approval Comments" + '</td></tr>');
        EmailMessage.AppendToBody('</table><br><br>');

        // Workflow History
        EmailMessage.AppendToBody('Approval Workflow History.<br>');
        EmailMessage.AppendToBody('<table border="0.1"><tr><td>Sequence:</td><td>Approver</td><td>Status</td><td>Comment(s)</td></tr>');
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", DocumentNo);
        if ApprovalEntry2.FindSet() then
            repeat
                EmailMessage.AppendToBody('<tr><td>' + Format(ApprovalEntry2."Sequence No.") +
                                          '</td><td>' + ApprovalEntry2."Approver ID" +
                                          '</td><td>' + Format(ApprovalEntry2.Status) +
                                          '</td><td>' + Format(ApprovalEntry2."Approval Comments") + '</td></tr>');
            until ApprovalEntry2.Next() = 0;
        EmailMessage.AppendToBody('</table><br><br>');

        // ESS Portal Link
        EmailMessage.AppendToBody('<a href="https://ess.rwandaircatering.rw/" target="_blank">Click https://ess.rwandaircatering.rw/</a> to access ESS portal.<br>');
        EmailMessage.AppendToBody('<p><strong>Note:</strong> This is a system generated email. Please do not reply.</p>');

        // // Attachments (same as Submitted procedure)
        // DocAttachments.Reset();
        // DocAttachments.SetRange("Table ID", Database::"Employee Leave Application");
        // DocAttachments.SetRange("No.", ApprovalEntry."Document No.");
        // if DocAttachments.FindSet() then
        //     repeat
        //         TempBlob.CreateOutStream(OutStr);
        //         Clear(InStr);
        //         if DocAttachments."Document Reference ID".HasValue then begin
        //             DocAttachments."Document Reference ID".ExportStream(OutStr);
        //             TempBlob.CreateInStream(InStr);
        //         end else
        //             //SharePointHandler.DownloadFileFromSharePointNoTableReturnStream(
        //             //DocAttachments."SharePoint File ID",
        //             //  DocAttachments."File Name",
        //             // InStr);
        //             AttachmentName := 'Support Doc - ' + DocAttachments."File Name";
        //         if DocAttachments."File Extension" <> '' then
        //             AttachmentName += '.' + DocAttachments."File Extension";
        //         //BaseAttachmentsMgmt.GetMimeType(AttachmentName, MimeType, FileExt);
        //         //  EmailMessage.AddAttachment(AttachmentName, MimeType, InStr);
        //         Clear(OutStr);
        //         Clear(InStr);
        //     until DocAttachments.Next() = 0;

        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Error('Failed to send Intermediate Approval email.');
    end;

    procedure SendPayrollSubmittedEmail(ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20])
    var
        PayrollHeader: Record "Payroll Processing Header";
        HrSetup: Record "Human Resources Setup";
        Approver: Record Employee;
        ApprovalEntry2: Record "Approval Entry";
        Subject: Text;
        Body: Text;
        PayrollPeriodText: Text;
        FirstApprover: Boolean;
    begin
        PayrollHeader.Reset();
        PayrollHeader.SetRange("Payroll Processing No", ApprovalEntry."Document No.");
        if not PayrollHeader.FindFirst() then
            exit;
        HrSetup.Get();

        PayrollPeriodText := Format(PayrollHeader."Payroll Period", 0, '<Month Text> <Year4>');
        Subject := 'Payroll Processing Approval Request';
        Body := 'Payroll Processing ' + ApprovalEntry."Document No." +
                ' for period ' + PayrollPeriodText + ' has been submitted for approval.';

        // First open approver becomes the primary To recipient
        Clear(EmailMessage);
        FirstApprover := true;
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", DocumentNo);
        ApprovalEntry2.SetRange(Status, ApprovalEntry2.Status::Open);
        if ApprovalEntry2.FindSet() then
            repeat
                if ApprovalEntry2."Approver Employee No" <> '' then
                    if Approver.Get(ApprovalEntry2."Approver Employee No") then
                        if Approver."Company E-Mail" <> '' then begin
                            if FirstApprover then begin
                                EmailMessage.Create(Approver."Company E-Mail", Subject, '', true);
                                FirstApprover := false;
                            end else
                                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", Approver."Company E-Mail");
                        end;
            until ApprovalEntry2.Next() = 0;

        if FirstApprover then
            exit;

        // CC HR and Payroll Admin for visibility
        if HrSetup."HR Department Email" <> '' then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."HR Department Email");
        if HrSetup."Payroll Administrator Email" <> '' then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."Payroll Administrator Email");

        BuildPayrollEmailBody(PayrollHeader, ApprovalEntry, DocumentNo, Body);

        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Error('Failed to send Payroll Submitted email.');
    end;

    procedure SendPayrollIntermediateApprovalEmail(ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20])
    var
        PayrollHeader: Record "Payroll Processing Header";
        HrSetup: Record "Human Resources Setup";
        Approver: Record Employee;
        ApprovalEntry2: Record "Approval Entry";
        Subject: Text;
        Body: Text;
        PayrollPeriodText: Text;
        FirstApprover: Boolean;
    begin
        PayrollHeader.Reset();
        PayrollHeader.SetRange("Payroll Processing No", ApprovalEntry."Document No.");
        if not PayrollHeader.FindFirst() then
            exit;
        HrSetup.Get();

        PayrollPeriodText := Format(PayrollHeader."Payroll Period", 0, '<Month Text> <Year4>');
        Subject := 'Payroll Processing Update';
        Body := 'Payroll Processing ' + ApprovalEntry."Document No." +
                ' for period ' + PayrollPeriodText +
                ' has been approved by ' + ApprovalEntry."Approver Name" +
                ', pending further approval.';

        // Next open approvers are the To recipients
        Clear(EmailMessage);
        FirstApprover := true;
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", DocumentNo);
        ApprovalEntry2.SetRange(Status, ApprovalEntry2.Status::Open);
        if ApprovalEntry2.FindSet() then
            repeat
                if ApprovalEntry2."Approver Employee No" <> '' then
                    if Approver.Get(ApprovalEntry2."Approver Employee No") then
                        if Approver."Company E-Mail" <> '' then begin
                            if FirstApprover then begin
                                EmailMessage.Create(Approver."Company E-Mail", Subject, '', true);
                                FirstApprover := false;
                            end else
                                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", Approver."Company E-Mail");
                        end;
            until ApprovalEntry2.Next() = 0;

        if FirstApprover then
            exit;

        // CC HR and Payroll Admin
        if HrSetup."HR Department Email" <> '' then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."HR Department Email");
        if HrSetup."Payroll Administrator Email" <> '' then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."Payroll Administrator Email");

        BuildPayrollEmailBody(PayrollHeader, ApprovalEntry, DocumentNo, Body);

        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Error('Failed to send Payroll Intermediate Approval email.');
    end;

    procedure SendPayrollApprovalEmail(ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20])
    var
        PayrollHeader: Record "Payroll Processing Header";
        HrSetup: Record "Human Resources Setup";
        Approver: Record Employee;
        ApprovalEntry2: Record "Approval Entry";
        Subject: Text;
        Body: Text;
        PayrollPeriodText: Text;
        FirstApprover: Boolean;
    begin
        PayrollHeader.Reset();
        PayrollHeader.SetRange("Payroll Processing No", ApprovalEntry."Document No.");
        if not PayrollHeader.FindFirst() then
            exit;
        HrSetup.Get();

        PayrollPeriodText := Format(PayrollHeader."Payroll Period", 0, '<Month Text> <Year4>');
        Subject := 'Payroll Processing Approved';
        Body := 'Payroll Processing ' + ApprovalEntry."Document No." +
                ' for period ' + PayrollPeriodText + ' has been fully Approved.';

        // All approvers are To recipients on final approval
        Clear(EmailMessage);
        FirstApprover := true;
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", ApprovalEntry."Document No.");
        ApprovalEntry2.SetFilter("Approver Employee No", '<>%1', '');
        if ApprovalEntry2.FindSet() then
            repeat
                if Approver.Get(ApprovalEntry2."Approver Employee No") then
                    if Approver."Company E-Mail" <> '' then begin
                        if FirstApprover then begin
                            EmailMessage.Create(Approver."Company E-Mail", Subject, '', true);
                            FirstApprover := false;
                        end else
                            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", Approver."Company E-Mail");
                    end;
            until ApprovalEntry2.Next() = 0;

        if FirstApprover then
            exit;

        // CC HR and Payroll Admin
        if HrSetup."HR Department Email" <> '' then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."HR Department Email");
        if HrSetup."Payroll Administrator Email" <> '' then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."Payroll Administrator Email");

        BuildPayrollEmailBody(PayrollHeader, ApprovalEntry, DocumentNo, Body);

        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Error('Failed to send Payroll Approved email.');
    end;

    procedure SendPayrollRejectedEmail(ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20])
    var
        PayrollHeader: Record "Payroll Processing Header";
        HrSetup: Record "Human Resources Setup";
        Approver: Record Employee;
        ApprovalEntry2: Record "Approval Entry";
        Subject: Text;
        Body: Text;
        PayrollPeriodText: Text;
        FirstApprover: Boolean;
    begin
        PayrollHeader.Reset();
        PayrollHeader.SetRange("Payroll Processing No", ApprovalEntry."Document No.");
        if not PayrollHeader.FindFirst() then
            exit;
        HrSetup.Get();

        PayrollPeriodText := Format(PayrollHeader."Payroll Period", 0, '<Month Text> <Year4>');
        Subject := 'Payroll Processing Rejected';
        Body := 'Payroll Processing ' + ApprovalEntry."Document No." +
                ' for period ' + PayrollPeriodText + ' has been Rejected.';

        // All approvers are To recipients so everyone is aware of the rejection
        Clear(EmailMessage);
        FirstApprover := true;
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", ApprovalEntry."Document No.");
        ApprovalEntry2.SetFilter("Approver Employee No", '<>%1', '');
        if ApprovalEntry2.FindSet() then
            repeat
                if Approver.Get(ApprovalEntry2."Approver Employee No") then
                    if Approver."Company E-Mail" <> '' then begin
                        if FirstApprover then begin
                            EmailMessage.Create(Approver."Company E-Mail", Subject, '', true);
                            FirstApprover := false;
                        end else
                            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", Approver."Company E-Mail");
                    end;
            until ApprovalEntry2.Next() = 0;

        if FirstApprover then
            exit;

        // CC HR and Payroll Admin
        if HrSetup."HR Department Email" <> '' then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."HR Department Email");
        if HrSetup."Payroll Administrator Email" <> '' then
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, HrSetup."Payroll Administrator Email");

        BuildPayrollEmailBody(PayrollHeader, ApprovalEntry, DocumentNo, Body);

        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Error('Failed to send Payroll Rejected email.');
    end;

    local procedure BuildPayrollEmailBody(PayrollHeader: Record "Payroll Processing Header"; ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20]; Body: Text)
    var
        ApprovalEntry2: Record "Approval Entry";
    begin
        EmailMessage.AppendToBody('Dear Approver,<br><br>');
        EmailMessage.AppendToBody(Body + '<br><br>');
        EmailMessage.AppendToBody('<table border="1">');
        EmailMessage.AppendToBody('<tr><td>Payroll No:</td><td>' + PayrollHeader."Payroll Processing No" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Company:</td><td>' + CompanyName + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Payroll Period:</td><td>' + Format(PayrollHeader."Payroll Period", 0, '<Month Text> <Year4>') + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Date Processed:</td><td>' + Format(PayrollHeader."Date Processed") + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Processed By:</td><td>' + PayrollHeader."User ID" + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Status:</td><td>' + Format(PayrollHeader.Status) + '</td></tr>');
        EmailMessage.AppendToBody('<tr><td>Submitted:</td><td>' + Format(ApprovalEntry."Date-Time Sent for Approval") + '</td></tr>');
        EmailMessage.AppendToBody('</table><br><br>');

        EmailMessage.AppendToBody('Approval Workflow History.<br>');
        EmailMessage.AppendToBody('<table border="0.1"><tr><td>Sequence:</td><td>Approver</td><td>Status</td><td>Comment(s)</td></tr>');
        ApprovalEntry2.Reset();
        ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
        ApprovalEntry2.SetRange("Document No.", DocumentNo);
        if ApprovalEntry2.FindSet() then
            repeat
                EmailMessage.AppendToBody('<tr><td>' + Format(ApprovalEntry2."Sequence No.") +
                                          '</td><td>' + ApprovalEntry2."Approver ID" +
                                          '</td><td>' + Format(ApprovalEntry2.Status) +
                                          '</td><td>' + Format(ApprovalEntry2."Approval Comments") + '</td></tr>');
            until ApprovalEntry2.Next() = 0;
        EmailMessage.AppendToBody('</table><br><br>');

        EmailMessage.AppendToBody('<p><strong>Note:</strong> This is a system generated email. Please do not reply.</p>');
    end;

    procedure FnPostLeavePg(LeaveNo: Code[10])
    var
        LRegister: Record "Employee Leave Application";
        HRLeaveApplication: Record "Employee Leave Application";
        HRLeavePeriods: Record "HR Leave Periods";
        journal: Record "HR Leave Journal Line";
        HRSetup: Record "Human Resources Setup";
    begin
        LRegister.Reset;
        LRegister.SetRange(LRegister."Application No", LeaveNo);
        if LRegister.FindFirst then begin
            if LRegister.Status = LRegister.Status::Released then
                //IF CONFIRM('Are you sure you want to post this leave?.',TRUE,FALSE)=TRUE THEN
                //BEGIN
                HRSetup.Get();
            journal.Reset;
            journal.SetRange("Journal Batch Name", HRSetup."Default Leave Posting Template");
            journal.SetRange("Journal Template Name", HRSetup."Positive Leave Posting Batch");
            if journal.Find('-') then
                journal.DeleteAll;

            HRLeavePeriods.Reset;
            HRLeavePeriods.SetRange(HRLeavePeriods.Closed, false);
            if HRLeavePeriods.FindLast then begin

                journal.Init;
                journal."Line No." := journal."Line No." + 1000;
                journal."Document No." := LRegister."Application No";
                journal."Journal Template Name" := HRSetup."Default Leave Posting Template"; //HRSetup."Positive Leave Posting Batch";
                journal."Journal Batch Name" := HRSetup."Positive Leave Posting Batch"; //HRSetup."Default Leave Posting Template";
                journal."Staff No." := LRegister."Employee No";
                journal.Validate("Staff No.");
                LRegister.TestField(LRegister."Approved Days");
                if LRegister."Approved Days" = 0 then
                    Error('Please open record and type in approved leave days before approving');
                journal."No. of Days" := LRegister."Approved Days";
                journal."Leave Period" := HRLeavePeriods."Period Code";
                journal."Leave Entry Type" := journal."Leave Entry Type"::Negative;
                journal.Validate("Leave Entry Type");
                journal.Description := Format(LRegister."Leave Type") + ' ' + LRegister."Employee No" + ' ' + LRegister."Application No";
                journal."Leave Type" := LRegister."Leave Type";
                journal."Posting Date" := LRegister."Application Date";
                journal.Validate("Leave Type");
                journal.IsMonthlyAccrued := false;
                journal.Insert;

                journal.Reset;
                journal.SetRange("Journal Batch Name", HRSetup."Positive Leave Posting Batch"/*HRSetup."Default Leave Posting Template"*/);
                journal.SetRange("Journal Template Name", HRSetup."Default Leave Posting Template"/*HRSetup."Positive Leave Posting Batch"*/);
                if journal.Find('-') then begin
                    CODEUNIT.Run(CODEUNIT::"HR Leave Jnl.-Post", journal);
                end;
                if LRegister."Leave Type" = HRSetup."Annual Leave Code" then begin
                    if LRegister."Include Leave Allowance" = true then begin
                        FnPostLeaveAllowance(LRegister."Employee No", LRegister."Days Applied");
                    end;
                end;
                LRegister.Posted := true;
                LRegister."Posted By" := UserId;
                LRegister."Date Posted" := Today;
                LRegister."Time Posted" := Time;
                LRegister.Modify;
            end;
        end;
        //END;
    end;

    local procedure FnPostLeaveAllowance(var EmployeeNo: Code[10]; var DaysApplieds: Decimal)
    var
        EmployeeX: Record Employee;
        AssignmentMatrix: Record "Assignment Matrix";
        HRSetup: Record "Human Resources Setup";
    begin
        HRSetup.Get();
        if EmployeeX.Get(EmployeeNo) then begin
            if DaysApplieds >= HRSetup."Leave Allowance Days" then begin
                FnGetBasicPay(EmployeeX."Salary Scale", EmployeeX.Present);
                if AssignmentMatrix.FindLast then begin
                    AssignmentMatrix.Init;
                    AssignmentMatrix."Employee No" := EmployeeNo;
                    AssignmentMatrix.Type := AssignmentMatrix.Type::Payment;
                    AssignmentMatrix.Code := HRSetup."Leave Allowance Code";
                    AssignmentMatrix.Validate(Code);
                    AssignmentMatrix.Amount := BasicSalary;
                    if AssignmentMatrix.Amount > 0 then
                        AssignmentMatrix.Insert;
                end;
                EmployeeX."Allowance Collected" := true;
                EmployeeX.Modify;
            end;
        end;
    end;

    local procedure FnGetBasicPay(var Grade: Code[10]; var Present: Code[10])
    var
        Benefits: Record "Scale Benefits";
        HRSetups: Record "Human Resources Setup";

    begin
        BasicSalary := 0;
        HRSetups.Get();
        Benefits.Reset;
        Benefits.SetRange(Benefits."Salary Scale", Grade);
        Benefits.SetRange(Benefits."Salary Pointer", Present);
        Benefits.SetRange(Benefits."ED Code", '01');
        if Benefits.Find('-') then begin
            BasicSalary := Round((1 / 3 * Benefits.Amount), 0.01, '>');
            if BasicSalary > HRSetups."Leave Allowance Limit" then
                BasicSalary := HRSetups."Leave Allowance Limit"
            else
                BasicSalary := BasicSalary;
        end;
    end;

    procedure SendLeaveApprovalEmail2(var ApprovalEntry: Record "Approval Entry"; DocumentNo: Code[20]) Ok: Boolean
    var
        Subject: Text;
        EmailReceiverName: Text;
        Body: Text;
        ApprovalEntry2: Record "Approval Entry";
        HRLeaveApplication: Record "Employee Leave Application";
        HrSetup: Record "Human Resources Setup";
        LeaveTypes: Record "Leave Types";
        DocAttachments: Record "Document Attachment";
        OutStr: OutStream;
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
    begin
        with ApprovalEntry do begin
            //Approver
            Subject := 'Approval Request';

            if Status = Status::Open then begin
                if "Approver Employee No" <> '' then
                    Employee.Get("Approver Employee No");
                EmailReceiverName := Employee.FullName;
                Body := Format(ApprovalEntry."Document Type") + ' Request No ' + "Document No." + ' requires your approval';

            end else
                if (Status = Status::Approved) or (Status = Status::Rejected) or (Status = Status::Canceled) then begin
                    Body := Format(ApprovalEntry."Document Type") + ' Request No ' + "Document No." + ' has been ' + Format(Status);
                    if "Approver Employee No" <> '' then
                        Employee.Get("Approver Employee No");
                    EmailReceiverName := Employee.FullName;
                end;
            if Employee."Company E-Mail" <> '' then begin
                HRLeaveApplication.Reset;
                if HRLeaveApplication.Get(DocumentNo) then;

                EmailMessage.Create(Employee."Company E-Mail", Subject, '', true);
                //SMTPMail.AddCC('dmunene@panachetechnohub.co.ke');
                EmailMessage.AppendToBody('Dear' + ' ' + EmailReceiverName + ',');
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody(Body);
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('<table border="1"><tr><td>Staff Name:</td><td>' + HRLeaveApplication."Employee Name" + '</td></tr>');
                EmailMessage.AppendToBody('<tr><td>Company:</td><td> ' + CompanyName + '</td></tr>');
                EmailMessage.AppendToBody('<tr><td>Employee Code:</td><td> ' + HRLeaveApplication."Employee No" + '</td></tr>');
                EmailMessage.AppendToBody('<tr><td>Submitted:</td><td> ' + Format("Date-Time Sent for Approval") + '</td></tr>');
                HRLeaveApplication.Reset;
                if HRLeaveApplication.Get("Document No.") then begin
                    HRLeaveApplication.CalcFields("Leave balance");
                    EmailMessage.AppendToBody('<tr><td>Leave Type:</td><td> ' + HRLeaveApplication."Leave Type" + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Days Applied:</td><td> ' + Format(HRLeaveApplication."Days Applied") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Current Balance:</td><td> ' + Format(HRLeaveApplication.GetLeaveTypeBalance()/*"Leave balance"*/) + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Date From::</td><td> ' + Format(HRLeaveApplication."Start Date") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Date To:</td><td> ' + Format(HRLeaveApplication."End Date") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Resumption Date:</td><td> ' + Format(HRLeaveApplication."Resumption Date") + '</td></tr>');
                end;
                EmailMessage.AppendToBody('</table>');
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('Approval Workflow History.');
                EmailMessage.AppendToBody('<table border="0.1"><tr><td>Sequence:</td><td>Approver</td><td>Status</td><td>Comment(s)</td></tr>');
                ApprovalEntry2.Reset;
                ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
                ApprovalEntry2.SetRange("Document No.", DocumentNo);
                if ApprovalEntry2.FindFirst then
                    repeat
                        if ApprovalEntry2."Approver Name" = '' then
                            ApprovalEntry2."Approver Name" := "Approver Name";

                        EmailMessage.AppendToBody('<tr><td>' + Format(ApprovalEntry2."Sequence No.") + '</td><td> ' + ApprovalEntry2."Approver Name" + '</td><td> ' + Format(ApprovalEntry2.Status) + '</td><td> ' + Format(ApprovalEntry2."Approval Comments") + '</td></tr>');

                    until ApprovalEntry2.Next = 0;
                EmailMessage.AppendToBody('</table>');
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('<a href="https://ess.rwandaircatering.rw/" target="_blank">Click https://ess.rwandaircatering.rw/</a> to access ESS portal.');
                EmailMessage.AppendToBody('<p><strong>Note:</strong> This is a system generated email. Please do not reply.</p>');
                //SMTPMail.Send;
                if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                    Ok := false
                else
                    Ok := true;

            end;

            //Requestor
            Subject := 'Approval Request';

            if Status = Status::Open then begin
                if "Sender Employee No" <> '' then
                    Employee.Get("Sender Employee No");
                EmailReceiverName := Employee.FullName;
                Body := 'Your ' + Format(ApprovalEntry."Document Type") + ' Request No ' + "Document No." + ' has been sent for approval';

            end else
                if (Status = Status::Approved) or (Status = Status::Rejected) or (Status = Status::Canceled) then begin
                    Body := 'Your ' + Format(ApprovalEntry."Document Type") + ' Request No ' + "Document No." + ' has been ' + Format(Status) + '.';
                    if "Sender Employee No" <> '' then
                        Employee.Get("Sender Employee No");
                    EmailReceiverName := Employee.FullName;
                end;

            if Employee."Company E-Mail" <> '' then begin
                EmailMessage.Create(Employee."Company E-Mail", Subject, '', true);
                //SMTPMail.AddCC('dmunene@panachetechnohub.co.ke');
                HrSetup.Get();
                if (HrSetup."HR Department Email" <> '') and (Status = Status::Approved) then
                    EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, DelChr(HrSetup."HR Department Email", '<>'));
                if (HRLeaveApplication."Leave Type" = 'MATERNITY') and (HrSetup."Payroll Administrator Email" <> '') and (Status = Status::Approved) then
                    EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, DelChr(HrSetup."Payroll Administrator Email", '<>'));
                EmailMessage.AppendToBody('Dear' + ' ' + EmailReceiverName + ',');
                EmailMessage.AppendToBody('<br><br>');
                // Body:='Your Request '+"Document No."+'has been '+FORMAT(Status);
                EmailMessage.AppendToBody(Body);
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('<table border="1"><tr><td>Staff Name:</td><td>' + EmailReceiverName + '</td></tr>');
                EmailMessage.AppendToBody('<tr><td>Company:</td><td> ' + CompanyName + '</td></tr>');
                EmailMessage.AppendToBody('<tr><td>Employee Code:</td><td> ' + Employee."No." + '</td></tr>');
                EmailMessage.AppendToBody('<tr><td>Submitted:</td><td> ' + Format("Date-Time Sent for Approval") + '</td></tr>');
                HRLeaveApplication.Reset;
                if HRLeaveApplication.Get("Document No.") then begin
                    //Copy any emails set in the leave type
                    LeaveTypes.Reset();
                    LeaveTypes.SetRange(Code, HRLeaveApplication."Leave Type");
                    LeaveTypes.SetFilter("Notification Email", '<>%1', '');
                    if LeaveTypes.FindFirst() then begin
                        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, DelChr(LeaveTypes."Notification Email", '<>'));
                        //Upload the attachment as well
                        DocAttachments.Reset();
                        DocAttachments.SetRange("Table ID", Database::"Employee Leave Application");
                        DocAttachments.SetRange("No.", "Document No.");
                        if DocAttachments.FindSet() then
                            repeat
                                if DocAttachments."Document Reference ID".HasValue then begin
                                    TempBlob.CreateOutStream(OutStr);
                                    DocAttachments."Document Reference ID".ExportStream(OutStr);
                                    TempBlob.CreateInStream(InStr);
                                    //  BaseAttachmentsMgmt.GetMimeType('Support Doc - ' + DocAttachments."File Name" + '.' + DocAttachments."File Extension", MimeType, FileExt);
                                    EmailMessage.AddAttachment('Support Doc - ' + DocAttachments."File Name" + '.' + DocAttachments."File Extension", MimeType, InStr);
                                    Clear(OutStr);
                                    Clear(InStr);
                                end;
                            until DocAttachments.Next() = 0;
                    end;

                    HRLeaveApplication.CalcFields("Leave balance");
                    EmailMessage.AppendToBody('<tr><td>Leave Type:</td><td> ' + HRLeaveApplication."Leave Type" + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Days Applied:</td><td> ' + Format(HRLeaveApplication."Days Applied") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Current Balance:</td><td> ' + Format(HRLeaveApplication.GetLeaveTypeBalance()/*"Leave balance"*/) + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Date From::</td><td> ' + Format(HRLeaveApplication."Start Date") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Date To:</td><td> ' + Format(HRLeaveApplication."End Date") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Resumption Date:</td><td> ' + Format(HRLeaveApplication."Resumption Date") + '</td></tr>');

                end;
                EmailMessage.AppendToBody('</table>');

                EmailMessage.AppendToBody('Approval Workflow History.');
                EmailMessage.AppendToBody('<table border="0.1"><tr><td>Sequence:</td><td>Approver</td><td>Status</td><td>Comment(s)</td></tr>');
                ApprovalEntry2.Reset;
                ApprovalEntry2.SetRange("Document Type", ApprovalEntry."Document Type");
                ApprovalEntry2.SetRange("Document No.", DocumentNo);
                if ApprovalEntry2.FindFirst then
                    repeat
                        if ApprovalEntry2."Approver Name" = '' then
                            ApprovalEntry2."Approver Name" := "Approver Name";
                        EmailMessage.AppendToBody('<tr><td>' + Format(ApprovalEntry2."Sequence No.") + '</td><td> ' + ApprovalEntry2."Approver Name" + '</td><td> ' + Format(ApprovalEntry2.Status) + '</td> <td> ' + Format(ApprovalEntry2."Approval Comments") + '</td></tr>');
                    until ApprovalEntry2.Next = 0;
                EmailMessage.AppendToBody('</table>');
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('<a href="https://ess.rwandaircatering.rw/" target="_blank">Click https://ess.rwandaircatering.rw/ </a> to access ESS portal.');
                EmailMessage.AppendToBody('<p><strong>Note:</strong> This is a system generated email. Please do not reply.</p>');
                //SMTPMail.Send;
                if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                    Ok := false
                else
                    Ok := true;

            end;
        end;
    end;


    procedure SendLeaveRecallEmail(LeaveRecallNo: Code[20]) Ok: Boolean
    var
        Subject: Text;
        EmailReceiverName: Text;
        Body: Text;
        ApprovalEntry2: Record "Approval Entry";
        HRLeaveApplication: Record "Employee Leave Application";
        HrSetup: Record "Human Resources Setup";
        ApprovalEntry: Record "Approval Entry";
        LeaveRecall: Record "Leave Recall";
        "Approver Employee No": Code[100];
        "Reliever Employee No": Code[100];
        ApproverEmail: Text;
        RelieverEmail: Text;
    begin
        LeaveRecall.Reset();
        LeaveRecall.SetRange("No.", LeaveRecallNo);
        if LeaveRecall.FindFirst() then begin
            ApproverEmail := '';
            RelieverEmail := '';
            HRLeaveApplication.Reset();
            HRLeaveApplication.SetRange("Application No", LeaveRecall."Leave Application");
            if HRLeaveApplication.FindFirst() then begin
                "Reliever Employee No" := HRLeaveApplication."Duties Taken Over By";
                "Approver Employee No" := '';
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange("Document No.", LeaveRecall."Leave Application");
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindLast() then
                    "Approver Employee No" := ApprovalEntry."Approver Employee No";

                Subject := 'Leave ' + LeaveRecall."Leave Application" + ' Recall';

                if "Approver Employee No" <> '' then begin
                    Employee.Reset();
                    Employee.SetRange("No.", "Approver Employee No");
                    if Employee.FindFirst() then
                        ApproverEmail := Employee."Company E-Mail";
                end;
                if "Reliever Employee No" <> '' then begin
                    Employee.Reset();
                    Employee.SetRange("No.", "Reliever Employee No");
                    if Employee.FindFirst() then
                        RelieverEmail := Employee."Company E-Mail";
                end;

                Body := 'You are hereby recalled from your leave ' + LeaveRecall."Leave Application" + ' for the following reason; <p>' + LeaveRecall."Reason for Recall" + '.</p>';
                Employee.Reset();
                Employee.SetRange("No.", HRLeaveApplication."Employee No");
                Employee.SetFilter("Company E-Mail", '<>%1', '');
                if Employee.FindFirst() then begin
                    EmailReceiverName := Employee.FullName;
                    EmailMessage.Create(Employee."Company E-Mail", Subject, '', true);

                    HrSetup.Get();
                    if (HrSetup."HR Department Email" <> '') then
                        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, DelChr(HrSetup."HR Department Email", '<>'));
                    if (ApproverEmail <> '') then
                        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, DelChr(ApproverEmail, '<>'));
                    if (RelieverEmail <> '') then
                        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, DelChr(RelieverEmail, '<>'));

                    EmailMessage.AppendToBody('Dear' + ' ' + EmailReceiverName + ',');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody(Body);
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('<table border="1"><tr><td>Staff Name</td><td>' + HRLeaveApplication."Employee Name" + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Employee Code</td><td> ' + HRLeaveApplication."Employee No" + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td colspan="2"><center><strong>Original Leave Details</strong></center></td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Leave No.</td><td> ' + HRLeaveApplication."Application No" + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Leave Type</td><td> ' + HRLeaveApplication."Leave Type" + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Days Approved</td><td> ' + Format(HRLeaveApplication."Approved Days") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>From</td><td> ' + Format(HRLeaveApplication."Start Date") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>To</td><td> ' + Format(HRLeaveApplication."End Date") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Resumption Date</td><td> ' + Format(HRLeaveApplication."Resumption Date") + '</td></tr>');

                    EmailMessage.AppendToBody('<tr><td colspan="2"><center><strong>Leave Recall Details</strong></center></td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Recall No.</td><td> ' + LeaveRecallNo + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>No. of Recalled Days</td><td> ' + Format(LeaveRecall."No. of Off Days") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Recalled From</td><td> ' + Format(LeaveRecall."Recalled From") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>To</td><td> ' + Format(LeaveRecall."Recalled To") + '</td></tr>');
                    EmailMessage.AppendToBody('<tr><td>Remaining Leave Days</td><td> ' + Format(HRLeaveApplication."Approved Days" - LeaveRecall."No. of Off Days") + '</td></tr>');
                    HRLeaveApplication.CalcFields("Leave balance");
                    EmailMessage.AppendToBody('<tr><td>Current Balance:</td><td> ' + Format(HRLeaveApplication.GetLeaveTypeBalance()/*"Leave balance"*/) + '</td></tr>');
                end;
                EmailMessage.AppendToBody('</table>');
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('Leave Approval Workflow History.');
                EmailMessage.AppendToBody('<table border="0.1"><tr><td>Sequence:</td><td>Approver</td><td>Status</td><td>Comment(s)</td></tr>');
                ApprovalEntry2.Reset;
                ApprovalEntry2.SetRange("Document No.", HRLeaveApplication."Application No");
                if ApprovalEntry2.FindFirst then
                    repeat
                        EmailMessage.AppendToBody('<tr><td>' + Format(ApprovalEntry2."Sequence No.") + '</td><td> ' + ApprovalEntry2."Approver Name" + '</td><td> ' + Format(ApprovalEntry2.Status) + '</td><td> ' + Format(ApprovalEntry2."Approval Comments") + '</td></tr>');
                    until ApprovalEntry2.Next = 0;
                EmailMessage.AppendToBody('</table>');
                EmailMessage.AppendToBody('<br><br>');
                EmailMessage.AppendToBody('<a href="https://ess.rwandaircatering.rw/" target="_blank">Click https://ess.rwandaircatering.rw/ </a> to access ESS portal.');
                EmailMessage.AppendToBody('<p><strong>Note:</strong> This is a system generated email. Please do not reply.</p>');
                //SMTPMail.Send;
                if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                    Ok := false
                else
                    Ok := true;
            end;
        end;
    end;

    procedure FnUpdateUserSetupRelieverDetails(LeaveUserID: Code[100]; DelegateStartDate: Date; DelegateEndDate: Date; RelieverID: Code[100])
    var
        usersetuprec: Record "User Setup";
    begin
        //UserSetupDelegationUpdate
        usersetuprec.Reset;
        usersetuprec.SetRange("User ID", LeaveUserID);
        if usersetuprec.FindFirst then begin
            usersetuprec."Delegation Start" := DelegateStartDate;
            usersetuprec."Delegation End" := DelegateEndDate;
            usersetuprec."Leave Reliever Code" := RelieverID;
            usersetuprec.Delegate := false;
            usersetuprec.Modify;

        end;
    end;

    procedure FormatDateDifferenceActual(StartDate: Date; EndDate: Date; RemoveExtraDays: Boolean): Text
    var
        TempDate: Date;
        Years: Integer;
        Months: Integer;
        Days: Integer;
    begin
        if EndDate < StartDate then
            exit('Invalid date range');

        TempDate := StartDate;

        // Count years
        while CalcDate('<1Y>', TempDate) <= EndDate do begin
            TempDate := CalcDate('<1Y>', TempDate);
            Years += 1;
        end;

        // Count months
        while CalcDate('<1M>', TempDate) <= EndDate do begin
            TempDate := CalcDate('<1M>', TempDate);
            Months += 1;
        end;

        // Remaining days
        Days := EndDate - TempDate;

        // Build the output string
        if Years > 0 then begin
            if RemoveExtraDays and (Days < 10) then
                exit(StrSubstNo('%1 year(s) %2 month(s)', Years, Months))
            else
                exit(StrSubstNo('%1 year(s) %2 month(s) %3 day(s)', Years, Months, Days));
        end else if Months > 0 then begin
            if RemoveExtraDays and (Days < 10) then begin
                if (Months >= 12) and (Months mod 12 = 0) then
                    exit(StrSubstNo('%1 year(s)', Months div 12))
                else
                    exit(StrSubstNo('%1 month(s)', Months));
            end else
                exit(StrSubstNo('%1 month(s) %2 day(s)', Months, Days));
        end else
            exit(StrSubstNo('%1 day(s)', Days));
    end;

    procedure InitializeAirtimeManagement()
    var
        HumanResSetup: Record "Human Resources Setup";
        JobQueueEntry: Record "Job Queue Entry";
        AirtimeMgmtFunctions: Codeunit "Airtime Management Functions";
    begin
        Window.Open('Creating no. series: #1#####\\Creating job queue: #2####');
        Window.Update(1, 'AIRTREC00001');
        if HumanResSetup.Get and (HumanResSetup."Airtime Request Nos" = '') then begin
            HumanResSetup."Airtime Request Nos" := 'AIRTREQ';
            if BaseFactory.CreateNoSeries('', HumanResSetup."Airtime Request Nos", 'Airtime request numbers', 'AIRTREQ00001') then begin
                HumanResSetup.Modify();
            end;
        end;

        Window.Update(2, 'Airtime allocation');
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", Codeunit::"Airtime Management Functions");
        if not JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Init();
            JobQueueEntry.InitRecurringJob(0);
            JobQueueEntry.Validate("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
            JobQueueEntry.Validate("Object ID to Run", Codeunit::"Airtime Management Functions");
            JobQueueEntry.ID := CreateGuid();
            JobQueueEntry."Earliest Start Date/Time" := CreateDateTime(CalcDate('1D', Today), 010000T);
            JobQueueEntry."Starting Time" := 010000T;
            JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
            JobQueueEntry."Run in User Session" := false;
            JobQueueEntry."Notify On Success" := false;
            JobQueueEntry."Maximum No. of Attempts to Run" := 5;
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry."Rerun Delay (sec.)" := 30;
            JobQueueEntry."Job Timeout" := JobQueueEntry.DefaultJobTimeout();
            JobQueueEntry.Description := 'Airtime Allocation';
            JobQueueEntry.Insert();
            ReScheduleJob(JobQueueEntry, '');
            if not JobQueueEntry.Modify() then
                JobQueueEntry.Insert();
        end;
        Window.Close();
        Message('Airtime management initialized successfully!');
    end;

    procedure ReScheduleJob(var vJobQueueEntry: Record "Job Queue Entry"; vCompanyName: Text)
    begin
        vJobQueueEntry.Status := vJobQueueEntry.Status::Ready;
        vJobQueueEntry."System Task ID" := TASKSCHEDULER.CreateTask(
          CODEUNIT::"Job Queue Dispatcher",
          CODEUNIT::"Job Queue Error Handler",
          true, vCompanyName, vJobQueueEntry."Earliest Start Date/Time", vJobQueueEntry.RecordId(), vJobQueueEntry."Job Timeout");
    end;


    procedure InitializeHotelManagement()
    var
        HumanResSetup: Record "Human Resources Setup";
        JobQueueEntry: Record "Job Queue Entry";
    begin
        Window.Open('Creating no. series: #1#####');
        Window.Update(1, 'HOTREQ');
        if HumanResSetup.Get and (HumanResSetup."Hotel Request Nos" = '') then begin
            HumanResSetup."Hotel Request Nos" := 'HOTREQ';
            if BaseFactory.CreateNoSeries('', HumanResSetup."Hotel Request Nos", 'Hotel request numbers', 'HOTTREQ00001') then begin
                HumanResSetup.Modify();
            end;
        end;

        Window.Close();
        Message('Hotel management initialized successfully!');
    end;

    var
        Window: Dialog;
        BaseFactory: Codeunit Factory;
        BasicSalary: Decimal;

}
