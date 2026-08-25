page 51525388 "Staff Targets Card"
{
    ApplicationArea = All;
    Editable = true;
    SourceTable = "Staff Target Objectives";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Staff No"; Rec."Staff No")
                {
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field(Section; Rec.Section)
                {
                }
                field(Period; Rec.Period)
                {

                    trigger OnValidate()
                    begin
                        //FRED 5/3/23 Limit modification to within set dates
                        HrAppraissalPeriods.Reset;
                        HrAppraissalPeriods.SetRange(Code, Rec.Period);
                        if HrAppraissalPeriods.FindFirst then begin
                            if (HrAppraissalPeriods."Allow Edits From" <> 0D) and (HrAppraissalPeriods."Allow Edits To" <> 0D) then begin
                                if (Today < HrAppraissalPeriods."Allow Edits From") or (Today > HrAppraissalPeriods."Allow Edits To") then begin
                                    Error('You are no longer allowed to modify this target because the working date is outside the allowable modification dates for this period!');
                                end;
                            end;
                        end;
                    end;
                }
                field("Created On"; Rec."Created On")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                }
            }
            part(Planning; "Staff Targets ListPart")
            {
                Caption = 'Planning';
                SubPageLink = "Doc No" = FIELD(No);//,
                                                   //"Staff No" = FIELD("Staff No"),
                                                   //Period = FIELD(Period);
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Performance Planning")
            {
                Image = "Report";

                trigger OnAction()
                begin
                    Targets.Reset;
                    Targets.SetRange(No, Rec.No);
                    if Targets.Find('-') then
                        REPORT.Run(Report::"Performance Planning", true, false, Targets);
                end;
            }
        }
        area(Processing)
        {
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
                    Message('Approval request has been sent successfully.');
                end;
            }
            action(MyCancelApproval)
            {
                Caption = 'Cancel Approval Request';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Rec."Approval Status" <> Rec."Approval Status"::Approved then begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        Message('Approval request has been Canceled');
                        Rec.Get(Rec.No);
                        if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then begin
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec.Modify();
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
                    if Rec."Approval Status" <> Rec."Approval Status"::Approved then
                        Error('The document must be approved to reopen.');
                    Rec."Approval Status" := Rec."Approval Status"::Open;
                    Rec.Modify();
                    CurrPage.Update(false);
                end;
            }
        }
        area(Promoted)
        {
            group(Approvall)
            {
                Caption = 'Approval';

                actionref(MySendApprovalRef; MySendApproval) { }
                actionref(MyCancelRef; MyCancelApproval) { }
                actionref(MyApprovalsRef; MyApprovals) { }
                actionref(ReopenRef; Reopen) { }
                actionref(PerformancePlanningRef; "Performance Planning") { }
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        //FRED 5/3/23 Limit modification to within set dates
        HrAppraissalPeriods.Reset;
        HrAppraissalPeriods.SetRange(Code, Rec.Period);
        if HrAppraissalPeriods.FindFirst then begin
            if (HrAppraissalPeriods."Allow Edits From" <> 0D) and (HrAppraissalPeriods."Allow Edits To" <> 0D) then begin
                if (Today < HrAppraissalPeriods."Allow Edits From") or (Today > HrAppraissalPeriods."Allow Edits To") then begin
                    Error('You are no longer allowed to modify this target because the working date is outside the allowable modification dates for this period!');
                end;
            end;
        end;

        //Sorted OnOpenPage but this is just for abundance of caution
        /*IF "Approved By Supervisor" THEN
          ERROR('You are not allowed to edit targets after approval!');*/

    end;

    trigger OnOpenPage()
    begin
        CurrPage.Editable := Rec."Approval Status" = Rec."Approval Status"::Open;
    end;

    var
        Targets: Record "Staff Target Objectives";
        UserSetup: Record "User Setup";
        SenderUserSetup: Record "User Setup";
        ApproverUserSetup: Record "User Setup";
        SenderName: Text[100];
        ApproverName: Text[100];
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email message";
        Employee: Record Employee;
        SenderStaffID: Code[30];
        SupervisorID: Code[30];
        HrAppraissalPeriods: Record "HR Appraisal Periods";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Mgmt HR";

    [ServiceEnabled]
    procedure SendEmailNotification(DocNo: Code[20]; SenderEmpNo: Code[30]; ApproverEmpNo: Code[30]; SenderName: Text[100]; ApproverName: Text[100]; Direction: Code[70]; Verdict: Code[70])
    var
        Subject: Code[30];
        BodyText: Text[250];
        RecipientName: Text[250];
        RecipientEmail: Text[100];
        EmpRec: Record Employee;
    begin
        RecipientEmail := '';
        RecipientName := '';
        if Direction = 'UP' then begin
            Subject := 'REQUEST FOR APPROVAL';
            RecipientName := ApproverName;
            BodyText := 'You have a pending Staff Targets approval, Document No: ' + DocNo + ' from ' + SenderName + '. Kindly Log in and check the document then Approve/Reject on your basis.';

            EmpRec.Reset();
            EmpRec.SetRange("No.", ApproverEmpNo);
            EmpRec.SetRange("Company E-Mail", '<>%1', '');
            if EmpRec.Find('-') then
                RecipientEmail := EmpRec."Company E-Mail";
        end else begin
            RecipientName := SenderName;
            if Verdict = 'APPROVED' then begin
                Subject := 'TARGETS APPROVED';
                BodyText := 'Your Staff Targets approval request for Document No: ' + DocNo + ' has been approved by your supervisor, ' + ApproverName + '. Kindly Log in to the system then proceed with subsequent steps.';
            end else begin
                Subject := 'TARGETS REJECTED';
                BodyText := 'Your Staff Targets approval request for Document No: ' + DocNo + ' has been rejected by your supervisor, ' + ApproverName + '. Kindly Log in to the system then take the necessary steps.';

                EmpRec.Reset();
                EmpRec.SetRange("No.", SenderEmpNo);
                EmpRec.SetRange("Company E-Mail", '<>%1', '');
                if EmpRec.Find('-') then
                    RecipientEmail := EmpRec."Company E-Mail";
            end;
        end;

        if RecipientEmail <> '' then begin
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
}