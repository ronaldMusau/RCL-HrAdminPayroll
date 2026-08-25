#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211732 "Performance Improvement Plan"
{
    PageType = Card;
    Caption = 'Performance Improvement Plan';
    SourceTable = "Performance Improvement Plan";
    PromotedActionCategories = 'New,Process,Report';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the PIP document number.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies whether this is a PIP or a PIP Review.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the date the PIP was created.';
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the performance cycle year.';
                }
                field("PIP Template ID"; Rec."PIP Template ID")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the PIP template used.';
                }
                field("Primary Evaluation ID"; Rec."Primary Evaluation ID")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the performance evaluation that triggered this PIP.';
                }
                field("Original PIP"; Rec."Original PIP")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'For PIP Reviews, specifies the original PIP document.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = ApprovalStyle;
                    ToolTip = 'Specifies the approval status of this PIP.';
                }
                field("PIP Progress Status"; Rec."PIP Progress Status")
                {
                    ApplicationArea = Basic;
                    StyleExpr = ProgressStyle;
                    ToolTip = 'Specifies the overall progress status based on milestone completion. Update this field as milestones are reviewed.';
                }
            }

            group(Employee)
            {
                Caption = 'Employee';

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee on this PIP.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the employee name.';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee job title.';
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee job grade.';
                }
                field("Immediate Supervisor No."; Rec."Immediate Supervisor No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the immediate supervisor responsible for this PIP.';
                }
                field("Immediate Supervisor Name"; Rec."Immediate Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the supervisor name.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee department.';
                }
                field("Personal Scorecard ID"; Rec."Personal Scorecard ID")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the personal scorecard linked to this PIP.';
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the strategic plan period.';
                }
            }

            group(Timeline)
            {
                Caption = 'PIP Timeline';

                field("PIP Start Date"; Rec."PIP Start Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the PIP start date (3–6 month window as per policy).';
                }
                field("PIP End Date"; Rec."PIP End Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the PIP end date.';
                }
                field("Extension Months"; Rec."Extension Months")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies extension months granted for Partial Improvement outcome (max 3 months).';
                }
                field("Last Review Date"; Rec."Last Review Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the date of the last monthly progress review.';
                }
                field("Total Milestones"; Rec."Total Milestones")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Total number of milestones defined for this PIP.';
                }
                field("Completed Milestones"; Rec."Completed Milestones")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Number of milestones marked as Completed.';
                }
            }

            group(Outcome)
            {
                Caption = 'Outcome';

                field("Performance Review Type"; Rec."Performance Review Type")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies whether this is an Interim or Final PIP Review.';
                }
                field("Final PIP Outcome"; Rec."Final PIP Outcome")
                {
                    ApplicationArea = Basic;
                    StyleExpr = OutcomeStyle;
                    ToolTip = 'Specifies the final outcome: Successful Improvement (employee exits PIP), Partial Improvement (extend up to 3 months), or Unsuccessful (escalate to disciplinary action).';
                }
                field("Final PIP Verdict Code"; Rec."Final PIP Verdict Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the verdict code for the PIP outcome.';
                }
            }

            group(Escalation)
            {
                Caption = 'Escalation';

                field("Escalation Level"; Rec."Escalation Level")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the current escalation level based on overdue milestones.';
                }
                field("Last Escalation Date"; Rec."Last Escalation Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies when the last escalation notification was sent.';
                }
            }

            group(Admin)
            {
                Caption = 'Administration';
                Editable = false;

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies who created this PIP.';
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies when this PIP was created.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies an optional description for this PIP.';
                }
                field("Blocked?"; Rec."Blocked?")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies if this PIP record is blocked from further processing.';
                }
            }

            part("Milestones"; "Improvement Plan Line")
            {
                Caption = 'Milestones';
                SubPageLink = "PIP ID" = field(No);
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendForApproval)
            {
                ApplicationArea = Basic;
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec."Approval Status" = Rec."approval status"::Open;
                ToolTip = 'Send this PIP through the approval workflow.';

                trigger OnAction()
                var
                    PerfApprovals: Codeunit "Performance Approvals";
                    Variant: Variant;
                begin
                    Rec.TestField("Employee No.");
                    Rec.TestField("PIP Start Date");
                    Rec.TestField("PIP End Date");
                    if Rec."PIP Start Date" >= Rec."PIP End Date" then
                        Error('PIP End Date must be after PIP Start Date.');
                    Rec.CalcFields("Total Milestones");
                    if Rec."Total Milestones" = 0 then
                        Error('Please add at least one milestone before sending for approval.');
                    if Rec."Total Milestones" > 5 then
                        Error('A PIP may have a maximum of 5 milestones as per policy.');

                    Variant := Rec;
                    PerfApprovals.CheckApprovalsWorkflowEnabled(Variant);
                    PerfApprovals.OnSendDocForApproval(Variant);
                    Rec.Get(Rec.No);
                    CurrPage.Update(false);
                end;
            }
            action(CancelApproval)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."Approval Status" = Rec."approval status"::"Pending Approval";
                ToolTip = 'Withdraw the approval request and revert the PIP to Open.';

                trigger OnAction()
                var
                    PerfApprovals: Codeunit "Performance Approvals";
                    Variant: Variant;
                begin
                    Variant := Rec;
                    PerfApprovals.OnCancelDocApprovalRequest(Variant);
                    Rec.Get(Rec.No);
                    CurrPage.Update(false);
                end;
            }
            action(RecordMonthlyReview)
            {
                ApplicationArea = Basic;
                Caption = 'Record Monthly Review';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."Approval Status" = Rec."approval status"::Released;
                ToolTip = 'Record that a monthly progress review has been conducted. Update the Last Review Date and milestone statuses.';

                trigger OnAction()
                begin
                    if Rec."Approval Status" <> Rec."approval status"::Released then
                        Error('Monthly reviews can only be recorded for Released PIPs.');

                    Rec."Last Review Date" := Today;
                    Rec.Modify(true);
                    Message('Monthly review date recorded as %1. Please update individual milestone statuses on the Milestones tab.', Today);
                end;
            }
        }
    }

    var
        ApprovalStyle: Text;
        ProgressStyle: Text;
        OutcomeStyle: Text;

    trigger OnAfterGetRecord()
    begin
        case Rec."Approval Status" of
            Rec."approval status"::Open:
                ApprovalStyle := 'Ambiguous';
            Rec."approval status"::"Pending Approval":
                ApprovalStyle := 'Attention';
            Rec."approval status"::Released:
                ApprovalStyle := 'Favorable';
            Rec."approval status"::Rejected:
                ApprovalStyle := 'Unfavorable';
        end;

        case Rec."PIP Progress Status" of
            Rec."pip progress status"::"On Track":
                ProgressStyle := 'Favorable';
            Rec."pip progress status"::"At Risk":
                ProgressStyle := 'Attention';
            Rec."pip progress status"::Overdue:
                ProgressStyle := 'Unfavorable';
            Rec."pip progress status"::Completed:
                ProgressStyle := 'Strong';
        end;

        case Rec."Final PIP Outcome" of
            Rec."final pip outcome"::"Successful Improvement":
                OutcomeStyle := 'Favorable';
            Rec."final pip outcome"::"Partial Improvement":
                OutcomeStyle := 'Attention';
            Rec."final pip outcome"::Unsuccessful:
                OutcomeStyle := 'Unfavorable';
            else
                OutcomeStyle := 'Standard';
        end;
    end;
}
