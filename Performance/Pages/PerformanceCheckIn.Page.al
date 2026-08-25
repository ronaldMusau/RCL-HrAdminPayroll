#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211802 "SPM Performance Check In Card"
{
    ApplicationArea = Basic;
    Caption = 'Performance Check In';
    PageType = Card;
    SourceTable = "SPM Performance Check In";
    PromotedActionCategories = 'New,Process,Report';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the check-in document number.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Specifies the employee for this check-in.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the employee name.';
                }
                field("Immediate Supervisor No."; Rec."Immediate Supervisor No.")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Specifies the immediate supervisor.';
                }
                field("Immediate Supervisor Name"; Rec."Immediate Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the supervisor name.';
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Specifies the employee department.';
                }
                field("Check-In Date"; Rec."Check-In Date")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Specifies the check-in date.';
                }
                field("Check-In Period Description"; Rec."Check-In Period Description")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Specifies the period description (e.g. Mid-Year Check-In Dec 2025).';
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Specifies the annual reporting year.';
                }
                field("Performance Mgt Plan ID"; Rec."Performance Mgt Plan ID")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Specifies the performance management plan.';
                }
                field("Personal Scorecard ID"; Rec."Personal Scorecard ID")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Specifies the personal scorecard (Staff Performance Contract).';
                }
                field("Check-In Status"; Rec."Check-In Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = StatusStyle;
                    ToolTip = 'Specifies the current status of the check-in.';
                }
            }

            group("Staff Check-In")
            {
                Caption = 'Staff Check-In';

                field("Q1 Objectives On Track"; Rec."Q1 Objectives On Track")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Q1: Are your objectives on track against plan?';
                }
                field("Q2 Feedback From Manager"; Rec."Q2 Feedback From Manager")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Q2: Did you receive ongoing feedback from your Line Manager?';
                }
                field("Q3 Dev Actions On Track"; Rec."Q3 Dev Actions On Track")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Q3: Are your Development Actions on track against plan?';
                }
                field("Q4 Mid-Year Self Rating"; Rec."Q4 Mid-Year Self Rating")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Q4: What is your mid-year self-rating?';
                }
                field("Employee Comments"; Rec."Employee Comments")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Editable = Rec."Check-In Status" = Rec."check-in status"::Open;
                    ToolTip = 'Employee comments on this check-in.';
                }
            }

            group("Manager Review")
            {
                Caption = 'Manager Review';
                Editable = Rec."Check-In Status" = Rec."check-in status"::Submitted;

                field("MQ1 Objectives On Track"; Rec."MQ1 Objectives On Track")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'MQ1: Are the staff''s objectives on track against plan?';
                }
                field("MQ2 Feedback Provided"; Rec."MQ2 Feedback Provided")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'MQ2: Did you provide ongoing feedback to this staff member?';
                }
                field("MQ3 Dev Actions On Track"; Rec."MQ3 Dev Actions On Track")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'MQ3: Are the staff''s Development Actions on track against plan?';
                }
                field("MQ4 Mid-Year Manager Rating"; Rec."MQ4 Mid-Year Manager Rating")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'MQ4: What is your manager rating for this staff member at mid-year?';
                }
                field("Manager Comments"; Rec."Manager Comments")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    ToolTip = 'Manager comments on this check-in.';
                }
            }

            group(Approval)
            {
                Caption = 'Audit Trail';
                Editable = false;

                field("Submitted By"; Rec."Submitted By")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies who submitted the check-in.';
                }
                field("Submitted On"; Rec."Submitted On")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies when the check-in was submitted.';
                }
                field("Manager Completed By"; Rec."Manager Completed By")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies which manager completed their section.';
                }
                field("Manager Completed On"; Rec."Manager Completed On")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies when the manager completed their section.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies who approved the check-in.';
                }
                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies when the check-in was approved.';
                }
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the reason for rejection, if applicable.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Submit)
            {
                ApplicationArea = Basic;
                Caption = 'Submit';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec."Check-In Status" = Rec."check-in status"::Open;
                ToolTip = 'Submit your check-in responses for manager review. The Manager Review section will be unlocked after submission.';

                trigger OnAction()
                var
                    PerfApprovals: Codeunit "Performance Approvals";
                    Variant: Variant;
                begin
                    Rec.TestField("Employee No.");
                    Rec.TestField("Annual Reporting Code");
                    Rec.TestField("Check-In Date");
                    if Rec."Q4 Mid-Year Self Rating" = Rec."q4 mid-year self rating"::" " then
                        Error('Please complete Q4 Mid-Year Self Rating before submitting.');
                    if Rec."Check-In Status" <> Rec."check-in status"::Open then
                        Error('Only Open check-ins can be submitted.');

                    Variant := Rec;
                    PerfApprovals.CheckApprovalsWorkflowEnabled(Variant);
                    PerfApprovals.OnSendDocForApproval(Variant);
                    Rec.Get(Rec."No.");
                    CurrPage.Update(false);
                    Message('Check-In submitted. The Manager Review section is now unlocked for your manager to complete.');
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec."Check-In Status" = Rec."check-in status"::Submitted;
                ToolTip = 'Approve this check-in after completing the Manager Review section. Release is handled through the workflow.';

                trigger OnAction()
                var
                    PerfApprovals: Codeunit "Performance Approvals";
                    RecRef: RecordRef;
                    Handled: Boolean;
                begin
                    if Rec."Check-In Status" <> Rec."check-in status"::Submitted then
                        Error('Only Submitted check-ins can be approved.');
                    if Rec."MQ4 Mid-Year Manager Rating" = Rec."mq4 mid-year manager rating"::" " then
                        Error('Please complete MQ4 Mid-Year Manager Rating in the Manager Review section before approving.');

                    Rec.Modify(true);
                    RecRef.GetTable(Rec);
                    PerfApprovals.Release(RecRef, Handled);
                    Rec.Get(Rec."No.");
                    CurrPage.Update(false);
                    Message('Check-In approved. Both staff and manager responses have been recorded.');
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."Check-In Status" = Rec."check-in status"::Submitted;
                ToolTip = 'Return this check-in to the employee for revision.';

                trigger OnAction()
                begin
                    if Rec."Check-In Status" <> Rec."check-in status"::Submitted then
                        Error('Only Submitted check-ins can be rejected.');
                    if not Confirm('Reject this check-in and return it to the employee for revision?', false) then
                        exit;

                    Rec."Check-In Status" := Rec."check-in status"::Rejected;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                    Message('Check-In rejected. Please update the Rejected Reason field and notify the employee.');
                end;
            }
            action(ReOpen)
            {
                ApplicationArea = Basic;
                Caption = 'Re-Open';
                Image = ReOpen;
                Enabled = Rec."Check-In Status" = Rec."check-in status"::Rejected;
                ToolTip = 'Re-open a rejected check-in so the employee can revise their responses.';

                trigger OnAction()
                var
                    PerfApprovals: Codeunit "Performance Approvals";
                    RecRef: RecordRef;
                    Handled: Boolean;
                begin
                    if Rec."Check-In Status" <> Rec."check-in status"::Rejected then
                        Error('Only Rejected check-ins can be re-opened.');

                    RecRef.GetTable(Rec);
                    PerfApprovals.ReOpen(RecRef, Handled);
                    Rec.Get(Rec."No.");
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        StatusStyle: Text;

    trigger OnAfterGetRecord()
    begin
        case Rec."Check-In Status" of
            Rec."check-in status"::Open:
                StatusStyle := 'Ambiguous';
            Rec."check-in status"::Submitted:
                StatusStyle := 'Attention'; // manager response pending
            Rec."check-in status"::Approved:
                StatusStyle := 'Favorable';
            Rec."check-in status"::Rejected:
                StatusStyle := 'Unfavorable';
            else
                StatusStyle := 'Standard';
        end;
    end;
}
