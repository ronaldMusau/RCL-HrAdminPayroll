codeunit 52211579 "Employee Document Mgmt"
{
    procedure UploadDocument(
        EmployeeNo: Code[20];
        CategoryCode: Code[20];
        FileName: Text[250];
        FileExtension: Text[30];
        Base64Content: Text;
        UploadedByEmployee: Boolean
    ): Integer
    var
        DocAttachment: Record "Document Attachment";
        Employee: Record Employee;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        OutStream: OutStream;
        NewID: Integer;
    begin
        if not Employee.Get(EmployeeNo) then
            Error('Employee %1 does not exist.', EmployeeNo);

        ValidateCategory(CategoryCode, UploadedByEmployee);

        if FileName = '' then
            Error('File name cannot be empty.');

        TempBlob.CreateOutStream(OutStream);
        Base64Convert.FromBase64(Base64Content, OutStream);
        TempBlob.CreateInStream(InStream);

        DocAttachment.Reset();
        DocAttachment.SetRange("Table ID", Database::Employee);
        DocAttachment.SetRange("No.", EmployeeNo);
        if DocAttachment.FindLast() then
            NewID := DocAttachment.ID + 1
        else
            NewID := 1;

        DocAttachment.Init();
        DocAttachment."Table ID" := Database::Employee;
        DocAttachment."No." := EmployeeNo;
        DocAttachment.ID := NewID;
        DocAttachment."File Name" := CopyStr(FileName, 1, MaxStrLen(DocAttachment."File Name"));
        DocAttachment."File Extension" := CopyStr(FileExtension, 1, MaxStrLen(DocAttachment."File Extension"));
        DocAttachment."Document Category Code" := CategoryCode;
        DocAttachment."Uploaded By Employee" := UploadedByEmployee;
        if UploadedByEmployee then
            DocAttachment."Employee Upload Date" := CurrentDateTime();
        DocAttachment.User := CopyStr(UserId(), 1, MaxStrLen(DocAttachment.User));
        DocAttachment."Attached Date" := CurrentDateTime();
        DocAttachment."Document Reference ID".ImportStream(InStream, FileName);
        DocAttachment.Insert(true);

        exit(DocAttachment.ID);
    end;

    procedure GetDocumentContent(EmployeeNo: Code[20]; AttachmentID: Integer): Text
    var
        DocAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        OutStream: OutStream;
        Base64Content: Text;
    begin
        DocAttachment.Reset();
        DocAttachment.SetRange("Table ID", Database::Employee);
        DocAttachment.SetRange("No.", EmployeeNo);
        DocAttachment.SetRange(ID, AttachmentID);

        if not DocAttachment.FindFirst() then
            Error('Document with ID %1 not found for employee %2.', AttachmentID, EmployeeNo);
        TempBlob.CreateOutStream(OutStream);
        DocAttachment."Document Reference ID".ExportStream(OutStream);
        TempBlob.CreateInStream(InStream);
        Base64Content := Base64Convert.ToBase64(InStream);
        exit(Base64Content);
    end;

    procedure DeleteDocument(EmployeeNo: Code[20]; AttachmentID: Integer)
    var
        DocAttachment: Record "Document Attachment";
    begin
        DocAttachment.Reset();
        DocAttachment.SetRange("Table ID", Database::Employee);
        DocAttachment.SetRange("No.", EmployeeNo);
        DocAttachment.SetRange(ID, AttachmentID);
        if not DocAttachment.FindFirst() then
            Error('Document with ID %1 not found for employee %2.', AttachmentID, EmployeeNo);
        DocAttachment.Delete(true);
    end;

    procedure InitializeDefaultCategories()
    begin
        CreateCategory('INS-COVER', 'Insurance Cover', false, true);
        CreateCategory('MARR-CERT', 'Marriage Certificate', false, true);
        CreateCategory('MED-LETTER', 'Medical Letter', false, true);
        CreateCategory('ACAD-CERT', 'Academic Certificate', false, true);
        CreateCategory('NATL-ID', 'National ID / Passport', true, true);
        CreateCategory('CONTRACT', 'Employment Contract', false, false);
        CreateCategory('OTHER', 'Other', false, true);
    end;

    procedure ValidateCategory(CategoryCode: Code[20]; CheckEmployeeUpload: Boolean)
    var
        EmpDocCat: Record "Emp Document Category";
    begin
        if CategoryCode = '' then
            Error('Document category cannot be empty.');
        if not EmpDocCat.Get(CategoryCode) then
            Error('Document category %1 does not exist.', CategoryCode);
        if EmpDocCat.Blocked then
            Error('Document category %1 is blocked.', CategoryCode);
        if CheckEmployeeUpload and not EmpDocCat."Allow Employee Upload" then
            Error('Employees are not allowed to upload documents of category %1.', CategoryCode);
    end;

    local procedure CreateCategory(Code: Code[20]; Description: Text[100]; Required: Boolean; AllowEmployeeUpload: Boolean)
    var
        EmpDocCat: Record "Emp Document Category";
    begin
        if not EmpDocCat.Get(Code) then begin
            EmpDocCat.Init();
            EmpDocCat.Code := Code;
            EmpDocCat.Description := Description;
            EmpDocCat.Required := Required;
            EmpDocCat."Allow Employee Upload" := AllowEmployeeUpload;
            EmpDocCat.Blocked := false;
            EmpDocCat.Insert(true);
        end;
    end;
}
