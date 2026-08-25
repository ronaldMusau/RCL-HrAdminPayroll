table 51525566 "Compassionate Checks"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            Caption = 'No.';
        }

        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if "Employee No." <> '' then begin
                    Employee.Get("Employee No.");
                    "Employee Name" := Employee.FullName();
                end else begin
                    "Employee Name" := '';
                end;
            end;
        }

        field(3; "Type"; Code[20])
        {
            Caption = 'Type';
            TableRelation = "Compassionate Check Setup";
            trigger OnValidate()
            var
                Employee: Record Employee;
                SetupRecord: Record "Compassionate Check Setup";
                SetupLine: Record "Compassionate Check Setup Line";
            begin
                if "Type" = '' then
                    exit;

                if not SetupRecord.Get("Type") then
                    exit;

                // Set default amount
                "Amount" := SetupRecord."Amount";

                // Try to override with job grade-specific amount
                if "Employee No." = '' then
                    exit;

                if not Employee.Get("Employee No.") then
                    exit;

                if SetupLine.Get("Type", Employee."Salary Scale") then
                    "Amount" := SetupLine."Amount";
            end;
        }

        field(4; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }

        field(5; "Employee Name"; Text[100])
        {
            Editable = false;
            Caption = 'Employee Name';
        }

        field(6; "Request Date"; Date)
        {
            Caption = 'Request Date';
            Editable = false;
        }

        field(8; "Created By"; Code[50])
        {
            Editable = false;
            Caption = 'Created By';
        }

        field(9; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Rejected,Approved';
            OptionMembers = Open,"Pending Approval",Rejected,Approved;
        }

        field(10; "Remarks"; Text[500])
        {
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
        key(EmployeeKey; "Employee No.") { }
    }

    trigger OnInsert()
    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgmt: Codeunit "No. Series";
        Employee: Record Employee;
    begin
        if "No." = '' then begin
            HumanResSetup.Get();
            HumanResSetup.TestField("Compassionate Check Nos.");
            "No." := NoSeriesMgmt.GetNextNo(HumanResSetup."Compassionate Check Nos.");
        end;

        "Request Date" := Today;
        "Created By" := UserId;
        Employee.Reset();
        Employee.SetRange("User ID", UserId);
        if Employee.FindFirst() then
            Validate("Employee No.", Employee."No.");
    end;
}
