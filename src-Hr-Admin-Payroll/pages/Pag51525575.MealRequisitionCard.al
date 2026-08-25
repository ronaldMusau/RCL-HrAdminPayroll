page 52211576 "Meal Requisition Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Meal Requisition Header";
    PromotedActionCategories = 'New,Process,Report,Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = IsEditable;
                field("Requisition No"; Rec."Requisition No") { Editable = false; }
                field("Request Date"; Rec."Request Date") { }
                field("Employee No"; Rec."Employee No") { }
                field("Employee Name"; Rec."Employee Name") { Editable = false; }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name") { Editable = false; }
                field(Status; Rec.Status) { }
                field("Total Amount"; Rec."Total Amount") { }
            }
            group(Lines)
            {
                part(MealLines; "Meal Requisition Lines")
                {
                    SubPageLink = "Requisition No" = FIELD("Requisition No");
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
                    Enabled = (Rec.Status = Rec.Status::Open);
                    trigger OnAction()
                    var
                        CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                        Variant: Variant;
                    begin
                        Rec.TestField("Employee No");

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
                        if Rec.Status <> Rec.Status::"Pending Approval" then
                            Error('Only requests pending approval can be canceled');
                        Variant := Rec;
                        CustomApprovalsHR.OnCancelDocApprovalRequest(Variant);
                    end;
                }
                action(ReopenMealRequisition)
                {
                    Caption = 'Reopen';
                    ApplicationArea = All;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Enabled = (Rec.Status = Rec.Status::Rejected);
                    trigger OnAction()
                    var
                        VarVariant: Variant;
                        CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                    begin
                        VarVariant := Rec;
                        CustomApprovalsHR.OnReopenDocument(VarVariant);
                        Rec.Get(Rec."Requisition No");
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

    var
        isEditable: Boolean;

    local procedure UpdateEditableState()
    begin
        IsEditable := Rec.Status = Rec.Status::Open;
    end;

}
