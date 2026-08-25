page 51525311 "Rules & Regulations"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Rules & Regulations";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Rules & Regulations"; Rec."Rules & Regulations")
                {
                }
                field("Document Link"; Rec."Document Link")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Language Code (Default)"; Rec."Language Code (Default)")
                {
                }
                field(Attachement; Rec.Attachement)
                {
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ViewAttachments)
            {
                Caption = 'View Attachments';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    RulesAttPage: Page "Rules Reg Attachments";
                begin
                    RulesAttPage.SetCode(Rec.Code);
                    RulesAttPage.RunModal();
                end;
            }

            
            action(ViewDistribution)
            {
                Caption = 'View Distribution';
                Image = Entries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                trigger OnAction()
                var
                    PortalDocDist: Record "Portal Doc Distribution";
                    DistPage: Page "Portal Doc Distribution";
                begin
                    PortalDocDist.SetRange("Document Code", Rec.Code);
                    DistPage.SetTableView(PortalDocDist);
                    DistPage.RunModal();
                end;
            }
            action(SendToPortal)
            {
                Caption = 'Send to Portal';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    SendPortalPage: Page "Send To Portal Selection";
                    DocAttachment: Record "Document Attachment";
                begin
                    if Rec.Attachement = Rec.Attachement::No then
                        Error('Please attach a document first before sending to portal.');

                    DocAttachment.Reset();
                    DocAttachment.SetRange("Table ID", 51525375);
                    DocAttachment.SetRange("No.", Rec.Code);
                    if not DocAttachment.FindLast() then
                        Error('No attachment found for this document.');

                    SendPortalPage.SetDocument(
                        Rec.Code,
                        Rec."Rules & Regulations",
                        DocAttachment.ID,
                        DocAttachment."File Name",
                        DocAttachment."File Extension");
                    SendPortalPage.RunModal();
                end;
            }
            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    DocAttachment: Record "Document Attachment";
                    TempBlob: Codeunit "Temp Blob";
                    FileManagement: Codeunit "File Management";
                    InStream: InStream;
                    FileName: Text;
                    RecRef: RecordRef;
                    FilterTxt: Label '*.jpg;*.jpeg;*.png;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.*', Locked = true;
                begin
                    RecRef.GetTable(Rec);
                    FileName := FileManagement.BLOBImportWithFilter(TempBlob, 'Select Document', FileName, StrSubstNo('Attachments (%1)|%1', FilterTxt), FilterTxt);
                    if FileName = '' then
                        exit;

                    DocAttachment.Init();
                    DocAttachment."Table ID" := 51525375;
                    DocAttachment."No." := Rec.Code;
                    DocAttachment."File Name" := CopyStr(FileManagement.GetFileName(FileName), 1, MaxStrLen(DocAttachment."File Name"));
                    DocAttachment."File Extension" := CopyStr(FileManagement.GetExtension(FileName), 1, MaxStrLen(DocAttachment."File Extension"));
                    DocAttachment.User := CopyStr(UserId(), 1, MaxStrLen(DocAttachment.User));
                    DocAttachment."Attached Date" := CurrentDateTime();
                    TempBlob.CreateInStream(InStream);
                    DocAttachment.SaveAttachmentFromStream(InStream, RecRef, CopyStr(FileManagement.GetFileName(FileName), 1, 250));

                    Rec.Attachement := Rec.Attachement::Yes;
                    Rec.Modify();
                    Message('Document uploaded successfully.');
                end;
            }
        }
        area(navigation)
        {
            /*group("&Attachment")
            {
                Caption = '&Attachment';
                Image = AnalysisView;
                action(Open)
                {
                    Caption = 'Open';
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Return';

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if InteractTemplLanguage.Get(Code, "Language Code (Default)") then
                            InteractTemplLanguage.OpenAttachment;
                    end;
                }
                action(Create)
                {
                    Caption = 'Create';
                    Ellipsis = true;
                    Image = CreateForm;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if not InteractTemplLanguage.Get(Code, "Language Code (Default)") then begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Code;
                            InteractTemplLanguage."Language Code" := "Language Code (Default)";
                            InteractTemplLanguage.Description := "Rules & Regulations";
                        end;
                        InteractTemplLanguage.CreateAttachment;
                        CurrPage.Update;
                        Attachement := Attachement::Yes;
                        Rec.Modify;
                    end;
                }
                action("Copy &from")
                {
                    Caption = 'Copy &from';
                    Ellipsis = true;
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if not InteractTemplLanguage.Get(Code, "Language Code (Default)") then begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Code;
                            InteractTemplLanguage."Language Code" := "Language Code (Default)";
                            InteractTemplLanguage.Description := "Rules & Regulations";
                            InteractTemplLanguage.Insert;
                            Commit;
                        end;
                        InteractTemplLanguage.CopyFromAttachment;
                        CurrPage.Update;
                        Attachement := Attachement::Yes;
                        Rec.Modify;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if not InteractTemplLanguage.Get(Code, "Language Code (Default)") then begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Code;
                            InteractTemplLanguage."Language Code" := "Language Code (Default)";
                            InteractTemplLanguage.Description := "Rules & Regulations";
                            InteractTemplLanguage.Insert;
                        end;
                        InteractTemplLanguage.ImportAttachment;
                        CurrPage.Update;
                        Attachement := Attachement::Yes;
                        Rec.Modify;
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if InteractTemplLanguage.Get(Code, "Language Code (Default)") then
                            InteractTemplLanguage.ExportAttachment;
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if InteractTemplLanguage.Get(Code, "Language Code (Default)") then begin
                            InteractTemplLanguage.RemoveAttachment(true);
                            Attachement := Attachement::No;
                            Rec.Modify;
                        end;
                    end;
                }
            }*/
        }
    }
}
