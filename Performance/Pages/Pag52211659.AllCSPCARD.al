#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211750 "All CSP CARD"
{
    PageType = Card;
    SourceTable = "Corporate Strategic Plans";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Primary Theme"; Rec."Primary Theme")
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Framework"; Rec."Strategy Framework")
                {
                    ApplicationArea = Basic;
                }
                field("Duration (Years)"; Rec."Duration (Years)")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Implementation Status"; Rec."Implementation Status")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Vision & Mission")
            {
                field("Vision Statement"; Rec."Vision Statement")
                {
                    ApplicationArea = Basic;
                }
                field("Mission Statement"; Rec."Mission Statement")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Activities)
            {
            }
            part(Control14; "Strategic Initiatives")
            {
                SubPageLink = "Strategic Plan ID" = field(Code);
            }
        }
        area(FactBoxes)
        {
            part("Doc. Attachment List Factbox"; "Doc. Attachment List Factbox")
            {
                Caption = 'Performance Summary';
                SubPageLink = "Table ID" = const(Database::"Perfomance Contract Header"), "No." = field(Code);
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Strategy Formulation")
            {
                Caption = 'Strategy Formulation';
                action("SWOT Matrix")
                {
                    ApplicationArea = Basic;
                }
                action("Risk Matrix")
                {
                    ApplicationArea = Basic;
                }
                action("Stakeholder Matrix")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Strategy Elements")
            {
                action("Core Values")
                {
                    ApplicationArea = Basic;
                    Image = ValueLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Strategy Core Value";
                    RunPageLink = "Strategic Plan ID" = field(Code);
                }
                action("Strategic Theme")
                {
                    ApplicationArea = Basic;
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Strategic Theme";
                    RunPageLink = "Strategic Plan ID" = field(Code);
                }
                action("Strategic Objectives")
                {
                    ApplicationArea = Basic;
                    Image = Route;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Strategic Objectives";
                    RunPageLink = "Strategic Plan ID" = field(Code);
                }
                action(Strategies)
                {
                    ApplicationArea = Basic;
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Strategies;
                    RunPageLink = "Strategic Plan ID" = field(Code);
                }
                action("CSP Planned Years")
                {
                    ApplicationArea = Basic;
                    Caption = 'Planned Years';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "CSP Planned Years";
                    RunPageLink = "CSP Code" = field(Code);
                }
                action("Annual Implementation Plans")
                {
                    ApplicationArea = Basic;
                    Image = CalculatePlan;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Annual Strategy Workplans";
                    RunPageLink = "Strategy Plan ID" = field(Code);
                }
            }
            group("Performance Contracts")
            {
                Caption = 'Performance Contracts';
                action("Directorate Per. Contracts")
                {
                    ApplicationArea = Basic;
                }
                action("Department Per. Contracts")
                {
                    ApplicationArea = Basic;
                }
                action("Individual Per. Contracts")
                {
                    ApplicationArea = Basic;
                }
                action("Print Strategic Plan")
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Code, Rec.Code);
                        Report.Run(Report::"Corporate Strategic Plan", true, true, Rec)
                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                    end;
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        IF ApprovalsMgmt.CheckStrategicPlanApprovalPossible(Rec) THEN
                          ApprovalsMgmt.OnSendStrategicPlanForApproval(Rec);
                        */

                        Rec."Approval Status" := Rec."approval status"::Released;
                        Rec.Modify;
                        Message('Document %1 has been approved Automatically', Rec.Code);

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                    //      ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        ApprovalsMgmt.OnCancelStrategicPlanApprovalRequest(Rec);
                        */

                    end;
                }
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
            }
        }
    }

    var
    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}

