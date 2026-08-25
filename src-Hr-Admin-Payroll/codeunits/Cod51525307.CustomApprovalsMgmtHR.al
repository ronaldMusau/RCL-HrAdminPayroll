codeunit 51525307 "Custom Approvals Mgmt HR"
{
    trigger OnRun()
    begin
        AddWorkflowEventsToLibrary();
    end;


    var
        WorkflowManagement: Codeunit "Workflow Management";
        UnsupportedRecordTypeErr: Label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';
        NoWorkflowEnabledErr: Label 'This record is not supported by related approval workflow.';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        "--JOB APPLICATION----": Label '**************';
        OnSendJobApplicationsApprovalRequestTxt: Label 'Approval of a Job Application is requested';
        RunWorkflowOnSendJobApplicationsForApprovalCode: Label 'RUNWORKFLOWONSENDJOBAPPLICATIONSFORAPPROVAL';
        OnCancelJobApplicationsApprovalRequestTxt: Label 'An Approval of a Job Application is canceled';
        RunWorkflowOnCancelJobApplicationsForApprovalCode: Label 'RUNWORKFLOWONCANCELJOBAPPLICATIONSFORAPPROVAL';
        "--Leave Application----": Label '**************';
        OnSendLeavesApplicationApprovalRequestTxt: Label 'Approval of a Leaves Application is requested';
        RunWorkflowOnSendLeavesApplicationForApprovalCode: Label 'RUNWORKFLOWONSENDLEAVESAPPLICATIONFORAPPROVAL';
        OnCancelLeaveApplicationApprovalRequestTxt: Label 'An Approval of a Leaves Application is canceled';
        RunWorkflowOnCancelLeaveApplicationForApprovalCode: Label 'RUNWORKFLOWONCANCELLEAVEAPPLICATIONFORAPPROVAL';
        LeaveRec: Page "Leave Application HR";
        Leave: Record "Employee Leave Application";

        PayrollProcessingHeader: Record "Payroll Processing Header";
        "--Pay Processing Header Header--": Label '**************';
        OnSendPayrollApprovalRequestTxt: Label 'An approval of a payroll processing header is requested';
        RunWorkflowSendPayrollApprovalCode: Label 'RUNWORKFLOWONSENDPAYROLLHEADERFORAPPROVAL';
        RunWorkflowSendRecruitmentDocApprovalCode: Label 'RUNWORKFLOWONSENDRECRUITMENTDOCFORAPPROVAL';
        RunWorkflowOnCancelRecruitmentDocApprovalCode: Label 'RUNWORKFLOWONCANCELRECRUITMENTAPPROVALREQUEST';
        OnSendRecruitmentDocApprovalRequestTxt: Label 'Approval for Recruitment is requested.';
        OnCancelRecruitmentDocApprovalRequestTxt: Label 'An approval request for Recruitment is canceled.';
        OnCancelPayrollApprovalRequestTxt: Label 'An approval of a payroll processing header is canceled';
        RunWorkflowOnCancelPayrollApprovalCode: Label 'RUNWORKFLOWONCANCELPAYROLLPROCESSINGHEADERAPPROVAL';

        "--Terminal Dues--": Label '**************';
        OnSendTerminalDuesApprovalRequestTxt: Label 'Approval of final dues is requested';
        RunWorkflowOnSendTerminalDuesForApprovalCode: Label 'RUNWORKFLOWONSENDTERMINALDUESFORAPPROVAL';
        OnCancelTerminalDuesApprovalRequestTxt: Label 'An approval of final dues is canceled';
        RunWorkflowOnCancelTerminalDuesApprovalCode: Label 'RUNWORKFLOWONCANCELTERMINALDUESAPPROVAL';
        TerminalDues: Record "Terminal Dues Header";

        "--Employee Changes--": Label '**************';
        OnSendEmployeeChangesApprovalRequestTxt: Label 'Approval of Employee Changes is requested';
        RunWorkflowOnSendEmployeeChangesApprovalCode: Label 'RUNWORKFLOWONSENDEMPLOYEECHANGESAPPROVAL';
        OnCancelEmployeeChangesApprovalRequestTxt: Label 'An approval of Employee Changes is canceled';
        RunWorkflowOnCancelEmployeeChangesApprovalCode: Label 'RUNWORKFLOWONCANCELEMPLOYEECHANGESAPPROVAL';
        EmployeeChanges: Record "Change Request";


        "--Training Allowance Batches-": Label '**************';
        OnSendTrainingAllowanceApprovalRequestTxt: Label 'Approval of Training allowance is requested';
        RunWorkflowOnSendTrainingAllowanceApprovalCode: Label 'RUNWORKFLOWONSENDTRAININGALLOWANCEAPPROVAL';
        OnCancelTrainingAllowanceApprovalRequestTxt: Label 'An approval of Training allowance is canceled';
        RunWorkflowOnCancelTrainingAllowanceApprovalCode: Label 'RUNWORKFLOWONCANCELTRAININGALLOWANCEAPPROVAL';
        TrainingAllowanceBatch: Record "Training Allowance Batches";

        "--Airtime Allocation batch--": Label '**************';
        OnSendAirtimeAllocationBatchApprovalRequestTxt: Label 'Approval of an Airtime Allocation Batch is requested';
        RunWorkflowOnSendAirtimeAllocationBatchApprovalCode: Label 'RUNWORKFLOWONSENDAIRTIMEALLOCATIONBATCHAPPROVAL';
        OnCancelAirtimeAllocationBatchApprovalRequestTxt: Label 'An approval of an Airtime Allocation Batch is canceled';
        RunWorkflowOnCancelAirtimeAllocationBatchApprovalCode: Label 'RUNWORKFLOWONCANCELAIRTIMEALLOCATIONBATCHAPPROVAL';
        AirtimeAllocationBatch: Record "Airtime Allocation Batches";


        "--Airtime Requests--": Label '**************';
        OnSendAirtimeRequestApprovalRequestTxt: Label 'Approval of an Airtime Request is requested';
        RunWorkflowOnSendAirtimeRequestApprovalCode: Label 'RUNWORKFLOWONSENDAIRTIMEREQUESTAPPROVAL';
        OnCancelAirtimeRequestApprovalRequestTxt: Label 'An approval of an Airtime Request is canceled';
        RunWorkflowOnCancelAirtimeRequestApprovalCode: Label 'RUNWORKFLOWONCANCELAIRTIMEREQUESTAPPROVAL';
        AirtimeRequest: Record "Airtime Requests";


        "--Hotel Booking Requests--": Label '**************';
        OnSendHotelBookingRequestApprovalRequestTxt: Label 'Approval of a Hotel Booking Request is requested';
        RunWorkflowOnSendHotelBookingRequestApprovalCode: Label 'RUNWORKFLOWONSENDHOTELBOOKINGREQUESTAPPROVAL';
        OnCancelHotelBookingRequestApprovalRequestTxt: Label 'An approval of a Hotel Booking Request is canceled';
        RunWorkflowOnCancelHotelBookingRequestApprovalCode: Label 'RUNWORKFLOWONCANCELHOTELBOOKINGREQUESTAPPROVAL';
        HotelBookingRequest: Record "Hotel Booking Requests";

        "--Refreshment Requests--": Label '**************';
        OnSendRefreshmentRequestApprovalRequestTxt: Label 'Approval of a Refreshment Request is requested';
        RunWorkflowOnSendRefreshmentRequestApprovalCode: Label 'RUNWORKFLOWONSENDREFRESHMENTREQUESTAPPROVAL';
        OnCancelRefreshmentRequestApprovalRequestTxt: Label 'An approval of a Refreshment Request is canceled';
        RunWorkflowOnCancelRefreshmentRequestApprovalCode: Label 'RUNWORKFLOWONCANCELREFRESHMENTREQUESTAPPROVAL';
        RefreshmentRequest: Record "Refreshment Requests";

        "--Room Booking Requests--": Label '**************';
        OnSendRoomBookingRequestApprovalRequestTxt: Label 'Approval of a Room Booking Request is requested';
        RunWorkflowOnSendRoomBookingRequestApprovalCode: Label 'RUNWORKFLOWONSENDROOMBOOKINGREQUESTAPPROVAL';
        OnCancelRoomBookingRequestApprovalRequestTxt: Label 'An approval of a Room Booking Request is canceled';
        RunWorkflowOnCancelRoomBookingRequestApprovalCode: Label 'RUNWORKFLOWONCANCELROOMBOOKINGREQUESTAPPROVAL';
        RoomBooking: Record "Room Booking Requests";

        "--Requisition Fees Requests--": Label '**************';
        OnSendRequisitionFeesRequestApprovalRequestTxt: Label 'Approval of a Requisition Fees Request is requested';
        RunWorkflowOnSendRequisitionFeesRequestApprovalCode: Label 'RUNWORKFLOWONSENDREQUISITIONFEESREQUESTAPPROVAL';
        OnCancelRequisitionFeesRequestApprovalRequestTxt: Label 'An approval of a Requisition Fees Request is canceled';
        RunWorkflowOnCancelRequisitionFeesRequestApprovalCode: Label 'RUNWORKFLOWONCANCELREQUISITIONFEESREQUESTAPPROVAL';
        RequisitionFeesRequest: Record "Requisition Fees Requests";

        "--Meal Requisition--": Label '**************';
        OnSendMealRequisitionApprovalRequestTxt: Label 'Approval of a Meal Requisition is requested';
        RunWorkflowOnSendMealRequisitionApprovalCode: Label 'RUNWORKFLOWONSENDMEALREQUISITIONAPPROVAL';
        OnCancelMealRequisitionApprovalRequestTxt: Label 'An approval of a Meal Requisition is canceled';
        RunWorkflowOnCancelMealRequisitionApprovalCode: Label 'RUNWORKFLOWONCANCELMEALREQUISITIONAPPROVAL';
        MealRequisitionHeader: Record "Meal Requisition Header";
        RecruitmentNeeds: Record "Recruitment Needs";

        "--Memo Requests--": Label '**************';
        OnSendMemoRequestApprovalRequestTx: Label 'Approval of a Memo  Request is requested';
        RunWorkflowOnSendMemoRequestApprovalCod: Label 'RUNWORKFLOWONSENDMemoREQUESTAPPROVAL';
        OnCancelMemoRequestApprovalRequestTx: Label 'An approval of a Memo Request is canceled';
        RunWorkflowOnCancelMemoRequestApprovalCod: Label 'RUNWORKFLOWONCANCElMemoFREQUESTAPPROVAL';
        Memoequest: Record "Memo Header";

        "--Shift Requests--": Label '**************';
        OnSendShiftRequestApprovalRequestTxt: Label 'Approval of a Shift  Request is requested';
        RunWorkflowOnSendShiftRequestApprovalCode: Label 'RUNWORKFLOWONSENDShiftREQUESTAPPROVAL';
        OnCancelShiftRequestApprovalRequestTxt: Label 'An approval of a Shift Request is canceled';
        RunWorkflowOnCancelShiftRequestApprovalCode: Label 'RUNWORKFLOWONCANCElShiftFREQUESTAPPROVAL';
        ShiftRequest: Record "Shift Header";

        "--Claim Requests--": Label '**************';
        OnSendClaimRequestApprovalRequestTxt: Label 'Approval of a Claim Request is requested';
        RunWorkflowOnSendClaimRequestApprovalCode: Label 'RUNWORKFLOWONSENDCLAIMREQUESTAPPROVAL';
        OnCancelClaimRequestApprovalRequestTxt: Label 'An approval of a Claim Request is canceled';
        RunWorkflowOnCancelClaimRequestApprovalCode: Label 'RUNWORKFLOWONCANCElCLAIMFREQUESTAPPROVAL';
        ClaimRequest: Record "Medical Claim Header";

        "--Travel Requests--": Label '**************';
        OnSendTravelRequestApprovalRequestTxt: Label 'Approval of a Travel  Request is requested';
        RunWorkflowOnSendTravelRequestApprovalCode: Label 'RUNWORKFLOWONSENDSTRAVELREQUESTAPPROVAL';
        OnCancelTravelRequestApprovalRequestTxt: Label 'An approval of a Travel Request is canceled';
        RunWorkflowOnCancelTravelRequestApprovalCode: Label 'RUNWORKFLOWONCANCElTRAVELFREQUESTAPPROVAL';
        TravelRequest: Record "Travelling Request";

        "--Compassionate Checks--": Label '**************';
        OnSendCompassionateCheckApprovalRequestTxt: Label 'Approval of a Compassionate Check is requested';
        RunWorkflowOnSendCompassionateCheckApprovalCode: Label 'RUNWORKFLOWONSENDCOMPASSIONATECHECKAPPROVAL';
        OnCancelCompassionateCheckApprovalRequestTxt: Label 'An approval of a Compassionate Check is canceled';
        RunWorkflowOnCancelCompassionateCheckApprovalCode: Label 'RUNWORKFLOWONCANCELCOMPASSIONATECHECKAPPROVAL';
        CompassionateCheck: Record "Compassionate Checks";
        "--Loan Applications--": Label '**************';
        OnSendLoanApplicationApprovalRequestTxt: Label 'Approval of a Loan Application is requested';
        RunWorkflowOnSendLoanApplicationForApprovalCode: Label 'RUNWORKFLOWONSENDLOANAPPLICATIONFORAPPROVAL';
        OnCancelLoanApplicationApprovalRequestTxt: Label 'An Approval of a Loan Application is canceled';
        RunWorkflowOnCancelLoanApplicationForApprovalCode: Label 'RUNWORKFLOWONCANCELLOANAPPLICATIONFORAPPROVAL';
        LoanApplication: Record "Loan Application";

        "--Staff Target Objectives--": Label '**************';
        OnSendStaffTargetObjectivesApprovalRequestTxt: Label 'Approval of Staff Target Objectives is requested';
        RunWorkflowOnSendStaffTargetObjectivesApprovalCode: Label 'RUNWORKFLOWONSENDSTAFFTARGETOBJECTIVESAPPROVAL';
        OnCancelStaffTargetObjectivesApprovalRequestTxt: Label 'An approval of Staff Target Objectives is canceled';
        RunWorkflowOnCancelStaffTargetObjectivesApprovalCode: Label 'RUNWORKFLOWONCANCELSTAFFTARGETOBJECTIVESAPPROVAL';
        StaffTargetObjectives: Record "Staff Target Objectives";

        "--Training Request--": Label '**************';
        OnSendTrainingRequestApprovalRequestTxt: Label 'Approval of Training Request is requested';
        RunWorkflowOnSendTrainingRequestApprovalCode: Label 'RUNWORKFLOWONSENDTRAININGREQUESTAPPROVAL';
        OnCancelTrainingRequestApprovalRequestTxt: Label 'An approval of Training Request is canceled';
        RunWorkflowOnCancelTrainingRequestApprovalCode: Label 'RUNWORKFLOWONCANCELTRAININGREQUESTAPPROVAL';
        TrainingRequest: Record "Training Request";

        "--HR Appraisal--": Label '**************';
        OnSendAppraisalRequestApprovalRequestTxt: Label 'Approval of an Appraisal Request is requested';
        RunWorkflowOnSendAppraisalRequestApprovalCode: Label 'RUNWORKFLOWONSENDAPPRAISALREQUESTAPPROVAL';
        OnCancelAppraisalRequestApprovalRequestTxt: Label 'An approval of an Appraisal Request is canceled';
        RunWorkflowOnCancelAppraisalRequestApprovalCode: Label 'RUNWORKFLOWONCANCELAPPRAISALREQUESTAPPROVAL';
        AppraisalRequest: Record "HR Appraisal Header";

        "--Mid Year Appraisal--": Label '**************';
        OnSendMidYearAppraisalApprovalRequestTxt: Label 'Approval of a Mid Year Appraisal is requested';
        RunWorkflowOnSendMidYearAppraisalApprovalCode: Label 'RUNWORKFLOWONSENDMIDYEARAPPRAISALAPPROVAL';
        OnCancelMidYearAppraisalApprovalRequestTxt: Label 'An approval of a Mid Year Appraisal is canceled';
        RunWorkflowOnCancelMidYearAppraisalApprovalCode: Label 'RUNWORKFLOWONCANCELMIDYEARAPPRAISALAPPROVAL';
        MidYearAppraisal: Record "Mid Year Appraisal";

        "--Staff Appraisal Header--": Label '**************';
        OnSendStaffAppraisalApprovalRequestTxt: Label 'Approval of a Staff Appraisal is requested';
        RunWorkflowOnSendStaffAppraisalApprovalCode: Label 'RUNWORKFLOWONSENDSTAFFAPPRAISALAPPROVAL';
        OnCancelStaffAppraisalApprovalRequestTxt: Label 'An approval of a Staff Appraisal is canceled';
        RunWorkflowOnCancelStaffAppraisalApprovalCode: Label 'RUNWORKFLOWONCANCELSTAFFAPPRAISALAPPROVAL';
        StaffAppraisalHeader: Record "Staff Appraisal Header";

        "--COURSE CARD----": Label '**************';
        OnSendCourseCardApprovalRequestTxt: Label 'Approval of a Course is requested';
        RunWorkflowOnSendCourseCardForApprovalCode: Label 'RUNWORKFLOWONSENDCOURSEAPPROVAL';
        OnCancelCourseCardApprovalRequestTxt: Label 'An Approval of a Course is canceled';
        RunWorkflowOnCancelCourseCardForApprovalCode: Label 'RUNWORKFLOWONCANCELCOURSEAPPROVAL';
        TrainingMasterPlan: Record "Training Master Plan Header";

        "--ANNUAL TRAINING PLAN----": Label '**************';
        OnSendAnnualTrainingPlanApprovalRequestTxt: Label 'Approval of an Annual Training Plan is requested';
        RunWorkflowOnSendAnnualTrainingPlanForApprovalCode: Label 'RUNWORKFLOWONSENDANNUALTRAININGPLANAPPROVAL';
        OnCancelAnnualTrainingPlanApprovalRequestTxt: Label 'An Approval of an Annual Training Plan is canceled';
        RunWorkflowOnCancelAnnualTrainingPlanForApprovalCode: Label 'RUNWORKFLOWONCANCELANNUALTRAININGPLANAPPROVAL';
        AnnualTrainingPlan: Record "Annual Training Plan";

        "--Disciplinary Cases--": Label '**************';
        OnSendDisciplinaryCaseApprovalRequestTxt: Label 'Approval of a Disciplinary Case is requested';
        RunWorkflowOnSendDisciplinaryCaseApprovalCode: Label 'RUNWORKFLOWONSENDDISCIPLINARYCASEAPPROVAL';
        OnCancelDisciplinaryCaseApprovalRequestTxt: Label 'An approval of a Disciplinary Case is canceled';
        RunWorkflowOnCancelDisciplinaryCaseApprovalCode: Label 'RUNWORKFLOWONCANCELDISCIPLINARYCASEAPPROVAL';
        DisciplinaryCase: Record "Disciplinary Cases";

        "--PIP Header--": Label '**************';
        OnSendPIPApprovalRequestTxt: Label 'Approval of a PIP is requested';
        RunWorkflowOnSendPIPApprovalCode: Label 'RUNWORKFLOWONSENDPIPAPPROVAL';
        OnCancelPIPApprovalRequestTxt: Label 'An approval of a PIP is canceled';
        RunWorkflowOnCancelPIPApprovalCode: Label 'RUNWORKFLOWONCANCELPIPAPPROVAL';
        PIPApprovalHeader: Record "PIP Header";


    procedure CheckApprovalsWorkflowEnabled(var Variant: Variant): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            //Leave Application
            DATABASE::"Employee Leave Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLeavesApplicationForApprovalCode));
            //Payroll Processing Header
            DATABASE::"Payroll Processing Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowSendPayrollApprovalCode));
            //Terminal Dues
            DATABASE::"Terminal Dues Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTerminalDuesForApprovalCode));
            //Employee Changes
            DATABASE::"Change Request":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendEmployeeChangesApprovalCode));
            //Training Allowance Batches
            DATABASE::"Training Allowance Batches":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTrainingAllowanceApprovalCode));
            //Airtime allocation batch
            DATABASE::"Airtime Allocation Batches":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendAirtimeAllocationBatchApprovalCode));
            //Airtime Requests
            DATABASE::"Airtime Requests":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendAirtimeRequestApprovalCode));
            //Hotel Booking Requests
            DATABASE::"Hotel Booking Requests":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendHotelBookingRequestApprovalCode));
            //Refreshment Requests
            DATABASE::"Refreshment Requests":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendRefreshmentRequestApprovalCode));
            //Room Booking Requests
            DATABASE::"Room Booking Requests":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendRoomBookingRequestApprovalCode));
            //Requisition Fees Requests
            DATABASE::"Requisition Fees Requests":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendRequisitionFeesRequestApprovalCode));
            DATABASE::"Memo Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMemoRequestApprovalCod));
            DATABASE::"Shift Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendShiftRequestApprovalCode));
            DATABASE::"Medical Claim Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendClaimRequestApprovalCode));
            DATABASE::"Travelling Request":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTravelRequestApprovalCode));
            //Compassionate Checks
            DATABASE::"Compassionate Checks":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendCompassionateCheckApprovalCode));
            //Loan Application
            DATABASE::"Loan Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLoanApplicationForApprovalCode));
            //Meal Requisition Header
            DATABASE::"Meal Requisition Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMealRequisitionApprovalCode));
            //Staff Target Objectives
            DATABASE::"Staff Target Objectives":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffTargetObjectivesApprovalCode));
            //Training Request
            DATABASE::"Training Request":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTrainingRequestApprovalCode));
            //Recruitment Needs
            DATABASE::"Recruitment Needs":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowSendRecruitmentDocApprovalCode));
            //HR Appraisal
            DATABASE::"HR Appraisal Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendAppraisalRequestApprovalCode));
            DATABASE::"Mid Year Appraisal":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMidYearAppraisalApprovalCode));
            DATABASE::"Staff Appraisal Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffAppraisalApprovalCode));
            //Training Master Plan Header
            DATABASE::"Training Master Plan Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendCourseCardForApprovalCode));
            //Annual Training Plan
            DATABASE::"Annual Training Plan":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendAnnualTrainingPlanForApprovalCode));
            //Disciplinary Cases
            DATABASE::"Disciplinary Cases":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDisciplinaryCaseApprovalCode));
            //PIP Header
            DATABASE::"PIP Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPIPApprovalCode));

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;


    [Scope('Cloud')]
    procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant; CheckApprovalsWorkflowTxt: Text): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        begin
            if not WorkflowManagement.CanExecuteWorkflow(Variant, CheckApprovalsWorkflowTxt) then
                Error(NoWorkflowEnabledErr);
            exit(true);
        end;
    end;


    [IntegrationEvent(false, false)]
    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelDocApprovalRequest(var Variant: Variant)
    begin
    end;

    procedure OnReopenDocument(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Compassionate Checks":
                begin
                    RecRef.SetTable(CompassionateCheck);
                    CompassionateCheck.Validate("Approval Status",
                        CompassionateCheck."Approval Status"::Open);
                    CompassionateCheck.Modify();
                    Variant := CompassionateCheck;
                end;
            DATABASE::"Meal Requisition Header":
                begin
                    RecRef.SetTable(MealRequisitionHeader);
                    MealRequisitionHeader.Validate("Status",
                        MealRequisitionHeader."Status"::Open);
                    MealRequisitionHeader.Modify();
                    Variant := MealRequisitionHeader;
                end;
            DATABASE::"Loan Application":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication.Validate("Loan Status",
                        LoanApplication."Loan Status"::Application);
                    LoanApplication.Modify();
                    Variant := LoanApplication;
                end;
            DATABASE::"Disciplinary Cases":
                begin
                    RecRef.SetTable(DisciplinaryCase);
                    DisciplinaryCase.Validate("Case Status", DisciplinaryCase."Case Status"::New);
                    DisciplinaryCase.Modify();
                    Variant := DisciplinaryCase;
                end;
            //PIP Header
            DATABASE::"PIP Header":
                begin
                    RecRef.SetTable(PIPApprovalHeader);
                    PIPApprovalHeader.Validate(Status, PIPApprovalHeader.Status::Open);
                    PIPApprovalHeader.Modify();
                    Variant := PIPApprovalHeader;
                end;
            DATABASE::"Employee Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::Open);
                    Leave.Modify();
                    Variant := Leave;
                end;
            DATABASE::"Travelling Request":
                begin
                    RecRef.SetTable(TravelRequest);
                    TravelRequest.Validate("Status", TravelRequest."Status"::Open);
                    TravelRequest.Modify();
                    Variant := TravelRequest;
                end;
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    procedure AddWorkflowEventsToLibrary()
    var
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin

        //Leave Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendLeavesApplicationForApprovalCode, DATABASE::"Employee Leave Application", OnSendLeavesApplicationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelLeaveApplicationForApprovalCode, DATABASE::"Employee Leave Application", OnCancelLeaveApplicationApprovalRequestTxt, 0, false);

        //Payroll Processing Header
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowSendPayrollApprovalCode, DATABASE::"Payroll Processing Header", OnSendPayrollApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelPayrollApprovalCode, DATABASE::"Payroll Processing Header", OnCancelPayrollApprovalRequestTxt, 0, false);

        //Terminal Dues
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTerminalDuesForApprovalCode, DATABASE::"Terminal Dues Header", OnSendTerminalDuesApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTerminalDuesApprovalCode, DATABASE::"Terminal Dues Header", OnCancelTerminalDuesApprovalRequestTxt, 0, false);

        //Employee Changes
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendEmployeeChangesApprovalCode, DATABASE::"Change Request", OnSendEmployeeChangesApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelEmployeeChangesApprovalCode, DATABASE::"Change Request", OnCancelEmployeeChangesApprovalRequestTxt, 0, false);

        //Training Allowance Batches
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTrainingAllowanceApprovalCode, DATABASE::"Training Allowance Batches", OnSendTrainingAllowanceApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTrainingAllowanceApprovalCode, DATABASE::"Training Allowance Batches", OnCancelTrainingAllowanceApprovalRequestTxt, 0, false);

        //Airtime allocation batch
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendAirtimeAllocationBatchApprovalCode, DATABASE::"Airtime Allocation Batches", OnSendAirtimeAllocationBatchApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelAirtimeAllocationBatchApprovalCode, DATABASE::"Airtime Allocation Batches", OnCancelAirtimeAllocationBatchApprovalRequestTxt, 0, false);

        //Airtime Requests
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendAirtimeRequestApprovalCode, DATABASE::"Airtime Requests", OnSendAirtimeRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelAirtimeRequestApprovalCode, DATABASE::"Airtime Requests", OnCancelAirtimeRequestApprovalRequestTxt, 0, false);

        //Hotel Booking Requests
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHotelBookingRequestApprovalCode, DATABASE::"Hotel Booking Requests", OnSendHotelBookingRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHotelBookingRequestApprovalCode, DATABASE::"Hotel Booking Requests", OnCancelHotelBookingRequestApprovalRequestTxt, 0, false);

        //Refreshment Requests
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendRefreshmentRequestApprovalCode, DATABASE::"Refreshment Requests", OnSendRefreshmentRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelRefreshmentRequestApprovalCode, DATABASE::"Refreshment Requests", OnCancelRefreshmentRequestApprovalRequestTxt, 0, false);

        //Room Booking Requests
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendRoomBookingRequestApprovalCode, DATABASE::"Room Booking Requests", OnSendRoomBookingRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelRoomBookingRequestApprovalCode, DATABASE::"Room Booking Requests", OnCancelRoomBookingRequestApprovalRequestTxt, 0, false);

        //Requisition Fees Requests
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendRequisitionFeesRequestApprovalCode, DATABASE::"Requisition Fees Requests", OnSendRequisitionFeesRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelRequisitionFeesRequestApprovalCode, DATABASE::"Requisition Fees Requests", OnCancelRequisitionFeesRequestApprovalRequestTxt, 0, false);

        //Memo Requests
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendMemoRequestApprovalCod, DATABASE::"Memo Header", OnSendMemoRequestApprovalRequestTx, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelMemoRequestApprovalCod, DATABASE::"Memo Header", OnCancelMemoRequestApprovalRequestTx, 0, false);

        //Shift Requests
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendShiftRequestApprovalCode, DATABASE::"Shift Header", OnSendShiftRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelShiftRequestApprovalCode, DATABASE::"Shift Header", OnCancelShiftRequestApprovalRequestTxt, 0, false);

        //Claim Requests
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendClaimRequestApprovalCode, DATABASE::"Medical Claim Header", OnSendClaimRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelClaimRequestApprovalCode, DATABASE::"Medical Claim Header", OnCancelClaimRequestApprovalRequestTxt, 0, false);

        //Travel Requests
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTravelRequestApprovalCode, DATABASE::"Travelling Request", OnSendTravelRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTravelRequestApprovalCode, DATABASE::"Travelling Request", OnCancelTravelRequestApprovalRequestTxt, 0, false);

        //Compassionate Checks
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendCompassionateCheckApprovalCode, DATABASE::"Compassionate Checks", OnSendCompassionateCheckApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelCompassionateCheckApprovalCode, DATABASE::"Compassionate Checks", OnCancelCompassionateCheckApprovalRequestTxt, 0, false);
        //Loan Applications
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendLoanApplicationForApprovalCode, DATABASE::"Loan Application", OnSendLoanApplicationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelLoanApplicationForApprovalCode, DATABASE::"Loan Application", OnCancelLoanApplicationApprovalRequestTxt, 0, false);

        //Meal Requisition
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendMealRequisitionApprovalCode, DATABASE::"Meal Requisition Header", OnSendMealRequisitionApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelMealRequisitionApprovalCode, DATABASE::"Meal Requisition Header", OnCancelMealRequisitionApprovalRequestTxt, 0, false);

        //Staff Target Objectives
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffTargetObjectivesApprovalCode, DATABASE::"Staff Target Objectives", OnSendStaffTargetObjectivesApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffTargetObjectivesApprovalCode, DATABASE::"Staff Target Objectives", OnCancelStaffTargetObjectivesApprovalRequestTxt, 0, false);

        //Training Request
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTrainingRequestApprovalCode, DATABASE::"Training Request", OnSendTrainingRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTrainingRequestApprovalCode, DATABASE::"Training Request", OnCancelTrainingRequestApprovalRequestTxt, 0, false);

        //HR Appraisal
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendAppraisalRequestApprovalCode, DATABASE::"HR Appraisal Header", OnSendAppraisalRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelAppraisalRequestApprovalCode, DATABASE::"HR Appraisal Header", OnCancelAppraisalRequestApprovalRequestTxt, 0, false);

        //Recruitment Needs
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowSendRecruitmentDocApprovalCode, DATABASE::"Recruitment Needs", OnSendRecruitmentDocApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelRecruitmentDocApprovalCode, DATABASE::"Recruitment Needs", OnCancelRecruitmentDocApprovalRequestTxt, 0, false);

        //Mid Year Appraisal
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendMidYearAppraisalApprovalCode, DATABASE::"Mid Year Appraisal", OnSendMidYearAppraisalApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelMidYearAppraisalApprovalCode, DATABASE::"Mid Year Appraisal", OnCancelMidYearAppraisalApprovalRequestTxt, 0, false);

        //Staff Appraisal Header
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffAppraisalApprovalCode, DATABASE::"Staff Appraisal Header", OnSendStaffAppraisalApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffAppraisalApprovalCode, DATABASE::"Staff Appraisal Header", OnCancelStaffAppraisalApprovalRequestTxt, 0, false);

        //Training Master Plan Header
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendCourseCardForApprovalCode, DATABASE::"Training Master Plan Header", OnSendCourseCardApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelCourseCardForApprovalCode, DATABASE::"Training Master Plan Header", OnCancelCourseCardApprovalRequestTxt, 0, false);

        //Annual Training Plan
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendAnnualTrainingPlanForApprovalCode, DATABASE::"Annual Training Plan", OnSendAnnualTrainingPlanApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelAnnualTrainingPlanForApprovalCode, DATABASE::"Annual Training Plan", OnCancelAnnualTrainingPlanApprovalRequestTxt, 0, false);

        //Disciplinary Cases
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDisciplinaryCaseApprovalCode, DATABASE::"Disciplinary Cases", OnSendDisciplinaryCaseApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDisciplinaryCaseApprovalCode, DATABASE::"Disciplinary Cases", OnCancelDisciplinaryCaseApprovalRequestTxt, 0, false);

        //PIP Header
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendPIPApprovalCode, DATABASE::"PIP Header", OnSendPIPApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelPIPApprovalCode, DATABASE::"PIP Header", OnCancelPIPApprovalRequestTxt, 0, false);
    end;

    local procedure RunWorkflowOnSendApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendApprovalRequest'));
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals Mgmt HR", OnSendDocForApproval, '', false, false)]
    procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            //Leave Application
            DATABASE::"Employee Leave Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendLeavesApplicationForApprovalCode, Variant);
            //Payroll Processing Header
            DATABASE::"Payroll Processing Header":
                WorkflowManagement.HandleEvent(RunWorkflowSendPayrollApprovalCode, Variant);
            //Terminal Dues
            DATABASE::"Terminal Dues Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTerminalDuesForApprovalCode, Variant);
            //Employee Changes
            DATABASE::"Change Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendEmployeeChangesApprovalCode, Variant);
            //Training Allowance Batches
            DATABASE::"Training Allowance Batches":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTrainingAllowanceApprovalCode, Variant);
            //Airtime allocation batch
            DATABASE::"Airtime Allocation Batches":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAirtimeAllocationBatchApprovalCode, Variant);
            //Airtime Requests
            DATABASE::"Airtime Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAirtimeRequestApprovalCode, Variant);
            //Hotel Booking Requests
            DATABASE::"Hotel Booking Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHotelBookingRequestApprovalCode, Variant);
            //Refreshment Requests
            DATABASE::"Refreshment Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRefreshmentRequestApprovalCode, Variant);
            //Room Booking Requests
            DATABASE::"Room Booking Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRoomBookingRequestApprovalCode, Variant);
            //Requisition Fees Requests
            DATABASE::"Requisition Fees Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRequisitionFeesRequestApprovalCode, Variant);
            DATABASE::"Memo Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMemoRequestApprovalCod, Variant);
            DATABASE::"Shift Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendShiftRequestApprovalCode, Variant);
            DATABASE::"Medical Claim Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendClaimRequestApprovalCode, Variant);
            DATABASE::"Travelling Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTravelRequestApprovalCode, Variant);
            //Compassionate Checks
            DATABASE::"Compassionate Checks":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCompassionateCheckApprovalCode, Variant);
            //Loan Application
            DATABASE::"Loan Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanApplicationForApprovalCode, Variant);
            //Meal Requisition Header
            DATABASE::"Meal Requisition Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMealRequisitionApprovalCode, Variant);
            //Staff Target Objectives
            DATABASE::"Staff Target Objectives":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffTargetObjectivesApprovalCode, Variant);
            //Recruitment Needs
            DATABASE::"Recruitment Needs":
                WorkflowManagement.HandleEvent(RunWorkflowSendRecruitmentDocApprovalCode, Variant);
            //Training Request
            DATABASE::"Training Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTrainingRequestApprovalCode, Variant);
            //HR Appraisal
            DATABASE::"HR Appraisal Header":
                begin
                    RecRef.SetTable(AppraisalRequest);
                    WorkflowManagement.HandleEvent(RunWorkflowOnSendAppraisalRequestApprovalCode, AppraisalRequest);
                end;
            DATABASE::"Mid Year Appraisal":
                begin
                    RecRef.SetTable(MidYearAppraisal);
                    WorkflowManagement.HandleEvent(RunWorkflowOnSendMidYearAppraisalApprovalCode, MidYearAppraisal);
                end;
            DATABASE::"Staff Appraisal Header":
                begin
                    RecRef.SetTable(StaffAppraisalHeader);
                    WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffAppraisalApprovalCode, StaffAppraisalHeader);
                end;
            //Training Master Plan Header
            DATABASE::"Training Master Plan Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCourseCardForApprovalCode, Variant);
            //Annual Training Plan
            DATABASE::"Annual Training Plan":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAnnualTrainingPlanForApprovalCode, Variant);
            //Disciplinary Cases
            DATABASE::"Disciplinary Cases":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDisciplinaryCaseApprovalCode, Variant);
            //PIP Header
            DATABASE::"PIP Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPIPApprovalCode, Variant);
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals Mgmt HR", OnCancelDocApprovalRequest, '', false, false)]
    procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            //Leave Application
            DATABASE::"Employee Leave Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveApplicationForApprovalCode, Variant);
            //Payroll Processing Header
            DATABASE::"Payroll Processing Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPayrollApprovalCode, Variant);
            //Terminal Dues
            DATABASE::"Terminal Dues Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTerminalDuesApprovalCode, Variant);
            //Employee Changes
            DATABASE::"Change Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelEmployeeChangesApprovalCode, Variant);
            //Training Allowance Batches
            DATABASE::"Training Allowance Batches":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTrainingAllowanceApprovalCode, Variant);
            //Airtime allocation batch
            DATABASE::"Airtime Allocation Batches":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAirtimeAllocationBatchApprovalCode, Variant);
            //Airtime Requests
            DATABASE::"Airtime Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAirtimeRequestApprovalCode, Variant);
            //Hotel Booking Requests
            DATABASE::"Hotel Booking Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHotelBookingRequestApprovalCode, Variant);
            //Refreshment Requests
            DATABASE::"Refreshment Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRefreshmentRequestApprovalCode, Variant);
            //Room Booking Requests
            DATABASE::"Room Booking Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRoomBookingRequestApprovalCode, Variant);
            //Requisition Fees Requests
            DATABASE::"Requisition Fees Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRequisitionFeesRequestApprovalCode, Variant);
            DATABASE::"Memo Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemoRequestApprovalCod, Variant);
            DATABASE::"Shift Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelShiftRequestApprovalCode, Variant);
            DATABASE::"Medical Claim Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelClaimRequestApprovalCode, Variant);
            DATABASE::"Travelling Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTravelRequestApprovalCode, Variant);
            //Compassionate Checks
            DATABASE::"Compassionate Checks":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCompassionateCheckApprovalCode, Variant);
            //Loan Application
            DATABASE::"Loan Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanApplicationForApprovalCode, Variant);
            //Meal Requisition Header
            DATABASE::"Meal Requisition Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMealRequisitionApprovalCode, Variant);
            //Staff Target Objectives
            DATABASE::"Staff Target Objectives":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffTargetObjectivesApprovalCode, Variant);
            //Training Request
            DATABASE::"Training Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTrainingRequestApprovalCode, Variant);
            //Recruitment Needs
            DATABASE::"Recruitment Needs":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRecruitmentDocApprovalCode, Variant);
            //HR Appraisal
            DATABASE::"HR Appraisal Header":
                begin
                    RecRef.SetTable(AppraisalRequest);
                    WorkflowManagement.HandleEvent(RunWorkflowOnCancelAppraisalRequestApprovalCode, AppraisalRequest);
                end;
            DATABASE::"Mid Year Appraisal":
                begin
                    RecRef.SetTable(MidYearAppraisal);
                    WorkflowManagement.HandleEvent(RunWorkflowOnCancelMidYearAppraisalApprovalCode, MidYearAppraisal);
                end;
            DATABASE::"Staff Appraisal Header":
                begin
                    RecRef.SetTable(StaffAppraisalHeader);
                    WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffAppraisalApprovalCode, StaffAppraisalHeader);
                end;
            //Training Master Plan Header
            DATABASE::"Training Master Plan Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCourseCardForApprovalCode, Variant);
            //Annual Training Plan
            DATABASE::"Annual Training Plan":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAnnualTrainingPlanForApprovalCode, Variant);
            //Disciplinary Cases
            DATABASE::"Disciplinary Cases":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDisciplinaryCaseApprovalCode, Variant);
            //PIP Header
            DATABASE::"PIP Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPIPApprovalCode, Variant);
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;


    var
        ApprovalEntry: Record "Approval Entry";

        PortalApprovals: Codeunit "Custom Helper Functions HR";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    procedure Reopen(RecRef: RecordRef; var Handled: Boolean)
    var
    begin
        case RecRef.Number of
            //Leave Application
            DATABASE::"Employee Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::Open);
                    Leave.Modify;
                    //Send cancellation
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", DATABASE::"Employee Leave Application");
                    ApprovalEntry.SetRange("Document No.", Leave."Application No");
                    ApprovalEntry.SetFilter(Status, '<>%1', ApprovalEntry.Status::Canceled);
                    if ApprovalEntry.FindLast() then
                        PortalApprovals.SendLeaveRejectedEmail(ApprovalEntry, Leave."Application No");
                    Handled := true;
                end;
            //Payroll Processing Header
            DATABASE::"Payroll Processing Header":
                begin
                    RecRef.SetTable(PayrollProcessingHeader);
                    PayrollProcessingHeader.Validate(Status, PayrollProcessingHeader.Status::Open);
                    PayrollProcessingHeader.Modify;
                    Handled := true;
                end;
            //Terminal Dues
            DATABASE::"Terminal Dues Header":
                begin
                    RecRef.SetTable(TerminalDues);
                    TerminalDues.Validate("Approval Status", TerminalDues."Approval Status"::Open);
                    TerminalDues.Modify;
                    Handled := true;
                end;
            //Employee Changes
            DATABASE::"Change Request":
                begin
                    RecRef.SetTable(EmployeeChanges);
                    EmployeeChanges.Validate("Change Approval Status", EmployeeChanges."Change Approval Status"::Open);
                    EmployeeChanges.Modify;
                    Handled := true;
                end;
            //Staff Target Objectives
            DATABASE::"Staff Target Objectives":
                begin
                    RecRef.SetTable(StaffTargetObjectives);
                    StaffTargetObjectives.Validate("Approval Status", StaffTargetObjectives."Approval Status"::Open);
                    StaffTargetObjectives.Modify;
                    Handled := true;
                end;
            //Training Request
            DATABASE::"Training Request":
                begin
                    RecRef.SetTable(TrainingRequest);
                    TrainingRequest.Validate(Status, TrainingRequest.Status::Open);
                    TrainingRequest.Modify;
                    Handled := true;
                end;

            //Airtime allocation batch
            DATABASE::"Airtime Allocation Batches":
                begin
                    RecRef.SetTable(AirtimeAllocationBatch);
                    AirtimeAllocationBatch.Validate("Approval Status", AirtimeAllocationBatch."Approval Status"::Open);
                    AirtimeAllocationBatch.Modify;
                    Handled := true;
                end;

            //Airtime Requests
            DATABASE::"Airtime Requests":
                begin
                    RecRef.SetTable(AirtimeRequest);
                    AirtimeRequest.Validate("Approval Status", AirtimeRequest."Approval Status"::Open);
                    AirtimeRequest.Modify;
                    Handled := true;
                end;
            //Hotel Booking Requests
            DATABASE::"Hotel Booking Requests":
                begin
                    RecRef.SetTable(HotelBookingRequest);
                    HotelBookingRequest.Validate("Approval Status", HotelBookingRequest."Approval Status"::Open);
                    HotelBookingRequest.Modify;
                    Handled := true;
                end;
            //Refreshment Requests
            DATABASE::"Refreshment Requests":
                begin
                    RecRef.SetTable(RefreshmentRequest);
                    RefreshmentRequest.Validate("Approval Status", RefreshmentRequest."Approval Status"::Open);
                    RefreshmentRequest.Modify;
                    Handled := true;
                end;
            //Room Booking Requests
            DATABASE::"Room Booking Requests":
                begin
                    RecRef.SetTable(RoomBooking);
                    RoomBooking.Validate("Approval Status", RoomBooking."Approval Status"::Open);
                    RoomBooking.Modify;
                    Handled := true;
                end;
            //Requisition Fees Requests
            DATABASE::"Requisition Fees Requests":
                begin
                    RecRef.SetTable(RequisitionFeesRequest);
                    RequisitionFeesRequest.Validate("Approval Status", RequisitionFeesRequest."Approval Status"::Open);
                    RequisitionFeesRequest.Modify;
                    Handled := true;
                end;
            //Training Allowance Batches
            DATABASE::"Training Allowance Batches":
                begin
                    RecRef.SetTable(TrainingAllowanceBatch);
                    TrainingAllowanceBatch.Validate("Approval Status", TrainingAllowanceBatch."Approval Status"::Open);
                    TrainingAllowanceBatch.Modify;
                    Handled := true;
                end;
            //Memos
            DATABASE::"Memo Header":
                begin
                    RecRef.SetTable(Memoequest);
                    Memoequest.Validate("Approval Status", Memoequest."Approval Status"::Open);
                    Memoequest.Modify;
                    Handled := true;
                end;

            DATABASE::"Shift Header":
                begin
                    RecRef.SetTable(ShiftRequest);
                    ShiftRequest.Validate("Approval Status", ShiftRequest."Approval Status"::Open);
                    ShiftRequest.Modify;
                    Handled := true;
                end;

            DATABASE::"Medical Claim Header":
                begin
                    RecRef.SetTable(ClaimRequest);
                    ClaimRequest.Validate("Approval Status", ClaimRequest."Approval Status"::Open);
                    ClaimRequest.Modify;
                    Handled := true;
                end;

            DATABASE::"Travelling Request":
                begin
                    RecRef.SetTable(TravelRequest);
                    TravelRequest.Validate("Status", TravelRequest."Status"::Open);
                    TravelRequest.Modify;
                    Handled := true;
                end;
            //Loan Application
            DATABASE::"Loan Application":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication.Validate("Loan Status", LoanApplication."Loan Status"::Application);
                    LoanApplication.Modify;
                    Handled := true;
                end;
            //Meal Requisition Header
            DATABASE::"Meal Requisition Header":
                begin
                    RecRef.SetTable(MealRequisitionHeader);
                    MealRequisitionHeader.Validate("Status", MealRequisitionHeader."Status"::Open);
                    MealRequisitionHeader.Modify;
                    Handled := true;
                end;
            //Recruitment Needs
            DATABASE::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentNeeds);
                    RecruitmentNeeds.Validate(Status, RecruitmentNeeds.Status::Open);
                    RecruitmentNeeds.Modify;
                    Handled := true;
                end;

            DATABASE::"HR Appraisal Header":
                begin
                    RecRef.SetTable(AppraisalRequest);
                    AppraisalRequest.Validate(Status, AppraisalRequest.Status::Open);
                    AppraisalRequest.Modify();
                    Handled := true;
                end;
            DATABASE::"Mid Year Appraisal":
                begin
                    RecRef.SetTable(MidYearAppraisal);
                    MidYearAppraisal.Validate("Approval Status", MidYearAppraisal."Approval Status"::Open);
                    MidYearAppraisal.Modify;
                    Handled := true;
                end;
            DATABASE::"Staff Appraisal Header":
                begin
                    RecRef.SetTable(StaffAppraisalHeader);
                    StaffAppraisalHeader.Validate("Approval Status", StaffAppraisalHeader."Approval Status"::Open);
                    StaffAppraisalHeader.Modify;
                    Handled := true;
                end;
            //Training Master Plan Header
            DATABASE::"Training Master Plan Header":
                begin
                    RecRef.SetTable(TrainingMasterPlan);
                    TrainingMasterPlan.Validate("Approval Status", TrainingMasterPlan."Approval Status"::Open);
                    TrainingMasterPlan.Modify;
                    Handled := true;
                end;
            //Annual Training Plan
            DATABASE::"Annual Training Plan":
                begin
                    RecRef.SetTable(AnnualTrainingPlan);
                    AnnualTrainingPlan.Validate("Approval Status", AnnualTrainingPlan."Approval Status"::Open);
                    AnnualTrainingPlan.Modify;
                    Handled := true;
                end;
            //Compassionate Checks
            DATABASE::"Compassionate Checks":
                begin
                    RecRef.SetTable(CompassionateCheck);
                    CompassionateCheck.Validate("Approval Status",
                        CompassionateCheck."Approval Status"::Open);
                    CompassionateCheck.Modify;
                    Handled := true;
                end;
            //Disciplinary Cases
            DATABASE::"Disciplinary Cases":
                begin
                    RecRef.SetTable(DisciplinaryCase);
                    DisciplinaryCase.Validate("Case Status", DisciplinaryCase."Case Status"::New);
                    DisciplinaryCase.Modify;
                    Handled := true;
                end;
            //PIP Header
            DATABASE::"PIP Header":
                begin
                    RecRef.SetTable(PIPApprovalHeader);
                    PIPApprovalHeader.Validate(Status, PIPApprovalHeader.Status::Open);
                    PIPApprovalHeader.Modify;
                    Handled := true;
                end;

        end;
    end;


    var
        UserSetup: Record "User Setup";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        AirtimeManagementFunctions: Codeunit "Airtime Management Functions";
        TravelTempBlob: Codeunit "Temp Blob";
        TravelOutStr: OutStream;
        TravelInStr: InStream;
        TravelDocAttach: Record "Document Attachment";
        TravelPdfName: Text;
        TravelReportParams: Text;
        PIPSetup: Record "PIP Setup";
        PIPHeader: Record "PIP Header";
        PIPEmailMessage: Codeunit "Email Message";
        PIPEmail: Codeunit Email;
        PIPToList: List of [Text];
    begin
        case RecRef.Number of
            //Leave Application
            DATABASE::"Employee Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::Released);
                    Leave.Modify;
                    // Only send email on FINAL approval — when leave is fully Released
                    Leave.Get(Leave."Application No");
                    if Leave.Status = Leave.Status::Released then begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", DATABASE::"Employee Leave Application");
                        ApprovalEntry.SetRange("Document No.", Leave."Application No");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                        if ApprovalEntry.FindLast() then
                            PortalApprovals.SendLeaveApprovalEmail(ApprovalEntry, Leave."Application No");
                    end;
                    Handled := true;
                    //=>Leave.FnPostLeave(Leave."Application No");
                    //LeaveRec.FnPostLeave(Leave."Application No");

                    //=========================================================Update Reliever Details
                    UserSetup.Reset;
                    UserSetup.SetRange("User ID", Leave."User ID");
                    if UserSetup.FindSet then begin
                        UserSetup."Delegation Start" := Leave."Start Date";
                        UserSetup."Delegation End" := Leave."Resumption Date";
                        UserSetup."Leave Reliever Code" := Leave."Duties Taken Over By";
                        UserSetup.Delegate := false;
                        UserSetup.Modify;
                    end;
                end;
            //Payroll Processing Header
            DATABASE::"Payroll Processing Header":
                begin
                    RecRef.SetTable(PayrollProcessingHeader);
                    PayrollProcessingHeader.Validate(Status, PayrollProcessingHeader.Status::Approved);
                    PayrollProcessingHeader.Modify;
                    // Only send email on FINAL approval — when payroll is fully Released
                    PayrollProcessingHeader.Get(PayrollProcessingHeader."Payroll Processing No");
                    if PayrollProcessingHeader.Status = PayrollProcessingHeader.Status::Approved then begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", DATABASE::"Payroll Processing Header");
                        ApprovalEntry.SetRange("Document No.", PayrollProcessingHeader."Payroll Processing No");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                        if ApprovalEntry.FindLast() then
                            PortalApprovals.SendPayrollApprovalEmail(ApprovalEntry, PayrollProcessingHeader."Payroll Processing No");
                    end;
                    Handled := true;
                end;
            //Terminal Dues
            DATABASE::"Terminal Dues Header":
                begin
                    RecRef.SetTable(TerminalDues);
                    TerminalDues.Validate("Approval Status", TerminalDues."Approval Status"::Released);
                    TerminalDues.Modify;
                    Handled := true;
                end;

            //Employee Changes
            DATABASE::"Change Request":
                begin
                    RecRef.SetTable(EmployeeChanges);
                    EmployeeChanges.Validate("Change Approval Status", EmployeeChanges."Change Approval Status"::Approved);
                    EmployeeChanges.UpdateEmployeeCard(); //update emp card
                    EmployeeChanges.Modify;
                    Handled := true;
                end;
            //Staff Target Objectives
            DATABASE::"Staff Target Objectives":
                begin
                    RecRef.SetTable(StaffTargetObjectives);
                    StaffTargetObjectives.Validate("Approval Status", StaffTargetObjectives."Approval Status"::Approved);
                    StaffTargetObjectives.Modify;
                    Handled := true;
                end;
            //Training Request
            DATABASE::"Training Request":
                begin
                    RecRef.SetTable(TrainingRequest);
                    TrainingRequest.Validate(Status, TrainingRequest.Status::Released);
                    TrainingRequest.CalcFields("Total Cost");
                    if TrainingRequest."Local Travel" then
                        TrainingRequest."Total Cost (LCY)" := TrainingRequest."Total Cost"
                    else if TrainingRequest."Exchange Rate" <> 0 then
                        TrainingRequest."Total Cost (LCY)" := TrainingRequest."Exchange Rate" * TrainingRequest."Total Cost"
                    else
                        TrainingRequest."Total Cost (LCY)" := TrainingRequest."Total Cost";
                    TrainingRequest.Modify;
                    Handled := true;
                end;

            //Training Allowance Batches
            DATABASE::"Training Allowance Batches":
                begin
                    RecRef.SetTable(TrainingAllowanceBatch);
                    TrainingAllowanceBatch.Validate("Approval Status", TrainingAllowanceBatch."Approval Status"::Released);
                    TrainingAllowanceBatch.Modify;
                    Handled := true;
                end;

            //Airtime allocation batch
            DATABASE::"Airtime Allocation Batches":
                begin
                    RecRef.SetTable(AirtimeAllocationBatch);
                    AirtimeAllocationBatch.Validate("Approval Status", AirtimeAllocationBatch."Approval Status"::Released);
                    AirtimeManagementFunctions.SendToVendor(AirtimeAllocationBatch."Month Start Date");
                    AirtimeAllocationBatch.Modify;
                    Handled := true;
                end;

            //Airtime Requests
            DATABASE::"Airtime Requests":
                begin
                    RecRef.SetTable(AirtimeRequest);
                    AirtimeRequest.Validate("Approval Status", AirtimeRequest."Approval Status"::Released);
                    AirtimeRequest.Modify;
                    Handled := true;
                end;

            //Hotel Booking Requests
            DATABASE::"Hotel Booking Requests":
                begin
                    RecRef.SetTable(HotelBookingRequest);
                    HotelBookingRequest.Validate("Approval Status", HotelBookingRequest."Approval Status"::Released);
                    HotelBookingRequest.Modify;
                    Handled := true;
                end;

            //Refreshment Requests
            DATABASE::"Refreshment Requests":
                begin
                    RecRef.SetTable(RefreshmentRequest);
                    RefreshmentRequest.Validate("Approval Status", RefreshmentRequest."Approval Status"::Released);
                    RefreshmentRequest.Modify;
                    Handled := true;
                end;

            //Room Booking Requests
            DATABASE::"Room Booking Requests":
                begin
                    RecRef.SetTable(RoomBooking);
                    RoomBooking.Validate("Approval Status", RoomBooking."Approval Status"::Released);
                    RoomBooking.Modify;
                    Handled := true;
                end;

            //Requisition Fees Requests
            DATABASE::"Requisition Fees Requests":
                begin
                    RecRef.SetTable(RequisitionFeesRequest);
                    RequisitionFeesRequest.Validate("Approval Status", RequisitionFeesRequest."Approval Status"::Released);
                    OnReleaseRequisitionFeesRequestBeforeModify(RequisitionFeesRequest);
                    RequisitionFeesRequest.Modify;
                    Handled := true;
                end;
            DATABASE::"Memo Header":
                begin
                    RecRef.SetTable(Memoequest);
                    Memoequest.Validate("Approval Status", Memoequest."Approval Status"::Released);
                    Memoequest.Modify;
                    Handled := true;
                end;

            DATABASE::"Shift Header":
                begin
                    RecRef.SetTable(ShiftRequest);
                    ShiftRequest.Validate("Approval Status", ShiftRequest."Approval Status"::Released);
                    ShiftRequest.Modify;
                    Handled := true;
                end;

            DATABASE::"Medical Claim Header":
                begin
                    RecRef.SetTable(ClaimRequest);
                    ClaimRequest.Validate("Approval Status", ClaimRequest."Approval Status"::Released);
                    ClaimRequest.Modify;
                    Handled := true;
                end;

            DATABASE::"Travelling Request":
                begin
                    RecRef.SetTable(TravelRequest);
                    TravelRequest.Validate("Status", TravelRequest."Status"::Released);
                    TravelRequest.Modify;
                    TravelTempBlob.CreateOutStream(TravelOutStr);
                    TravelReportParams := StrSubstNo(
                        '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="TravellingRequest">VERSION(1) SORTING(Field1) WHERE(Field1=1(%1))</DataItem></DataItems></ReportParameters>',
                        TravelRequest."Request No.");
                    Report.SaveAs(Report::"HR Travel Clearance Form", TravelReportParams, ReportFormat::Pdf, TravelOutStr);
                    TravelTempBlob.CreateInStream(TravelInStr);
                    TravelPdfName := 'TravelClearance_' + TravelRequest."Request No." + '.pdf';
                    TravelDocAttach.Init();
                    TravelDocAttach."Table ID" := DATABASE::"Travelling Request";
                    TravelDocAttach."No." := CopyStr(TravelRequest."Request No.", 1, 20);
                    TravelDocAttach."File Name" := CopyStr(TravelPdfName, 1, MaxStrLen(TravelDocAttach."File Name"));
                    TravelDocAttach."File Extension" := 'pdf';
                    TravelDocAttach."Document Reference ID".ImportStream(TravelInStr, TravelPdfName);
                    TravelDocAttach.Insert(true);
                    Handled := true;
                end;

            //Compassionate Checks
            DATABASE::"Compassionate Checks":
                begin
                    RecRef.SetTable(CompassionateCheck);
                    CompassionateCheck.Validate("Approval Status", CompassionateCheck."Approval Status"::Approved);
                    CompassionateCheck.Modify;
                    Handled := true;
                end;
            //Loan Application
            DATABASE::"Loan Application":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication.Validate("Loan Status", LoanApplication."Loan Status"::Approved);
                    LoanApplication.Modify;
                    Handled := true;
                end;
            //Meal Requisition Header
            DATABASE::"Meal Requisition Header":
                begin
                    RecRef.SetTable(MealRequisitionHeader);
                    MealRequisitionHeader.Validate("Status", MealRequisitionHeader."Status"::Approved);
                    MealRequisitionHeader.Modify;
                    Handled := true;
                end;
            //Recruitment Needs
            DATABASE::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentNeeds);
                    RecruitmentNeeds.Validate(Status, RecruitmentNeeds.Status::Released);
                    RecruitmentNeeds.Modify;
                    Handled := true;
                end;

            DATABASE::"HR Appraisal Header":
                begin
                    RecRef.SetTable(AppraisalRequest);
                    AppraisalRequest.Validate(Status, AppraisalRequest.Status::Released);
                    AppraisalRequest.Modify();
                    Handled := true;
                end;
            DATABASE::"Mid Year Appraisal":
                begin
                    RecRef.SetTable(MidYearAppraisal);
                    MidYearAppraisal.Validate("Approval Status", MidYearAppraisal."Approval Status"::Released);
                    MidYearAppraisal.Modify;
                    Handled := true;
                end;
            DATABASE::"Staff Appraisal Header":
                begin
                    RecRef.SetTable(StaffAppraisalHeader);
                    StaffAppraisalHeader.Validate("Approval Status", StaffAppraisalHeader."Approval Status"::Released);
                    StaffAppraisalHeader.Modify;
                    StaffAppraisalHeader.CalcFields("Overall Score(%)");
                    if PIPSetup.Get() then
                        if StaffAppraisalHeader."Overall Score(%)" < PIPSetup."Cutoff Score" then begin
                            PIPHeader.Init();
                            PIPHeader."Employee No" := StaffAppraisalHeader."Staff No";
                            PIPHeader.Validate("Employee No");
                            PIPHeader."Appraisal No" := StaffAppraisalHeader.No;
                            PIPHeader."Appraisal Period" := StaffAppraisalHeader.Period;
                            PIPHeader."Supervisor No" := StaffAppraisalHeader.Supervisor;
                            PIPHeader.Validate("Supervisor No");
                            PIPHeader.Insert(true);
                            if PIPSetup."Notify HR" and (PIPSetup."HR Email" <> '') then begin
                                Clear(PIPToList);
                                PIPToList.Add(PIPSetup."HR Email");
                                PIPEmailMessage.Create(PIPToList,
                                    'PIP Triggered: ' + PIPHeader."Employee Name",
                                    'A Performance Improvement Plan has been created for ' +
                                    PIPHeader."Employee Name" + ' (Score: ' +
                                    Format(StaffAppraisalHeader."Overall Score(%)") + '%). PIP No: ' +
                                    PIPHeader."PIP No",
                                    true);
                                PIPEmail.Send(PIPEmailMessage, Enum::"Email Scenario"::Default);
                            end;
                        end;
                    Handled := true;
                end;
            //Training Master Plan Header
            DATABASE::"Training Master Plan Header":
                begin
                    RecRef.SetTable(TrainingMasterPlan);
                    TrainingMasterPlan.Validate("Approval Status", TrainingMasterPlan."Approval Status"::Released);
                    TrainingMasterPlan.Modify;
                    Handled := true;
                end;
            //Annual Training Plan
            DATABASE::"Annual Training Plan":
                begin
                    RecRef.SetTable(AnnualTrainingPlan);
                    AnnualTrainingPlan.Validate("Approval Status", AnnualTrainingPlan."Approval Status"::Released);
                    AnnualTrainingPlan.Modify;
                    Handled := true;
                end;
            //Disciplinary Cases
            DATABASE::"Disciplinary Cases":
                begin
                    RecRef.SetTable(DisciplinaryCase);
                    DisciplinaryCase.Validate("Case Status", DisciplinaryCase."Case Status"::Closed);
                    DisciplinaryCase.Modify;
                    Handled := true;
                end;
            //PIP Header
            DATABASE::"PIP Header":
                begin
                    RecRef.SetTable(PIPApprovalHeader);
                    PIPApprovalHeader.Validate(Status, PIPApprovalHeader.Status::Approved);
                    PIPApprovalHeader.Modify;
                    Handled := true;
                end;
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
    local procedure SetStatusToPending(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            //Leave Application
            DATABASE::"Employee Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::"Pending Approval");
                    Leave.Modify;
                    Variant := Leave;
                    IsHandled := true;
                end;

            //Payroll Processing Header
            DATABASE::"Payroll Processing Header":
                begin
                    RecRef.SetTable(PayrollProcessingHeader);
                    PayrollProcessingHeader.Validate(Status, PayrollProcessingHeader.Status::"Pending Approval");
                    PayrollProcessingHeader.Modify;
                    Variant := PayrollProcessingHeader;
                    // Only send email on FINAL approval — when payroll is send for approval
                    PayrollProcessingHeader.Get(PayrollProcessingHeader."Payroll Processing No");
                    if PayrollProcessingHeader.Status = PayrollProcessingHeader.Status::"Pending Approval" then begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", DATABASE::"Payroll Processing Header");
                        ApprovalEntry.SetRange("Document No.", PayrollProcessingHeader."Payroll Processing No");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                        if ApprovalEntry.FindLast() then
                            PortalApprovals.SendPayrollSubmittedEmail(ApprovalEntry, PayrollProcessingHeader."Payroll Processing No");
                    end;
                    IsHandled := true;
                end;

            //Terminal Dues
            DATABASE::"Terminal Dues Header":
                begin
                    RecRef.SetTable(TerminalDues);
                    TerminalDues.Validate("Approval Status", TerminalDues."Approval Status"::"Pending Approval");
                    TerminalDues.Modify;
                    Variant := TerminalDues;
                    IsHandled := true;
                end;
            //Employee Changes
            DATABASE::"Change Request":
                begin
                    RecRef.SetTable(EmployeeChanges);
                    EmployeeChanges.Validate("Change Approval Status", EmployeeChanges."Change Approval Status"::"Pending Approval");
                    EmployeeChanges.Modify();
                    Variant := EmployeeChanges;
                    IsHandled := true;
                end;
            //Staff Target Objectives
            DATABASE::"Staff Target Objectives":
                begin
                    RecRef.SetTable(StaffTargetObjectives);
                    StaffTargetObjectives.Validate("Approval Status", StaffTargetObjectives."Approval Status"::"Pending Approval");
                    StaffTargetObjectives.Modify();
                    Variant := StaffTargetObjectives;
                    IsHandled := true;
                end;
            //Training Request
            DATABASE::"Training Request":
                begin
                    RecRef.SetTable(TrainingRequest);
                    TrainingRequest.Validate(Status, TrainingRequest.Status::"Pending Approval");
                    TrainingRequest.CalcFields("Total Cost");
                    if TrainingRequest."Local Travel" then
                        TrainingRequest."Total Cost (LCY)" := TrainingRequest."Total Cost"
                    else if TrainingRequest."Exchange Rate" <> 0 then
                        TrainingRequest."Total Cost (LCY)" := TrainingRequest."Exchange Rate" * TrainingRequest."Total Cost"
                    else
                        TrainingRequest."Total Cost (LCY)" := TrainingRequest."Total Cost";
                    TrainingRequest.Modify();
                    Variant := TrainingRequest;
                    IsHandled := true;
                end;
            //Training Allowance Batches
            DATABASE::"Training Allowance Batches":
                begin
                    RecRef.SetTable(TrainingAllowanceBatch);
                    TrainingAllowanceBatch.Validate("Approval Status", TrainingAllowanceBatch."Approval Status"::"Pending Approval");
                    TrainingAllowanceBatch.Modify();
                    Variant := TrainingAllowanceBatch;
                    IsHandled := true;
                end;
            //Airtime allocation batch
            DATABASE::"Airtime Allocation Batches":
                begin
                    RecRef.SetTable(AirtimeAllocationBatch);
                    AirtimeAllocationBatch.Validate("Approval Status", AirtimeAllocationBatch."Approval Status"::"Pending Approval");
                    AirtimeAllocationBatch.Modify();
                    Variant := AirtimeAllocationBatch;
                    IsHandled := true;
                end;
            //Airtime Requests
            DATABASE::"Airtime Requests":
                begin
                    RecRef.SetTable(AirtimeRequest);
                    AirtimeRequest.Validate("Approval Status", AirtimeRequest."Approval Status"::"Pending Approval");
                    AirtimeRequest.Modify();
                    Variant := AirtimeRequest;
                    IsHandled := true;
                end;
            //Hotel Booking Requests
            DATABASE::"Hotel Booking Requests":
                begin
                    RecRef.SetTable(HotelBookingRequest);
                    HotelBookingRequest.Validate("Approval Status", HotelBookingRequest."Approval Status"::"Pending Approval");
                    HotelBookingRequest.Modify();
                    Variant := HotelBookingRequest;
                    IsHandled := true;
                end;
            //Refreshment Requests
            DATABASE::"Refreshment Requests":
                begin
                    RecRef.SetTable(RefreshmentRequest);
                    RefreshmentRequest.Validate("Approval Status", RefreshmentRequest."Approval Status"::"Pending Approval");
                    RefreshmentRequest.Modify();
                    Variant := RefreshmentRequest;
                    IsHandled := true;
                end;
            //Room Booking Requests
            DATABASE::"Room Booking Requests":
                begin
                    RecRef.SetTable(RoomBooking);
                    RoomBooking.Validate("Approval Status", RoomBooking."Approval Status"::"Pending Approval");
                    RoomBooking.Modify();
                    Variant := RoomBooking;
                    IsHandled := true;
                end;
            //Requisition Fees Requests
            DATABASE::"Requisition Fees Requests":
                begin
                    RecRef.SetTable(RequisitionFeesRequest);
                    RequisitionFeesRequest.Validate("Approval Status", RequisitionFeesRequest."Approval Status"::"Pending Approval");
                    RequisitionFeesRequest.Modify();
                    Variant := RequisitionFeesRequest;
                    IsHandled := true;
                end;
            DATABASE::"Memo Header":
                begin
                    RecRef.SetTable(Memoequest);
                    Memoequest.Validate("Approval Status", Memoequest."Approval Status"::"Pending Approval");
                    Memoequest.Modify();
                    Variant := Memoequest;
                    IsHandled := true;
                end;

            DATABASE::"Shift Header":
                begin
                    RecRef.SetTable(ShiftRequest);
                    ShiftRequest.Validate("Approval Status", ShiftRequest."Approval Status"::"Pending Approval");
                    ShiftRequest.Modify();
                    Variant := ShiftRequest;
                    IsHandled := true;
                end;

            DATABASE::"Medical Claim Header":
                begin
                    RecRef.SetTable(ClaimRequest);
                    ClaimRequest.Validate("Approval Status", ClaimRequest."Approval Status"::"Pending Approval");
                    ClaimRequest.Modify();
                    Variant := ClaimRequest;
                    IsHandled := true;
                end;

            DATABASE::"Travelling Request":
                begin
                    RecRef.SetTable(TravelRequest);
                    TravelRequest.Validate("Status", TravelRequest."Status"::"Pending Approval");
                    TravelRequest.Modify();
                    Variant := TravelRequest;
                    IsHandled := true;
                end;

            //Compassionate Checks
            DATABASE::"Compassionate Checks":
                begin
                    RecRef.SetTable(CompassionateCheck);
                    CompassionateCheck.Validate("Approval Status", CompassionateCheck."Approval Status"::"Pending Approval");
                    CompassionateCheck.Modify();
                    Variant := CompassionateCheck;
                    IsHandled := true;
                end;
            //Loan Application
            DATABASE::"Loan Application":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication.Validate("Loan Status", LoanApplication."Loan Status"::"Being Processed");
                    LoanApplication.Modify();
                    Variant := LoanApplication;
                    IsHandled := true;
                end;
            //Meal Requisition Header
            DATABASE::"Meal Requisition Header":
                begin
                    RecRef.SetTable(MealRequisitionHeader);
                    MealRequisitionHeader.Validate("Status", MealRequisitionHeader."Status"::"Pending Approval");
                    MealRequisitionHeader.Modify();
                    Variant := MealRequisitionHeader;
                    IsHandled := true;
                end;
            //Recruitment Needs
            DATABASE::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentNeeds);
                    RecruitmentNeeds.Validate(Status, RecruitmentNeeds.Status::"Pending Approval");
                    RecruitmentNeeds.Modify();
                    Variant := RecruitmentNeeds;
                    IsHandled := true;
                end;

            DATABASE::"HR Appraisal Header":
                begin
                    RecRef.SetTable(AppraisalRequest);
                    AppraisalRequest.Validate(Status, AppraisalRequest.Status::"Pending Approval");
                    AppraisalRequest.Modify();
                    Variant := AppraisalRequest;
                    IsHandled := true;
                end;
            DATABASE::"Mid Year Appraisal":
                begin
                    RecRef.SetTable(MidYearAppraisal);
                    MidYearAppraisal.Validate("Approval Status", MidYearAppraisal."Approval Status"::"Pending Approval");
                    MidYearAppraisal.Modify();
                    Variant := MidYearAppraisal;
                    IsHandled := true;
                end;
            DATABASE::"Staff Appraisal Header":
                begin
                    RecRef.SetTable(StaffAppraisalHeader);
                    StaffAppraisalHeader.Validate("Approval Status", StaffAppraisalHeader."Approval Status"::"Pending Approval");
                    StaffAppraisalHeader.Modify();
                    Variant := StaffAppraisalHeader;
                    IsHandled := true;
                end;
            //Training Master Plan Header
            DATABASE::"Training Master Plan Header":
                begin
                    RecRef.SetTable(TrainingMasterPlan);
                    TrainingMasterPlan.Validate("Approval Status", TrainingMasterPlan."Approval Status"::"Pending Approval");
                    TrainingMasterPlan.Modify();
                    Variant := TrainingMasterPlan;
                    IsHandled := true;
                end;
            //Annual Training Plan
            DATABASE::"Annual Training Plan":
                begin
                    RecRef.SetTable(AnnualTrainingPlan);
                    AnnualTrainingPlan.Validate("Approval Status", AnnualTrainingPlan."Approval Status"::"Pending Approval");
                    AnnualTrainingPlan.Modify();
                    Variant := AnnualTrainingPlan;
                    IsHandled := true;
                end;
            //Disciplinary Cases
            DATABASE::"Disciplinary Cases":
                begin
                    RecRef.SetTable(DisciplinaryCase);
                    DisciplinaryCase.Validate("Case Status", DisciplinaryCase."Case Status"::Ongoing);
                    DisciplinaryCase.Modify();
                    Variant := DisciplinaryCase;
                    IsHandled := true;
                end;
            //PIP Header
            DATABASE::"PIP Header":
                begin
                    RecRef.SetTable(PIPApprovalHeader);
                    PIPApprovalHeader.Validate(Status, PIPApprovalHeader.Status::"Pending Approval");
                    PIPApprovalHeader.Modify();
                    Variant := PIPApprovalHeader;
                    IsHandled := true;
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
    procedure PopulateApprovalEntryArgument(RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance") //Found: Boolean
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        case RecRef.Number of
            //Leave Application
            DATABASE::"Employee Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::LeaveApplication;
                    ApprovalEntryArgument."Document No." := Leave."Application No";
                    ApprovalEntryArgument.Validate("Document No.");
                    ApprovalEntryArgument."Record ID to Approve" := Leave.RecordId;
                end;
            //Payroll Processing Header
            DATABASE::"Payroll Processing Header":
                begin
                    RecRef.SetTable(PayrollProcessingHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Payroll;
                    ApprovalEntryArgument."Document No." := PayrollProcessingHeader."Payroll Processing No";
                    ApprovalEntryArgument.Validate("Document No.");
                end;

            //Terminal Dues
            DATABASE::"Terminal Dues Header":
                begin
                    RecRef.SetTable(TerminalDues);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Final Dues";
                    ApprovalEntryArgument."Document No." := TerminalDues."No.";
                    ApprovalEntryArgument.Description := 'Approval of ' + TerminalDues."No." + ' Final Dues for ' + TerminalDues."WB No." + ' ' + TerminalDues."Full Name";
                    TerminalDues.CalcFields(Balance);
                    ApprovalEntryArgument.Amount := TerminalDues.Balance;
                    //ApprovalEntryArgument."Amount (LCY)" := GenJournalLine."Amount (LCY)";
                    //ApprovalEntryArgument."Currency Code" := GenJournalLine."Currency Code";
                end;
            //Employee Changes
            DATABASE::"Change Request":
                begin
                    RecRef.SetTable(EmployeeChanges);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Employee Change";
                    ApprovalEntryArgument."Document No." := EmployeeChanges."No.";
                    ApprovalEntryArgument.Description := 'Approval of ' + EmployeeChanges."No." + ' employee change request for ' + EmployeeChanges."Emp No." + ' ' + EmployeeChanges.FullName;
                end;
            //Staff Target Objectives
            DATABASE::"Staff Target Objectives":
                begin
                    RecRef.SetTable(StaffTargetObjectives);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := StaffTargetObjectives.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Description := 'Approval of staff target objectives ' + StaffTargetObjectives.No + ' for ' + StaffTargetObjectives."Staff No" + ' - ' + StaffTargetObjectives."Staff Name";
                end;
            //Training Request
            DATABASE::"Training Request":
                begin
                    RecRef.SetTable(TrainingRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := TrainingRequest."Request No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Description := 'Approval of training request ' + TrainingRequest."Request No." + ' for ' + TrainingRequest."Employee No" + ' - ' + TrainingRequest."Employee Name";
                end;

            //Training Allowance Batches
            DATABASE::"Training Allowance Batches":
                begin
                    RecRef.SetTable(TrainingAllowanceBatch);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Training Allowance";
                    ApprovalEntryArgument."Document No." := TrainingAllowanceBatch."Batch Name";
                    ApprovalEntryArgument.Description := 'Approval of ' + TrainingAllowanceBatch.Description;
                end;
            //Airtime allocation batch
            DATABASE::"Airtime Allocation Batches":
                begin
                    RecRef.SetTable(AirtimeAllocationBatch);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Airtime Allocation Batch";
                    ApprovalEntryArgument."Document No." := AirtimeAllocationBatch."Doc No";
                    ApprovalEntryArgument.Description := 'Approval of airtime allocation batch ' + Format(AirtimeAllocationBatch."Month Start Date") + ' - ' + AirtimeAllocationBatch.Description;
                end;
            //Airtime Requests
            DATABASE::"Airtime Requests":
                begin
                    RecRef.SetTable(AirtimeRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Hotel Booking Request";
                    ApprovalEntryArgument."Document No." := AirtimeRequest."No.";
                    ApprovalEntryArgument.Description := 'Approval of airtime request ' + AirtimeRequest."No." + ' for ' + AirtimeRequest."Emp No." + ' - ' + AirtimeRequest."Emp Name";
                end;
            //Hotel Booking Requests
            DATABASE::"Hotel Booking Requests":
                begin
                    RecRef.SetTable(HotelBookingRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Airtime Request";
                    ApprovalEntryArgument."Document No." := HotelBookingRequest."No.";
                    ApprovalEntryArgument.Description := 'Approval of hotel booking request ' + HotelBookingRequest."No." + ' for ' + HotelBookingRequest."Hotel Name" + ' raised by ' + HotelBookingRequest."Requested By Emp Name";
                end;
            //Refreshment Requests
            DATABASE::"Refreshment Requests":
                begin
                    RecRef.SetTable(RefreshmentRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Refreshment Request";
                    ApprovalEntryArgument."Document No." := RefreshmentRequest."No.";
                    ApprovalEntryArgument.Description := 'Approval of refreshment request ' + RefreshmentRequest."No.";
                end;
            //Room Booking Requests
            DATABASE::"Room Booking Requests":
                begin
                    RecRef.SetTable(RoomBooking);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Room Booking Request";
                    ApprovalEntryArgument."Document No." := RoomBooking."No.";
                    ApprovalEntryArgument.Description := 'Approval of room booking request ' + RoomBooking."No.";
                end;
            //Requisition Fees Requests
            DATABASE::"Requisition Fees Requests":
                begin
                    RecRef.SetTable(RequisitionFeesRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Room Booking Request";
                    ApprovalEntryArgument."Document No." := RequisitionFeesRequest."No.";
                    ApprovalEntryArgument.Description := 'Approval of requisition fees request ' + RequisitionFeesRequest."No.";
                end;
            DATABASE::"Memo Header":
                begin
                    RecRef.SetTable(Memoequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := Memoequest."No.";
                    ApprovalEntryArgument.Description := 'Approval of Memo request ' + Memoequest."No.";
                end;

            DATABASE::"Shift Header":
                begin
                    RecRef.SetTable(ShiftRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := ShiftRequest."No.";
                    ApprovalEntryArgument.Description := 'Approval of Shift request ' + ShiftRequest."No.";
                end;

            DATABASE::"Medical Claim Header":
                begin
                    RecRef.SetTable(ClaimRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := ClaimRequest."Claim No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Description := 'Approval of Claim request ' + ClaimRequest."Claim No";
                end;

            DATABASE::"Travelling Request":
                begin
                    RecRef.SetTable(TravelRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := TravelRequest."Request No.";
                    ApprovalEntryArgument.Description := 'Approval of Claim request ' + TravelRequest."Request No.";
                end;

            //Compassionate Checks
            DATABASE::"Compassionate Checks":
                begin
                    RecRef.SetTable(CompassionateCheck);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := CompassionateCheck."No.";
                    ApprovalEntryArgument.Description := 'Approval of compassionate check ' + CompassionateCheck."No." + ' for employee ' + CompassionateCheck."Employee No." + ' - ' + CompassionateCheck."Employee Name";
                    ApprovalEntryArgument.Amount := CompassionateCheck.Amount;
                end;
            //Loan Application
            DATABASE::"Loan Application":
                begin
                    RecRef.SetTable(LoanApplication);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := LoanApplication."Loan No";
                    ApprovalEntryArgument.Description := 'Approval of loan application ' + LoanApplication."Loan No" + ' for ' + LoanApplication."Employee No" + ' - ' + LoanApplication."Employee Name";
                    ApprovalEntryArgument.Amount := LoanApplication."Amount Requested";
                end;
            //Meal Requisition Header
            DATABASE::"Meal Requisition Header":
                begin
                    RecRef.SetTable(MealRequisitionHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := MealRequisitionHeader."Requisition No";
                    ApprovalEntryArgument.Description := 'Approval of meal requisition ' + MealRequisitionHeader."Requisition No" + ' for ' + MealRequisitionHeader."Employee No" + ' - ' + MealRequisitionHeader."Employee Name";
                    MealRequisitionHeader.CalcFields("Total Amount");
                    ApprovalEntryArgument.Amount := MealRequisitionHeader."Total Amount";
                end;
            //Recruitment Needs
            DATABASE::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentNeeds);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := RecruitmentNeeds."No.";
                    ApprovalEntryArgument.Description := 'Approval of recruitment need ' + RecruitmentNeeds."No." + ' for ' + RecruitmentNeeds.Description;
                end;

            DATABASE::"HR Appraisal Header":
                begin
                    RecRef.SetTable(AppraisalRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := AppraisalRequest."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            DATABASE::"Mid Year Appraisal":
                begin
                    RecRef.SetTable(MidYearAppraisal);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := MidYearAppraisal.No;
                    ApprovalEntryArgument.Description := 'Approval of mid year appraisal ' + MidYearAppraisal.No + ' for ' + MidYearAppraisal."Staff No" + ' - ' + MidYearAppraisal."Staff Name";
                end;
            DATABASE::"Staff Appraisal Header":
                begin
                    RecRef.SetTable(StaffAppraisalHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := StaffAppraisalHeader.No;
                    ApprovalEntryArgument.Description := 'Approval of staff appraisal ' + StaffAppraisalHeader.No + ' for ' + StaffAppraisalHeader."Staff No" + ' - ' + StaffAppraisalHeader."Staff Name";
                end;
            //Training Master Plan Header
            DATABASE::"Training Master Plan Header":
                begin
                    RecRef.SetTable(TrainingMasterPlan);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := TrainingMasterPlan."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Description := 'Approval of training master plan ' + TrainingMasterPlan."No." + ' - ' + TrainingMasterPlan.Title;
                end;
            //Annual Training Plan
            DATABASE::"Annual Training Plan":
                begin
                    RecRef.SetTable(AnnualTrainingPlan);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := AnnualTrainingPlan."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Description := 'Approval of annual training plan ' + AnnualTrainingPlan."No." + ' - ' + AnnualTrainingPlan.Title;
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    procedure Reject(var ApprovalEntry: Record "Approval Entry")
    begin
        case ApprovalEntry."Table ID" of
            //Leave Application
            DATABASE::"Employee Leave Application":
                begin
                    Leave.Reset();
                    Leave.SetRange("Application No", ApprovalEntry."Document No.");
                    if Leave.FindFirst() then begin
                        Leave.Validate(Status, Leave.Status::Rejected);
                        Leave.Modify;
                        PortalApprovals.SendLeaveRejectedEmail(ApprovalEntry, Leave."Application No");
                    end;
                end;
            //Payroll Processing Header
            DATABASE::"Payroll Processing Header":
                begin
                    PayrollProcessingHeader.Reset();
                    PayrollProcessingHeader.SetRange("Payroll Processing No", ApprovalEntry."Document No.");
                    if PayrollProcessingHeader.FindFirst() then begin
                        PayrollProcessingHeader.Validate(Status, PayrollProcessingHeader.Status::Open);
                        PayrollProcessingHeader.Modify();
                        PortalApprovals.SendPayrollRejectedEmail(ApprovalEntry, PayrollProcessingHeader."Payroll Processing No");
                    end;
                end;
            //Terminal Dues
            DATABASE::"Terminal Dues Header":
                begin
                    TerminalDues.Reset();
                    TerminalDues.SetRange("No.", ApprovalEntry."Document No.");
                    if TerminalDues.FindFirst() then begin
                        TerminalDues.Validate("Approval Status", TerminalDues."Approval Status"::Rejected);
                        TerminalDues.Modify;
                    end;
                end;

            //Employee Changes
            DATABASE::"Change Request":
                begin
                    EmployeeChanges.Reset();
                    EmployeeChanges.SetRange("No.", ApprovalEntry."Document No.");
                    if EmployeeChanges.FindFirst() then begin
                        EmployeeChanges.Validate("Change Approval Status", EmployeeChanges."Change Approval Status"::Rejected);
                        EmployeeChanges.Modify;
                    end;
                end;

            //Staff Target Objectives
            DATABASE::"Staff Target Objectives":
                begin
                    StaffTargetObjectives.Reset();
                    StaffTargetObjectives.SetRange(No, ApprovalEntry."Document No.");
                    if StaffTargetObjectives.FindFirst() then begin
                        StaffTargetObjectives.Validate("Approval Status", StaffTargetObjectives."Approval Status"::Rejected);
                        StaffTargetObjectives.Modify;
                    end;
                end;
            //Training Request
            DATABASE::"Training Request":
                begin
                    TrainingRequest.Reset();
                    TrainingRequest.SetRange("Request No.", ApprovalEntry."Document No.");
                    if TrainingRequest.FindFirst() then begin
                        TrainingRequest.Validate(Status, TrainingRequest.Status::Rejected);
                        TrainingRequest.Modify;
                    end;
                end;

            //Training Allowance Batches
            DATABASE::"Training Allowance Batches":
                begin
                    TrainingAllowanceBatch.Reset();
                    TrainingAllowanceBatch.SetRange("Batch Name", ApprovalEntry."Document No.");
                    if TrainingAllowanceBatch.FindFirst() then begin
                        TrainingAllowanceBatch.Validate("Approval Status", TrainingAllowanceBatch."Approval Status"::Rejected);
                        TrainingAllowanceBatch.Modify;
                    end;
                end;

            //Airtime allocation batch
            DATABASE::"Airtime Allocation Batches":
                begin
                    AirtimeAllocationBatch.Reset();
                    AirtimeAllocationBatch.SetRange("Doc No", ApprovalEntry."Document No.");
                    if AirtimeAllocationBatch.FindFirst() then begin
                        AirtimeAllocationBatch.Validate("Approval Status", AirtimeAllocationBatch."Approval Status"::Rejected);
                        AirtimeAllocationBatch.Modify;
                    end;
                end;

            //Airtime Requests
            DATABASE::"Airtime Requests":
                begin
                    AirtimeRequest.Reset();
                    AirtimeRequest.SetRange("No.", ApprovalEntry."Document No.");
                    if AirtimeRequest.FindFirst() then begin
                        AirtimeRequest.Validate("Approval Status", AirtimeRequest."Approval Status"::Rejected);
                        AirtimeRequest.Modify;
                    end;
                end;

            //Hotel Booking Requests
            DATABASE::"Hotel Booking Requests":
                begin
                    HotelBookingRequest.Reset();
                    HotelBookingRequest.SetRange("No.", ApprovalEntry."Document No.");
                    if HotelBookingRequest.FindFirst() then begin
                        HotelBookingRequest.Validate("Approval Status", HotelBookingRequest."Approval Status"::Rejected);
                        HotelBookingRequest.Modify;
                    end;
                end;

            //Refreshment Requests
            DATABASE::"Refreshment Requests":
                begin
                    RefreshmentRequest.Reset();
                    RefreshmentRequest.SetRange("No.", ApprovalEntry."Document No.");
                    if RefreshmentRequest.FindFirst() then begin
                        RefreshmentRequest.Validate("Approval Status", RefreshmentRequest."Approval Status"::Rejected);
                        RefreshmentRequest.Modify;
                    end;
                end;

            //Room Booking Requests
            DATABASE::"Room Booking Requests":
                begin
                    RoomBooking.Reset();
                    RoomBooking.SetRange("No.", ApprovalEntry."Document No.");
                    if RoomBooking.FindFirst() then begin
                        RoomBooking.Validate("Approval Status", RoomBooking."Approval Status"::Rejected);
                        RoomBooking.Modify;
                    end;
                end;

            //Requisition Fees Requests
            DATABASE::"Requisition Fees Requests":
                begin
                    RequisitionFeesRequest.Reset();
                    RequisitionFeesRequest.SetRange("No.", ApprovalEntry."Document No.");
                    if RequisitionFeesRequest.FindFirst() then begin
                        RequisitionFeesRequest.Validate("Approval Status", RequisitionFeesRequest."Approval Status"::Rejected);
                        RequisitionFeesRequest.Modify;
                    end;
                end;
            DATABASE::"Memo Header":
                begin
                    Memoequest.Reset();
                    Memoequest.SetRange("No.", ApprovalEntry."Document No.");
                    if Memoequest.FindFirst() then begin
                        Memoequest.Validate("Approval Status", Memoequest."Approval Status"::Rejected);
                        Memoequest.Modify;
                    end;
                end;

            DATABASE::"Shift Header":
                begin
                    ShiftRequest.Reset();
                    ShiftRequest.SetRange("No.", ApprovalEntry."Document No.");
                    if ShiftRequest.FindFirst() then begin
                        ShiftRequest.Validate("Approval Status", ShiftRequest."Approval Status"::Rejected);
                        ShiftRequest.Modify;
                    end;
                end;

            DATABASE::"Medical Claim Header":
                begin
                    ClaimRequest.Reset();
                    ClaimRequest.SetRange("Claim No", ApprovalEntry."Document No.");
                    if ClaimRequest.FindFirst() then begin
                        ClaimRequest.Validate("Approval Status", ClaimRequest."Approval Status"::Rejected);
                        ClaimRequest.Modify;
                    end;
                end;

            DATABASE::"Travelling Request":
                begin
                    TravelRequest.Reset();
                    TravelRequest.SetRange("Request No.", ApprovalEntry."Document No.");
                    if TravelRequest.FindFirst() then begin
                        TravelRequest.Validate("Status", TravelRequest."Status"::Rejected);
                        TravelRequest.Modify;
                    end;
                end;

            //Compassionate Checks
            DATABASE::"Compassionate Checks":
                begin
                    CompassionateCheck.Reset();
                    CompassionateCheck.SetRange("No.", ApprovalEntry."Document No.");
                    if CompassionateCheck.FindFirst() then begin
                        CompassionateCheck.Validate("Approval Status", CompassionateCheck."Approval Status"::Rejected);
                        CompassionateCheck.Modify;
                    end;
                end;
            //Loan Application
            DATABASE::"Loan Application":
                begin
                    LoanApplication.Reset();
                    LoanApplication.SetRange("Loan No", ApprovalEntry."Document No.");
                    if LoanApplication.FindFirst() then begin
                        LoanApplication.Validate("Loan Status", LoanApplication."Loan Status"::Rejected);
                        LoanApplication.Modify;
                    end;
                end;
            //Recruitment Needs
            DATABASE::"Recruitment Needs":
                begin
                    RecruitmentNeeds.Reset();
                    RecruitmentNeeds.SetRange("No.", ApprovalEntry."Document No.");
                    if RecruitmentNeeds.FindFirst() then begin
                        RecruitmentNeeds.Validate(Status, RecruitmentNeeds.Status::Rejected);
                        RecruitmentNeeds.Modify;
                    end;
                end;

            DATABASE::"HR Appraisal Header":
                begin
                    AppraisalRequest.Reset();
                    AppraisalRequest.SetRange("No.", ApprovalEntry."Document No.");
                    if AppraisalRequest.FindFirst() then begin
                        AppraisalRequest.Validate(Status, AppraisalRequest.Status::Rejected);
                        AppraisalRequest.Modify();
                    end;
                end;
            DATABASE::"Mid Year Appraisal":
                begin
                    MidYearAppraisal.Reset();
                    MidYearAppraisal.SetRange(No, ApprovalEntry."Document No.");
                    if MidYearAppraisal.FindFirst() then begin
                        MidYearAppraisal.Validate("Approval Status", MidYearAppraisal."Approval Status"::Rejected);
                        MidYearAppraisal.Modify();
                    end;
                end;
            DATABASE::"Staff Appraisal Header":
                begin
                    StaffAppraisalHeader.Reset();
                    StaffAppraisalHeader.SetRange(No, ApprovalEntry."Document No.");
                    if StaffAppraisalHeader.FindFirst() then begin
                        StaffAppraisalHeader.Validate("Approval Status", StaffAppraisalHeader."Approval Status"::Rejected);
                        StaffAppraisalHeader.Modify();
                    end;
                end;
            //Training Master Plan Header
            DATABASE::"Training Master Plan Header":
                begin
                    TrainingMasterPlan.Reset();
                    TrainingMasterPlan.SetRange("No.", ApprovalEntry."Document No.");
                    if TrainingMasterPlan.FindFirst() then begin
                        TrainingMasterPlan.Validate("Approval Status", TrainingMasterPlan."Approval Status"::Rejected);
                        TrainingMasterPlan.Modify;
                    end;
                end;
            //Annual Training Plan
            DATABASE::"Annual Training Plan":
                begin
                    AnnualTrainingPlan.Reset();
                    AnnualTrainingPlan.SetRange("No.", ApprovalEntry."Document No.");
                    if AnnualTrainingPlan.FindFirst() then begin
                        AnnualTrainingPlan.Validate("Approval Status", AnnualTrainingPlan."Approval Status"::Rejected);
                        AnnualTrainingPlan.Modify;
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnApproveApprovalRequest, '', false, false)]
    local procedure OnApproveApprovalRequest(VAR ApprovalEntry: Record "Approval Entry")
    var
        NextApprovalEntry: Record "Approval Entry";
    begin
        //FnApproveRecordsWithSameSequenceNumber(ApprovalEntry);
        case ApprovalEntry."Table ID" of
            DATABASE::"Payroll Processing Header":
                begin
                    NextApprovalEntry.Reset();
                    NextApprovalEntry.SetRange("Table ID", DATABASE::"Payroll Processing Header");
                    NextApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
                    NextApprovalEntry.SetRange(Status, NextApprovalEntry.Status::Open);
                    if NextApprovalEntry.FindFirst() then
                        // There are still pending approvers — send intermediate notification
                        PortalApprovals.SendPayrollIntermediateApprovalEmail(ApprovalEntry, ApprovalEntry."Document No.");
                end;
        end;
    end;

    LOCAL PROCEDURE FnApproveRecordsWithSameSequenceNumber(ApprovalEntry: Record "Approval Entry"): Boolean
    VAR
        otherApprovalEntries: Record "Approval Entry";
    BEGIN
        otherApprovalEntries.RESET;
        otherApprovalEntries.SETRANGE("Sequence No.", ApprovalEntry."Sequence No.");
        otherApprovalEntries.SETRANGE("Document No.", ApprovalEntry."Document No.");
        IF otherApprovalEntries.FIND('-') THEN BEGIN
            REPEAT
                otherApprovalEntries.Status := ApprovalEntry.Status::Approved;
                otherApprovalEntries.MODIFY(TRUE);
            UNTIL otherApprovalEntries.NEXT = 0;
        END;
    END;


    [IntegrationEvent(false, false)]
    local procedure OnReleaseRequisitionFeesRequestBeforeModify(var RequisitionFeesRequest: Record "Requisition Fees Requests")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeApprovalEntryInsert, '', false, false)]
    local procedure "Approvals Mgmt._OnBeforeApprovalEntryInsert"(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepArgument: Record "Workflow Step Argument"; ApproverId: Code[50]; var IsHandled: Boolean)
    var
        EmployeeLeaveApplication: Record "Employee Leave Application";
        Emp: Record Employee;
        TravellingRequest: Record "Travelling Request";
        AccidentLogMgmt: Record "Accident / Incident Logs Manag";

    begin
        // Emp.Reset();
        // Emp.SetRange("User ID", ApproverId);
        // if Emp.FindFirst() then begin
        //     ApprovalEntry.Validate("Approver Employee No", Emp."No.");
        // end;
        case ApprovalEntry."Table ID" of
            51525327://Employee Leave Application
                begin
                    EmployeeLeaveApplication.Reset();
                    EmployeeLeaveApplication.SetRange("Application No", ApprovalEntry."Document No.");
                    if EmployeeLeaveApplication.FindFirst() then begin
                        ApprovalEntry.Validate("Sender Employee No", EmployeeLeaveApplication."Employee No");
                        Emp.Get(EmployeeLeaveApplication."Employee No");
                        if Emp."Manager No." = '' then
                            Error('The employee %1 does not have a manager assigned. Please assign a manager before proceeding with the approval workflow.', Emp."No.");
                        Emp.Get(Emp."Manager No.");
                        if Emp."User ID" = '' then
                            Error('The manager %1 does not have a user ID assigned. Please assign a user ID before proceeding with the approval workflow.', Emp."No.");
                        //ApprovalEntry."Approver ID" := Emp."User ID";
                        ApprovalEntry.Validate("Approver Employee No", Emp."No.");
                    end;
                end;
            51525309:
                begin
                    EmployeeChanges.Reset();
                    EmployeeChanges.SetRange("No.", ApprovalEntry."Document No.");
                    if EmployeeChanges.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", EmployeeChanges."Emp No.");
                end;
            51525336://Staff Target Objectives
                begin
                    StaffTargetObjectives.Reset();
                    StaffTargetObjectives.SetRange(No, ApprovalEntry."Document No.");
                    if StaffTargetObjectives.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", StaffTargetObjectives."Staff No");
                end;
            51525344://Training Request
                begin
                    TrainingRequest.Reset();
                    TrainingRequest.SetRange("Request No.", ApprovalEntry."Document No.");
                    if TrainingRequest.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", TrainingRequest."Employee No");
                end;
            51525313:
                begin
                    PayrollProcessingHeader.Reset();
                    PayrollProcessingHeader.SetRange("Payroll Processing No", ApprovalEntry."Document No.");
                    if PayrollProcessingHeader.FindFirst() then begin
                        Emp.Reset();
                        Emp.SetRange("User ID", PayrollProcessingHeader."User ID");
                        if Emp.FindFirst() then
                            ApprovalEntry.Validate("Sender Employee No", Emp."No.");
                    end;
                    Emp.Reset();
                    Emp.SetRange("User ID", ApproverId);
                    if Emp.FindFirst() then
                        ApprovalEntry.Validate("Approver Employee No", Emp."No.");
                end;
            51525558:
                begin
                    Memoequest.Reset();
                    Memoequest.SetRange("No.", ApprovalEntry."Document No.");
                    if Memoequest.FindFirst() then begin
                        Emp.Reset();
                        Emp.SetRange("No.", Memoequest."Requestor User ID");
                        if Emp.FindFirst() then
                            ApprovalEntry.Validate("Sender Employee No", Emp."No.");
                    end;
                end;
            51525438://Medical Claim Header
                begin
                    ClaimRequest.Reset();
                    ClaimRequest.SetRange("Claim No", ApprovalEntry."Document No.");
                    if ClaimRequest.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", ClaimRequest."Employee No");
                end;
            51525906: //Travelling Request
                begin
                    TravellingRequest.Reset();
                    TravellingRequest.SetRange("Request No.", ApprovalEntry."Document No.");
                    if TravellingRequest.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", TravellingRequest."Employee No.");
                    Emp.Reset();
                    Emp.SetRange("User ID", ApprovalEntry."Approver ID");
                    if Emp.FindFirst() then
                        ApprovalEntry.Validate("Approver Name", Emp."Full Name");
                end;
            51525556://Accident Logs management
                begin
                    AccidentLogMgmt.Reset();
                    AccidentLogMgmt.SetRange("Document Number", ApprovalEntry."Document No.");
                    if AccidentLogMgmt.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", AccidentLogMgmt."Reporting Party ");
                end;
            51525559://Shift Header
                begin
                    ShiftRequest.Reset();
                    ShiftRequest.SetRange("No.", ApprovalEntry."Document No.");
                    if ShiftRequest.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", ShiftRequest."Created by");
                end;
            51525566://Compassionate Checks
                begin
                    CompassionateCheck.Reset();
                    CompassionateCheck.SetRange("No.", ApprovalEntry."Document No.");
                    if CompassionateCheck.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", CompassionateCheck."Employee No.");
                end;
            51525460://Loan Application
                begin
                    LoanApplication.Reset();
                    LoanApplication.SetRange("Loan No", ApprovalEntry."Document No.");
                    if LoanApplication.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", LoanApplication."Employee No");
                end;
            51525572://Meal Requisition Header
                begin
                    MealRequisitionHeader.Reset();
                    MealRequisitionHeader.SetRange("Requisition No", ApprovalEntry."Document No.");
                    if MealRequisitionHeader.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", MealRequisitionHeader."Employee No");
                end;
            51525334://HR Appraisal Header
                begin
                    AppraisalRequest.Reset();
                    AppraisalRequest.SetRange("No.", ApprovalEntry."Document No.");
                    if AppraisalRequest.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", AppraisalRequest."Employee No.");
                end;
            51525338://Mid Year Appraisal
                begin
                    MidYearAppraisal.Reset();
                    MidYearAppraisal.SetRange(No, ApprovalEntry."Document No.");
                    if MidYearAppraisal.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", MidYearAppraisal."Staff No");
                end;
            51525339://Staff Appraisal Header
                begin
                    StaffAppraisalHeader.Reset();
                    StaffAppraisalHeader.SetRange(No, ApprovalEntry."Document No.");
                    if StaffAppraisalHeader.FindFirst() then
                        ApprovalEntry.Validate("Sender Employee No", StaffAppraisalHeader."Staff No");
                end;
            51525359://Training Allowance Batches
                begin
                    TrainingAllowanceBatch.Reset();
                    TrainingAllowanceBatch.SetRange("Batch Name", ApprovalEntry."Document No.");
                    if TrainingAllowanceBatch.FindFirst() then begin
                        Emp.Reset();
                        Emp.SetRange("User ID", TrainingAllowanceBatch."Submitted By");
                        if Emp.FindFirst() then
                            ApprovalEntry.Validate("Sender Employee No", Emp."No.");
                    end;
                end;
            51525341://Training Master Plan Header
                begin
                    TrainingMasterPlan.Reset();
                    TrainingMasterPlan.SetRange("No.", ApprovalEntry."Document No.");
                    if TrainingMasterPlan.FindFirst() then begin
                        Emp.Reset();
                        Emp.SetRange("User ID", UserId);
                        if Emp.FindFirst() then
                            ApprovalEntry.Validate("Sender Employee No", Emp."No.");
                    end;
                end;
            51525575://Annual Training Plan
                begin
                    AnnualTrainingPlan.Reset();
                    AnnualTrainingPlan.SetRange("No.", ApprovalEntry."Document No.");
                    if AnnualTrainingPlan.FindFirst() then begin
                        Emp.Reset();
                        Emp.SetRange("User ID", AnnualTrainingPlan."Created By");
                        if Emp.FindFirst() then
                            ApprovalEntry.Validate("Sender Employee No", Emp."No.");
                    end;
                end;
        end;
    end;




}


