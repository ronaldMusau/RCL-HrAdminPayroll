#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211750 "Training Courses Needs"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = true;
        }
        field(2; "Course Code"; Code[30])
        {
            TableRelation = "Training Courses Setup";
        }
        field(3; "Course Description"; Text[100])
        {
            CalcFormula = lookup("Training Courses Setup".Descritpion where(Code = field("Course Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Training Need Code"; Code[30])
        {
            TableRelation = "Training Needs Lines";
        }
        field(5; "Training Need Description"; Text[100])
        {
            CalcFormula = lookup("Training Needs Lines".Description where(Code = field("Training Need Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Course Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    var
        mcontent: label 'Status must be new on Training Application No.';
        mcontent2: label '. Please cancel the approval request and try again';
        TrainingNeedsLines: Record "Training Needs Lines";
        TrainingCoursesSetup: Record "Training Courses Setup";
}

