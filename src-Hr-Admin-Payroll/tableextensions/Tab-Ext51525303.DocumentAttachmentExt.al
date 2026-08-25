tableextension 51525303 "Document Attachment Ext" extends "Document Attachment"
{
    fields
    {
        field(51525301; "Document Category Code"; Code[20])
        {
            Caption = 'Document Category';
            DataClassification = ToBeClassified;
            TableRelation = "Emp Document Category".Code;
        }
        field(51525302; "Uploaded By Employee"; Boolean)
        {
            Caption = 'Uploaded By Employee';
            DataClassification = ToBeClassified;
        }
        field(51525303; "Employee Upload Date"; DateTime)
        {
            Caption = 'Employee Upload Date';
            DataClassification = ToBeClassified;
        }
    }
}
