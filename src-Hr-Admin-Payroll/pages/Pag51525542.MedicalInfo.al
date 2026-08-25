page 51525542 "Medical Info"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Medical History";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Certificate No."; Rec."Certificate No.")
                {
                }
                field("Certificate Type"; Rec."Certificate Type")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Results; Rec.Results)
                {
                }
                field("Issue Date"; Rec."Issue Date")
                {
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                }
                field("Notification Days"; Rec."Notification Days")
                {
                }
                field(Notified; Rec.Notified)
                {
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Attachments)
            {
                Caption = 'Certificate Attachments';
                ApplicationArea = All;
                Image = Attach;
                ToolTip = 'Upload or view the certificate document for this record.';
                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }
}
