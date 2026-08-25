page 52211691 "Depart Performance Logs Card"
{
    PageType = Card;
    SourceTable = "Performance Diary Log";

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
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Names"; Rec."Employee Names")
                {
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Caption = 'Department';
                    Editable = false;
                }
                // field("Department Code"; Rec."Division Code")
                // {
                //     Caption = 'Department';
                //     Editable = false;
                // }
                field("Region ID"; Rec."Region ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                // field("Reporting PC Type";"Reporting PC Type")
                // {
                // }
                field("HOD Scorecard ID"; Rec."HOD Scorecard ID")
                {
                    Caption = 'Targets';
                }
                field("Year Reporting Code"; Rec."Year Reporting Code")
                {
                }
                field("CSP ID"; Rec."CSP ID")
                {
                }
                field("Activity Start Date"; Rec."Activity Start Date")
                {
                }
                field("Activity End Date"; Rec."Activity End Date")
                {
                }
                field("Reporting Quater Code"; Rec."Reporting Quater Code")
                {
                }
                field("AWP ID"; Rec."AWP ID")
                {
                    Editable = false;
                }
                field("CEO PC ID"; Rec."CEO PC ID")
                {
                    Editable = false;
                }
                field("Functional PC"; Rec."Functional PC")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    Editable = false;
                }
                field("Created Time"; Rec."Created Time")
                {
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    MultiLine = true;
                }
            }
            part(Part; "Performance Log Lines")
            {
                SubPageLink = "PLog No." = FIELD(No),
                              "Employee No." = FIELD("Employee No."),
                              "Personal Scorecard ID" = FIELD("HOD Scorecard ID"),
                              "Strategy Plan ID" = FIELD("CSP ID");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Suggest Targets")
            {
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // StrategicPlanning.FnSuggestDepartPlogLines(Rec);
                    MESSAGE('Performance log Target Lines Successfully');
                end;
            }
            // separator()
            // {
            // }
            action(Approvals)
            {
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // ApprovalsMgmt.OpenApprovalEntriesPage(RECORDID);
                end;
            }
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    // ApprovalMgt: Codeunit 1535;
                    // SMTPSetup: Codeunit "400";
                    CompanyInfo: Record 79;
                    UserSetup: Record 91;
                    SenderAddress: Text[80];
                    Recipients: Text[80];
                    SenderName: Text[70];
                    Body: Text[250];
                    Subject: Text[80];
                    FileName: Text;
                    // FileMangement: Codeunit "419";
                    ProgressWindow: Dialog;
                    // SMTPMailSet: Record 409;
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
                    PlogLines: Record "Plog Lines";
                begin
                    Rec.TESTFIELD("Approval Status", Rec."Approval Status"::Open);

                    PlogLines.RESET;
                    PlogLines.SETRANGE("PLog No.", Rec.No);
                    IF PlogLines.FINDFIRST THEN BEGIN
                        REPEAT
                            PlogLines.TESTFIELD("Achieved Target");
                        UNTIL PlogLines.NEXT = 0;
                    END;


                    //  IF ApprovalsMgmt.CheckPerformanceLogsApprovalsWorkflowEnabled(Rec) THEN
                    //   ApprovalsMgmt.OnSendPerformanceLogsForApproval(Rec);



                    //       CompanyInfo.GET();
                    //         SMTPMailSet.GET;
                    //         SenderAddress := SMTPMailSet."Email Sender Address";
                    //         SenderName :=CompanyInfo.Name+' M&E';
                    //         Subject := STRSUBSTNO('Performance Log');
                    //            PerfomanceContractHeader.RESET;
                    //            PerfomanceContractHeader.SETRANGE(No,No);
                    //            IF PerfomanceContractHeader.FINDFIRST THEN BEGIN
                    //               FileDirectory :=  'C:\DOCS\';
                    //               FileName := 'PCA_'+PerfomanceContractHeader.No+'.pdf';
                    //               //Window.OPEN('processing');
                    //               Window.OPEN('PROCESSING Performance Log ############1##');
                    //                 Window.UPDATE(1,PerfomanceContractHeader.No+'-'+PerfomanceContractHeader.Description);

                    //               WindowisOpen := TRUE;
                    //               IF FileName = '' THEN
                    //                 ERROR('Please specify what the file should be saved as');


                    //                REPORT.SAVEASPDF(52211645,FileDirectory+FileName,PerfomanceContractHeader);




                    //               IF EXISTS(FileDirectory+FileName) THEN BEGIN
                    //                 Counter:=Counter+1;

                    //               SMTPMailSet.GET;
                    //               SenderAddress := SMTPMailSet."Email Sender Address";



                    //              Employee.RESET;
                    //              Employee.SETRANGE("No.","Employee No.");
                    //              IF Employee.FIND('-') THEN BEGIN
                    //                Recipients :=Employee."Company E-Mail";
                    //              END;
                    //              IF Recipients<>'' THEN BEGIN
                    //                Body:='Dear Team <BR>Please find attached the Plog Report <Br>'+Description;
                    //                 cu400.CreateMessage(CompanyInfo.Name,SenderAddress,Recipients,Subject,Body,TRUE);

                    //                 cu400.AppendBody(
                    //                 '<BR><BR>Kind Regards,');
                    //                 cu400.AppendBody('<BR>'+CompInfo.Name);
                    //                 cu400.AddAttachment(FileDirectory+FileName,FileName);
                    //                 cu400.Send;

                    //                 SLEEP(1000);
                    //                 Window.CLOSE;
                    //             END;
                    //             END;
                    //           END;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TESTFIELD("Approval Status", Rec."Approval Status"::"Pending Approval");//status must be open.
                    //ApprovalsMgmt.OnCancelPerformanceLogsApprovalRequest(Rec);
                end;
            }
            // separator()
            // {
            // }
            action("Print Performance Log Summary")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SETRANGE(No, Rec.No);
                    Report.Run(Report::"Performance Log", TRUE, TRUE, Rec)
                end;
            }
            // separator()
            // {
            // }
            action("Post Performance Log")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                // trigger OnAction()
                // var
                //     PlogLines: Record "Plog Lines";
                //     ContractType: Option " ",HOD,Staff;
                // begin
                //     TESTFIELD("Approval Status","Approval Status"::Released);
                //     PlogLines.RESET;
                //     PlogLines.SETRANGE("PLog No.",No);
                //     IF PlogLines.FINDFIRST THEN BEGIN
                //       REPEAT
                //         // IF (PlogLines."Activity Type"<>PlogLines."Activity Type"::"JD Activity") THEN BEGIN
                //         //    //StrategicPlanning.FnInsertPlogEntry("CSP ID",'','','',PlogLines."Initiative No.",Description,EntryType::Actual,"Year Reporting Code","Reporting Quater Code",PlogLines."Planned Date","Directorate Code",
                //         //   "Department Code",PlogLines."Achieved Target",0,No,SourceType
                //         //   ,"Employee No.",PlogLines."Achieved Date",DocumentType::Plog,"Region ID","HOD Scorecard ID","AWP ID","Board PC ID","CEO PC ID","Functional PC",PlogLines."Unit of Measure",
                //         //   ContractType::HOD,PlogLines."Reporting Category");
                //         END;
                //          IF (PlogLines."Activity Type"=PlogLines."Activity Type"::"JD Activity") THEN BEGIN
                //              //StrategicPlanning.FnInsertJDPlogEntry(PlogLines);
                //          END;
                //         UNTIL PlogLines.NEXT=0;
                //       END;
                //       Posted:=TRUE;
                //       "Posted By":=USERID;
                //       "Posted On":=TODAY;
                //       MODIFY;

                //     MESSAGE('Performance Log %1 has been Posted Successfully',No);
                // end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Plog Type" := Rec."Plog Type"::AWP;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Plog Type" := Rec."Plog Type"::AWP;
    end;

    trigger OnOpenPage()
    begin
        Rec."Plog Type" := Rec."Plog Type"::AWP;
    end;

    var
        PerformanceDiaryEntry: Record "Performance Diary Entry";
        StrategicPlanning: Codeunit "Strategic Planning";
        EntryType: Option Planned,Actual;
        SourceType: Option "Strategic Plan","Perfomance Contract";
        DocumentType: Option Plog,Appraisal;
    //ApprovalsMgmt: Codeunit 
}

