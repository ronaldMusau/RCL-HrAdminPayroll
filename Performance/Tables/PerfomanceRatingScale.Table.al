#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211692 "Perfomance Rating Scale"
{
    DrillDownPageID = "Perfomance Rating Scales";
    LookupPageID = "Perfomance Rating Scales";

    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Scale Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Excellent-Poor(5-1),Excellent-Poor(1-5),Impact(1-4)';
            OptionMembers = "Excellent-Poor(5-1)","Excellent-Poor(1-5)","Impact(1-4)";

            trigger OnValidate()
            begin
                if "Scale Type" = "scale type"::"Excellent-Poor(1-5)" then begin
                    "Max Excellent Raw Score" := 1;
                    "Least Poor Raw Score" := 5;
                end;

                if "Scale Type" = "scale type"::"Excellent-Poor(5-1)" then begin
                    "Max Excellent Raw Score" := 5;
                    "Least Poor Raw Score" := 1;
                end;

                if "Scale Type" = "scale type"::"Impact(1-4)" then begin
                    "Max Excellent Raw Score" := 4;
                    "Least Poor Raw Score" := 1;
                end;
            end;
        }
        field(4; "Max Excellent Raw Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Least Poor Raw Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Created On"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created On" := Today;
    end;
}

