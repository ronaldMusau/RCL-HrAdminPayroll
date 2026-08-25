#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211657 "Self-Supervisor Appraisal"
{
    PageType = Card;
    SourceTable = "Performance Evaluation";
    SourceTableView = where("Document Type" = const("Performance Appraisal"),
                            "Document Status" = const(Draft));

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
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Evaluation Type"; Rec."Evaluation Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Mgt Plan ID"; Rec."Performance Mgt Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Task ID"; Rec."Performance Task ID")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Start Date"; Rec."Evaluation Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Evaluation End Date"; Rec."Evaluation End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Template ID"; Rec."Appraisal Template ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Current Designation"; Rec."Current Designation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Current Grade"; Rec."Current Grade")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal Scorecard ID"; Rec."Personal Scorecard ID")
                {
                    ApplicationArea = Basic;
                }
                field("Immediate Supervisor No."; Rec."Immediate Supervisor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Immediate Supervisor Name"; Rec."Immediate Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Review Period"; Rec."Review Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Review Period field.', Comment = '%';
                }
                field("Competency Template ID"; Rec."Competency Template ID")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("General Assessment Template ID"; Rec."General Assessment Template ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Objective & Outcome Weight %"; Rec."Objective & Outcome Weight %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Competency Weight %"; Rec."Competency Weight %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Weight %"; Rec."Total Weight %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Performance Rating Scale"; Rec."Performance Rating Scale")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Proficiency Rating Scale"; Rec."Proficiency Rating Scale")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field(Department; Rec.Division)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Are Objectives On Track?"; Rec."Are Objectives On Track?")
                {
                    ApplicationArea = Basic;
                }
                field("Received Ongoing Feedback"; Rec."Received Ongoing Feedback")
                {
                    ApplicationArea = Basic;
                }
                field("Development Actions On Track"; Rec."Development Actions On Track")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Blocked?"; Rec."Blocked?")
                {
                    ApplicationArea = Basic;
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
                field("Last Evaluation Date"; Rec."Last Evaluation Date")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Objectives and Outcomes"; "Objectives and Outcomes-Self")
            {
                Caption = 'Suggest Officers Perfomance Target';
                SubPageLink = "Performance Evaluation ID" = field(No);
            }
            part(Control39; "Proficiency Evalulation-Self")
            {
                SubPageLink = "Performance Evaluation ID" = field(No);
            }
            part(Control47; "Evaluation Training Needs")
            {
                SubPageLink = "Perfomance Evaluation No" = field(No);
            }
        }
        area(factboxes)
        {
            part("Attached Documents1"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Performance Evaluation"), "No." =
                FIELD(No);
            }
            systempart(Control1000000017; Notes)
            {
            }
            systempart(Control1000000018; MyNotes)
            {
            }
            systempart(Control1000000019; Links)
            {
            }

        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(creation)
        {
            action("Suggest Objectives & Outcomes")
            {
                ApplicationArea = Basic;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Suggest Officers Perfomance Target';

                trigger OnAction()
                begin
                    if not Confirm('Are sure you want to Suggest Objectives & Outcomes', true) then
                        Error('Objectives & Outcomes not Suggested');
                    PCObjective.Reset;
                    PCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                    PCObjective.SetRange("Due Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                    if PCObjective.FindSet() then begin
                        repeat
                            ObjectiveOutcome.Init;
                            ObjectiveOutcome."Performance Evaluation ID" := Rec.No;
                            ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                            ObjectiveOutcome."Scorecard ID" := PCObjective."Workplan No.";
                            ObjectiveOutcome."Intiative No" := PCObjective."Initiative No.";
                            ObjectiveOutcome."Objective/Initiative" := PCObjective."Objective/Initiative";
                            ObjectiveOutcome."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                            ObjectiveOutcome."Self-Review Qty" := PCObjective."AnnualWorkplan Achieved Target";
                            // ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                            ObjectiveOutcome."Target Qty" := PCObjective."Imported Annual Target Qty";
                            ObjectiveOutcome."Performance Rating Scale" := Rec."Performance Rating Scale";
                            ObjectiveOutcome.Insert(true);

                        until PCObjective.Next = 0;

                    end;

                    PCSubActivities.Reset;
                    PCSubActivities.SetRange("Strategy Plan ID", Rec."Strategy Plan ID");
                    PCSubActivities.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                    if PCSubActivities.FindSet() then begin
                        repeat
                            ObjectiveOutcome.Init;
                            ObjectiveOutcome."Performance Evaluation ID" := Rec.No;
                            ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                            ObjectiveOutcome."Scorecard ID" := PCSubActivities."Workplan No.";
                            ObjectiveOutcome."Intiative No" := PCSubActivities."Initiative No.";
                            ObjectiveOutcome."Objective/Initiative" := PCSubActivities."Objective/Initiative";
                            ObjectiveOutcome."Outcome Perfomance Indicator" := PCSubActivities."Outcome Perfomance Indicator";
                            ObjectiveOutcome."Self-Review Qty" := PCSubActivities."AnnualWorkplan Achieved Target";
                            // ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                            ObjectiveOutcome."Target Qty" := PCSubActivities."Imported Annual Target Qty";
                            ObjectiveOutcome."Performance Rating Scale" := Rec."Performance Rating Scale";
                            ObjectiveOutcome.Insert(true);

                        until PCSubActivities.Next() = 0;
                    end;

                    PCJobDescription.Reset;
                    PCJobDescription.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                    if PCJobDescription.FindSet() then begin
                        repeat
                            ObjectiveOutcome.Init;
                            ObjectiveOutcome."Performance Evaluation ID" := Rec.No;
                            ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                            ObjectiveOutcome."Scorecard ID" := PCJobDescription."Workplan No.";
                            ObjectiveOutcome."Intiative No" := PCJobDescription."Key Performance Indicator";
                            ObjectiveOutcome."Objective/Initiative" := PCJobDescription.Description;
                            ObjectiveOutcome."Outcome Perfomance Indicator" := '';
                            ObjectiveOutcome."Self-Review Qty" := 0;
                            // ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                            ObjectiveOutcome."Target Qty" := 0;
                            ObjectiveOutcome."Performance Rating Scale" := Rec."Performance Rating Scale";
                            ObjectiveOutcome.Insert(true);

                        until PCJobDescription.Next() = 0;
                    end;
                    Message('Objectives and Outcomes Populated Successfully');
                end;
            }
            action("Load Competency Templates")
            {
                ApplicationArea = Basic;
                Image = Template;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('Are sure you want to Load Competency Templates', true) then
                        Error('Competency Templates not Loaded');
                    CompetencyLines.Reset;
                    CompetencyLines.SetRange("Competency Template ID", Rec."Competency Template ID");
                    if CompetencyLines.Find('-') then begin
                        repeat
                            ProEvaluation.Init;
                            ProEvaluation."Performance Evaluation ID" := Rec.No;
                            ProEvaluation."Line No" := FnGetLastLineNoB + 1;
                            ProEvaluation."Competency Template ID" := Rec."Competency Template ID";
                            ProEvaluation."Competency Code" := CompetencyLines."Competency Code";
                            ProEvaluation.Validate("Competency Code");
                            ProEvaluation."Competency Category" := CompetencyLines."Competency Category";
                            ProEvaluation.Description := CompetencyLines.Description;
                            ProEvaluation."Profiency Rating Scale" := Rec."Proficiency Rating Scale";
                            ProEvaluation."Target Qty" := CompetencyLines."Weight %";
                            ProEvaluation."Weight %" := CompetencyLines."Weight %";
                            ProEvaluation.Insert(true);
                        until CompetencyLines.Next = 0;
                    end;
                    Message('Competency Templates loaded Successfully');
                end;
            }

            // action("Create Training Needs")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Create Training Needs', comment = 'NLB="YourLanguageCaption"';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Image = NewDocument;

            //     trigger OnAction()
            //     var
            //         TrnNeedReq: Record "Training Needs Requests";
            //         HRSetup: Record "Human Resources Setup";
            //         TrnNeedHeader: Record "Training Needs Header";
            //         NoSeriesMgt: Codeunit NoSeriesManagement;
            //         EvalTrainNeeds: Record "Evaluation Training Needs";
            //         TrnNeedReq1: Record "Training Needs Requests";
            //         i: Integer;
            //     begin
            //         TrnNeedHeader.Init;
            //         HRSetup.Get();
            //         HRSetup.TestField("Training Request Nos");
            //         TrnNeedHeader.Code := NoSeriesMgt.DoGetNextNo(HRSetup."Training Request Nos", Today, true, true);
            //         TrnNeedHeader."Created By" := UserId;
            //         TrnNeedHeader."Created On" := CurrentDatetime;
            //         TrnNeedHeader."Employee No" := Rec."Employee No.";
            //         TrnNeedHeader."Employee Name" := Rec."Employee Name";
            //         TrnNeedHeader.Department := Rec.Division;
            //         TrnNeedHeader."Perfomance Header No" := Rec.No;
            //         if TrnNeedHeader.Insert(true) then begin
            //             EvalTrainNeeds.Reset();
            //             EvalTrainNeeds.SetRange("Perfomance Evaluation No", Rec.No);
            //             if EvalTrainNeeds.FindSet then begin
            //                 repeat
            //                     message('%1', EvalTrainNeeds."Perfomance Evaluation No");
            //                     message('Need No %1', EvalTrainNeeds."Training Need Number");
            //                     TrnNeedReq1.Reset;
            //                     if TrnNeedReq1.FindLast() then
            //                         i := TrnNeedReq1."Entry No.";
            //                     TrnNeedReq.Init;
            //                     TrnNeedReq."Entry No." := i + 1;
            //                     TrnNeedReq."Course ID" := EvalTrainNeeds.Course;
            //                     TrnNeedReq.validate("Course ID");
            //                     //TrnNeedReq.Description := EvalTrainNeeds.Description;
            //                     TrnNeedReq."Reason for Training" := TrnNeedReq."Reason for Training"::"Performance Gap";
            //                     TrnNeedReq.Comments := EvalTrainNeeds."Supervisor's Comments";
            //                     TrnNeedReq."Training Header No." := TrnNeedHeader.Code;
            //                     if TrnNeedReq.insert = true then
            //                         Message('%1', TrnNeedReq."Entry No.");
            //                 until EvalTrainNeeds.Next() = 0;
            //             end;

            //         end;

            //         Message('Successfully created Training Needs Request %1', TrnNeedHeader.Code);
            //     end;
            // }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    // ApprovalsMgmt.OpenApprovalEntriesPage(RECORDID);
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    PerformanceApprovals: Codeunit "Performance Approvals";
                    VarVariant: Variant;
                begin
                    Rec.TestField("Approval Status", Rec."approval status"::Open);
                    Rec.TestField("Strategy Plan ID");
                    Rec.TestField("Performance Mgt Plan ID");
                    Rec.TestField("Performance Task ID");
                    Rec.TestField("Employee No.");
                    Rec.TestField("Personal Scorecard ID");
                    Rec.TestField("Immediate Supervisor No.");
                    Rec.TestField("Annual Reporting Code");
                    Rec.TestField(Closed, false);


                    ObjectiveOutcome.Reset;
                    ObjectiveOutcome.SetRange("Performance Evaluation ID", Rec.No);
                    if ObjectiveOutcome.Find('-') then begin
                        repeat
                            ObjectiveOutcome.TestField("Target Qty");
                            ObjectiveOutcome.TestField("Self-Review Qty");
                        until ObjectiveOutcome.Next = 0;
                    end;

                    ProEvaluation.Reset;
                    ProEvaluation.SetRange("Performance Evaluation ID", Rec.No);
                    if ProEvaluation.Find('-') then begin
                        repeat
                            ProEvaluation.TestField("Self-Review Qty");
                            ProEvaluation.TestField("Target Qty");
                        until ProEvaluation.Next = 0;
                    end;


                    //status must be open.
                    //TESTFIELD("Created By",USERID); //control so that only the initiator of the document can send for approval
                    /* IF ApprovalsMgmt.CheckGFAApprovalsWorkflowEnabled(Rec) THEN
                      ApprovalsMgmt.OnSendGFAForApproval(Rec);*/


                    // Rec."Approval Status" := Rec."approval status"::Released;
                    // Rec."Document Status" := Rec."document status"::Evaluation;
                    // Rec.Modify;

                    // Message('Document has been approved Automatically');

                    VarVariant := Rec;
                    IF PerformanceApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                        PerformanceApprovals.OnSendDocForApproval(VarVariant);

                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    VarVariant: Variant;
                    PerformanceApprovals: Codeunit "Performance Approvals";
                begin
                    Rec.TestField("Approval Status", Rec."approval status"::"Pending Approval");//status must be open.
                                                                                                /*TESTFIELD("Created By",USERID); //control so that only the initiator of the document can send for approval
                                                                                                ApprovalsMgmt.""(Rec);*/
                                                                                                // "Approval Status":="Approval Status"::Open;
                                                                                                // Rec.Modify;
                                                                                                // Message('Document has been Re-Opened');
                    VarVariant := Rec;
                    PerformanceApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attach Documents';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    // Rec.TestField("Approval Status", Rec."Approval Status"::Open);
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."document type"::"Performance Appraisal";
        Rec."Evaluation Type" := Rec."evaluation type"::"Self-Appraisal with Supervisor Score";
    end;

    trigger OnOpenPage()
    begin
        Rec."Document Type" := Rec."document type"::"Performance Appraisal";
        Rec."Evaluation Type" := Rec."evaluation type"::"Self-Appraisal with Supervisor Score";
    end;

    var
        PCObjective: Record "PC Objective";
        ObjectiveOutcome: Record "Objective Evaluation Result";
        CompetencyLines: Record "Competency Template Line";
        ProEvaluation: Record "Proficiency Evaluation Result";
        PCSubActivities: Record "Secondary PC Objective";
        PCJobDescription: Record "PC Job Description";

    local procedure FnGetLastLineNo() LineNumber: Integer
    var
        Billable: Record "Objective Evaluation Result";
    begin
        Billable.Reset;
        if Billable.Find('+') then
            LineNumber := Billable."Line No"
        else
            LineNumber := 1;
        exit(LineNumber);
    end;

    local procedure FnGetLastLineNoB() LineNumber: Integer
    var
        ProEvalution: Record "Proficiency Evaluation Result";
    begin
        ProEvalution.Reset;
        if ProEvalution.Find('+') then
            LineNumber := ProEvalution."Line No"
        else
            LineNumber := 1;
        exit(LineNumber);
    end;
}

