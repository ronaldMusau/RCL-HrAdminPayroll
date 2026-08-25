#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211723 "PC Perspective"
{
    DrillDownPageID = "Strategy Framework Perspective";
    LookupPageID = "Strategy Framework Perspective";

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No;
        }
        field(3; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No of Activities"; Integer)
        {
            CalcFormula = count("PC Objective" where("Framework Perspective" = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Total Weight"; Decimal)
        {
            CalcFormula = sum("PC Objective"."Assigned Weight (%)" where("Framework Perspective" = field(Code)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", "Document No")
        {
            Clustered = true;
        }
        key(Key2; "Document No")
        {
        }
    }

    fieldgroups
    {
    }
}

