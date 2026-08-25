page 52211554 "Shift Card"
{
    PageType = Card;
    SourceTable = "Shift Header";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Shift';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    // Editable = false;
                }
                field("Shift Date"; Rec."Shift Start Date")
                {
                    ApplicationArea = All;
                }
                field("Shift End Date"; Rec."Shift End Date")
                {

                }
                field("Week No."; Rec."Week No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Year; Rec."Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shift Type"; Rec."Shift Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shift Department"; Rec."Shift Department")
                {

                }
                field("Created by"; Rec."Created by")
                {

                }
                field(Department; Rec.Department)
                {
                    Visible = false;
                }
            }

            part(ShiftLines; "Shift Lines Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Shift No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // 1️⃣ Your real actions (logic)
            action(MyAttachment)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;

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

            action("Post Doc")
            {
                Caption = 'Post';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.posted := true;
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen';
                ApplicationArea = All;
                Image = ReOpen;

                trigger OnAction()
                begin
                    Rec.posted := false;
                    Rec.Modify();
                end;
            }
            action(PrintShiftReport)
            {
                ApplicationArea = All;
                Caption = 'Print Shift Report';
                Image = Print;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(Report::"Shift Report", true, false, Rec);
                end;
            }

        }
        area(Promoted)
        {
            // 2️⃣ Group that uses actionref
            group(AttachDocument)
            {
                Caption = 'Attach Document';

                actionref(Attachment; MyAttachment) { }

            }
            group(Post)
            {
                Caption = 'Post';

                actionref(MyPostRef; "Post Doc") { }
                actionref(ReopenRef; Reopen) { }

            }
            group(Report)
            {
                Caption = 'Report';

                actionref(MyReportRef; PrintShiftReport) { }

            }

        }


    }

}

