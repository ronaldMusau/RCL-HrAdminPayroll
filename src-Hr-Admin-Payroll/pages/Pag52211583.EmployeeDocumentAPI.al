page 52211583 "Employee Document API"
{
    PageType = API;
    SourceTable = "Document Attachment";
    APIPublisher = 'org';
    APIGroup = 'hr';
    APIVersion = 'v1.0';
    EntityName = 'employeeDocument';
    EntitySetName = 'employeeDocuments';
    DelayedInsert = true;
    ODataKeyFields = ID;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.ID) { }
                field(employeeNo; Rec."No.") { }
                field(documentCategoryCode; Rec."Document Category Code") { }
                field(fileName; Rec."File Name") { }
                field(fileExtension; Rec."File Extension") { }
                field(uploadedByEmployee; Rec."Uploaded By Employee") { }
                field(employeeUploadDate; Rec."Employee Upload Date") { }
                field(uploadedBy; Rec.User) { }
                field(attachedDate; Rec."Attached Date") { }
                field(base64FileContent; Base64FileContent)
                {
                    trigger OnValidate()
                    begin
                        HasFileContent := Base64FileContent <> '';
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Table ID", Database::Employee);
    end;

    trigger OnAfterGetRecord()
    var
        EmpDocMgmt: Codeunit "Employee Document Mgmt";
    begin
        Clear(Base64FileContent);
        if Rec."Document Reference ID".HasValue() then
            Base64FileContent := EmpDocMgmt.GetDocumentContent(Rec."No.", Rec.ID);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        EmpDocMgmt: Codeunit "Employee Document Mgmt";
        NewID: Integer;
    begin
        if Rec."No." = '' then
            Error('employeeNo is required.');
        if Rec."Document Category Code" = '' then
            Error('documentCategoryCode is required.');
        if Rec."File Name" = '' then
            Error('fileName is required.');
        if not HasFileContent then
            Error('base64FileContent is required.');

        NewID := EmpDocMgmt.UploadDocument(
            Rec."No.",
            Rec."Document Category Code",
            Rec."File Name",
            Rec."File Extension",
            Base64FileContent,
            true
        );

        Rec.Reset();
        Rec.SetRange("Table ID", Database::Employee);
        Rec.SetRange("No.", Rec."No.");
        Rec.SetRange(ID, NewID);
        if Rec.FindFirst() then;

        exit(false);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        EmpDocMgmt: Codeunit "Employee Document Mgmt";
    begin
        EmpDocMgmt.DeleteDocument(Rec."No.", Rec.ID);
        exit(false);
    end;

    var
        Base64FileContent: Text;
        HasFileContent: Boolean;
}
