page 52211549 "Accident / Incident Logs Manag"
{
    ApplicationArea = All;
    Caption = 'Accident / Incident Logs Manag';
    PageType = Card;
    SourceTable = "Accident / Incident Logs Manag";
    PromotedActionCategories = 'New,Process,Navigate,Report,Approve,Approval,Approvals';
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Document Number"; Rec."Document Number")
                {
                    ToolTip = 'Specifies the value of the Document Number field.', Comment = '%';
                }
                field("Reporting Party "; Rec."Reporting Party ")
                {
                    ToolTip = 'Specifies the value of the Reporting Party field.', Comment = '%';
                }
                field("Reporting Party Name"; Rec."Reporting Party Name")
                {
                    ToolTip = 'Specifies the value of the Reporting Party Name field.', Comment = '%';
                }
                field("Location of Incident"; Rec."Location of Incident")
                {
                    ToolTip = 'Specifies the value of the Location of Incident field.', Comment = '%';
                }
                field("Date of Incident"; Rec."Date of Incident")
                {
                    ToolTip = 'Specifies the value of the Date of Incident field.', Comment = '%';
                }
                field("Time of Incident"; Rec."Time of Incident")
                {
                    ToolTip = 'Specifies the value of the Time of Incident field.', Comment = '%';
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    ToolTip = 'Specifies the value of the Incident Description field.', Comment = '%';
                }
                field("Corrective Action Taken"; Rec."Corrective Action Taken")
                {

                }
                field("Follow-up or investigations"; Rec."Follow-up or investigations")
                {

                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ToolTip = 'Specifies the value of the Approval Status field.', Comment = '%';
                }
            }
            part("Accident / Incident Logs Kines"; "Accident / Incident Logs Lines")
            {
                SubPageLink = "Doc. No." = FIELD("Document Number");
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
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                        Variant: Variant;
                    begin

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
                    PromotedCategory = Category6;
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
                action(ViewApprovals)
                {
                    ApplicationArea = All;
                    Caption = 'View Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
                    end;
                }
                action(Print)
                {
                    ApplicationArea = All;
                    Caption = 'Print Incident log Report';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    trigger OnAction()
                    begin
                        Rec.Reset();
                        Rec.SetRange("Document Number", Rec."Document Number");
                        Report.Run(Report::"Accident / Incident Logs", true, true, Rec);
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
