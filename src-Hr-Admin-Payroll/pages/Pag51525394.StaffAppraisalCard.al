page 51525394 "Staff Appraisal Card"
{
    ApplicationArea = All;
    SourceTable = "Staff Appraisal Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field("Staff No"; Rec."Staff No")
                {
                }
                field("Staff Name"; Rec."Staff Name")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field(Section; Rec.Section)
                {
                }
                field(Period; Rec.Period)
                {
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                }
                field("Period Desc"; Rec."Period Desc")
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field("Sent to Supervisor"; Rec."Sent to Supervisor")
                {
                    Visible = false;
                }
                field("Approved By Supervisor"; Rec."Approved By Supervisor")
                {
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                }
                field("Overall Score(%)"; Rec."Overall Score(%)")
                { }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Status';
                    Editable = false;
                }
            }
            part(Control18; "Staff Appraisal Lines")
            {
                Caption = 'Appraisal Lines';
                SubPageLink = "Doc No" = FIELD(No),
                              Type = FILTER(Objectives);
            }
            /*part(Control19; "Staff Management Review")
            {
                Caption = 'SECTION 2: GENERAL PERFORMANCE 2.1 Management and Leadership Description: Guides the team to achieve desired results. Delegates responsibilities appropriately and effectively, while developing direct reports.';
                SubPageLink = "Doc No" = FIELD(No),
                              Type = FILTER("Management Leadership");
            }
            part("2.2 Job Knowledge iption: Applies the technical and professional skills needed for the job."; "Staff Job Knowledge Review")
            {
                Caption = '2.2 Job Knowledge Description: Applies the technical and professional skills needed for the job.';
                SubPageLink = "Doc No" = FIELD(No),
                Type = FILTER("Job Knowledge");
            }
            part(Control21; "Staff Problem Solving")
            {
                Caption = '2.3 Problem Solving Description: Identifies and analyzes problems, makes logical decisions and seeks solutions to individual and organizational challenges.';
                SubPageLink = "Doc No" = FIELD(No),
                              Type = FILTER("Problem Solving");
            }
            part(Control22; "Staff Communication")
            {
                Caption = '2.4 Communication and Teamwork Description: Listens effectively and provides information and guidance to individuals in an appropriate and timely manner';
                SubPageLink = "Doc No" = FIELD(No),
                              Type = FILTER("Communication and Teamwork");
            }
            part("SECTION 3: LEARNING GOALS AND PROFESSIONAL DEVELOPMENT"; "Staff Learning Goals")
            {
                Caption = 'SECTION 3: LEARNING GOALS AND PROFESSIONAL DEVELOPMENT';
                SubPageLink = "Doc No" = FIELD(No),
                              Type = FILTER("Learning Goals");
            }*/
            part("FINAL COMMENTS - EMPLOYEE"; "Staff Employee Comments")
            {
                Caption = 'Final Comments - Employee';
                SubPageLink = "Doc No" = FIELD(No),
                Type = FILTER("Employee Comments");
            }
            part("FINAL COMMENTS MANAGER"; "Staff Supervisor Comments")
            {
                Caption = 'Final Comments - Supervisor';
                SubPageLink = "Doc No" = FIELD(No),
                Type = FILTER("Supervisor Comments");
            }
        }
        area(FactBoxes)
        {
            part(ApprovalEntries; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(51525339), "Document No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Appraisal Report")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    StaffAppraisal.Reset;
                    StaffAppraisal.SetRange(No, Rec.No);
                    if StaffAppraisal.Find('-') then
                        REPORT.Run(51525263, true, false, StaffAppraisal);
                end;
            }
            action("Evaluation Scale")
            {
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Appraisal Remarks";
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send Approval Request';
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    VarVariant: Variant;
                    CustomApprovals: Codeunit "Custom Approvals Mgmt HR";
                begin
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Request';
                ApplicationArea = All;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    VarVariant: Variant;
                    CustomApprovals: Codeunit "Custom Approvals Mgmt HR";
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                ApplicationArea = All;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        CurrPage.Editable := Rec."Approval Status" = Rec."Approval Status"::Open;
    end;

    var
        StaffAppraisal: Record "Staff Appraisal Header";
        UserSetup: Record "User Setup";
        SenderUserSetup: Record "User Setup";
        ApproverUserSetup: Record "User Setup";
        SenderName: Text[100];
        ApproverName: Text[100];
        //SMTPSetup: Record "SMTP Mail Setup";
        //SMTPMail: Codeunit "SMTP Mail";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email message";
        Employee: Record Employee;
        SenderStaffID: Code[30];
        SupervisorID: Code[30];

    local procedure SendEmailNotification(DocNo: Code[20]; SenderID: Code[30]; ApproverID: Code[30]; SenderName: Text[100]; ApproverName: Text[100]; Direction: Code[10]; Verdict: Code[10])
    var
        Subject: Code[30];
        BodyText: Text[250];
        RecipientName: Text[250];
        RecipientEmail: Text[100];
    begin
        if Direction = 'UP' then begin
            Subject := 'REQUEST FOR APPROVAL';
            RecipientName := ApproverName;
            BodyText := 'You have a pending Appraissal approval, Document No: ' + DocNo + ' from ' + SenderName + '. Kindly Log in and check the document then Approve/Reject on your basis.';
        end else begin
            RecipientName := SenderName;
            if Verdict = 'APPROVED' then begin
                Subject := 'APPRAISAL APPROVED';
                BodyText := 'Your Appraissal approval request for Document No: ' + DocNo + ' has been approved by your supervisor, ' + ApproverName + '. Kindly Log in to the system then proceed with subsequent steps.';
            end else begin
                Subject := 'APPRAISAL REJECTED';
                BodyText := 'Your Appraissal approval request for Document No: ' + DocNo + ' has been rejected by your supervisor, ' + ApproverName + '. Kindly Log in to the system then take the necessary steps.';
            end;
        end;


        SenderUserSetup.Reset;
        SenderUserSetup.SetRange("User ID", SenderID);
        SenderUserSetup.SetFilter("E-Mail", '<>%1', '');
        if SenderUserSetup.FindFirst then begin
            //MESSAGE('here %1',ApproverID);
            ApproverUserSetup.Reset;
            ApproverUserSetup.SetRange("User ID", ApproverID);
            if ApproverUserSetup.Find('-') then begin
                //MESSAGE('Approver %1',ApproverUserSetup."E-Mail");
                if ApproverUserSetup."E-Mail" <> '' then begin
                    if Direction = 'UP' then
                        RecipientEmail := ApproverUserSetup."E-Mail"
                    else
                        RecipientEmail := SenderUserSetup."E-Mail";
                    EmailMessage.Create(RecipientEmail, Subject, '', true);
                    EmailMessage.AppendToBody('<HR>');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('Dear ' + RecipientName + ',');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody(BodyText);
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('Kind Regards');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody(CompanyName);
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('<HR>');
                    //SLEEP(3000);
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    //MESSAGE('here 1');
                end;
            end;
        end;
    end;
}