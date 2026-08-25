codeunit 52211629 "Performance Approvals"
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: label 'This record is not supported by the related approval workflow.';

        OnSendPerfomApprovalRequestTxt: label 'Approval of a Performance Contract is requested.';
        RunWorkflowOnSendPerformForApprovalCode: label 'RUNWORKFLOWONSENDPERFORMFORAPPROVAL';
        OnCancelPerformApprovalRequestTxt: label 'An Approval of a Performance Contract is canceled.';
        RunWorkflowOnCancelPerformForApprovalCode: label 'RUNWORKFLOWONCANCELPERFORMFORAPPROVAL';

        OnSendAnnualApprovalRequestTxt: label 'Approval of an Annual Workplan is requested.';
        RunWorkflowOnSendAnnualForApprovalCode: label 'RUNWORKFLOWONSENDANNUALFORAPPROVAL';
        OnCancelAnnualApprovalRequestTxt: label 'An Approval of an Annual Workplan is canceled.';
        RunWorkflowOnCancelAnnualForApprovalCode: label 'RUNWORKFLOWONCANCELANNUALFORAPPROVAL';

        OnSendCorporateApprovalRequestTxt: label 'Approval of a Corporate Strategic Plan is requested.';
        RunWorkflowOnSendCorporateForApprovalCode: label 'RUNWORKFLOWONSENDCORPORATEFORAPPROVAL';
        OnCancelCorporateApprovalRequestTxt: label 'An Approval of a Corporate Strategic Plan is canceled.';
        RunWorkflowOnCancelCorporateForApprovalCode: label 'RUNWORKFLOWONCANCELCORPORATEFORAPPROVAL';

        OnSendPIPApprovalRequestTxt: label 'Approval of a Performance Improvement Plan is requested.';
        RunWorkflowOnSendPIPForApprovalCode: label 'RUNWORKFLOWONSENDPIPFORAPPROVAL';
        OnCancelPIPApprovalRequestTxt: label 'An Approval of a Performance Improvement Plan is canceled.';
        RunWorkflowOnCancelPIPForApprovalCode: label 'RUNWORKFLOWONCANCELPIPFORAPPROVAL';

        OnSendCheckInApprovalRequestTxt: label 'A Performance Check-In has been submitted for manager review.';
        RunWorkflowOnSendCheckInForApprovalCode: label 'RUNWORKFLOWONSENDCHECKINFORAPPROVAL';
        OnCancelCheckInApprovalRequestTxt: label 'A Performance Check-In submission has been withdrawn.';
        RunWorkflowOnCancelCheckInForApprovalCode: label 'RUNWORKFLOWONCANCELCHECKINFORAPPROVAL';

    procedure CheckApprovalsWorkflowEnabled(var Variant: Variant): Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Perfomance Contract Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPerformForApprovalCode));
            Database::"Annual Strategy Workplan":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendAnnualForApprovalCode));
            Database::"Corporate Strategic Plans":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendCorporateForApprovalCode));
            Database::"Performance Improvement Plan":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPIPForApprovalCode));
            Database::"SPM Performance Check In":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendCheckInForApprovalCode));
        end;
    end;

    procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant; CheckApprovalsWorkflowTxt: Text): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(Variant, CheckApprovalsWorkflowTxt) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelDocApprovalRequest(var Variant: Variant)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddWorkflowEventsToLibrary()
    var
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnSendPerformForApprovalCode, Database::"Perfomance Contract Header", OnSendPerfomApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnCancelPerformForApprovalCode, Database::"Perfomance Contract Header", OnCancelPerformApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnSendAnnualForApprovalCode, Database::"Annual Strategy Workplan", OnSendAnnualApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnCancelAnnualForApprovalCode, Database::"Annual Strategy Workplan", OnCancelAnnualApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnSendCorporateForApprovalCode, Database::"Corporate Strategic Plans", OnSendCorporateApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnCancelCorporateForApprovalCode, Database::"Corporate Strategic Plans", OnCancelCorporateApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnSendPIPForApprovalCode, Database::"Performance Improvement Plan", OnSendPIPApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnCancelPIPForApprovalCode, Database::"Performance Improvement Plan", OnCancelPIPApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnSendCheckInForApprovalCode, Database::"SPM Performance Check In", OnSendCheckInApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnCancelCheckInForApprovalCode, Database::"SPM Performance Check In", OnCancelCheckInApprovalRequestTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Performance Approvals", 'OnSendDocForApproval', '', false, false)]
    procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Perfomance Contract Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPerformForApprovalCode, Variant);
            Database::"Annual Strategy Workplan":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAnnualForApprovalCode, Variant);
            Database::"Corporate Strategic Plans":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCorporateForApprovalCode, Variant);
            Database::"Performance Improvement Plan":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPIPForApprovalCode, Variant);
            Database::"SPM Performance Check In":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCheckInForApprovalCode, Variant);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Performance Approvals", 'OnCancelDocApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Perfomance Contract Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPerformForApprovalCode, Variant);
            Database::"Annual Strategy Workplan":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAnnualForApprovalCode, Variant);
            Database::"Corporate Strategic Plans":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCorporateForApprovalCode, Variant);
            Database::"Performance Improvement Plan":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPIPForApprovalCode, Variant);
            Database::"SPM Performance Check In":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCheckInForApprovalCode, Variant);
        end;
    end;

    procedure ReOpen(var RecRef: RecordRef; var Handled: Boolean)
    var
        Variant: Variant;
        Corporate: Record "Corporate Strategic Plans";
        Perform: Record "Perfomance Contract Header";
        Annual: Record "Annual Strategy Workplan";
        PIP: Record "Performance Improvement Plan";
        CheckIn: Record "SPM Performance Check In";
    begin
        case RecRef.Number of
            Database::"Corporate Strategic Plans":
                begin
                    RecRef.SetTable(Corporate);
                    Corporate.Validate("Approval Status", Corporate."Approval Status"::Open);
                    Corporate.Modify();
                    Variant := Corporate;
                    Handled := true;
                end;
            Database::"Perfomance Contract Header":
                begin
                    RecRef.SetTable(Perform);
                    Perform.Validate("Approval Status", Perform."Approval Status"::Open);
                    Perform.Modify();
                    Variant := Perform;
                    Handled := true;
                end;
            Database::"Annual Strategy Workplan":
                begin
                    RecRef.SetTable(Annual);
                    Annual.Validate("Approval Status", Annual."Approval Status"::Open);
                    Annual.Modify();
                    Variant := Annual;
                    Handled := true;
                end;
            Database::"Performance Improvement Plan":
                begin
                    RecRef.SetTable(PIP);
                    PIP.Validate("Approval Status", PIP."Approval Status"::Open);
                    PIP.Modify();
                    Variant := PIP;
                    Handled := true;
                end;
            Database::"SPM Performance Check In":
                begin
                    RecRef.SetTable(CheckIn);
                    CheckIn."Check-In Status" := CheckIn."check-in status"::Open;
                    CheckIn."Submitted By" := '';
                    CheckIn."Submitted On" := 0D;
                    CheckIn."Rejected Reason" := '';
                    CheckIn.Modify();
                    Variant := CheckIn;
                    Handled := true;
                end;
        end;
    end;

    procedure Release(RecRef: RecordRef; var Handled: Boolean)
    var
        Variant: Variant;
        Corporate: Record "Corporate Strategic Plans";
        Perform: Record "Perfomance Contract Header";
        Annual: Record "Annual Strategy Workplan";
        PIP: Record "Performance Improvement Plan";
        CheckIn: Record "SPM Performance Check In";
    begin
        Handled := true;
        case RecRef.Number of
            Database::"Corporate Strategic Plans":
                begin
                    RecRef.SetTable(Corporate);
                    Corporate.Validate("Approval Status", Corporate."Approval Status"::Released);
                    Corporate.Modify();
                    Variant := Corporate;
                end;
            Database::"Perfomance Contract Header":
                begin
                    RecRef.SetTable(Perform);
                    Perform.Validate("Approval Status", Perform."Approval Status"::Released);
                    Perform.Modify();
                    Variant := Perform;
                end;
            Database::"Annual Strategy Workplan":
                begin
                    RecRef.SetTable(Annual);
                    Annual.Validate("Approval Status", Annual."Approval Status"::Released);
                    Annual.Modify();
                    Variant := Annual;
                end;
            Database::"Performance Improvement Plan":
                begin
                    RecRef.SetTable(PIP);
                    PIP.Validate("Approval Status", PIP."Approval Status"::Released);
                    PIP.Modify();
                    Variant := PIP;
                end;
            Database::"SPM Performance Check In":
                begin
                    RecRef.SetTable(CheckIn);
                    CheckIn."Check-In Status" := CheckIn."check-in status"::Approved;
                    CheckIn."Manager Completed By" := UserId();
                    CheckIn."Manager Completed On" := Today;
                    CheckIn."Approved By" := UserId();
                    CheckIn."Approved On" := Today;
                    CheckIn.Modify();
                    Variant := CheckIn;
                end;
        end;
    end;

    procedure SetStatusToPending(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Corporate: Record "Corporate Strategic Plans";
        Perform: Record "Perfomance Contract Header";
        Annual: Record "Annual Strategy Workplan";
        PIP: Record "Performance Improvement Plan";
        CheckIn: Record "SPM Performance Check In";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Corporate Strategic Plans":
                begin
                    RecRef.SetTable(Corporate);
                    Corporate.Validate("Approval Status", Corporate."Approval Status"::"Pending Approval");
                    Corporate.Modify();
                    Variant := Corporate;
                    IsHandled := true;
                end;
            Database::"Perfomance Contract Header":
                begin
                    RecRef.SetTable(Perform);
                    Perform.Validate("Approval Status", Perform."Approval Status"::"Pending Approval");
                    Perform.Modify();
                    Variant := Perform;
                    IsHandled := true;
                end;
            Database::"Annual Strategy Workplan":
                begin
                    RecRef.SetTable(Annual);
                    Annual.Validate("Approval Status", Annual."Approval Status"::"Pending Approval");
                    Annual.Modify();
                    Variant := Annual;
                    IsHandled := true;
                end;
            Database::"Performance Improvement Plan":
                begin
                    RecRef.SetTable(PIP);
                    PIP.Validate("Approval Status", PIP."Approval Status"::"Pending Approval");
                    PIP.Modify();
                    Variant := PIP;
                    IsHandled := true;
                end;
            Database::"SPM Performance Check In":
                begin
                    RecRef.SetTable(CheckIn);
                    CheckIn."Check-In Status" := CheckIn."check-in status"::Submitted;
                    CheckIn."Submitted By" := UserId();
                    CheckIn."Submitted On" := Today;
                    CheckIn.Modify();
                    Variant := CheckIn;
                    IsHandled := true;
                end;
        end;
    end;
}
