#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211696 "Competency Template Line"
{

    fields
    {
        field(1; "Competency Template ID"; Code[30])
        {

            TableRelation = "Competency Per Template".Code;
        }
        field(2; "Line No."; Integer)
        {

        }
        field(3; "Competency Code"; Code[100])
        {

            TableRelation = Competency."No.";

            trigger OnValidate()
            begin
                if Competency.Get("Competency Code") then begin
                    "Competency Description" := Competency.Description;
                    "Competency Category" := Competency."Competency Category";
                end;
            end;
        }
        field(4; "Competency Description"; Text[100])
        {

        }
        field(5; "Competency Category"; Code[50])
        {

            // OptionCaption = 'Core/Required,Desired/Added Advantage';
            // OptionMembers = "Core/Required","Desired/Added Advantage";
        }
        field(6; Description; Text[255])
        {

        }
        field(7; "Weight %"; Decimal)
        {

        }
        field(8; "Job Grade"; Code[30])
        {

            TableRelation = "Salary Scales".Scale;
        }
        field(9; "Competency Type"; Enum "Competency Type")
        {

        }
    }

    keys
    {
        key(Key1; "Competency Template ID", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Competency: Record Competency;
}

