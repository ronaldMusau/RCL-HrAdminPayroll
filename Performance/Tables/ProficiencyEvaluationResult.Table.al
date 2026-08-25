#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211711 "Proficiency Evaluation Result"
{

    fields
    {
        field(1; "Performance Evaluation ID"; Code[100])
        {

            TableRelation = "Performance Evaluation".No;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Competency Template ID"; Code[100])
        {

        }
        field(4; "Competency Code"; Code[30])
        {


            // trigger OnValidate()
            // begin
            //     if Competency.Get("Competency Code") then begin
            //       "Competency Description":=Competency.Description;
            //     end;
            // end;
        }
        field(5; Description; Text[255])
        {

        }
        field(6; "Outcome Perfomance Indicator"; Code[100])
        {

            TableRelation = "Performance Indicator".KPI;

            trigger OnValidate()
            begin
                if PerformanceIndicator.Get("Outcome Perfomance Indicator") then begin
                    //"Unit of Measure":=PerformanceIndicator."Unit of Measure";
                end;
            end;
        }
        field(7; "Unit of Measure"; Code[100])
        {

            TableRelation = "Unit of Measure";
        }
        field(8; "Desired Proficiency Direction"; Option)
        {

            OptionCaption = 'Increasing KPI,Decreasing KPI,Not Applicable';
            OptionMembers = "Increasing KPI","Decreasing KPI","Not Applicable";
        }
        field(9; "Profiency Rating Scale"; Code[100])
        {

            TableRelation = "Perfomance Rating Scale".Code;
        }
        field(10; "Scale Type"; Option)
        {

            OptionCaption = 'Excellent-Poor(5-1),Excellent-Poor(1-5)';
            OptionMembers = "Excellent-Poor(5-1)","Excellent-Poor(1-5)";
        }
        field(11; "Target Qty"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Achieved Result" <> 0 then
                    "Competency Appraisal" := ("Achieved Result" / "Target Qty") * 100;
            end;
        }
        field(12; "Self-Review Qty"; Decimal)
        {


            trigger OnValidate()
            begin
                if "Self-Review Qty" > 5 then
                    Error('Score should not be above what is set up in Competency Proficiency Scale');
            end;
        }
        field(13; "AppraiserReview Qty"; Decimal)
        {


            trigger OnValidate()
            begin
                if "Self-Review Qty" > 5 then
                    Error('Score should not be above what is set up in Competency Proficiency Scale');
                "Final/Actual Qty" := "AppraiserReview Qty";
                //VALIDATE("Final/Actual Qty");
                "Raw Profiency Score" := "AppraiserReview Qty";
            end;
        }
        field(14; "Final/Actual Qty"; Decimal)
        {


            trigger OnValidate()
            begin
                if "Self-Review Qty" > 5 then
                    Error('Score should not be above what is set up in Competency Proficiency Scale');

                "Raw Profiency Score" := "Final/Actual Qty";
            end;
        }
        field(15; "Raw Profiency Score"; Decimal)
        {

        }
        field(16; "Weight %"; Decimal)
        {

        }
        field(17; "Final Weighted Line Score"; Decimal)
        {

        }
        field(18; "Intiative No"; Code[100])
        {

        }
        field(19; "Competency Description"; Text[100])
        {

        }
        field(20; "Competency Category"; Code[50])
        {
            // OptionCaption = 'Core/Required,Desired/Added Advantage';
            // OptionMembers = "Core/Required","Desired/Added Advantage";
        }
        field(21; Comments; Text[250])
        {

        }
        field(22; "Competency Type"; Enum "Competency Type")
        {

        }
        field(23; "Competency Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Performance Score';
            Editable = false;
        }
        field(24; "Achieved Result"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Target Qty" <> 0 then
                    "Competency Appraisal" := ("Achieved Result" / "Target Qty") * 100;
            end;
        }
    }

    keys
    {
        key(Key1; "Performance Evaluation ID", "Line No", "Competency Template ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        ProficiencyEval.Reset();
        ProficiencyEval.SetRange("Performance Evaluation ID", Rec."Performance Evaluation ID");
        if ProficiencyEval.FindLast() then
            "Line No" := ProficiencyEval."Line No" + 1;
    end;

    trigger OnModify()
    begin
        RecalculateScores();
    end;

    trigger OnDelete()
    begin
        RecalculateScores();
    end;

    var
        PerformanceIndicator: Record "Performance Indicator";
        Competency: Record Competency;
        ProficiencyEval: Record "Proficiency Evaluation Result";
        Perfomance: Record "Performance Evaluation";

    local procedure RecalculateScores()
    begin
        Perfomance.Reset();
        Perfomance.SetRange(No, "Performance Evaluation ID");
        if Perfomance.FindFirst() then
            Perfomance.GetFinalScore(Perfomance);
    end;
}
