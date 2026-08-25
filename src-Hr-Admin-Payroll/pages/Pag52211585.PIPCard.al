page 52211585 "PIP Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "PIP Header";
    PromotedActionCategories = 'New,Process,Report,Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = IsEditable;
                field("PIP No"; Rec."PIP No") { Editable = false; }
                field("Employee No"; Rec."Employee No") { }
                field("Employee Name"; Rec."Employee Name") { Editable = false; }
                field("Appraisal No"; Rec."Appraisal No") { }
                field("Appraisal Period"; Rec."Appraisal Period") { }
                field("Supervisor No"; Rec."Supervisor No") { }
                field("Supervisor Name"; Rec."Supervisor Name") { Editable = false; }
                field("Start Date"; Rec."Start Date") { }
                field("End Date"; Rec."End Date") { }
                field(Status; Rec.Status) { Editable = false; }
                field(Notes; Rec.Notes) { MultiLine = true; }
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
                action(SendPIPApproval)
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
                action(CancelPIPApproval)
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
                action(ReopenPIP)
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
                        Rec.Get(Rec."PIP No");
                        CurrPage.Update(false);
                    end;
                }
                action(ViewPIPApprovals)
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
        IsEditable: Boolean;

    local procedure UpdateEditableState()
    begin
        IsEditable := Rec.Status = Rec.Status::Open;
    end;
}
