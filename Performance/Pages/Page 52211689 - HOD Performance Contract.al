page 52211689 "HOD Performance Contract"
{
    Caption = 'Departmental Performance Contract';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Perfomance Contract Header";
    PromotedActionCategories = 'New,Process,Report,Request Approval,Print,Release,Dimensions';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Caption = 'Contract No';
                    Editable = false;
                }
                field("Responsible Employee No."; Rec."Responsible Employee No.")
                {
                    Caption = 'Employee No';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                }
                // field("Functional Template ID";"Annual Performance Contract")
                // {
                //     Caption = 'Performance Contract Template';
                // }
                field("Contract Year"; Rec."Annual Reporting Code")
                {
                }
                field("Goal Template ID"; Rec."Goal Template ID")
                {
                    Visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Change Status"; Rec."Change Status")
                {
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                }
                field(Designation; Rec.Designation)
                {
                    Visible = false;
                }
                field(Grade; Rec.Grade)
                {
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Department Code';
                }
                field("Responsibility Center Name"; Rec."Responsibility Center Name")
                {
                    Caption = 'Department Name';
                    Editable = false;
                }
                field("Blocked?"; Rec."Blocked")
                {
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    Editable = false;
                }
                // field("Total  Departments Count";"Total  Departments Count")
                // {
                // }
                // field("Total Weight(%)";"Total Weight(%)")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                field("Total Assigned Weight(%)"; Rec."Total Assigned Weight(%)")
                {
                    Caption = 'Total Assigned Weight(%)';
                    Editable = false;
                    Visible = true;
                }
            }
            // part("Objectives and Intiatives";80465)
            // {
            //     Caption = 'Board PC Activities';
            //     SubPageLink = "Workplan No."=FIELD(No),
            //                   Initiative Type=CONST(Board);
            // }
            // part("Core Activities";80465)
            // {
            //     Caption = 'Core Activities';
            //     SubPageLink = "Workplan No."=FIELD(No),
            //                   Initiative Type=FILTER(Board);
            //     Visible = false;
            // }
            part("Added Activities"; "Secondary Workplan Initiatives")
            {
                Caption = 'Additional Activities';
                SubPageLink = "Workplan No." = FIELD(No),
                              "Strategy Plan ID" = FIELD("Strategy Plan ID"),
                              "Year Reporting Code" = FIELD("Annual Reporting Code");
                Visible = false;
            }
            part("Job Description"; "PC Job Description")
            {
                Caption = 'Job Description';
                SubPageLink = "Workplan No." = FIELD(No);
                // Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Performance)
            {
                Caption = 'Performance';
                Image = Vendor;
                group("Performance Review")
                {
                    Caption = 'Performance Review';
                    Image = Vendor;
                    action("Performance Appraisal")
                    {
                        Image = AddWatch;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        // RunObject = Page 80084;
                        // RunPageLink = Personal Scorecard ID=FIELD(No),
                        //               Document Type=CONST(Performance Appraisal);
                    }
                    action("Performance Appeal")
                    {
                        Caption = 'Performance Appeal';
                        Image = AddWatch;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        // RunObject = Page 80089;
                        // RunPageLink = Personal Scorecard ID=FIELD(No),
                        //               Document Type=CONST(Performance Appeal);
                    }
                    action(PIPs)
                    {
                        Caption = 'PIPs';
                        Image = AddWatch;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        // RunObject = Page 80103;
                        // RunPageLink = Personal Scorecard ID=FIELD(No);
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    // RunObject = Page 5222;
                    // RunPageLink = Table Name=CONST(7),
                    //               No.=FIELD(No. Series);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("Change Log")
                {
                    Image = Log;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    // RunObject = Page 80100;
                    // RunPageLink = Personal Scorecard ID=FIELD(No);
                }
            }
        }
        area(creation)
        {
            action("Suggest Objective Lines")
            {
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF NOT CONFIRM('Are you sure you want to Suggest Activities', TRUE) THEN
                        ERROR('Activities not Suggested');

                    Rec.TESTFIELD("Strategy Plan ID");
                    //TESTFIELD("Annual Performance Contract");
                    Rec.TESTFIELD("Annual Reporting Code");

                    SPMGeneralSetup.GET;

                    IF (SPMGeneralSetup."Allow Loading of  CSP" = TRUE) THEN BEGIN
                        PcLinesN.RESET;
                        PcLinesN.SETRANGE("Strategy Plan ID", Rec."Strategy Plan ID");
                        //PcLinesN.SETRANGE("Workplan No.","Annual Performance Contract");
                        PcLinesN.SETRANGE("Primary Department", Rec."Responsibility Center");
                        IF PcLinesN.FIND('-') THEN BEGIN
                            REPEAT
                                //ERROR('Test %1 %2 %3 %4',No,StrategyObjLines."Strategy Plan ID","Goal Template ID",StrategyObjLines."Activity ID");
                                PcLines.INIT;
                                PcLines."Workplan No." := Rec.No;
                                PcLines."Strategy Plan ID" := PcLinesN."Strategy Plan ID";
                                PcLines."Initiative Type" := PcLinesN."Initiative Type";
                                PcLines."Initiative No." := PcLinesN."Initiative No.";
                                PcLines."Goal Template ID" := Rec."Goal Template ID";
                                PcLines."Objective/Initiative" := PcLinesN."Objective/Initiative";
                                PcLines."Year Reporting Code" := Rec."Annual Reporting Code";
                                PcLines."Primary Department" := PcLinesN."Primary Department";
                                // PcLines."Primary Division" := PcLinesN."Primary Division";
                                PcLines."Outcome Perfomance Indicator" := PcLinesN."Outcome Perfomance Indicator";
                                PcLines."Assigned Weight (%)" := PcLinesN."Assigned Weight (%)";
                                PcLines."Summary of subactivities" := PcLinesN."Summary of subactivities";
                                PcLines."Strategy Framework" := PcLinesN."Strategy Framework";
                                PcLines."Framework Perspective" := PcLines."Framework Perspective";
                                PcLines."Unit of Measure" := PcLinesN."Unit of Measure";
                                PcLines."Start Date" := Rec."Start Date";
                                PcLines."Due Date" := Rec."End Date";
                                PcLines."Imported Annual Target Qty" := PcLinesN."Imported Annual Target Qty";
                                PcLines."Q1 Target Qty" := PcLinesN."Q1 Target Qty";
                                PcLines."Q2 Target Qty" := PcLinesN."Q2 Target Qty";
                                PcLines."Q3 Target Qty" := PcLinesN."Q3 Target Qty";
                                PcLines."Q4 Target Qty" := PcLinesN."Q4 Target Qty";
                                PcLines.INSERT(TRUE);

                                //Sub Activities
                                OriginalSubActivities.RESET;
                                OriginalSubActivities.SETRANGE("Strategy Plan ID", Rec."Strategy Plan ID");
                                //OriginalSubActivities.SETRANGE("Workplan No.","Annual Performance Contract");
                                OriginalSubActivities.SETRANGE("Initiative No.", PcLines."Initiative No.");
                                IF OriginalSubActivities.FINDFIRST THEN BEGIN
                                    REPEAT
                                        PCSubActivities.INIT;
                                        PCSubActivities."Strategy Plan ID" := OriginalSubActivities."Strategy Plan ID";
                                        PCSubActivities."Workplan No." := Rec.No;
                                        PCSubActivities."Initiative No." := OriginalSubActivities."Initiative No.";
                                        PCSubActivities."Sub Initiative No." := OriginalSubActivities."Sub Initiative No.";
                                        PCSubActivities."Entry Number" := OriginalSubActivities."Entry Number";
                                        PCSubActivities.TRANSFERFIELDS(OriginalSubActivities, FALSE);
                                        PCSubActivities.INSERT(TRUE);
                                    UNTIL OriginalSubActivities.NEXT = 0;
                                END;
                                //End Sub Activities


                                BoardSubActivities.RESET;
                                BoardSubActivities.SETRANGE("Strategy Plan ID", Rec."Strategy Plan ID");
                                //BoardSubActivities.SETRANGE("Workplan No.","Annual Performance Contract");
                                BoardSubActivities.SETRANGE("Initiative No.", PcLines."Initiative No.");
                                IF BoardSubActivities.FINDFIRST THEN BEGIN
                                    REPEAT
                                        PCSubActivities.INIT;
                                        PCSubActivities."Strategy Plan ID" := BoardSubActivities."Strategy Plan ID";
                                        PCSubActivities."Workplan No." := Rec.No;
                                        PCSubActivities."Initiative No." := BoardSubActivities."Initiative No.";
                                        PCSubActivities."Sub Initiative No." := BoardSubActivities."Sub Initiative No.";
                                        PCSubActivities."Entry Number" := BoardSubActivities."Entry Number";
                                        PCSubActivities.TRANSFERFIELDS(BoardSubActivities, FALSE);
                                        PCSubActivities.INSERT(TRUE);
                                    UNTIL BoardSubActivities.NEXT = 0;
                                END;
                            //End Sub Activities
                            UNTIL PcLinesN.NEXT = 0;
                        END;
                    END;
                    //Loading JD
                    IF (SPMGeneralSetup."Allow Loading of JD" = TRUE) THEN BEGIN
                        JobResponsiblities.RESET;
                        IF Rec."Acting Job ID" <> '' THEN BEGIN
                            JobResponsiblities.SETRANGE("Job ID", Rec."Acting Job ID");
                        END ELSE BEGIN
                            JobResponsiblities.SETRANGE("Job ID", Rec.Position);
                        END;
                        IF JobResponsiblities.FINDFIRST THEN BEGIN
                            REPEAT
                                PCJobDescription.INIT;
                                PCJobDescription."Workplan No." := Rec.No;
                                PCJobDescription.Description := JobRes.Responsibility;
                                PCJobDescription."Start Date" := Rec."Start Date";
                                PCJobDescription."Due Date" := Rec."End Date";
                                //   PCJobDescription."Line Number":=FORMAT(JobResponsiblities."Entry No.");
                                //   PCJobDescription.Description:=JobResponsiblities.Responsibility;
                                PCJobDescription."Primary Department" := Rec."Responsibility Center";
                                PCJobDescription.VALIDATE("Primary Department");
                                PCJobDescription.INSERT;

                            UNTIL JobResponsiblities.NEXT = 0;
                        END;
                    END;

                    //load JD from New HR Module 
                    /*IF (SPMGeneralSetup."Allow Loading of JD"=TRUE) THEN BEGIN
                      JobRes.RESET;
                      IF "Acting Job ID"<>'' THEN BEGIN
                        JobRes.SETRANGE("Position ID","Acting Job ID");
                        END ELSE BEGIN
                        JobRes.SETRANGE("Position ID",Position);
                          END;
                        IF JobRes.FINDFIRST THEN BEGIN
                        REPEAT
                          PCJobDescription.INIT;
                          PCJobDescription."Workplan No.":=No;
                          PCJobDescription."Line Number":=FORMAT(JobRes."Line No");
                          PCJobDescription.Description:=JobRes.Description;
                          PCJobDescription."Primary Department":="Responsibility Center";
                          PCJobDescription.VALIDATE("Primary Department");
                          PCJobDescription.INSERT;
                    
                        UNTIL JobRes.NEXT=0;
                      END;
                    END; */


                    //Board Sub-activities
                    /*BoardSubActivities.RESET;
                    BoardSubActivities.SETRANGE("Workplan No.","Annual Workplan");
                    IF BoardSubActivities.FINDSET THEN BEGIN
                    REPEAT
                    PCSubActivities.INIT;
                    PCSubActivities."Workplan No.":=No;
                    PCSubActivities."Initiative No.":=BoardSubActivities."Activity Id";
                    PCSubActivities.TRANSFERFIELDS(BoardSubActivities,FALSE);
                    PCSubActivities.INSERT(TRUE);
                    UNTIL BoardSubActivities.NEXT=0;
                    END;*/

                    MESSAGE('Functional PC Populated Successfully');

                end;
            }
            action("Populate Goals Hub")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GoalTemplateLine.RESET;
                    GoalTemplateLine.SETRANGE("Goal Template ID", Rec."Goal Template ID");
                    IF GoalTemplateLine.FIND('-') THEN BEGIN
                        REPEAT
                            workplangoalhub.INIT;
                            workplangoalhub."Goal ID" := GoalTemplateLine."Goal ID";
                            workplangoalhub."Performance Contract ID" := Rec.No;
                            workplangoalhub."Goal Description" := GoalTemplateLine.Description;
                            workplangoalhub."Aligned-To PC ID" := GoalTemplateLine."Corporate Strategic Plan ID";
                            workplangoalhub."Aligned-To PC Goal ID" := GoalTemplateLine."Strategic Objective ID";
                            workplangoalhub.INSERT(TRUE);
                        UNTIL GoalTemplateLine.NEXT = 0;
                    END;
                    MESSAGE('WorkPlan Hub Populated successfully');
                end;
            }
            // action("Aligned Business Goals")
            // {
            //     Image = "Action";
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     // RunObject = Page 80051;
            //     // RunPageLink = "Performance Contract ID"=FIELD(No);
            // }
            // action("Risk Analysis")
            // {
            //     Image = Reserve;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     // RunObject = Page 80052;
            //     // RunPageLink = Document No=FIELD(No);
            // }
            // action("Capability Matrix")
            // {
            //     Image = "Action";
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     // RunObject = Page 80053;
            //     // RunPageLink = Document No=FIELD(No);
            // }
            // separator()
            // {
            // }
            action(Approvals)
            {
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalsMgt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            action("Send Approval Request")
            {
                Caption = 'Send for Signature';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    // ApprovalMgt: Codeunit App
                    // SMTPSetup: Codeunit Email;
                    CompanyInfo: Record 79;
                    UserSetup: Record 91;
                    SenderAddress: Text[80];
                    Recipients: Text[80];
                    SenderName: Text[70];
                    Body: Text[250];
                    Subject: Text[80];
                    FileName: Text;
                    //FileMangement: Codeunit 419;
                    ProgressWindow: Dialog;
                    //SMTPMailSet: Record 409;
                    FileDirectory: Text[100];
                    Window: Dialog;
                    WindowisOpen: Boolean;
                    Counter: Integer;
                    BranchName: Code[80];
                    DimValue: Record "Dimension Value";
                    CustEmail: Text[100];
                    HRSetup: Record "Human Resources Setup";
                    CompInfo: Record "Company Information";
                    PerfomanceContractHeader: Record "Perfomance Contract Header";
                    Employee: Record Employee;
                    VarVariant: Variant;
                    PerformanceApprovals: Codeunit "Performance Approvals";
                begin

                    Rec.TESTFIELD("Approval Status", Rec."Approval Status"::Open);
                    /*TotalWeight:=0;
                    CALCFIELDS("Total Assigned Weight(%)","Secondary Assigned Weight(%)","JD Assigned Weight(%)");
                    TotalWeight:="Total Assigned Weight(%)"+"Secondary Assigned Weight(%)"+"JD Assigned Weight(%)";
                    IF NOT (TotalWeight=100) THEN
                       ERROR('Total Assigned Weight for all Core Mandate Primary Activities should be (100%),Currently is %1',TotalWeight);
                    */
                    PcLines.RESET;
                    PcLines.SETRANGE("Workplan No.", Rec.No);
                    IF PcLines.FINDFIRST THEN BEGIN
                        REPEAT
                        // PcLines.TESTFIELD("Primary Directorate");
                        // PcLines.TESTFIELD("Primary Department");
                        UNTIL PcLines.NEXT = 0;
                    END;
                    VarVariant := Rec;
                    IF PerformanceApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                        PerformanceApprovals.OnSendDocForApproval(VarVariant);


                    //status must be open.
                    /*TESTFIELD("Created By",USERID); //control so that only the initiator of the document can send for approval
                     IF ApprovalsMgmt.CheckPerformanceContractApprovalsWorkflowEnabled(Rec) THEN
                      ApprovalsMgmt.OnSendPerformanceContractForApproval(Rec);*/


                    // "Approval Status" := "Approval Status"::Released;
                    // MODIFY;
                    /*
                   CompanyInfo.GET();
                     SMTPMailSet.GET;
                     SenderAddress := SMTPMailSet."Email Sender Address";
                     SenderName :=CompanyInfo.Name+' M&E';
                     Subject := STRSUBSTNO('Individual PC');
                        PerfomanceContractHeader.RESET;
                        PerfomanceContractHeader.SETRANGE(No,No);
                        IF PerfomanceContractHeader.FINDFIRST THEN BEGIN
                           FileDirectory :=  'C:\DOCS\';
                           FileName := 'PCA_'+PerfomanceContractHeader.No+'.pdf';
                           //Window.OPEN('processing');
                           Window.OPEN('PROCESSING Individual PC ############1##');
                             Window.UPDATE(1,PerfomanceContractHeader.No+'-'+PerfomanceContractHeader.Description);

                           WindowisOpen := TRUE;
                           IF FileName = '' THEN
                             ERROR('Please specify what the file should be saved as');


                                                        REPORT.SAVEASPDF(52211645,FileDirectory+FileName,PerfomanceContractHeader);




                           IF EXISTS(FileDirectory+FileName) THEN BEGIN
                             Counter:=Counter+1;

                           SMTPMailSet.GET;
                           SenderAddress := SMTPMailSet."Email Sender Address";



                          Employee.RESET;
                          Employee.SETRANGE("No.","Responsible Employee No.");
                          IF Employee.FIND('-') THEN BEGIN
                            Recipients :=Employee."Company E-Mail";
                          END;
                          IF Recipients<>'' THEN BEGIN
                            Body:='Dear Team <BR>Please find attached the Individual PC <Br>'+Description;
                             cu400.CreateMessage(CompanyInfo.Name,SenderAddress,Recipients,Subject,Body,TRUE);

                             cu400.AppendBody(
                             '<BR><BR>Kind Regards,');
                             cu400.AppendBody('<BR>'+CompInfo.Name);
                             cu400.AddAttachment(FileDirectory+FileName,FileName);
                             cu400.Send;

                             SLEEP(1000);
                             Window.CLOSE;
                         END;
                         END;
                       END;


                   MESSAGE('Document has been approved Automatically');
                   */

                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Signature Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    VarVariant: Variant;
                    PerformanceApprovals: Codeunit "Performance Approvals";
                begin
                    Rec.TESTFIELD("Approval Status", Rec."Approval Status"::"Pending Approval");//status must be open.
                                                                                                /*TESTFIELD("Created By",USERID); //control so that only the initiator of the document can send for approval
                                                                                                ApprovalsMgmt.""(Rec);*/

                    /*ApprovalsMgmt.OnCancelPerformanceContractApprovalRequest(Rec);*/
                    // "Approval Status" := "Approval Status"::Open;
                    // MODIFY;
                    VarVariant := Rec;
                    PerformanceApprovals.OnCancelDocApprovalRequest(VarVariant);
                    // MESSAGE('Document has been Re-Opened');

                end;
            }
            // separator()
            // {
            // }
            // action("Send Appraisal")
            // {
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;

            //     trigger OnAction()
            //     begin
            //         Rec.TESTFIELD("Approval Status", Rec."Approval Status"::Released);
            //         MESSAGE('Test');
            //     end;
            // }
            // separator()
            // {
            // }
            // action("Sub Activities Report")
            // {
            //     Image = Print;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction()
            //     begin
            //         SETRANGE(No, No);
            //         //REPORT.RUN(80041,TRUE,TRUE,Rec)
            //     end;
            // }
            action("Print Individual PC")
            {
                Caption = 'Departmental  Performance Contract';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SETRANGE(No, Rec.No);
                    Report.Run(Report::"Individual PC", TRUE, TRUE, Rec)
                end;
            }
            action("Individual PC-Sub Indicators")
            {
                Caption = 'Departmental PC-Sub Indicators>';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Report 52211648;
            }
        }
        area(processing)
        {
            group("<Action9>")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(LockContract)
                {
                    ApplicationArea = Service;
                    Caption = '&Lock Contract';
                    Image = Lock;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Make sure that the changes will be part of the contract.';

                    trigger OnAction()
                    var
                    // LockOpenServContract: Codeunit "5943";
                    begin
                        Rec.TESTFIELD("Approval Status", Rec."Approval Status"::Released);
                        Rec."Change Status" := Rec."Change Status"::Locked;
                        Rec.MODIFY;
                        MESSAGE('Contract Locked Successfully');
                    end;
                }
                action(SignContract)
                {
                    ApplicationArea = Service;
                    Caption = 'Si&gn Contract';
                    Image = Signature;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Confirm the contract.';

                    trigger OnAction()
                    var
                    //SignServContractDoc: Codeunit "5944";
                    begin
                        Rec.TESTFIELD("Approval Status", Rec."Approval Status"::Released);
                        Rec.TESTFIELD("Change Status", Rec."Change Status"::Locked);
                        Rec.Status := Rec.Status::Signed;
                        Rec.MODIFY;
                        MESSAGE('Contract signed Successfully');
                    end;
                }
                action(CopyWorkplan)
                {
                    ApplicationArea = Jobs;
                    Caption = '&Copy WorkPlan';
                    Ellipsis = true;
                    Image = CopyFromTask;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Copy a Workplan and its Lines';

                    // trigger OnAction()
                    // var
                    //     CopyJob: Page "80088";
                    // begin
                    //     CopyJob.SetFromWorkplan(Rec);
                    //     CopyJob.RUNMODAL;
                    // end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::"Individual Scorecard PC";
        Rec."Score Card Type" := Rec."Score Card Type"::Departmental;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Document Type" := Rec."Document Type"::"Individual Scorecard PC";
        Rec."Score Card Type" := Rec."Score Card Type"::Departmental;
    end;

    trigger OnOpenPage()
    begin
        Rec."Document Type" := Rec."Document Type"::"Individual Scorecard PC";
        Rec."Score Card Type" := Rec."Score Card Type"::Departmental;
    end;

    var
        GoalTemplateLine: Record "Goal Template Line";
        workplangoalhub: Record "PC Goal Hub";
        StrategyObjLines: Record "Strategy Workplan Lines";
        PcLines: Record "PC Objective";
        PcLinesN: Record "PC Objective";
        JobResponsiblities: Record "Job Application Table";
        PCJobDescription: Record "PC Job Description";
        SPMGeneralSetup: Record "SPM General Setup";
        TotalWeight: Decimal;
        BoardSubActivities: Record "Board Sub Activities";
        PCSubActivities: Record "Sub PC Objective";
        //ApprovalsMgmt: Codeunit "1535";
        OriginalSubActivities: Record "Sub PC Objective";
        JobRes: Record "Job Responsiblities";
        CompanyJobsRec: Record "Company Jobs";
        SubWorkplanActivity: Record "Sub Workplan Activity";
}

