#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211660 "Self-Supervisor Appraisal-E"
{
    PageType = Card;
    SourceTable = "Performance Evaluation";
    SourceTableView = where("Document Type" = const("Performance Appraisal"),
                            "Document Status" = const(Evaluation));

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
                field("Competency Template ID"; Rec."Competency Template ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = false;
                }
                field("Proficiency Rating Scale"; Rec."Proficiency Rating Scale")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
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
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
            part("Objectives and Outcomes"; "Objectives and Outcomes-Self E")
            {
                SubPageLink = "Performance Evaluation ID" = field(No);
            }
            part(Control39; "Proficiency Evalulation-Self E")
            {
                SubPageLink = "Performance Evaluation ID" = field(No);
            }
            group(Statistics)
            {
                Caption = 'Appraisal Confirmation';
                Visible = true;
                field("Employee Confirm"; Rec."Employee Confirm")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Confirm"; Rec."Supervisor Confirm")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents1"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Performance Evaluation"), "No." = FIELD(No);
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
            action("Submit Appraisal")
            {
                ApplicationArea = Basic;
                Image = Delivery;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // Rec.TestField("Employee Confirm", true);
                    Rec.TestField("Supervisor Confirm", true);

                    Rec."Document Status" := Rec."document status"::Submitted;
                    Rec.Modify;
                    Message('Appraisal Submitted Sucessfully');
                end;
            }
            action("Send to Employee")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    StrategicPlanning: Codeunit "Strategic Planning";
                begin
                    StrategicPlanning.SendSelfSupervisorAppraisalToEmployee(Rec);
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
            //         TrnNeedHeader.Reset();
            //         TrnNeedHeader.SetRange("Perfomance Header No", Rec.No);
            //         if TrnNeedHeader.FindSet() then begin
            //             repeat
            //                 TrnNeedReq.Reset();
            //                 TrnNeedReq.SetRange("Training Header No.", TrnNeedHeader.Code);
            //                 TrnNeedReq.DeleteAll();

            //                 EvalTrainNeeds.Reset();
            //                 EvalTrainNeeds.SetRange("Perfomance Evaluation No", Rec.No);
            //                 if EvalTrainNeeds.FindSet then begin
            //                     repeat
            //                         message('%1', EvalTrainNeeds."Perfomance Evaluation No");
            //                         message('Need No %1', EvalTrainNeeds."Training Need Number");
            //                         TrnNeedReq1.Reset;
            //                         if TrnNeedReq1.FindLast() then
            //                             i := TrnNeedReq1."Entry No.";
            //                         TrnNeedReq.Init;
            //                         TrnNeedReq."Entry No." := i + 1;
            //                         TrnNeedReq."Course ID" := EvalTrainNeeds.Course;
            //                         TrnNeedReq.validate("Course ID");
            //                         //TrnNeedReq.Description := EvalTrainNeeds.Description;
            //                         TrnNeedReq."Reason for Training" := TrnNeedReq."Reason for Training"::"Performance Gap";
            //                         TrnNeedReq.Comments := EvalTrainNeeds."Supervisor's Comments";
            //                         TrnNeedReq."Training Header No." := TrnNeedHeader.Code;
            //                         if TrnNeedReq.insert = true then
            //                             Message('%1', TrnNeedReq."Entry No.");
            //                     until EvalTrainNeeds.Next() = 0;
            //                 end;

            //                 Message('Successfully updated Training Needs Request %1', TrnNeedHeader.Code);
            //             until TrnNeedHeader.Next = 0;
            //         end else begin
            //             TrnNeedHeader.Init;
            //             HRSetup.Get();
            //             HRSetup.TestField("Training Request Nos");
            //             TrnNeedHeader.Code := NoSeriesMgt.DoGetNextNo(HRSetup."Training Request Nos", Today, true, true);
            //             TrnNeedHeader."Created By" := UserId;
            //             TrnNeedHeader."Created On" := CurrentDatetime;
            //             TrnNeedHeader."Employee No" := Rec."Employee No.";
            //             TrnNeedHeader."Employee Name" := Rec."Employee Name";
            //             TrnNeedHeader.Department := Rec.Division;
            //             TrnNeedHeader."Perfomance Header No" := Rec.No;
            //             if TrnNeedHeader.Insert(true) then begin
            //                 EvalTrainNeeds.Reset();
            //                 EvalTrainNeeds.SetRange("Perfomance Evaluation No", Rec.No);
            //                 if EvalTrainNeeds.FindSet then begin
            //                     repeat
            //                         message('%1', EvalTrainNeeds."Perfomance Evaluation No");
            //                         message('Need No %1', EvalTrainNeeds."Training Need Number");
            //                         TrnNeedReq1.Reset;
            //                         if TrnNeedReq1.FindLast() then
            //                             i := TrnNeedReq1."Entry No.";
            //                         TrnNeedReq.Init;
            //                         TrnNeedReq."Entry No." := i + 1;
            //                         TrnNeedReq."Course ID" := EvalTrainNeeds.Course;
            //                         TrnNeedReq.validate("Course ID");
            //                         //TrnNeedReq.Description := EvalTrainNeeds.Description;
            //                         TrnNeedReq."Reason for Training" := TrnNeedReq."Reason for Training"::"Performance Gap";
            //                         TrnNeedReq.Comments := EvalTrainNeeds."Supervisor's Comments";
            //                         TrnNeedReq."Training Header No." := TrnNeedHeader.Code;
            //                         if TrnNeedReq.insert = true then
            //                             Message('%1', TrnNeedReq."Entry No.");
            //                     until EvalTrainNeeds.Next() = 0;
            //                 end;

            //             end;
            //             Message('Successfully created Training Needs Request %1', TrnNeedHeader.Code);
            //         end;
            //     end;
            // }
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

