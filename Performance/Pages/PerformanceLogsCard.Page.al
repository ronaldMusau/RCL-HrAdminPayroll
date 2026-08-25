#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211747 "Performance Logs Card"
{
    Caption = 'Performance Reports Card';
    PageType = Card;
    SourceTable = "Performance Diary Log";
    PromotedActionCategories = 'Home,Process,Report,Approvals,Print';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Names"; Rec."Employee Names")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field("Division Code"; Rec."Division Code")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field("Region ID"; Rec."Region ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Personal Scorecard ID"; Rec."Personal Scorecard ID")
                {
                    ApplicationArea = Basic;
                }
                field("Year Reporting Code"; Rec."Year Reporting Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reporting Quater Code"; Rec."Reporting Quater Code")
                {
                    ApplicationArea = Basic;
                    Editable = True;
                }

                field("Activity Start Date"; Rec."Activity Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Activity End Date"; Rec."Activity End Date")
                {
                    ApplicationArea = Basic;
                }
                field("CSP ID"; Rec."CSP ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("AWP ID"; Rec."AWP ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Board PC ID"; Rec."Board PC ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("CEOs PC ID"; Rec."CEOs PC ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field("Functional PC"; Rec."Functional PC")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field("Are Objectives On Track?"; Rec."Are Objectives On Track?")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received Ongoing Feedback"; Rec."Received Ongoing Feedback")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Development Actions On Track"; Rec."Development Actions On Track")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control25; "Performance Log Lines")
            {
                SubPageLink = "PLog No." = field(No),
                              "Employee No." = field("Employee No."),
                              "Personal Scorecard ID" = field("Personal Scorecard ID"),
                              "Strategy Plan ID" = field("CSP ID");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Suggest Targets")
            {
                ApplicationArea = Basic;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to Suggest Targets', true) then
                        Error('Targets not Suggested');

                    StrategicPlanning.FnSuggestPlogLines(Rec);
                    Message('Performance log Target Lines Successfully');
                end;
            }
            separator(Action30)
            {
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
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
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    //     ApprovalMgt: Codeunit "Approvals Mgmt.";
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
                    PlogLines: Record "Plog Lines";
                    VarVariant: Variant;
                    PerformanceApprovals: Codeunit "Performance Approvals";
                begin
                    Rec.TestField("Approval Status", Rec."approval status"::Open);

                    PlogLines.Reset;
                    PlogLines.SetRange("PLog No.", Rec.No);
                    if PlogLines.FindFirst then begin
                        repeat
                            PlogLines.TestField("Achieved Target");
                        until PlogLines.Next = 0;
                    end;

                    // Rec."Approval Status" := Rec."approval status"::Released;
                    // Rec.Modify;
                    // Message('Document has been approved Automatically');

                    VarVariant := Rec;
                    IF PerformanceApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                        PerformanceApprovals.OnSendDocForApproval(VarVariant);


                    CurrPage.Close();
                    //status must be open.
                    /*TESTFIELD("Created By",USERID); //control so that only the initiator of the document can send for approval
                     IF ApprovalsMgmt.IsBankRecReqApprovalsWorkflowEnabled(Rec) THEN
                      ApprovalsMgmt.OnSendBankRecReqForApproval(Rec);*/



                    /*
                    CompanyInfo.GET();
                      SMTPMailSet.GET;
                      SenderAddress := SMTPMailSet."Email Sender Address";
                      SenderName :=CompanyInfo.Name+' M&E';
                      Subject := STRSUBSTNO('Performance Log');
                         PerfomanceContractHeader.RESET;
                         PerfomanceContractHeader.SETRANGE(No,No);
                         IF PerfomanceContractHeader.FINDFIRST THEN BEGIN
                            FileDirectory :=  'C:\DOCS\';
                            FileName := 'PCA_'+PerfomanceContractHeader.No+'.pdf';
                            //Window.OPEN('processing');
                            Window.OPEN('PROCESSING Performance Log ############1##');
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
                           Employee.SETRANGE("No.","Employee No.");
                           IF Employee.FIND('-') THEN BEGIN
                             Recipients :=Employee."Company E-Mail";
                           END;
                           IF Recipients<>'' THEN BEGIN
                             Body:='Dear Team <BR>Please find attached the Plog Report <Br>'+Description;
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
                    VarVariant: Variant;
                    PerformanceApprovals: Codeunit "Performance Approvals";
                begin
                    Rec.TestField("Approval Status", Rec."Approval Status"::"Pending Approval");//status must be open.

                    VarVariant := Rec;
                    PerformanceApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            separator(Action31)
            {
            }
            // action(Attachments)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Upload Documents';
            //     Image = Attach;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

            //     trigger OnAction()
            //     var
            //         DocumentAttachmentDetails: Page "Document Attachment Details";
            //         RecRef: RecordRef;
            //     begin
            //         RecRef.GetTable(Rec);
            //         DocumentAttachmentDetails.OpenForRecRef(RecRef);
            //         DocumentAttachmentDetails.RunModal;
            //     end;
            // }
            action("Print Performance Log Summary")
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(No, Rec.No);
                    Report.Run(Report::"Performance Log", true, true, Rec)
                end;
            }
            separator(Action33)
            {
            }
            action("Post Performance Log")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PlogLines: Record "Plog Lines";
                begin
                    if not Confirm('Are you sure you want to Post', true) then
                        Error('Perforamnce Log not Posted');
                    Rec.TestField("Approval Status", Rec."approval status"::Released);
                    PlogLines.Reset;
                    PlogLines.SetRange("PLog No.", Rec.No);
                    if PlogLines.FindFirst then begin
                        repeat
                            if (PlogLines."Activity Type" <> PlogLines."activity type"::"JD Activity") then begin
                                StrategicPlanning.FnInsertPlogEntry(Rec."CSP ID", '', '', '', PlogLines."Initiative No.", Rec.Description, Entrytype::Actual, Rec."Year Reporting Code", rec."Reporting Quater Code", PlogLines."Planned Date", Rec."Department Code", PlogLines."Achieved Target", 0, Rec.No, SourceType
                                   , Rec."Employee No.", PlogLines."Achieved Date", Documenttype::Plog, Rec."Region ID", Rec."Personal Scorecard ID", Rec."AWP ID", Rec."Board PC ID", Rec."CEO PC ID", Rec."Functional PC", PlogLines."Unit of Measure", PlogLines.Comments, PlogLines."Q1 Achieved Target", PlogLines."Q2 Achieved Target", PlogLines."Q3 AchievedTarget", PlogLines."Q4 Achieved Target", PlogLines."Remaining Targets", PlogLines."Achieved Weight(%)", PlogLines.Variance);
                                //     StrategicPlanning.FnInsertPlogEntry(Rec."CSP ID", '', '', '', PlogLines."Initiative No.", Rec.Description, Entrytype::Actual, Rec."Year Reporting Code", rec."Reporting Quater Code", PlogLines."Planned Date", Rec."Department Code", Rec."Division Code", PlogLines."Achieved Target", 0, Rec.No, SourceType
                                //    , Rec."Employee No.", PlogLines."Achieved Date", Documenttype::Plog, Rec."Region ID", Rec."Personal Scorecard ID", Rec."AWP ID", Rec."Board PC ID", Rec."CEO PC ID", Rec."Functional PC", PlogLines."Unit of Measure", PlogLines.Comments, PlogLines."Q1 Achieved Target", PlogLines."Q2 Achieved Target", PlogLines."Q3 AchievedTarget", PlogLines."Q4 Achieved Target", PlogLines."Remaining Targets", PlogLines."Achieved Weight(%)", PlogLines.Variance);
                            end;
                            if (PlogLines."Activity Type" = PlogLines."activity type"::"JD Activity") then begin
                                StrategicPlanning.FnInsertJDPlogEntry(PlogLines);
                            end;
                        until PlogLines.Next = 0;
                    end;
                    Rec.Posted := true;
                    Rec."Posted By" := UserId;
                    Rec."Posted On" := Today;
                    Rec.Modify;

                    Message('Performance Log %1 has been Posted Successfully', Rec.No);
                end;
            }
        }
    }

    var
        PerformanceDiaryEntry: Record "Performance Diary Entry";
        StrategicPlanning: Codeunit "Strategic Planning";
        EntryType: Option Planned,Actual;
        SourceType: Option "Strategic Plan","Perfomance Contract";
        DocumentType: Option Plog,Appraisal;
    //  ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}

#pragma implicitwith restore

