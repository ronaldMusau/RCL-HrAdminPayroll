#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211758 "HODs Performance Contract"
{
    Caption = 'CEO Annual Workplan';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Perfomance Contract Header";
    SourceTableView = where("Document Type" = const("Staff Performance Contract"));
    PromotedActionCategories = 'New,Process,Report,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Caption = 'Contract No';
                    Editable = false;
                }
                field("Responsible Employee No."; Rec."Responsible Employee No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee No';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Annual Workplan"; Rec."Annual Workplan")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Year"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Goal Template ID"; Rec."Goal Template ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Change Status"; Rec."Change Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                // field("Responsibility Center"; Rec."Responsibility Center")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Department';
                // }
                // field("Responsibility Center Name"; Rec."Responsibility Center Name")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Caption = 'Department Name';
                // }
                field("Blocked?"; Rec."Blocked")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Assigned Weight(%)"; Rec."Total Assigned Weight(%)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Core Inititives Weight(%)';
                    Editable = false;
                }
                field("Secondary Assigned Weight(%)"; Rec."Secondary Assigned Weight(%)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Additional Inititives Weight(%)';
                    Editable = false;
                    Visible = false;
                }
                field("JD Assigned Weight(%)"; Rec."JD Assigned Weight(%)")
                {
                    ApplicationArea = Basic;
                    Caption = 'JD Inititives Weight(%)';
                    Editable = false;
                }
            }
            group(Statistics)
            {
                field("No. of Departments' PCs"; Rec."No. of Departments' PCs")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("No. of Principal Officers PCs"; Rec."No. of Principal Officers PCs")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                // field("No. of Senior Officers PCs"; Rec."No. of Senior Officers PCs")
                // {
                //     ApplicationArea = Basic;
                // }
                field("No. of Staff PCs"; Rec."No. of Staff PCs")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Objectives and Initiatives"; "Workplan Initiatives")
            {
                Caption = 'Board PC Activities';
                SubPageLink = "Workplan No." = field(No),
                              "Initiative Type" = const(Board);
                Visible = false;
            }
            part("CEO Workplan Initiatives"; "CEO Workplan Initiatives")
            {
                Caption = 'Core Initiatives';
                SubPageLink = "Workplan No." = field(No),
                              "Strategy Plan ID" = field("Strategy Plan ID"),
                              "Initiative Type" = filter(Activity | Board);
            }
            // part("Added Activities"; "Secondary Workplan Initiatives")
            // {
            //     Caption = 'Additional Initiatives';
            //     SubPageLink = "Workplan No." = field(No),
            //                   "Strategy Plan ID" = field("Strategy Plan ID"),
            //                   "Year Reporting Code" = field("Annual Reporting Code");
            // }
            part(Control8; "PC Job Description")
            {
                Caption = 'Job Description';
                SubPageLink = "Workplan No." = field(No);
                // visible = false;
            }

        }
        area(factboxes)
        {
            // part(Attachments; "Sharepoint File List")
            // {
            //     ApplicationArea = Basic;
            //     SubPageLink = "No." = field(No);
            // }
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
                        ApplicationArea = Basic;
                        Image = AddWatch;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunObject = Page "Standard Perfomance Appraisal";
                        RunPageLink = "Personal Scorecard ID" = field(No),
                                      "Document Type" = const("Performance Appraisal");
                    }
                    action("Performance Appeal")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Performance Appeal';
                        Image = AddWatch;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunObject = Page "Perfomance Appeals";
                        RunPageLink = "Personal Scorecard ID" = field(No),
                                      "Document Type" = const("Performance Appeal");
                    }
                    action(PIPs)
                    {
                        ApplicationArea = Basic;
                        Caption = 'PIPs';
                        Image = AddWatch;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunObject = Page "Performance Improvement Plans";
                        RunPageLink = "Personal Scorecard ID" = field(No);
                    }
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const(7),
                                  "No." = field("No. Series");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action("Change Log")
                {
                    ApplicationArea = Basic;
                    Image = Log;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Performance Diary Logs";
                    RunPageLink = "Personal Scorecard ID" = field(No);
                }
            }
        }
        area(creation)
        {
            action("Suggest Objective Lines")
            {
                ApplicationArea = Basic;
                Caption = 'Cascade CPC Activities';
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to Suggest Activities', true) then
                        Error('Activities not Suggested');

                    Rec.TestField("Strategy Plan ID");
                    Rec.TestField("Annual Workplan");
                    Rec.TestField("Annual Reporting Code");

                    SPMGeneralSetup.Get;

                    if (SPMGeneralSetup."Allow Loading of  CSP" = true) then begin
                        StrategyObjLines.Reset;
                        StrategyObjLines.SetRange("Strategy Plan ID", Rec."Strategy Plan ID");
                        StrategyObjLines.SetRange("No", Rec."Annual Workplan");
                        if StrategyObjLines.Find('-') then begin
                            repeat
                                PcLines.Init;
                                PcLines."Workplan No." := Rec.No;
                                PcLines."Strategy Plan ID" := Rec."Strategy Plan ID";
                                PcLines."Initiative Type" := PcLines."Initiative Type"::Activity;
                                PcLines."Initiative No." := StrategyObjLines."Activity ID";
                                PcLines."Goal Template ID" := Rec."Goal Template ID";
                                PcLines."Objective/Initiative" := StrategyObjLines.Description;
                                PcLines."Year Reporting Code" := Rec."Annual Reporting Code";
                                PcLines."Primary Department" := StrategyObjLines."Primary Department";
                                PcLines."Primary Department Name" := StrategyObjLines."Primary Department Name";
                                PcLines."Outcome Perfomance Indicator" := StrategyObjLines."Key Performance Indicator";
                                // PcLines.Validate("Outcome Perfomance Indicator");
                                PcLines."Key Performance Indicator" := StrategyObjLines."Key Performance Indicator";
                                PcLines."Unit of Measure" := StrategyObjLines."Unit of Measure";
                                PcLines."Start Date" := Rec."Start Date";
                                PcLines."Due Date" := Rec."End Date";
                                PcLines."Imported Annual Target Qty" := StrategyObjLines."Imported Annual Target Qty";
                                PcLines."Q1 Target Qty" := StrategyObjLines."Q1 Target";
                                PcLines."Q2 Target Qty" := StrategyObjLines."Q2 Target";
                                PcLines."Q3 Target Qty" := StrategyObjLines."Q3 Target";
                                PcLines."Q4 Target Qty" := StrategyObjLines."Q4 Target";
                                // PcLines."Assigned Weight (%)" := StrategyObjLines."Assigned Weight (%)";
                                // PcLines."Previous Annual Target Qty" := StrategyObjLines."Previous Annual Target Qty";
                                PcLines.Insert(true);


                                //Sub Activities
                                OriginalSubActivities.Reset;
                                OriginalSubActivities.SetRange("Strategy Plan ID", Rec."Strategy Plan ID");
                                OriginalSubActivities.SetRange("Workplan No.", Rec."Annual Workplan");
                                OriginalSubActivities.SetRange("Initiative No.", PcLines."Initiative No.");
                                if OriginalSubActivities.FindFirst then begin
                                    repeat
                                        PCSubActivities.Init;
                                        PCSubActivities."Strategy Plan ID" := OriginalSubActivities."Strategy Plan ID";
                                        PCSubActivities."Workplan No." := Rec.No;
                                        PCSubActivities."Initiative No." := OriginalSubActivities."Initiative No.";
                                        PCSubActivities."Sub Initiative No." := OriginalSubActivities."Sub Initiative No.";
                                        PCSubActivities."Entry Number" := OriginalSubActivities."Entry Number";
                                        PCSubActivities.TransferFields(OriginalSubActivities, false);
                                        PCSubActivities.Insert(true);
                                    until OriginalSubActivities.Next = 0;
                                end;
                            //End Sub Activities
                            until StrategyObjLines.Next = 0;
                        end;
                    end;

                    // if (SPMGeneralSetup."Allow Loading of  CSP" = true) then begin
                    //     PcLinesN.Reset;
                    //     PcLinesN.SetRange("Strategy Plan ID", Rec."Strategy Plan ID");
                    //     PcLinesN.SetRange("Workplan No.", Rec."Annual Workplan");
                    //     //PcLinesN.SETRANGE("Primary Department","Responsibility Center");
                    //     if PcLinesN.Find('-') then begin
                    //         repeat
                    //             PcLines.Init;
                    //             PcLines."Workplan No." := Rec.No;
                    //             PcLines."Strategy Plan ID" := PcLinesN."Strategy Plan ID";
                    //             PcLines."Initiative Type" := PcLinesN."Initiative Type";
                    //             PcLines."Initiative No." := PcLinesN."Initiative No.";
                    //             PcLines."Goal Template ID" := Rec."Goal Template ID";
                    //             PcLines."Objective/Initiative" := PcLinesN."Objective/Initiative";
                    //             PcLines."Year Reporting Code" := Rec."Annual Reporting Code";
                    //             PcLines."Primary Department" := PcLinesN."Primary Department";
                    //             PcLines."Primary Department Name" := PcLinesN."Primary Department Name";
                    //             // PcLines."Primary Division" := PcLinesN."Primary Division";
                    //             //PcLines."Primary Division Name" := PcLinesN."Primary Division Name";
                    //             PcLines."Outcome Perfomance Indicator" := PcLinesN."Outcome Perfomance Indicator";
                    //             PcLines.Validate("Outcome Perfomance Indicator");
                    //             PcLines."Key Performance Indicator" := PcLinesN."Key Performance Indicator";
                    //             PcLines."Unit of Measure" := PcLinesN."Unit of Measure";
                    //             PcLines."Start Date" := Rec."Start Date";
                    //             PcLines."Due Date" := Rec."End Date";
                    //             PcLines."Imported Annual Target Qty" := PcLinesN."Imported Annual Target Qty";
                    //             PcLines."Q1 Target Qty" := PcLinesN."Q1 Target Qty";
                    //             PcLines."Q2 Target Qty" := PcLinesN."Q2 Target Qty";
                    //             PcLines."Q3 Target Qty" := PcLinesN."Q3 Target Qty";
                    //             PcLines."Q4 Target Qty" := PcLinesN."Q4 Target Qty";
                    //             PcLines."Assigned Weight (%)" := PcLinesN."Assigned Weight (%)";
                    //             PcLines."Previous Annual Target Qty" := PcLinesN."Previous Annual Target Qty";
                    //             PcLines.Insert(true);


                    //             //Sub Activities
                    //             OriginalSubActivities.Reset;
                    //             OriginalSubActivities.SetRange("Strategy Plan ID", Rec."Strategy Plan ID");
                    //             OriginalSubActivities.SetRange("Workplan No.", Rec."Annual Workplan");
                    //             OriginalSubActivities.SetRange("Initiative No.", PcLines."Initiative No.");
                    //             if OriginalSubActivities.FindFirst then begin
                    //                 repeat
                    //                     PCSubActivities.Init;
                    //                     PCSubActivities."Strategy Plan ID" := OriginalSubActivities."Strategy Plan ID";
                    //                     PCSubActivities."Workplan No." := Rec.No;
                    //                     PCSubActivities."Initiative No." := OriginalSubActivities."Initiative No.";
                    //                     PCSubActivities."Sub Initiative No." := OriginalSubActivities."Sub Initiative No.";
                    //                     PCSubActivities."Entry Number" := OriginalSubActivities."Entry Number";
                    //                     PCSubActivities.TransferFields(OriginalSubActivities, false);
                    //                     PCSubActivities.Insert(true);
                    //                 until OriginalSubActivities.Next = 0;
                    //             end;
                    //         //End Sub Activities
                    //         until PcLinesN.Next = 0;
                    //     end;
                    // end;
                    //Loading JD
                    if (SPMGeneralSetup."Allow Loading of JD" = true) then begin
                        //MESSAGE('Wow');
                        JobRes.Reset;
                        if Rec."Acting Job ID" <> '' then begin
                            JobRes.SetRange("Job ID", PCHeader."Acting Job ID");
                        end else begin
                            if PCHeader.Position <> '' then
                                JobRes.SetRange("Job ID", PCHeader.Position);
                        end;
                        if JobRes.FindSet then begin
                            repeat
                                PCJobDescription.Init;
                                PCJobDescription."Workplan No." := Rec.No;
                                PCJobDescription."Line Number" := Format(JobRes."Line No");
                                PCJobDescription.Description := JobRes.Responsibility;
                                PCJobDescription."Start Date" := Rec."Start Date";
                                PCJobDescription."Due Date" := Rec."End Date";
                                //PCJobDescription."Primary Department":="Responsibility Center";
                                //PCJobDescription.VALIDATE("Primary Department");
                                PCJobDescription.Insert(true);
                            until JobRes.Next = 0;
                        end;
                    end;


                    /*IF (SPMGeneralSetup."Allow Loading of JD"=TRUE) THEN BEGIN
                      JobResponsiblities.RESET;
                       IF "Acting Job ID"<>'' THEN BEGIN
                        JobResponsiblities.SETRANGE("Application No","Acting Job ID");
                      END ELSE BEGIN
                      JobResponsiblities.SETRANGE("Application No",Position);
                        END;
                      IF JobResponsiblities.FINDFIRST THEN BEGIN
                        REPEAT
                          PCJobDescription.INIT;
                          PCJobDescription."Workplan No.":=No;
                          PCJobDescription."Line Number":=FORMAT(JobResponsiblities.Surname);
                          PCJobDescription.Description:=JobResponsiblities."First Name";
                          PCJobDescription."Primary Department":="Responsibility Center";
                          PCJobDescription.VALIDATE("Primary Department");
                          PCJobDescription.INSERT;
                    
                        UNTIL JobResponsiblities.NEXT=0;
                      END;
                      END;*/


                    //Board Sub-activities
                    BoardSubActivities.Reset;
                    BoardSubActivities.SetRange("Strategy Plan ID", Rec."Strategy Plan ID");
                    BoardSubActivities.SetRange("Workplan No.", Rec."Annual Workplan");
                    if BoardSubActivities.FindSet then begin
                        repeat
                            PCSubActivities.Init;
                            PCSubActivities."Workplan No." := Rec.No;
                            PCSubActivities."Initiative No." := BoardSubActivities."Activity Id";
                            PCSubActivities.TransferFields(BoardSubActivities, false);
                            PCSubActivities.Insert(true);
                        until BoardSubActivities.Next = 0;
                    end;

                    Message('Annual Workplan PC Populated Successfully');

                end;
            }
            action("Populate Goals Hub")
            {
                ApplicationArea = Basic;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    GoalTemplateLine.Reset;
                    GoalTemplateLine.SetRange("Goal Template ID", Rec."Goal Template ID");
                    if GoalTemplateLine.Find('-') then begin
                        repeat
                            workplangoalhub.Init;
                            workplangoalhub."Goal ID" := GoalTemplateLine."Goal ID";
                            workplangoalhub."Performance Contract ID" := Rec.No;
                            workplangoalhub."Goal Description" := GoalTemplateLine.Description;
                            workplangoalhub."Aligned-To PC ID" := GoalTemplateLine."Corporate Strategic Plan ID";
                            workplangoalhub."Aligned-To PC Goal ID" := GoalTemplateLine."Strategic Objective ID";
                            workplangoalhub.Insert(true);
                        until GoalTemplateLine.Next = 0;
                    end;
                    Message('WorkPlan Hub Populated successfully');
                end;
            }
            action("Aligned Business Goals")
            {
                ApplicationArea = Basic;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Aligned Business Goals";
                RunPageLink = "Performance Contract ID" = field(No);
                Visible = false;
            }
            // action("Risk Analysis")
            // {
            //     ApplicationArea = Basic;
            //     Image = Reserve;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     visible = false;
            //     RunObject = Page "Workplan Risk";
            //     RunPageLink = "Document No" = field(No);
            // }
            // action("Capability Matrix")
            // {
            //     ApplicationArea = Basic;
            //     Image = "Action";
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     RunObject = Page "Workplan Capability Matrixs";
            //     RunPageLink = "Document No" = field(No);
            //     visible = false;
            // }
            separator(Action34)
            {
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // ApprovalsMgmt.OpenApprovalEntriesPage(RecordId);
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    //   ApprovalMgt: Codeunit "Approvals Mgmt.";
                    SMTPSetup: Codeunit Mail;
                    CompanyInfo: Record "Company Information";
                    UserSetup: Record "User Setup";
                    SenderAddress: Text[80];
                    Recipients: Text[80];
                    SenderName: Text[70];
                    Body: Text[250];
                    Subject: Text[80];
                    FileName: Text;
                    FileMangement: Codeunit "File Management";
                    ProgressWindow: Dialog;
                    SMTPMailSet: Record "Email Account";
                    FileDirectory: Text[100];
                    Window: Dialog;
                    WindowisOpen: Boolean;
                    Counter: Integer;
                    cu400: Codeunit Mail;
                    BranchName: Code[80];
                    DimValue: Record "Dimension Value";
                    CustEmail: Text[100];
                    HRSetup: Record "Human Resources Setup";
                    CompInfo: Record "Company Information";
                    PerfomanceContractHeader: Record "Perfomance Contract Header";
                    Employee: Record Employee;
                    PerformanceApprovals: Codeunit "Performance Approvals";
                    VarVariant: Variant;
                begin
                    /*
                    TESTFIELD("Approval Status","Approval Status"::Open);
                    TotalWeight:=0;
                    CALCFIELDS("Total Assigned Weight(%)","Secondary Assigned Weight(%)","JD Assigned Weight(%)");
                    TotalWeight:="Total Assigned Weight(%)"+"Secondary Assigned Weight(%)"+"JD Assigned Weight(%)";
                    IF NOT (TotalWeight=100) THEN
                       ERROR('Total Assigned Weight for all Core Mandate Primary Activities should be (100%),Currently is %1',TotalWeight);
                    
                    PcLines.RESET;
                    PcLines.SETRANGE("Workplan No.",No);
                    IF PcLines.FINDFIRST THEN BEGIN
                      REPEAT
                       // PcLines.TESTFIELD("Primary Directorate");
                       // PcLines.TESTFIELD("Primary Department");
                        UNTIL PcLines.NEXT=0;
                      END;*/


                    //status must be open.
                    /*TESTFIELD("Created By",USERID); //control so that only the initiator of the document can send for approval
                     IF ApprovalsMgmt.CheckPerformanceContractApprovalsWorkflowEnabled(Rec) THEN
                      ApprovalsMgmt.IsTSalaryApprovalsWorkflowEnabled(Rec);
                      */

                    Rec.TestField("Approval Status", Rec."approval status"::Open);
                    VarVariant := Rec;
                    IF PerformanceApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                        PerformanceApprovals.OnSendDocForApproval(VarVariant);

                    // Rec."Approval Status" := Rec."approval status"::Released;
                    // Rec.Modify;
                    // Message('Document Approved Automatically');
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


                            // Report.SaveAsPdf(52211645,FileDirectory+FileName,PerfomanceContractHeader);




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

                             cu400.AddBodyline(
                             '<BR><BR>Kind Regards,');
                             cu400.AddBodyline('<BR>'+CompInfo.Name);
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
                ApplicationArea = Basic;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PerformanceApprovals: Codeunit "Performance Approvals";
                    VarVariant: Variant;
                begin
                    Rec.TestField("Approval Status", Rec."approval status"::"Pending Approval");//status must be open.
                                                                                                /*TESTFIELD("Created By",USERID); //control so that only the initiator of the document can send for approval
                                                                                                ApprovalsMgmt.""(Rec);*/

                    VarVariant := Rec;
                    PerformanceApprovals.OnCancelDocApprovalRequest(VarVariant);
                    //ApprovalsMgmt.OnSendTSalaryForApproval(Rec);
                    /*"Approval Status":="Approval Status"::Open;
                    MODIFY;
                     MESSAGE('Document has been Re-Opened');*/

                end;
            }
            separator(Action30)
            {
            }
            action("Send Appraisal")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.TestField("Approval Status", Rec."approval status"::Released);
                    Message('Test');
                end;
            }
            separator(Action49)
            {
            }
            action("Print Individual PC")
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.SetRange(No, Rec.No);
                    Report.Run(Report::"Individual PC", true, true, Rec)
                    //REPORT.RUN(80019, TRUE, TRUE, Rec)
                end;
            }
            action("Individual PC-Sub Indicators")
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Individual PC-Sub Indicators";
            }
            action("Board PC")
            {
                ApplicationArea = Basic;
                Caption = 'Board PC';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                visible = false;

                trigger OnAction()
                begin
                    Rec.SetRange(No, Rec.No);
                    Report.Run(80026, true, true, Rec)
                end;
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
                        LockOpenServContract: Codeunit "Lock-OpenServContract";
                    begin
                        Rec.TestField("Approval Status", Rec."approval status"::Released);
                        Rec."Change Status" := Rec."change status"::Locked;
                        Rec.Modify;
                        Message('Contract Locked Successfully');
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
                        SignServContractDoc: Codeunit SignServContractDoc;
                    begin
                        Rec.TestField("Approval Status", Rec."approval status"::Released);
                        Rec.TestField("Change Status", Rec."change status"::Locked);
                        Rec.Status := Rec.Status::Signed;
                        Rec.Modify;
                        Message('Contract signed Successfully');
                    end;
                }
                action(SignContract1)
                {
                    ApplicationArea = Service;
                    Caption = 'Supervisor Si&gn Contract';
                    Image = Signature;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Supervisor to Confirm the contract.';

                    trigger OnAction()
                    var
                        SignServContractDoc: Codeunit SignServContractDoc;
                    begin
                        Rec.TestField("Approval Status", Rec."approval status"::Released);
                        Rec.TestField("Change Status", Rec."change status"::Locked);
                        rec.TestField(Status, rec.Status::Signed);
                        Rec.Status := Rec.Status::"Supervisor Signed";
                        Rec.Modify;
                        Message('Supervisor Signed Contract Successfully');
                    end;
                }
                // action(CopyWorkplan)
                // {
                //     ApplicationArea = Jobs;
                //     Caption = '&Copy WorkPlan';
                //     Ellipsis = true;
                //     Image = CopyFromTask;
                //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //     //PromotedCategory = Process;
                //     ToolTip = 'Copy a Workplan and its Lines';
                //     Visible = false;

                //     trigger OnAction()
                //     var
                //         CopyJob: Page "Copy WorkPlan";
                //     begin
                //         CopyJob.SetFromWorkplan(Rec);
                //         CopyJob.RunModal;
                //     end;
                // }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."document type"::"Staff Performance Contract";
        Rec."Score Card Type" := Rec."score card type"::CEOs;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Document Type" := Rec."document type"::"Staff Performance Contract";
        Rec."Score Card Type" := Rec."score card type"::CEOs;
    end;

    trigger OnAfterGetCurrRecord()
    var
        DocType: Enum "Approval Document Type";
    begin
        // DocType := DocType::"HODs Performance Contracts";
        // CurrPage.Attachments.Page.Documenttype(DocType, Rec.No);
    end;

    trigger OnOpenPage()
    begin
        Rec."Document Type" := Rec."document type"::"Staff Performance Contract";
        Rec."Score Card Type" := Rec."score card type"::CEOs;
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
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OriginalSubActivities: Record "Sub PC Objective";
        JobRes: Record "Job Responsiblities";
        CompanyJobsRec: Record "Company Jobs";
        PCPerspectives: Record "PC Perspective";
        CSPPerspective: Record "Strategy Framework Perspective";
        Employee: Record Employee;
        PCHeader: Record "Perfomance Contract Header";
}

#pragma implicitwith restore

