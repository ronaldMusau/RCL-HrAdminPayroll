page 52211582 "Emp Doc Category API"
{
    PageType = API;
    SourceTable = "Emp Document Category";
    APIPublisher = 'org';
    APIGroup = 'hr';
    APIVersion = 'v1.0';
    EntityName = 'employeeDocumentCategory';
    EntitySetName = 'employeeDocumentCategories';
    DelayedInsert = true;
    ODataKeyFields = "Code";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(code; Rec."Code") { }
                field(description; Rec.Description) { }
                field(required; Rec.Required) { }
                field(allowEmployeeUpload; Rec."Allow Employee Upload") { }
                field(blocked; Rec.Blocked) { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Blocked, false);
    end;
}
