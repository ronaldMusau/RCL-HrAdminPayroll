#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211749 "Training Courses Setup"
{
    LookupPageId = "Training Courses Setup";
    DrillDownPageId = "Training Courses Setup";

    fields
    {
        field(1; "Code"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Descritpion; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(3; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Domain; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Domains";
        }
        field(5; "No. of Staff Trained"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Budget Spent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Name of Course"; Text[1050])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Institution; Code[1000])
        {
            TableRelation = Vendor;
        }
        field(9; "No Series"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(26; Type; Option)
        {
            OptionMembers = Primary,Other;
        }
        field(27; "Course ID"; Code[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Courses Setup";

            trigger OnValidate()
            begin
                if "Course ID" <> '' then begin
                    if Courses.Get("Course ID") then begin
                        Descritpion := Courses.Descritpion;
                    end;
                end else begin
                    Descritpion := '';
                end;
            end;
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
        fieldgroup(DropDown; "Code", Descritpion)
        {
        }
    }

    trigger OnInsert()
    begin
        HumanResourcesSetup.Get();
        //HumanResourcesSetup.TestField("Training Courses Nos");
        if Code = '' then begin
            // Code := NoSeriesManagement.GetNextNo(HumanResourcesSetup."Training Courses Nos", 0D, true);
        end
    end;

    var
        NoSeriesManagement: Codeunit "No. Series";
        HumanResourcesSetup: Record "Human Resources Setup";
        Courses: Record "Training Courses Setup";

}

