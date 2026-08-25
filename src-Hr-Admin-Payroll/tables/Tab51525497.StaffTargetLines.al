table 51525497 "Staff Target Lines"
{
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            /*trigger OnValidate()
            begin
                "Objective Code" := No;
            end;*/
        }
        field(2; "Objective Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WB Dept Target Objective"."Objective No" where("Document No" = field("Department Target No"));

            trigger OnValidate()
            var
                DeptTargetObjective: Record "WB Dept Target Objective";
                TargetLine: Record "Target Lines";
            begin
                DeptTargetObjective.SetRange("Document No", "Department Target No");
                DeptTargetObjective.SetRange("Objective No", "Objective Code");
                if DeptTargetObjective.FindFirst() then begin
                    Objective := DeptTargetObjective.Objective;

                    TargetLine.SetRange("Document No", "Department Target No");
                    TargetLine.SetRange("Objective No", "Objective Code");
                    if TargetLine.FindFirst() then begin
                        "Success Measure" := TargetLine."Success Measures";
                        "Specific Action Plan" := TargetLine.Description;
                        Theme := TargetLine.Action;
                        "Due Date" := TargetLine."Due Date";
                        "Due Date Description" := TargetLine.Timelines;
                    end;
                end;
            end;
        }
        field(3; Objective; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Success Measure"; Text[250])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Staff No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(7; "Doc No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; Period; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Appraisal Periods".Period;
            TableRelation = "HR Appraisal Periods".Code;
        }
        field(9; "Specific Action Plan"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Due Date Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Big Specific Action Plan"; BLOB)
        {
            Compressed = false;
            DataClassification = ToBeClassified;
        }
        field(12; "Big Success Measure"; BLOB)
        {
            Compressed = false;
            DataClassification = ToBeClassified;
        }
        field(13; Theme; Text[100])
        {
            Caption = 'Theme';
            TableRelation = "Performance Management Themes".Title;
        }
        field(14; "Approved By Supervisor"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Staff Target Objectives"."Approved By Supervisor" where(No = field("Doc No")));
            Editable = false;
        }
        field(15; "Department Code"; Code[240])
        {
            Editable = false;
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(16; "Department Target No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WB Departmental Targets".No where(Period = field(Period), "Department Code" = field("Department Code"));

            trigger OnValidate()
            begin
                "Objective Code" := '';
                Objective := '';
            end;
        }
    }

    keys
    {
        key(Key1; "Doc No", "Staff No", No, Period)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; No, Period, Objective)
        { }
    }

    trigger OnInsert()
    begin
        //StaffTargetObjectives.GET("Doc No");
        //StaffTargetObjectives.GET("Doc No");
        StaffTargetObjectives.Reset;
        StaffTargetObjectives.SetRange(No, "Doc No");
        if StaffTargetObjectives.FindFirst then begin
            //StaffTargetObjectives.TestField(Period);
            Period := StaffTargetObjectives.Period;
            "Department Code" := StaffTargetObjectives.Department;
        end;
        if No = '' then begin
            EmpTargets.Reset;
            if EmpTargets.FindLast then begin
                No := IncStr(EmpTargets.No);
            end else begin
                No := 'EMPOBJ-001';
            end;
        end;
        //Validate(No);
    end;

    trigger OnModify()
    begin
        StaffTargetObjectives.Reset;
        StaffTargetObjectives.SetRange(No, "Doc No");
        if StaffTargetObjectives.FindFirst then begin
            //StaffTargetObjectives.TestField(Period);
            Period := StaffTargetObjectives.Period;
            "Department Code" := StaffTargetObjectives.Department;
        end;
    end;

    var
        EmpTargets: Record "Staff Target Lines";
        StaffTargetObjectives: Record "Staff Target Objectives";

    procedure setCriticalFields()
    begin
        StaffTargetObjectives.Reset;
        StaffTargetObjectives.SetRange(No, "Doc No");
        if StaffTargetObjectives.FindFirst then begin
            Period := StaffTargetObjectives.Period;
            "Department Code" := StaffTargetObjectives.Department;
            "Staff No" := StaffTargetObjectives."Staff No";
        end;
    end;
}