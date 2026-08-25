page 52211572 "Loan Application Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Loan Application";
    PromotedActionCategories = 'New,Process,Report,Approval';
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = IsEditable;
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                }
                field("Loan No"; Rec."Loan No")
                {
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Amount Requested"; Rec."Amount Requested")
                {
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Editable = IsApprovedAmountEditable;
                }
                field(Instalment; Rec.Instalment)
                {
                }
                field("Loan Status"; Rec."Loan Status")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(SendApproval)
                {
                    ApplicationArea = All;
                    Caption = 'Send for Approval';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Enabled = (Rec."Loan Status" = Rec."Loan Status"::Application);
                    trigger OnAction()
                    var
                        CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                        Variant: Variant;
                    begin
                        Rec.TestField("Employee No");
                        Rec.TestField("Loan Product Type");
                        Rec.TestField("Amount Requested");

                        Variant := Rec;
                        if CustomApprovalsHR.CheckApprovalsWorkflowEnabled(Variant) then
                            CustomApprovalsHR.OnSendDocForApproval(Variant);
                    end;
                }
                action(CancelApproval)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                        Variant: Variant;
                    begin
                        if Rec."Loan Status" <> Rec."Loan Status"::"Being Processed" then
                            Error('Only requests pending approval can be canceled');
                        Variant := Rec;
                        CustomApprovalsHR.OnCancelDocApprovalRequest(Variant);
                    end;
                }
                action(ReopenLoanApplication)
                {
                    Caption = 'Reopen';
                    ApplicationArea = All;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Enabled = (Rec."Loan Status" = Rec."Loan Status"::Rejected);
                    trigger OnAction()
                    var
                        VarVariant: Variant;
                        CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                    begin
                        VarVariant := Rec;
                        CustomApprovalsHR.OnReopenDocument(VarVariant);
                        Rec.Get(Rec."Loan No", Rec."Loan Product Type");
                        CurrPage.Update(false);
                    end;
                }
                action(ViewApprovals)
                {
                    ApplicationArea = All;
                    Caption = 'View Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        UpdateEditableState();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateEditableState();
    end;

    local procedure UpdateEditableState()
    begin
        IsEditable := Rec."Loan Status" = Rec."Loan Status"::Application;
        IsApprovedAmountEditable := Rec."Loan Status" = Rec."Loan Status"::"Being Processed";
    end;

    var
        IsEditable: Boolean;
        IsApprovedAmountEditable: Boolean;
}

