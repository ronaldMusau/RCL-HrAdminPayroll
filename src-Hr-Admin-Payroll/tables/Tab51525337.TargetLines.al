table 51525571 "Target Lines"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "WB Departmental Targets".No;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(24; "Objective No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "WB Dept Target Objective"."Objective No" where("Document No" = field("Document No"));

            trigger OnValidate()
            var
                DeptTargetObjective: Record "WB Dept Target Objective";
            begin
                DeptTargetObjective.SetRange("Document No", "Document No");
                DeptTargetObjective.SetRange("Objective No", "Objective No");
                if DeptTargetObjective.FindFirst() then begin
                    Objective := DeptTargetObjective.Objective;
                    "Goal Statement" := DeptTargetObjective."Goal Statement";
                end else begin
                    Objective := '';
                    "Goal Statement" := '';
                end;
            end;
        }

        field(5; "Objective"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Goal Statement"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(16; Action; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(17; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(18; "Responsible Person"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Jobs"."Job ID";

            trigger OnValidate()
            var
                JobRec: Record "Company Jobs";
            begin
                JobRec.Reset();
                JobRec.SetRange("Job ID", Rec."Responsible Person");
                if JobRec.FindFirst() then
                    Rec."Responsible Person Name" := JobRec."Job Description"
                else
                    Rec."Responsible Person Name" := '';
            end;
        }
        field(19; "Responsible Person Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Resources Needed"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(21; Timelines; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Success Measures"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(23; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No", "Objective No", "Line No")
        {
            Clustered = true;
        }

    }
}
