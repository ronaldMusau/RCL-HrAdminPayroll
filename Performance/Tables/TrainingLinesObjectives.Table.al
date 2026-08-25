#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211746 "Training Lines Objectives"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Objective Id"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Lines Objectives";
        }
        field(3; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Objective; Text[100])
        {
        }
        field(5; "Goal ID"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Goal Hub";
        }
        field(6; "Goal Description"; Text[100])
        {
            CalcFormula = lookup("Training Goal Hub".Description where(Code = field("Goal ID")));
            FieldClass = FlowField;
        }
        field(7; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Need,Plan;
        }
    }

    keys
    {
        key(Key1; "Entry No", "Objective Id", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

