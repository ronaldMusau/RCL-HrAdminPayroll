#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211817 "Employee KPI Self-Setup"
{
    ApplicationArea = Basic;
    Caption = 'Employee KPI Self-Setup';
    PageType = Card;
    SourceTable = "Perfomance Contract Header";
    SourceTableView = where("Document Type" = const("Staff Performance Contract"),
                            "Target Setting Type" = const("Employee-Initiated"));
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
                    ToolTip = 'Specifies the scorecard number.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = StatusStyle;
                    ToolTip = 'Open: editing. Pending Approval: awaiting manager review. Released: approved by manager.';
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Approval Status" = Rec."approval status"::Open;
                    ToolTip = 'Specifies the performance cycle year.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Populated from the Annual Reporting Code.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Populated from the Annual Reporting Code.';
                }
                field("Responsible Employee No."; Rec."Responsible Employee No.")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Approval Status" = Rec."approval status"::Open;
                    ToolTip = 'Specifies the employee setting up their own KPIs.';
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
                    Editable = false;
                    ToolTip = 'Specifies the job title.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the department.';
                }
            }

            group(WeightSummary)
            {
                Caption = 'KPI Weight Summary';

                field("Total Assigned Weight(%)"; Rec."Total Assigned Weight(%)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = WeightStyle;
                    ToolTip = 'Shows the running total of all KPI weights. Must equal 100% before you can submit.';
                }
            }

            part("Objectives & KPIs"; "PC Objectives Self Setup")
            {
                Caption = 'Objectives & KPIs';
                SubPageLink = "Workplan No." = field(No);
                Editable = Rec."Approval Status" = Rec."approval status"::Open;
                ApplicationArea = Basic;
            }

            group(ManagerFeedback)
            {
                Caption = 'Manager Feedback / Return Reason';
                Visible = (Rec."Approval Status" = Rec."approval status"::"Pending Approval") or (Rec."Manager Return Reason" <> '');

                field("Manager Return Reason"; Rec."Manager Return Reason")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Approval Status" = Rec."approval status"::"Pending Approval";
                    MultiLine = true;
                    ToolTip = 'Manager: fill in this field before clicking Return for Revision. Employee: shows the manager''s feedback when the scorecard is returned.';
                }
            }

            group(AuditTrail)
            {
                Caption = 'Audit Trail';
                Editable = false;

                field("Employee Submitted By"; Rec."Employee Submitted By")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies who submitted the scorecard for manager review.';
                }
                field("Employee Submitted On"; Rec."Employee Submitted On")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies when the scorecard was submitted.';
                }
                field("Manager Acknowledged By"; Rec."Manager Acknowledged By")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the manager who approved the scorecard.';
                }
                field("Manager Acknowledged On"; Rec."Manager Acknowledged On")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies when the manager approved the scorecard.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SubmitToManager)
            {
                ApplicationArea = Basic;
                Caption = 'Submit to Manager';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec."Approval Status" = Rec."approval status"::Open;
                ToolTip = 'Submit your Objectives & KPIs to your manager for review. Total weight must equal 100%.';

                trigger OnAction()
                begin
                    Rec.SubmitForManagerApproval();
                    CurrPage.Update(false);
                    Message('Scorecard submitted to your manager for review.');
                end;
            }
            action(ApproveKPIs)
            {
                ApplicationArea = Basic;
                Caption = 'Approve KPIs';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec."Approval Status" = Rec."approval status"::"Pending Approval";
                ToolTip = 'Approve the employee''s Objectives & KPIs and release the scorecard.';

                trigger OnAction()
                begin
                    Rec.ManagerApprove();
                    CurrPage.Update(false);
                    Message('KPIs approved. The scorecard is now released.');
                end;
            }
            action(ReturnToEmployee)
            {
                ApplicationArea = Basic;
                Caption = 'Return for Revision';
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."Approval Status" = Rec."approval status"::"Pending Approval";
                ToolTip = 'Return the scorecard to the employee. Fill in the Manager Return Reason field first.';

                trigger OnAction()
                begin
                    if not Confirm('Return this scorecard to the employee for revision?', false) then
                        exit;
                    Rec.Modify(true);
                    Rec.ManagerReturn(Rec."Manager Return Reason");
                    CurrPage.Update(false);
                    Message('Scorecard returned to the employee with your feedback.');
                end;
            }
        }
    }

    var
        StatusStyle: Text;
        WeightStyle: Text;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total Assigned Weight(%)");

        case Rec."Approval Status" of
            Rec."approval status"::Open:
                StatusStyle := 'Ambiguous';
            Rec."approval status"::"Pending Approval":
                StatusStyle := 'Attention';
            Rec."approval status"::Released:
                StatusStyle := 'Favorable';
            Rec."approval status"::Rejected:
                StatusStyle := 'Unfavorable';
        end;

        if Rec."Total Assigned Weight(%)" = 100 then
            WeightStyle := 'Favorable'
        else if Rec."Total Assigned Weight(%)" > 100 then
            WeightStyle := 'Unfavorable'
        else
            WeightStyle := 'Attention';
    end;

}
