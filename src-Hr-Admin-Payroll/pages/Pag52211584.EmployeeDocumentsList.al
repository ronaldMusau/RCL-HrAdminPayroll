page 52211584 "Employee Documents List"
{
    ApplicationArea = All;
    Caption = 'Employee Documents';
    PageType = List;
    SourceTable = "Document Attachment";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(employeeNo; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Employee No.';
                    ToolTip = 'Specifies the employee number.';
                }
                field(employeeName; EmployeeName)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name';
                    Editable = false;
                    ToolTip = 'Specifies the employee full name.';
                }
                field("Document Category Code"; Rec."Document Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'Document Category';
                    ToolTip = 'Specifies the document category.';
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Caption = 'File Name';
                    ToolTip = 'Click to preview the document.';

                    trigger OnDrillDown()
                    begin
                        if Rec."Document Reference ID".HasValue then
                            Rec.Export(true);
                    end;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    Caption = 'File Type';
                }
                field("Uploaded By Employee"; Rec."Uploaded By Employee")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Upload';
                    ToolTip = 'Specifies whether this was uploaded by the employee via ESS.';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Caption = 'Uploaded By';
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                    Caption = 'Upload Date';
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(5200),
                              "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PreviewDoc)
            {
                ApplicationArea = All;
                Caption = 'Preview Document';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                begin
                    if Rec."File Name" <> '' then
                        Rec.Export(true);
                end;
            }
            action(OpenEmployeeCard)
            {
                ApplicationArea = All;
                Caption = 'Open Employee Card';
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;

                trigger OnAction()
                var
                    Employee: Record Employee;
                    HREmployee: Page "HR Employee";
                begin
                    if Employee.Get(Rec."No.") then begin
                        HREmployee.SetRecord(Employee);
                        HREmployee.Run();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Table ID", Database::Employee);
    end;

    trigger OnAfterGetRecord()
    var
        Employee: Record Employee;
    begin
        if Employee.Get(Rec."No.") then
            EmployeeName := Employee."First Name" + ' ' + Employee."Last Name"
        else
            EmployeeName := '';
    end;

    var
        EmployeeName: Text[100];
}
