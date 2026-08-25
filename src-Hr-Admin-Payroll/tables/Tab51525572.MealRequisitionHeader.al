table 51525572 "Meal Requisition Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Requisition No"; Code[20])
        {
            Caption = 'Requisition No.';
        }
        field(2; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(3; "Employee No"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if "Employee No" <> '' then begin
                    Employee.Get("Employee No");
                    "Employee Name" := Employee.FullName();
                    "Department Code" := Employee."Global Dimension 2 Code";
                    if Employee."Global Dimension 2 Code" <> '' then begin
                        DimValue.Reset();
                        DimValue.SetRange(Code, Employee."Global Dimension 2 Code");
                        if DimValue.FindFirst() then
                            "Department Name" := DimValue.Name;
                    end;
                end else begin
                    "Employee Name" := '';
                end;
            end;
        }
        field(4; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(5; "Status"; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            Caption = 'Status';
            Editable = false;
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            CalcFormula = Sum("Meal Requisition Line".Amount WHERE("Requisition No" = FIELD("Requisition No")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(7; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            Editable = false;
        }
        field(8; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Requisition No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
        HRSetup: Record "Human Resources Setup";
        SeriesCode: Code[20];
    begin
        if "Requisition No" = '' then begin
            HRSetup.Get();
            SeriesCode := HRSetup."Meal Requisition Nos";
            if SeriesCode <> '' then begin
                "Requisition No" := NoSeriesMgt.GetNextNo(SeriesCode);
            end;

        end;
        Emp.Reset();
        Emp.SetRange("User ID", USERID);
        if Emp.FindFirst() then begin
            Validate("Employee No", Emp."No.");
            "Department Code" := Emp."Global Dimension 2 Code";
        end;
        "Request Date" := Today();
    end;

    var
        Emp: Record Employee;
        DimValue: Record "Dimension Value";
}
