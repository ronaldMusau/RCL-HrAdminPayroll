page 52211610 "Rules Reg Attachments"
{
    ApplicationArea = All;
    Caption = 'Attached Documents';
    PageType = List;
    SourceTable = "Document Attachment";
    Editable = true;
    DeleteAllowed = true;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        if Rec."Document Reference ID".HasValue then
                            Rec.Export(true);
                    end;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'File Type';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Download)
            {
                Caption = 'Download';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                trigger OnAction()
                begin
                    if Rec."Document Reference ID".HasValue then
                        Rec.Export(true);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Table ID", 51525375);
        Rec.SetRange("No.", CurrentCode);
    end;

    var
        CurrentCode: Code[20];

    procedure SetCode(RulesCode: Code[20])
    begin
        CurrentCode := RulesCode;
    end;
}