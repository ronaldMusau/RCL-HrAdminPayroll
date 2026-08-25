page 52211568 "Compassionate Checks Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Compassionate Checks";
    PromotedActionCategories = 'New,Process,Report,Approval';

    layout
    {
        area(content)
        {
            group("Compassionate Check Request")
            {
                Caption = 'Compassionate Check Request';
                Editable = IsEditable;

                group(Details)
                {
                    Caption = 'Details';
                    field("No."; Rec."No.")
                    {
                        Editable = false;
                    }
                    field("Employee No."; Rec."Employee No.")
                    {
                        NotBlank = true;
                    }
                    field("Employee Name"; Rec."Employee Name")
                    {
                        Editable = false;
                    }
                    field("Type"; Rec."Type")
                    {
                        NotBlank = true;
                    }
                    field("Amount"; Rec."Amount")
                    {
                        Editable = false;
                        NotBlank = true;
                    }
                }

                group(Status)
                {
                    Caption = 'Status';
                    field("Request Date"; Rec."Request Date")
                    {
                        Editable = false;
                    }
                    field("Created By"; Rec."Created By")
                    {
                        Editable = false;
                    }
                    field("Approval Status"; Rec."Approval Status")
                    {
                        Editable = false;
                    }
                }

                group(Additional)
                {
                    Caption = 'Additional Information';
                    field("Remarks"; Rec."Remarks")
                    {
                        InstructionalText = 'Optional';
                        ShowMandatory = true;
                    }
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
                    Enabled = (Rec."Approval Status" = Rec."Approval Status"::Open);
                    trigger OnAction()
                    var
                        CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                        Variant: Variant;
                    begin
                        Rec.TestField("Employee No.");
                        Rec.TestField("Type");
                        Rec.TestField("Amount");
                        Rec.TestField("Remarks");

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
                        if Rec."Approval Status" <> Rec."Approval Status"::"Pending Approval" then
                            Error('Only requests pending approval can be canceled');
                        Variant := Rec;
                        CustomApprovalsHR.OnCancelDocApprovalRequest(Variant);
                    end;
                }
                action(ReopenCompassionateCheck)
                {
                    Caption = 'Reopen';
                    ApplicationArea = All;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Enabled = (Rec."Approval Status" = Rec."Approval Status"::Rejected);
                    trigger OnAction()
                    var
                        VarVariant: Variant;
                        CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                    begin
                        VarVariant := Rec;
                        CustomApprovalsHR.OnReopenDocument(VarVariant);
                        Rec.Get(Rec."No.");
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
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
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
        IsEditable := Rec."Approval Status" = Rec."Approval Status"::Open;
    end;

    var
        IsEditable: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";



}
