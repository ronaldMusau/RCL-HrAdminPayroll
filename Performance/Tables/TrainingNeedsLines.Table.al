#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211751 "Training Needs Lines"
{

    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Appraisal,Government Directive,Other';
            OptionMembers = Appraisal,"Government Directive",Other;
        }
        field(4; Comments; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No. of Linked Objectives"; Integer)
        {
            CalcFormula = count("Training Lines Objectives" where(Code = field(Code),
                                                                   Type = const(Need)));
            FieldClass = FlowField;
        }
        field(6; "Training Header No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Courses Needs";
        }
        field(7; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Created By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Training Header No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            HRSetup.Get;
            // HRSetup.TestField(HRSetup."Training Application Nos.");
            //Code := NoSeriesMgt.GetNextNo(HRSetup."Training Application Nos.", 0D, true);
        end;

        "Created By" := UserId;
        "Created On" := CurrentDatetime;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit "No. Series";
}

