page 52211611 "Send Doc To Portal"
{
    ApplicationArea = All;
    Caption = 'Send Document to Portal';
    PageType = StandardDialog;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(SendTo; SendTo)
                {
                    ApplicationArea = All;
                    Caption = 'Send To';
                    OptionCaption = 'All Employees,By Department,Individual Employee';
                }
                field(DepartmentCode; DepartmentCode)
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    TableRelation = "Responsibility Center";
                    Visible = SendTo = SendTo::"By Department";
                }
                field(EmployeeNo; EmployeeNo)
                {
                    ApplicationArea = All;
                    Caption = 'Employee No.';
                    TableRelation = Employee."No.";
                    Visible = SendTo = SendTo::"Individual Employee";
                }
                field(EmployeeName; EmployeeName)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name';
                    Editable = false;
                    Visible = SendTo = SendTo::"Individual Employee";
                }
            }
        }
    }

    var
        SendTo: Option "All Employees","By Department","Individual Employee";
        DepartmentCode: Code[20];
        EmployeeNo: Code[20];
        EmployeeName: Text[100];
        DocumentCode: Code[20];

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::OK then begin
            if SendTo = SendTo::"By Department" then
                if DepartmentCode = '' then
                    Error('Please select a department.');
            if SendTo = SendTo::"Individual Employee" then
                if EmployeeNo = '' then
                    Error('Please select an employee.');
        end;
        exit(true);
    end;

    procedure SetDocumentCode(DocCode: Code[20])
    begin
        DocumentCode := DocCode;
    end;

    procedure GetSendTo(): Option
    begin
        exit(SendTo);
    end;

    procedure GetDepartmentCode(): Code[20]
    begin
        exit(DepartmentCode);
    end;

    procedure GetEmployeeNo(): Code[20]
    begin
        exit(EmployeeNo);
    end;
}
