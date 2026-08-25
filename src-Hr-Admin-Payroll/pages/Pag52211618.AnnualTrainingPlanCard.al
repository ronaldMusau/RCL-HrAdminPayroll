page 52211618 "Annual Training Plan Card"
{
    PageType = Card;
    SourceTable = "Annual Training Plan";
    Caption = 'Training Master Plan Card';
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.") { ApplicationArea = All; Editable = false; }
                field("Title"; Rec."Title") { ApplicationArea = All; Editable = EnableEditing; }
                field("Fiscal Year"; Rec."Fiscal Year") { ApplicationArea = All; Editable = EnableEditing; }
                field("Description"; Rec."Description") { ApplicationArea = All; Editable = EnableEditing; MultiLine = true; }
                field("Approval Status"; Rec."Approval Status") { ApplicationArea = All; Editable = false; }
                field("Created By"; Rec."Created By") { ApplicationArea = All; Editable = false; }
                field("Created Date"; Rec."Created Date") { ApplicationArea = All; Editable = false; }
            }
            group(BudgetSummary)
            {
                Caption = 'Budget Summary';
                field("Extra Budget"; Rec."Extra Budget") { ApplicationArea = All; Editable = EnableEditing; }
                field(CoursesBudget; CoursesBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Courses Budget';
                    Editable = false;
                }
                field(TotalBudget; TotalBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Total Budget';
                    Editable = false;
                }
                field(TotalCommitted; TotalCommitted)
                {
                    ApplicationArea = All;
                    Caption = 'Total Committed';
                    Editable = false;
                }
                field(TotalUsed; TotalUsed)
                {
                    ApplicationArea = All;
                    Caption = 'Total Used';
                    Editable = false;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = All;
                    Caption = 'Balance';
                    Editable = false;
                }
            }
            part(CourseLines; "Annual Training Plan Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Plan No." = field("No.");
                Editable = EnableEditing;
                UpdatePropagation = Both;
            }
        }
        area(FactBoxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(51525575), "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Enabled = Rec."Approval Status" = Rec."Approval Status"::Open;
                trigger OnAction()
                var
                    VarVariant: Variant;
                    CustomApprovals: Codeunit "Custom Approvals Mgmt HR";
                begin
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Enabled = Rec."Approval Status" = Rec."Approval Status"::"Pending Approval";
                trigger OnAction()
                var
                    VarVariant: Variant;
                    CustomApprovals: Codeunit "Custom Approvals Mgmt HR";
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Reopen)
            {
                ApplicationArea = All;
                Caption = 'Reopen';
                Image = ReOpen;
                Enabled = Rec."Approval Status" = Rec."Approval Status"::Released;
                trigger OnAction()
                begin
                    if not Confirm('Reopen this Annual Training Plan? Approval Status will reset to Open.') then
                        exit;
                    Rec."Approval Status" := Rec."Approval Status"::Open;
                    Rec.Modify(true);
                    EnableEditing := true;
                    CurrPage.Update(false);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Courses Budget", "Total Committed", "Total Used");
        CoursesBudget := Rec."Courses Budget";
        TotalBudget := Rec."Courses Budget" + Rec."Extra Budget";
        TotalCommitted := Rec."Total Committed";
        TotalUsed := Rec."Total Used";
        Balance := TotalBudget - TotalUsed;
        EnableEditing := Rec."Approval Status" = Rec."Approval Status"::Open;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Approval Status" := Rec."Approval Status"::Open;
        EnableEditing := true;
    end;

    trigger OnOpenPage()
    begin
        EnableEditing := Rec."Approval Status" = Rec."Approval Status"::Open;
    end;

    var
        EnableEditing: Boolean;
        CoursesBudget: Decimal;
        TotalBudget: Decimal;
        TotalCommitted: Decimal;
        TotalUsed: Decimal;
        Balance: Decimal;
}
