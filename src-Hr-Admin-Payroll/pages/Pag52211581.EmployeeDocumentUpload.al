page 52211581 "Employee Document Upload"
{
    ApplicationArea = All;
    Caption = 'Employee Documents';
    PageType = Worksheet;
    SourceTable = "Document Attachment";
    Editable = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filter by Category';
                field(CategoryFilter; CategoryFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Document Category';
                    TableRelation = "Emp Document Category".Code;
                    ToolTip = 'Filter documents by category. If selected, Upload Document will use this category automatically.';

                    trigger OnValidate()
                    begin
                        ApplyCategoryFilter();
                        CurrPage.Update(false);
                    end;
                }
            }
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the filename of the attachment.';

                    trigger OnDrillDown()
                    begin
                        if Rec."Document Reference ID".HasValue then
                            Rec.Export(true);
                    end;
                }
                field("Document Category Code"; Rec."Document Category Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the document category.';
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Uploaded By Employee"; Rec."Uploaded By Employee")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            action(UploadDoc)
            {
                ApplicationArea = All;
                Caption = 'Upload Document';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    FileManagement: Codeunit "File Management";
                    Base64Convert: Codeunit "Base64 Convert";
                    EmpDocMgmt: Codeunit "Employee Document Mgmt";
                    InStream: InStream;
                    FileName: Text;
                    CategoryCode: Code[20];
                    FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
                    ImportTxt: Label 'Select document to upload.';
                begin
                    // If category already selected at top, use it  no need to ask again
                    if CategoryFilter <> '' then
                        CategoryCode := CategoryFilter
                    else
                        if not SelectCategoryCode(CategoryCode) then
                            exit;

                    FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, StrSubstNo('Attachments (%1)|%1', FilterTxt), FilterTxt);
                    if FileName = '' then
                        exit;

                    TempBlob.CreateInStream(InStream);
                    EmpDocMgmt.UploadDocument(
                        CurrentEmployeeNo,
                        CategoryCode,
                        CopyStr(FileManagement.GetFileName(FileName), 1, 250),
                        CopyStr(FileManagement.GetExtension(FileName), 1, 30),
                        GetBase64FromBlob(TempBlob),
                        false
                    );
                    CurrPage.Update(false);
                end;
            }
            action(PreviewDoc)
            {
                ApplicationArea = All;
                Caption = 'Preview';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;

                trigger OnAction()
                begin
                    if Rec."File Name" <> '' then
                        Rec.Export(true);
                end;
            }
            action(DeleteDoc)
            {
                ApplicationArea = All;
                Caption = 'Delete Document';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;

                trigger OnAction()
                var
                    EmpDocMgmt: Codeunit "Employee Document Mgmt";
                begin
                    if not Confirm('Are you sure you want to delete document %1?', false, Rec."File Name") then
                        exit;
                    EmpDocMgmt.DeleteDocument(CurrentEmployeeNo, Rec.ID);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ApplyBaseFilter();
    end;

    var
        CurrentEmployeeNo: Code[20];
        CategoryFilter: Code[20];

    procedure SetEmployeeNo(EmployeeNo: Code[20])
    begin
        CurrentEmployeeNo := EmployeeNo;
        ApplyBaseFilter();
    end;

    local procedure ApplyBaseFilter()
    begin
        Rec.Reset();
        Rec.SetRange("Table ID", Database::Employee);
        if CurrentEmployeeNo <> '' then
            Rec.SetRange("No.", CurrentEmployeeNo);
        if CategoryFilter <> '' then
            Rec.SetRange("Document Category Code", CategoryFilter);
    end;

    local procedure ApplyCategoryFilter()
    begin
        Rec.Reset();
        Rec.SetRange("Table ID", Database::Employee);
        if CurrentEmployeeNo <> '' then
            Rec.SetRange("No.", CurrentEmployeeNo);
        if CategoryFilter <> '' then
            Rec.SetRange("Document Category Code", CategoryFilter);
    end;

    local procedure SelectCategoryCode(var CategoryCode: Code[20]): Boolean
    var
        EmpDocCat: Record "Emp Document Category";
        EmpDocCatList: Page "Emp Document Category List";
    begin
        EmpDocCat.Reset();
        EmpDocCat.SetRange(Blocked, false);
        EmpDocCatList.SetTableView(EmpDocCat);
        EmpDocCatList.LookupMode(true);
        if EmpDocCatList.RunModal() = Action::LookupOK then begin
            EmpDocCatList.GetRecord(EmpDocCat);
            CategoryCode := EmpDocCat.Code;
            exit(true);
        end;
        exit(false);
    end;

    local procedure GetBase64FromBlob(var TempBlob: Codeunit "Temp Blob"): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
    begin
        TempBlob.CreateInStream(InStream);
        exit(Base64Convert.ToBase64(InStream));
    end;
}
