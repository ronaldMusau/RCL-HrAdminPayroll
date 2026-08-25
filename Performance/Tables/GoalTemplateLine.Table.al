#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211701 "Goal Template Line"
{

    fields
    {
        field(1; "Goal ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Goal Template ID"; Code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if GoalTemplate.Get("Goal Template ID") then begin
                    "Corporate Strategic Plan ID" := GoalTemplate."Corporate Strategic Plan ID";
                end;
            end;
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Goal Category"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Goal Category";
        }
        field(5; "Corporate Strategic Plan ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans".Code;
        }
        field(6; "Strategic Objective ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Objective"."Objective ID";
        }
    }

    keys
    {
        key(Key1; "Goal ID", "Goal Template ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GoalTemplate: Record "Goal Template";
}

