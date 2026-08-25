table 51525581 "PIP Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "PIP No"; Code[20])
        {
            Caption = 'PIP No.';
        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if "Employee No" <> '' then begin
                    Emp.Get("Employee No");
                    "Employee Name" := Emp.FullName();
                end else
                    "Employee Name" := '';
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(4; "Appraisal No"; Code[20])
        {
            Caption = 'Appraisal No.';
            TableRelation = "Staff Appraisal Header".No;
        }
        field(5; "Appraisal Period"; Code[20])
        {
            Caption = 'Appraisal Period';
            TableRelation = "HR Appraisal Periods".Code;
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
            trigger OnValidate()
            begin
                if ("End Date" <> 0D) and ("Start Date" <> 0D) and ("End Date" < "Start Date") then
                    Error('End Date must be on or after Start Date.');
            end;
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            Editable = false;
        }
        field(9; "Supervisor No"; Code[20])
        {
            Caption = 'Supervisor No.';
            TableRelation = Employee;
            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if "Supervisor No" <> '' then begin
                    Emp.Get("Supervisor No");
                    "Supervisor Name" := Emp.FullName();
                end else
                    "Supervisor Name" := '';
            end;
        }
        field(10; "Supervisor Name"; Text[100])
        {
            Caption = 'Supervisor Name';
            Editable = false;
        }
        field(11; Notes; Text[250])
        {
            Caption = 'Notes';
        }
    }

    keys
    {
        key(Key1; "PIP No")
        {
            Clustered = true;
        }
        key(K2; "Employee No", Status) { }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        PIPSetup: Record "PIP Setup";
    begin
        if "PIP No" = '' then begin
            PIPSetup.Get();
            PIPSetup.TestField("PIP Nos");
            "PIP No" := NoSeries.GetNextNo(PIPSetup."PIP Nos");
        end;
        "Start Date" := Today();
    end;
}
