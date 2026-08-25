#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211795 "Training Courses Needs"
{
    PageType = ListPart;
    SourceTable = "Training Courses Needs";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Training Need Code"; Rec."Training Need Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Training Need Description"; Rec."Training Need Description")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Approvals")
                {
                    ApplicationArea = Basic;
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition";
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // Report.Run(69122, true, true, Rec);
                    end;
                }
                action("&Send Approval &Request")
                {
                    ApplicationArea = Basic;
                    Caption = '&Send Approval &Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action("&Cancel Approval request")
                {
                    ApplicationArea = Basic;
                    Caption = '&Cancel Approval request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                separator(Action14)
                {
                }
                group(ActionGroup21)
                {
                    action("Import Needs")
                    {
                        ApplicationArea = Basic;
                        Image = Import;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = XMLport "Import Training Needs";

                        trigger OnAction()
                        begin
                            ImportTrainingNeeds.GetRec(Rec);
                            ImportTrainingNeeds.Run();
                        end;
                    }
                }
            }
        }
    }

    var
        ImportTrainingNeeds: XmlPort "Import Training Needs";
}

