#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211693 "Perfomance Scale Line"
{

    fields
    {
        field(1; "Performance Scale ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Perfomance Grade"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Default Score Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Behavioral Indicator"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Lower Limit Target (%)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Scale Type" = "scale type"::"Excellent-Poor(5-1)") then begin
                    "Lower Limit Criteria Value" := ((((200 - "Lower Limit Target (%)") / 200) * -4) + 5);
                    "Criteria Value Range Span" := "Upper Limit Criteria Value" - "Lower Limit Criteria Value";
                end;

                if ("Scale Type" = "scale type"::"Excellent-Poor(1-5)") then begin
                    "Lower Limit Criteria Value" := (((200 - "Lower Limit Target (%)" / 200) * 4) + 1);
                    "Criteria Value Range Span" := "Lower Limit Criteria Value" - "Upper Limit Criteria Value";
                end;

                // Impact(1-4): BRD band assignment
                if ("Scale Type" = "scale type"::"Impact(1-4)") then begin
                    if "Lower Limit Target (%)" >= 121 then
                        "Default Score Value" := 4
                    else if "Lower Limit Target (%)" >= 100 then
                        "Default Score Value" := 3
                    else if "Lower Limit Target (%)" >= 61 then
                        "Default Score Value" := 2
                    else
                        "Default Score Value" := 1;
                end;
            end;
        }
        field(6; "Upper Limit Target (%)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Scale Type" = "scale type"::"Excellent-Poor(5-1)") then begin
                    //"Upper Limit Criteria Value":=((((200-"Upper Limit Target (%)")/200)*4)+1);
                    "Upper Limit Criteria Value" := ((((200 - "Upper Limit Target (%)") / 200) * -4) + 5);
                    "Criteria Value Range Span" := "Upper Limit Criteria Value" - "Lower Limit Criteria Value";
                end;

                if ("Scale Type" = "scale type"::"Excellent-Poor(1-5)") then begin
                    //"Upper Limit Criteria Value":=((((200-"Upper Limit Target (%)")/200)*-4)+5);
                    "Upper Limit Criteria Value" := ((((200 - "Upper Limit Target (%)") / 200) * 4) + 1);
                    "Criteria Value Range Span" := "Lower Limit Criteria Value" - "Upper Limit Criteria Value";
                end;
            end;
        }
        field(7; "Lower Limit Criteria Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Upper Limit Criteria Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Criteria Value Range Span"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Scale Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Excellent-Poor(5-1),Excellent-Poor(1-5),Impact(1-4)';
            OptionMembers = "Excellent-Poor(5-1)","Excellent-Poor(1-5)","Impact(1-4)";
        }
    }

    keys
    {
        key(Key1; "Performance Scale ID", "Perfomance Grade", "Scale Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PerfomanceRatingScale: Record "Perfomance Rating Scale";
}

