
Page 52211722 "Standard Perform Appraisal"
{
    PageType = Card;
    SourceTable = "Performance Evaluation";
    RefreshOnActivate = true;
    PopulateAllFields = true;
    PromotedActionCategories = 'Home,Process,Report,Approvals,Print';
    SourceTableView = where("Document Type" = const("Performance Appraisal"),
                            "Document Status" = const(Draft));
    layout
    {
        area(content)
        {
            group(General)
            {
                group("Section 1")
                {
                    field("Review Period"; Rec."Review Period")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Personal No."; Rec."Employee No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Name; Rec."Employee Name")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Department; Rec.Department)
                    {
                        ApplicationArea = Basic;
                    }
                    // field(Department; Rec.Division)
                    // {
                    //     ApplicationArea = Basic;
                    // }
                    field("Work Station"; Rec."Work Station")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Current Designation"; Rec."Current Designation")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Terms of Service"; Rec."Employement Terms")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Length of Service"; Rec."Length of Service")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Job Group"; Rec."Job Group")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Salary Scale"; Rec."Salary Scale")
                    {
                        ApplicationArea = Basic;
                    }


                }



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
                field("Second Immediate Supervisor No."; Rec."Second Immediate Supervisor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Second Immediate Supervisor Name"; Rec."Second Immediate Supervisor Name")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Departmental Objectives ID"; Rec."Departmental Objectives ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Competency Template ID"; Rec."Competency Template ID")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                    Visible = false;
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
                    Visible = false;
                }
                field("Competency Weight %"; Rec."Competency Weight %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total Weight %"; Rec."Total Weight %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Objectives & Outcomes Score"; Rec."Objectives & Outcomes Score")
                {
                    ApplicationArea = All;
                }
                field("Competency Score"; Rec."Competency Score")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Final Score"; Rec."Final Score")
                {
                    ApplicationArea = All;
                }
                field("Performance Rating Scale"; Rec."Performance Rating Scale")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Proficiency Rating Scale"; Rec."Proficiency Rating Scale")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Behavioural Competencies';
                    Visible = false;
                }

                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Evaluation Stage"; Rec."Evaluation Stage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the current evaluation pipeline stage.';
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
                    Visible = false;
                }
            }
            // part(Objectives; "Departmental Objectives")
            // {
            //     SubPageLink = "Department Code" = field(Department), "Appraisal Period" = field("Review Period");
            //     UpdatePropagation = Both;
            //     Editable =false;
            // }
            // part("Department Objectives"; "Strategy Workplan Lines")
            // {
            //     Caption = 'Department Objectives';
            //     SubPageLink = "Primary Department" = field(Department), "Strategy Plan ID" = field("Strategy Plan ID");
            //     UpdatePropagation = Both;
            //     Editable =false;
            // }
            part("Department Objectives"; "AppraisalDept.ObjectivesSF")
            {
                Caption = 'Department Objectives';
                SubPageLink = "Document No." = field(No), "Primary Department" = field(Department), "Appraisal Period" = field("Review Period");
                UpdatePropagation = Both;
                Editable = false;
                // Visible = false;
            }
            part("MidYear Appraisal"; NewAndChangedApprTargets)
            {
                Caption = 'Mid-Year Performance Appraisal';
                SubPageLink = "Document No." = field(No);
                UpdatePropagation = Both;
            }
            part("Objectives and Outcomes"; "Objectives and Outcomes")
            {
                SubPageLink = "Performance Evaluation ID" = field(No);
                UpdatePropagation = Both;
                // Editable =false;
            }
            part("Core Values Assessment"; "Values Evaluation Results")
            {
                Caption = 'Core Values Assessment (40%)';
                SubPageLink = "Performance Evaluation ID" = field(No);
                UpdatePropagation = Both;
            }
            part(Control39; "Proficiency Evalulation")
            {
                SubPageLink = "Performance Evaluation ID" = field(No);
                Caption = 'Behavioural Competencies';
                Visible = false;
                UpdatePropagation = Both;
            }
            group("&Recommendation Reward/Sanctions")
            {
                Caption = 'Recommendations Of Rewards Or Sanctions';
                Visible = false;
                field("Recommendation Type"; Rec."Recommendation Type")
                {
                    ApplicationArea = Basic;
                }
                field(RecommendationsOfRewardsOrSanctions; RecommendationsOfRewardsOrSanctions)
                {
                    ApplicationArea = Basic, Suite;
                    // Importance = Additional;
                    MultiLine = true;
                    // ShowCaption = false;
                    Caption = 'Recommendations';

                    trigger OnValidate()
                    begin
                        Rec.SetRecommendationOfRewardOrSanction(RecommendationsOfRewardsOrSanctions);
                    end;
                }
            }
            part("Additional Targets"; "Additional Targets")
            {
                SubPageLink = Code = field(No);
                ApplicationArea = Basic, Suite;
            }
            part("Evaluation Improvement Plan"; "Evaluation Improvement Plan")
            {
                Caption = 'Performance Improvement Plan';
                Visible = false;
                SubPageLink = "Perfomance Evaluation No" = field(No);
                UpdatePropagation = Both;
            }
            group("&PIP Comments")
            {
                Caption = 'PIP Comments & Review';
                Visible = false;
                field(PIPSupervisorComments; PIPSupervisorComments)
                {
                    ApplicationArea = Basic, Suite;
                    // Importance = Additional;
                    MultiLine = true;
                    // ShowCaption = false;
                    Caption = 'PIP Supervisor Comments';

                    trigger OnValidate()
                    begin
                        Rec.SetPIPSupervisorComments(PIPSupervisorComments);
                    end;
                }

                field(PIPEmployeeComments; PIPEmployeeComments)
                {
                    ApplicationArea = Basic, Suite;
                    // Importance = Additional;
                    MultiLine = true;
                    // ShowCaption = false;
                    Caption = 'PIP Employee Comments';

                    trigger OnValidate()
                    begin
                        Rec.SetPIPEmployeeComments(PIPEmployeeComments);
                    end;
                }

                field(PIPFinalReview; PIPFinalReview)
                {
                    ApplicationArea = Basic, Suite;
                    // Importance = Additional;
                    MultiLine = true;
                    // ShowCaption = false;
                    Caption = 'PIP Final Review';

                    trigger OnValidate()
                    begin
                        Rec.SetPIPFinalReview(PIPFinalReview);
                    end;
                }
            }
            // group("&PIP Employee Comments")
            // {
            //     Caption = 'PIP Employee Comments';

            // }
            // group("&PIP Final Review")
            // {
            //     Caption = 'PIP Final Review';

            // }
            part(Control47; "Evaluation Training Needs")
            {
                SubPageLink = "Perfomance Evaluation No" = field(No);
                Visible = false;
            }
        }
        area(factboxes)
        {
            // part(Attachments; "Sharepoint File List")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Attachments';
            //     SubPageLink = "No." = FIELD(No);
            // }
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
        area(processing)
        {
            action("Submit for Self-Assessment")
            {
                ApplicationArea = Basic;
                Caption = 'Submit for Self-Assessment';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Move this evaluation to the Employee Self-Assessment stage.';

                trigger OnAction()
                begin
                    Rec.TestField("Employee No.");
                    Rec.TestField("Personal Scorecard ID");
                    if Rec."Evaluation Stage" <> Rec."evaluation stage"::Draft then
                        Error('Evaluation must be in Draft stage to submit for Self-Assessment.');
                    Rec."Evaluation Stage" := Rec."evaluation stage"::"Employee Self-Assessment";
                    Rec.Modify(true);
                    Message('Evaluation moved to Employee Self-Assessment stage.');
                end;
            }
            action("Submit for Manager Review")
            {
                ApplicationArea = Basic;
                Caption = 'Submit for Manager Evaluation';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Submit the employee self-assessment to the manager for rating.';

                trigger OnAction()
                begin
                    if Rec."Evaluation Stage" <> Rec."evaluation stage"::"Employee Self-Assessment" then
                        Error('Evaluation must be in Employee Self-Assessment stage.');
                    Rec."Evaluation Stage" := Rec."evaluation stage"::"Manager Evaluation";
                    Rec.Modify(true);
                    Message('Evaluation submitted for Manager Evaluation.');
                end;
            }
            action("Submit for HR Review")
            {
                ApplicationArea = Basic;
                Caption = 'Submit for HR Review';
                Image = Release;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Submit the manager-rated evaluation to HR for review.';

                trigger OnAction()
                begin
                    if Rec."Evaluation Stage" <> Rec."evaluation stage"::"Manager Evaluation" then
                        Error('Evaluation must be in Manager Evaluation stage.');
                    Rec."Evaluation Stage" := Rec."evaluation stage"::"HR Review";
                    Rec."HR Review Date" := Today;
                    Rec."HR Reviewer No." := CopyStr(UserId(), 1, 50);
                    Rec.Modify(true);
                    Message('Evaluation submitted for HR Review.');
                end;
            }
            action("Open Calibration")
            {
                ApplicationArea = Basic;
                Caption = 'Open Calibration';
                Image = Adjust;
                ToolTip = 'Move the evaluation into the Calibration stage — ratings are locked during the calibration window.';

                trigger OnAction()
                begin
                    if Rec."Evaluation Stage" <> Rec."evaluation stage"::"HR Review" then
                        Error('Evaluation must be in HR Review stage to open Calibration.');
                    Rec."Evaluation Stage" := Rec."evaluation stage"::Calibration;
                    Rec.Modify(true);
                    Message('Evaluation moved to Calibration stage. Ratings are now locked during the calibration window.');
                end;
            }
            action("Final Approve")
            {
                ApplicationArea = Basic;
                Caption = 'Final Approve';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Final-approve the evaluation. If final score is below 100%, a PIP will be auto-created.';

                trigger OnAction()
                var
                    StrategicPlanning: Codeunit "Strategic Planning";
                begin
                    if Rec."Evaluation Stage" <> Rec."evaluation stage"::Calibration then
                        Error('Evaluation must be in Calibration stage to Final Approve.');
                    Rec."Evaluation Stage" := Rec."evaluation stage"::"Final Approved";
                    Rec."Final Approval Date" := Today;
                    Rec."Final Approved By" := CopyStr(UserId(), 1, 50);
                    Rec.Modify(true);

                    // Auto-trigger PIP if final score < 100% (Developing or Expected Impact)
                    Rec.GetFinalScore(Rec);
                    if Rec."Final Score" < 100 then
                        StrategicPlanning.AutoCreatePIPFromEvaluation(Rec.No);

                    Message('Evaluation has been Final Approved.');
                end;
            }
            action("Acknowledge (Employee)")
            {
                ApplicationArea = Basic;
                Caption = 'Acknowledge (Employee)';
                Image = Confirm;
                ToolTip = 'Employee acknowledges receipt and review of the final evaluation result.';

                trigger OnAction()
                begin
                    if Rec."Evaluation Stage" <> Rec."evaluation stage"::"Final Approved" then
                        Error('Acknowledgment is only allowed after Final Approval.');
                    Rec."Employee Confirm" := true;
                    Rec."Employee Acknowledgment Date" := Today;
                    Rec.Modify(true);
                    Message('Employee acknowledgment recorded on %1.', Today);
                end;
            }
            action("Acknowledge (Supervisor)")
            {
                ApplicationArea = Basic;
                Caption = 'Acknowledge (Supervisor)';
                Image = Confirm;
                ToolTip = 'Supervisor acknowledges the final evaluation result.';

                trigger OnAction()
                begin
                    if Rec."Evaluation Stage" <> Rec."evaluation stage"::"Final Approved" then
                        Error('Acknowledgment is only allowed after Final Approval.');
                    Rec."Supervisor Confirm" := true;
                    Rec."Supervisor Acknowledgment Date" := Today;
                    Rec.Modify(true);
                    Message('Supervisor acknowledgment recorded on %1.', Today);
                end;
            }
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

                trigger OnAction()
                var
                    MidYearPerformance: Record NewAndChangedApprTargets;
                begin
                    if not Confirm('Are you sure you want to Suggest Objectives & Outcomes?', true) then
                        Error('Objectives & Outcomes not Suggested');

                    ObjectiveOutcome.Reset();
                    ObjectiveOutcome.SetRange("Performance Evaluation ID", Rec.No);
                    if ObjectiveOutcome.FindSet then
                        ObjectiveOutcome.DeleteAll();

                    MidYearPerformance.Reset();
                    MidYearPerformance.SetRange("Document No.", Rec.No);
                    if MidYearPerformance.FindSet then
                        MidYearPerformance.DeleteAll();

                    SPMGeneralSetup.Get;
                    SPMGeneralSetup.TestField("Appraisal Based On");

                    if SPMGeneralSetup."Appraisal Based On" = SPMGeneralSetup."appraisal based on"::"Direct Input" then begin
                        SPMGeneralSetup.Get();
                        if (SPMGeneralSetup."Allow Loading of  CSP" = true) then begin
                            PCObjective.Reset;
                            PCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            if PCObjective.FindFirst then begin
                                repeat
                                    PCObjective.TestField("Due Date");
                                until PCObjective.Next = 0;
                            end;

                            PCObjective.Reset;
                            PCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            PCObjective.TestField("Due Date");
                            PCObjective.SetRange("Due Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                            if PCObjective.FindSet() then begin
                                repeat
                                    ObjectiveOutcome.Init;
                                    ObjectiveOutcome."Performance Evaluation ID" := Rec.No;
                                    ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                                    ObjectiveOutcome."Scorecard ID" := PCObjective."Workplan No.";
                                    ObjectiveOutcome."Intiative No" := PCObjective."Initiative No.";
                                    ObjectiveOutcome."Objective/Initiative" := PCObjective."Objective/Initiative";
                                    ObjectiveOutcome."Departmental Objective" := PCObjective."Departmental Objective";
                                    ObjectiveOutcome."Primary Department" := Rec.Department;
                                    // ObjectiveOutcome."Primary Division" := Rec.Division;
                                    ObjectiveOutcome."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                                    ObjectiveOutcome."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                                    ObjectiveOutcome."Performance Indicator" := PCObjective."Performance Indicator";
                                    ObjectiveOutcome."Unit of Measure" := PCObjective."Unit of Measure";
                                    ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                                    ObjectiveOutcome."Target Qty" := PCObjective."Imported Annual Target Qty";
                                    ObjectiveOutcome."Performance Rating Scale" := Rec."Performance Rating Scale";
                                    ObjectiveOutcome.Validate("Performance Rating Scale");
                                    ObjectiveOutcome."Desired Perfomance Direction" := PCObjective."Desired Perfomance Direction";
                                    ObjectiveOutcome."Weight %" := PCObjective."Assigned Weight (%)";
                                    if ObjectiveOutcome.Insert(true) then begin
                                        MidYearPerformance.Init();
                                        MidYearPerformance."Document No." := ObjectiveOutcome."Performance Evaluation ID";
                                        MidYearPerformance."Line No." := FnGetLastLineNoMidY + 1;
                                        MidYearPerformance."Objective/Initiative" := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance."Target Qty" := ObjectiveOutcome."Target Qty";
                                        MidYearPerformance.Target := ObjectiveOutcome."Key Performance Indicator";
                                        MidYearPerformance.Insert(true);
                                    end;
                                    //Sub Objective OutCome
                                    SubPCObjective.Reset;
                                    SubPCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                                    SubPCObjective.SetRange("Initiative No.", PCObjective."Initiative No.");
                                    if SubPCObjective.FindSet then begin
                                        repeat
                                            SubObjectiveEvaluation.Init;
                                            SubObjectiveEvaluation."Performance Evaluation ID" := Rec.No;
                                            SubObjectiveEvaluation."Line No" := FnGetLastSubPcLineNo + 1;
                                            SubObjectiveEvaluation."Scorecard ID" := PCObjective."Workplan No.";
                                            SubObjectiveEvaluation."Intiative No" := PCObjective."Initiative No.";
                                            SubObjectiveEvaluation."Objective/Initiative" := PCObjective."Objective/Initiative";
                                            SubObjectiveEvaluation."Sub Intiative No" := SubPCObjective."Sub Initiative No.";
                                            SubObjectiveEvaluation."Sub Intiative Description" := SubPCObjective."Objective/Initiative";
                                            SubObjectiveEvaluation."Primary Department" := Rec.Department;
                                            // SubObjectiveEvaluation."Primary Division" := Rec.Division;
                                            SubObjectiveEvaluation."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                                            SubObjectiveEvaluation."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                                            SubObjectiveEvaluation."Performance Indicator" := PCObjective."Performance Indicator";
                                            SubObjectiveEvaluation."Unit of Measure" := PCObjective."Unit of Measure";
                                            SubObjectiveEvaluation.Validate("Outcome Perfomance Indicator");
                                            SubObjectiveEvaluation."Target Qty" := PCObjective."Imported Annual Target Qty";
                                            SubObjectiveEvaluation."Performance Rating Scale" := Rec."Performance Rating Scale";
                                            SubObjectiveEvaluation.Validate("Performance Rating Scale");
                                            SubObjectiveEvaluation."Desired Perfomance Direction" := PCObjective."Desired Perfomance Direction";
                                            SubObjectiveEvaluation."Weight %" := SubPCObjective."Assigned Weight (%)";
                                            SubObjectiveEvaluation.Insert(true);

                                        until SubPCObjective.Next = 0;
                                    end;
                                //End Sub Objective OutCome
                                until PCObjective.Next = 0;
                            end;

                            SecondaryPCObjective.Reset;
                            SecondaryPCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            if SecondaryPCObjective.FindFirst then begin
                                repeat
                                //SecondaryPCObjective.TESTFIELD("Due Date");
                                until SecondaryPCObjective.Next = 0;
                            end;

                            SecondaryPCObjective.Reset;
                            SecondaryPCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            SecondaryPCObjective.SetRange("Due Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                            if SecondaryPCObjective.FindSet then begin
                                repeat
                                    ObjectiveOutcome.Init;
                                    ObjectiveOutcome."Performance Evaluation ID" := Rec.No;
                                    ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                                    ObjectiveOutcome."Scorecard ID" := SecondaryPCObjective."Workplan No.";
                                    ObjectiveOutcome."Intiative No" := SecondaryPCObjective."Initiative No.";
                                    ObjectiveOutcome."Objective/Initiative" := SecondaryPCObjective."Objective/Initiative";
                                    ObjectiveOutcome."Primary Department" := Rec.Department;
                                    // ObjectiveOutcome."Primary Division" := Rec.Division;
                                    ObjectiveOutcome."Outcome Perfomance Indicator" := SecondaryPCObjective."Outcome Perfomance Indicator";
                                    ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                                    ObjectiveOutcome."Target Qty" := SecondaryPCObjective."Imported Annual Target Qty";
                                    ObjectiveOutcome."Performance Rating Scale" := Rec."Performance Rating Scale";
                                    ObjectiveOutcome.Validate("Performance Rating Scale");
                                    ObjectiveOutcome."Desired Perfomance Direction" := SecondaryPCObjective."Desired Perfomance Direction";
                                    ObjectiveOutcome."Weight %" := SecondaryPCObjective."Assigned Weight (%)";
                                    if ObjectiveOutcome.Insert(true) then begin
                                        MidYearPerformance.Init();
                                        MidYearPerformance."Document No." := ObjectiveOutcome."Performance Evaluation ID";
                                        MidYearPerformance."Line No." := FnGetLastLineNoMidY + 1;
                                        MidYearPerformance."Objective/Initiative" := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance."Target Qty" := ObjectiveOutcome."Target Qty";
                                        MidYearPerformance.Target := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance.Insert(true);
                                    end;
                                    //Insert Sub Objective Outcome
                                    //Sub Objective OutCome
                                    SubPCObjective.Reset;
                                    SubPCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                                    SubPCObjective.SetRange("Initiative No.", SecondaryPCObjective."Initiative No.");
                                    if SubPCObjective.FindSet then begin
                                        repeat
                                            SubObjectiveEvaluation.Init;
                                            SubObjectiveEvaluation."Performance Evaluation ID" := Rec.No;
                                            SubObjectiveEvaluation."Line No" := FnGetLastSubPcLineNo + 1;
                                            SubObjectiveEvaluation."Scorecard ID" := SecondaryPCObjective."Workplan No.";
                                            SubObjectiveEvaluation."Intiative No" := SecondaryPCObjective."Initiative No.";
                                            SubObjectiveEvaluation."Objective/Initiative" := SecondaryPCObjective."Objective/Initiative";
                                            SubObjectiveEvaluation."Sub Intiative No" := SubPCObjective."Sub Initiative No.";
                                            SubObjectiveEvaluation."Sub Intiative Description" := SubPCObjective."Objective/Initiative";
                                            SubObjectiveEvaluation."Primary Department" := Rec.Department;
                                            // SubObjectiveEvaluation."Primary Division" := Rec.Division;
                                            SubObjectiveEvaluation."Outcome Perfomance Indicator" := SecondaryPCObjective."Outcome Perfomance Indicator";
                                            SubObjectiveEvaluation."Key Performance Indicator" := SecondaryPCObjective."Outcome Perfomance Indicator";
                                            SubObjectiveEvaluation.Validate("Outcome Perfomance Indicator");
                                            SubObjectiveEvaluation."Target Qty" := PCObjective."Imported Annual Target Qty";
                                            SubObjectiveEvaluation."Performance Rating Scale" := Rec."Performance Rating Scale";
                                            SubObjectiveEvaluation.Validate("Performance Rating Scale");
                                            SubObjectiveEvaluation."Desired Perfomance Direction" := SecondaryPCObjective."Desired Perfomance Direction";
                                            SubObjectiveEvaluation."Weight %" := SubPCObjective."Assigned Weight (%)";
                                            SubObjectiveEvaluation.Insert(true);

                                        until SubPCObjective.Next = 0;
                                    end;
                                //End Sub Objective OutCome
                                //End Insert Sub Objective Outcome

                                until SecondaryPCObjective.Next = 0;
                            end;
                        end;

                        if (SPMGeneralSetup."Allow Loading of JD" = true) then begin
                            PCJobDescription.Reset;
                            PCJobDescription.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            //  PCJobDescription.SetRange("Due Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                            if PCJobDescription.FindSet then begin
                                repeat
                                    ObjectiveOutcome.Init;
                                    ObjectiveOutcome."Performance Evaluation ID" := Rec.No;
                                    ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                                    ObjectiveOutcome."Scorecard ID" := PCJobDescription."Workplan No.";
                                    ObjectiveOutcome."Intiative No" := Format(PCJobDescription."Line Number");
                                    ObjectiveOutcome."Objective/Initiative" := PCJobDescription.Description;
                                    ObjectiveOutcome."Primary Department" := Rec.Department;
                                    // ObjectiveOutcome."Primary Division" := Rec.Division;
                                    ObjectiveOutcome."Outcome Perfomance Indicator" := PCJobDescription."Outcome Perfomance Indicator";
                                    ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                                    ObjectiveOutcome."Target Qty" := PCJobDescription."Imported Annual Target Qty";
                                    ObjectiveOutcome."Performance Rating Scale" := Rec."Performance Rating Scale";
                                    ObjectiveOutcome.Validate("Performance Rating Scale");
                                    ObjectiveOutcome."Desired Perfomance Direction" := PCJobDescription."Desired Perfomance Direction";
                                    ObjectiveOutcome."Weight %" := PCJobDescription."Assigned Weight (%)";
                                    if ObjectiveOutcome.Insert(true) then begin
                                        MidYearPerformance.Init();
                                        MidYearPerformance."Document No." := ObjectiveOutcome."Performance Evaluation ID";
                                        MidYearPerformance."Line No." := FnGetLastLineNoMidY + 1;
                                        MidYearPerformance."Objective/Initiative" := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance."Target Qty" := ObjectiveOutcome."Target Qty";
                                        MidYearPerformance.Target := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance.Insert(true);
                                    end;
                                until PCJobDescription.Next = 0;
                            end;
                        end;
                    end;

                    if SPMGeneralSetup."Appraisal Based On" = SPMGeneralSetup."appraisal based on"::"Plog Input" then begin
                        SPMGeneralSetup.Get();
                        if (SPMGeneralSetup."Allow Loading of  CSP" = true) then begin
                            PCObjective.Reset;
                            PCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            if PCObjective.FindSet then begin
                                repeat
                                    PCObjective.TestField("Due Date");
                                until PCObjective.Next = 0;
                            end;

                            PCObjective.Reset;
                            PCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            //PCObjective.TESTFIELD("Due Date");
                            PCObjective.SetRange("Due Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                            if PCObjective.FindSet then begin
                                repeat

                                    AchievedTarget := 0;
                                    PlogLines.Reset;
                                    PlogLines.SetRange("Personal Scorecard ID", PCObjective."Workplan No.");
                                    PlogLines.SetRange("Initiative No.", PCObjective."Initiative No.");
                                    PlogLines.SetRange("Achieved Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                                    PlogLines.CalcSums("Achieved Target");
                                    AchievedTarget := PlogLines."Achieved Target";

                                    /* IF AchievedTarget=0 THEN
                                        ERROR('Performance Logs for Appraisal of Period  %1 and to %2 must be Updated first',"Evaluation Start Date","Evaluation End Date");*/

                                    ObjectiveOutcome.Init;
                                    ObjectiveOutcome."Performance Evaluation ID" := Rec.No;
                                    ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                                    ObjectiveOutcome."Scorecard ID" := PCObjective."Workplan No.";
                                    ObjectiveOutcome."Intiative No" := PCObjective."Initiative No.";
                                    ObjectiveOutcome."Objective/Initiative" := PCObjective."Objective/Initiative";
                                    ObjectiveOutcome."Primary Department" := Rec.Department;
                                    // ObjectiveOutcome."Primary Division" := Rec.Division;
                                    ObjectiveOutcome."Departmental Objective" := PCObjective."Departmental Objective";
                                    ObjectiveOutcome."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                                    ObjectiveOutcome."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                                    ObjectiveOutcome."Performance Indicator" := PCObjective."Performance Indicator";
                                    ObjectiveOutcome."Unit of Measure" := PCObjective."Unit of Measure";
                                    ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                                    ObjectiveOutcome."Performance Rating Scale" := Rec."Performance Rating Scale";
                                    ObjectiveOutcome.Validate("Performance Rating Scale");
                                    ObjectiveOutcome."Desired Perfomance Direction" := PCObjective."Desired Perfomance Direction";
                                    ObjectiveOutcome."Weight %" := PCObjective."Assigned Weight (%)";
                                    ObjectiveOutcome."Target Qty" := PCObjective."Imported Annual Target Qty";
                                    ObjectiveOutcome."Self-Review Qty" := AchievedTarget;
                                    ObjectiveOutcome."AppraiserReview Qty" := AchievedTarget;
                                    ObjectiveOutcome."Final/Actual Qty" := AchievedTarget;
                                    ObjectiveOutcome.Validate("Final/Actual Qty");
                                    if ObjectiveOutcome.Insert(true) then begin
                                        MidYearPerformance.Init();
                                        MidYearPerformance."Document No." := ObjectiveOutcome."Performance Evaluation ID";
                                        MidYearPerformance."Line No." := FnGetLastLineNoMidY + 1;
                                        MidYearPerformance."Objective/Initiative" := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance."Target Qty" := ObjectiveOutcome."Target Qty";
                                        MidYearPerformance.Target := ObjectiveOutcome."Key Performance Indicator";
                                        MidYearPerformance.Insert(true);
                                    end;

                                    //Sub Objective OutCome
                                    AchievedSubActivityTarget := 0;
                                    SubPlogLines.Reset;
                                    SubPlogLines.SetRange("Personal Scorecard ID", PCObjective."Workplan No.");
                                    SubPlogLines.SetRange("Initiative No.", PCObjective."Initiative No.");
                                    SubPlogLines.SetRange("Achieved Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                                    SubPlogLines.CalcSums("Achieved Target");
                                    AchievedTarget := PlogLines."Achieved Target";

                                    SubPCObjective.Reset;
                                    SubPCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                                    SubPCObjective.SetRange("Initiative No.", PCObjective."Initiative No.");
                                    if SubPCObjective.FindSet then begin
                                        repeat
                                            SubObjectiveEvaluation.Init;
                                            SubObjectiveEvaluation."Performance Evaluation ID" := Rec.No;
                                            SubObjectiveEvaluation."Line No" := FnGetLastSubPcLineNo + 1;
                                            SubObjectiveEvaluation."Scorecard ID" := SubPCObjective."Workplan No.";
                                            SubObjectiveEvaluation."Intiative No" := SubPCObjective."Initiative No.";
                                            SubObjectiveEvaluation."Objective/Initiative" := SubPCObjective."Objective/Initiative";
                                            SubObjectiveEvaluation."Sub Intiative No" := SubPCObjective."Sub Initiative No.";
                                            SubObjectiveEvaluation."Sub Intiative Description" := SubPCObjective."Objective/Initiative";
                                            SubObjectiveEvaluation."Primary Department" := Rec.Department;
                                            // SubObjectiveEvaluation."Primary Division" := Rec.Division;
                                            SubObjectiveEvaluation."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                                            SubObjectiveEvaluation."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                                            SubObjectiveEvaluation.Validate("Outcome Perfomance Indicator");
                                            SubObjectiveEvaluation."Target Qty" := SubPCObjective."Sub Targets";
                                            SubObjectiveEvaluation."Self-Review Qty" := AchievedSubActivityTarget;
                                            SubObjectiveEvaluation."AppraiserReview Qty" := AchievedSubActivityTarget;
                                            SubObjectiveEvaluation."Final/Actual Qty" := AchievedSubActivityTarget;
                                            SubObjectiveEvaluation.Validate("Final/Actual Qty");
                                            SubObjectiveEvaluation."Performance Rating Scale" := Rec."Performance Rating Scale";
                                            SubObjectiveEvaluation.Validate("Performance Rating Scale");
                                            SubObjectiveEvaluation."Desired Perfomance Direction" := PCObjective."Desired Perfomance Direction";
                                            SubObjectiveEvaluation."Weight %" := SubPCObjective."Assigned Weight (%)";
                                            SubObjectiveEvaluation.Insert(true);

                                        until SubPCObjective.Next = 0;
                                    end;
                                //End Sub Objective OutCome


                                until PCObjective.Next = 0;
                            end;

                            SecondaryPCObjective.Reset;
                            SecondaryPCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            if SecondaryPCObjective.FindFirst then begin
                                repeat
                                //SecondaryPCObjective.TESTFIELD("Due Date");
                                until SecondaryPCObjective.Next = 0;
                            end;

                            SecondaryPCObjective.Reset;
                            SecondaryPCObjective.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            SecondaryPCObjective.SetRange("Due Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                            if SecondaryPCObjective.FindFirst then begin
                                repeat
                                    AchievedTarget := 0;
                                    PlogLines.Reset;
                                    PlogLines.SetRange("Personal Scorecard ID", SecondaryPCObjective."Workplan No.");
                                    PlogLines.SetRange("Initiative No.", SecondaryPCObjective."Initiative No.");
                                    PlogLines.SetRange("Achieved Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                                    PlogLines.CalcSums("Achieved Target");
                                    AchievedTarget := PlogLines."Achieved Target";

                                    /* IF AchievedTarget=0 THEN
                                        ERROR('Performance Logs for Appraisal of Period  %1 and to %2 must be Updated first',"Evaluation Start Date","Evaluation End Date"); */


                                    ObjectiveOutcome.Init;
                                    ObjectiveOutcome."Performance Evaluation ID" := Rec.No;
                                    ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                                    ObjectiveOutcome."Scorecard ID" := SecondaryPCObjective."Workplan No.";
                                    ObjectiveOutcome."Intiative No" := SecondaryPCObjective."Initiative No.";
                                    ObjectiveOutcome."Objective/Initiative" := SecondaryPCObjective."Objective/Initiative";
                                    ObjectiveOutcome."Primary Department" := Rec.Department;
                                    // ObjectiveOutcome."Primary Division" := Rec.Division;
                                    ObjectiveOutcome."Outcome Perfomance Indicator" := SecondaryPCObjective."Outcome Perfomance Indicator";
                                    ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                                    ObjectiveOutcome."Target Qty" := SecondaryPCObjective."Imported Annual Target Qty";
                                    ObjectiveOutcome."Performance Rating Scale" := Rec."Performance Rating Scale";
                                    ObjectiveOutcome.Validate("Performance Rating Scale");
                                    ObjectiveOutcome."Self-Review Qty" := AchievedTarget;
                                    ObjectiveOutcome."AppraiserReview Qty" := AchievedTarget;
                                    ObjectiveOutcome."Final/Actual Qty" := AchievedTarget;
                                    ObjectiveOutcome."Desired Perfomance Direction" := SecondaryPCObjective."Desired Perfomance Direction";
                                    ObjectiveOutcome."Weight %" := SecondaryPCObjective."Assigned Weight (%)";
                                    if ObjectiveOutcome.Insert(true) then begin
                                        MidYearPerformance.Init();
                                        MidYearPerformance."Document No." := ObjectiveOutcome."Performance Evaluation ID";
                                        MidYearPerformance."Line No." := FnGetLastLineNoMidY + 1;
                                        MidYearPerformance."Objective/Initiative" := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance."Target Qty" := ObjectiveOutcome."Target Qty";
                                        MidYearPerformance.Target := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance.Insert(true);
                                    end;
                                until SecondaryPCObjective.Next = 0;
                            end;
                        end;
                        if (SPMGeneralSetup."Allow Loading of JD" = true) then begin
                            PCJobDescription.Reset;
                            PCJobDescription.SetRange("Workplan No.", Rec."Personal Scorecard ID");
                            PCJobDescription.SetRange("Due Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                            if PCJobDescription.FindFirst then begin
                                repeat
                                    AchievedTarget := 0;
                                    PlogLines.Reset;
                                    PlogLines.SetRange("Personal Scorecard ID", PCJobDescription."Workplan No.");
                                    PlogLines.SetRange("Initiative No.", Format(PCJobDescription."Line Number"));
                                    PlogLines.SetRange("Achieved Date", Rec."Evaluation Start Date", Rec."Evaluation End Date");
                                    PlogLines.CalcSums("Achieved Target");
                                    AchievedTarget := PlogLines."Achieved Target";

                                    /*IF AchievedTarget=0 THEN
                                       ERROR('Performance Logs for Appraisal of Period  %1 and to %2 must be Updated first',"Evaluation Start Date","Evaluation End Date"); */

                                    ObjectiveOutcome.Init;
                                    ObjectiveOutcome."Performance Evaluation ID" := Rec.No;
                                    ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                                    ObjectiveOutcome."Scorecard ID" := PCJobDescription."Workplan No.";
                                    ObjectiveOutcome."Intiative No" := Format(PCJobDescription."Line Number");
                                    ObjectiveOutcome."Objective/Initiative" := PCJobDescription.Description;
                                    ObjectiveOutcome."Primary Department" := Rec.Department;
                                    // ObjectiveOutcome."Primary Division" := Rec.Division;
                                    ObjectiveOutcome."Outcome Perfomance Indicator" := PCJobDescription."Outcome Perfomance Indicator";
                                    ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                                    ObjectiveOutcome."Target Qty" := PCJobDescription."Imported Annual Target Qty";
                                    ObjectiveOutcome."Performance Rating Scale" := Rec."Performance Rating Scale";
                                    ObjectiveOutcome."Desired Perfomance Direction" := PCJobDescription."Desired Perfomance Direction";
                                    ObjectiveOutcome.Validate("Performance Rating Scale");
                                    ObjectiveOutcome."Weight %" := PCJobDescription."Assigned Weight (%)";
                                    ObjectiveOutcome."Self-Review Qty" := AchievedTarget;
                                    ObjectiveOutcome."AppraiserReview Qty" := AchievedTarget;
                                    ObjectiveOutcome."Final/Actual Qty" := AchievedTarget;
                                    ObjectiveOutcome.Validate("Final/Actual Qty");
                                    if ObjectiveOutcome.Insert(true) then begin
                                        MidYearPerformance.Init();
                                        MidYearPerformance."Document No." := ObjectiveOutcome."Performance Evaluation ID";
                                        MidYearPerformance."Line No." := FnGetLastLineNoMidY + 1;
                                        MidYearPerformance."Objective/Initiative" := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance."Target Qty" := ObjectiveOutcome."Target Qty";
                                        MidYearPerformance.Target := ObjectiveOutcome."Objective/Initiative";
                                        MidYearPerformance.Insert(true);
                                    end;
                                until PCJobDescription.Next = 0;
                            end;
                        end;
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
                Visible = false;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to load Competency Templates', true) then
                        Error('Competency Templates not loaded');

                    ProEvaluation.Reset();
                    ProEvaluation.SetRange("Performance Evaluation ID", Rec.No);
                    if ProEvaluation.FindSet() then
                        ProEvaluation.DeleteAll();

                    CompetencyLines.Reset;
                    CompetencyLines.SetRange("Competency Template ID", Rec."Competency Template ID");
                    //MESSAGE('%1, %2', "Current Grade", CompetencyLines."Job Grade");
                    // CompetencyLines.SetRange("Job Grade", Rec."Current Grade");
                    if CompetencyLines.FindSet() then begin
                        repeat
                            ProEvaluation.Init;
                            ProEvaluation."Performance Evaluation ID" := Rec.No;
                            ProEvaluation."Line No" := FnGetLastLineNoB + 2;
                            ProEvaluation."Competency Template ID" := Rec."Competency Template ID";
                            ProEvaluation."Competency Code" := CompetencyLines."Competency Code";
                            ProEvaluation."Competency Description" := CompetencyLines."Competency Description";
                            ProEvaluation."Competency Category" := CompetencyLines."Competency Category";
                            ProEvaluation."Profiency Rating Scale" := Rec."Proficiency Rating Scale";
                            ProEvaluation."Target Qty" := CompetencyLines."Weight %";
                            ProEvaluation."Weight %" := CompetencyLines."Weight %";
                            ProEvaluation.Insert(true);
                        until CompetencyLines.Next = 0;
                    end;
                    Message('Competency Templates loaded Successfully');
                    /*
                    CompetencyLines.RESET;
                    CompetencyLines.SETRANGE("Competency Template ID","Competency Template ID");
                    IF CompetencyLines.FIND('-') THEN BEGIN
                      REPEAT
                          ProEvaluation.INIT;
                          ProEvaluation."Performance Evaluation ID":=No;
                          ProEvaluation."Line No":=FnGetLastLineNoB+1;
                          ProEvaluation."Competency Template ID":="Competency Template ID";
                          ProEvaluation."Competency Code":=CompetencyLines."Competency Code";
                          ProEvaluation.VALIDATE("Competency Code");
                          ProEvaluation."Competency Category":=CompetencyLines."Competency Category";
                          ProEvaluation.Description:=CompetencyLines.Description;
                          ProEvaluation."Profiency Rating Scale":="Proficiency Rating Scale";
                          ProEvaluation."Target Qty":=CompetencyLines."Weight %";
                          ProEvaluation."Weight %":=CompetencyLines."Weight %";
                          ProEvaluation.INSERT(TRUE);
                        UNTIL CompetencyLines.NEXT=0;
                     END;
                       MESSAGE('Competency Templates loaded Successfully');
                    */

                end;
            }
            separator(Action42)
            {
            }
            action("Print Appraisal Report")
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PEval: Record "Performance Evaluation";
                begin
                    PEval.Reset();
                    PEval.SetRange(No, Rec.No);
                    PEval.SetRange("Review Period", Rec."Review Period");
                    PEval.SetRange("Employee No.", Rec."Employee No.");
                    Report.Run(report::"Standard Performance Appraisal", true, true, PEval);
                end;
            }
            separator(Action40)
            {
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                ToolTip = 'Approve the requested changes.';
                Visible = OpenApprovalEntriesExistForCurrUser;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                ToolTip = 'Reject the approval request.';
                Visible = OpenApprovalEntriesExistForCurrUser;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Delegate)
            {
                ApplicationArea = All;
                Caption = 'Delegate';
                Image = Delegate;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = OpenApprovalEntriesExistForCurrUser;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Comment)
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Image = ViewComments;
                ToolTip = 'View or add comments for the record.';
                Visible = OpenApprovalEntriesExistForCurrUser;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.GetApprovalComment(Rec);
                end;
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
                    Var_Varaint: Variant;
                // CustomApprovalMgt: Codeunit "Custom Approvals Codeunit";
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
                        until ObjectiveOutcome.Next = 0;
                    end;

                    ProEvaluation.Reset;
                    ProEvaluation.SetRange("Performance Evaluation ID", Rec.No);
                    if ProEvaluation.Find('-') then begin
                        repeat
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
                    Var_Varaint := Rec;
                    // if CustomApprovalMgt.CheckApprovalsWorkflowEnabled(Var_Varaint) then
                    //     CustomApprovalMgt.OnSendDocForApproval(Var_Varaint);

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
                // CustomApprovalsMgt: Codeunit "Custom Approvals Codeunit";
                begin
                    Rec.TestField("Approval Status", Rec."approval status"::"Pending Approval");//status must be open.
                                                                                                /*TESTFIELD("Created By",USERID); //control so that only the initiator of the document can send for approval
                                                                                                ApprovalsMgmt.""(Rec);*/
                                                                                                // "Approval Status":="Approval Status"::Open;
                                                                                                // Rec.Modify;
                                                                                                // Message('Document has been Re-Opened');
                    VarVariant := Rec;
                    // CustomApprovalsMgt.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        DocType: Enum "Approval Document Type";
    begin
        // DocType := DocType::"Performance Appraisal";
        // CurrPage.Attachments.Page.Documenttype(DocType, Rec.No);
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."document type"::"Performance Appraisal";
        Rec."Evaluation Type" := Rec."evaluation type"::"Standard Appraisal/Supervisor Score Only";
    end;

    trigger OnOpenPage()
    begin
        Rec."Document Type" := Rec."document type"::"Performance Appraisal";
        Rec."Evaluation Type" := Rec."evaluation type"::"Standard Appraisal/Supervisor Score Only";
        // Rec.GetFinalScore();
        // Rec.Validate("Employee No.");
    end;

    var
        PCObjective: Record "PC Objective";
        ObjectiveOutcome: Record "Objective Evaluation Result";
        CompetencyLines: Record "Competency Template Line";
        ProEvaluation: Record "Proficiency Evaluation Result";
        SPMGeneralSetup: Record "SPM General Setup";
        AchievedTarget: Decimal;
        PlogLines: Record "Plog Lines";
        SecondaryPCObjective: Record "Secondary PC Objective";
        PCJobDescription: Record "PC Job Description";
        SubObjectiveEvaluation: Record "Sub Objective Evaluation";
        SubPCObjective: Record "Sub PC Objective";
        AchievedSubActivityTarget: Decimal;
        SubPlogLines: Record "Sub Plog Lines";
        PIPSupervisorComments: Text;
        PIPEmployeeComments: Text;
        PIPFinalReview: Text;
        RecommendationsOfRewardsOrSanctions: Text;
        ManagerialView: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;

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

    local procedure FnGetLastSubPcLineNo() LineNumber: Integer
    var
        Billable: Record "Sub Objective Evaluation";
    begin
        Billable.Reset;
        if Billable.Find('+') then
            LineNumber := Billable."Line No"
        else
            LineNumber := 1;
        exit(LineNumber);
    end;

    local procedure FnGetLastLineNoMidY() LineNumber: Integer
    var
        MidY: Record NewAndChangedApprTargets;
    begin
        MidY.Reset;
        if MidY.Find('+') then
            LineNumber := MidY."Line No."
        else
            LineNumber := 1;
        exit(LineNumber);
    end;

    procedure SetControlAppearance()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        PIPEmployeeComments := Rec.GetPIPEmployeeComments();
        PIPSupervisorComments := Rec.GetPIPSupervisorComments();
        PIPFinalReview := Rec.GetPIPFinalReview();
        RecommendationsOfRewardsOrSanctions := Rec.GetRecommendationOfRewardOrSanction();
    end;
}


