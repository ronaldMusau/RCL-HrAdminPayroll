#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211699 "Objective Evaluation Result"
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
        field(3; "Scorecard ID"; Code[50])
        {

            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"));
        }
        field(4; "Scorecard Line No"; Integer)
        {

        }
        field(5; "Objective/Initiative"; Text[2048])
        {

        }
        field(6; "Outcome Perfomance Indicator"; Code[100])
        {

            TableRelation = "Performance Indicator";

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
        field(8; "Desired Perfomance Direction"; Option)
        {

            OptionCaption = 'Increasing KPI,Decreasing KPI,Not Applicable';
            OptionMembers = "Increasing KPI","Decreasing KPI","Not Applicable";
        }
        field(9; "Performance Rating Scale"; Code[100])
        {

            TableRelation = "Perfomance Rating Scale".Code;

            trigger OnValidate()
            begin
                PerfomanceRatingScale.Reset;
                PerfomanceRatingScale.SetRange(Code, "Performance Rating Scale");
                if PerfomanceRatingScale.Find('-') then begin
                    "Scale Type" := PerfomanceRatingScale."Scale Type";
                end;
            end;
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
                    "Performance Appraisal" := ("Achieved Result" / "Target Qty") * 100;
            end;
        }
        field(12; "Self-Review Qty"; Decimal)
        {

        }
        field(13; "AppraiserReview Qty"; Decimal)
        {

        }
        field(14; "Final/Actual Qty"; Decimal)
        {


            trigger OnValidate()
            begin
                PerformanceRatingRawScore := 0;

                Validate("Performance Rating Scale");
                if ("Desired Perfomance Direction" = "desired perfomance direction"::"Increasing KPI") then begin
                    if "Scale Type" = "scale type"::"Excellent-Poor(5-1)" then begin
                        "Raw Performance Score" := (((((2 * "Target Qty") - "Final/Actual Qty") / (2 * "Target Qty")) * -4) + 5);
                    end;
                    if "Scale Type" = "scale type"::"Excellent-Poor(1-5)" then begin
                        "Raw Performance Score" := (((((2 * "Target Qty") - "Final/Actual Qty") / (2 * "Target Qty")) * 4) + 1);
                    end;
                end;

                if ("Desired Perfomance Direction" = "desired perfomance direction"::"Decreasing KPI") then begin
                    if "Scale Type" = "scale type"::"Excellent-Poor(5-1)" then begin
                        "Raw Performance Score" := ((5 + (-4 * ("Final/Actual Qty" / (2 * "Target Qty")))));
                    end;
                    if "Scale Type" = "scale type"::"Excellent-Poor(1-5)" then begin
                        "Raw Performance Score" := ((1 + (4 * ("Final/Actual Qty" / (2 * "Target Qty")))));
                    end;
                end;


                PerformanceRatingRawScore := "Raw Performance Score";

                if (PerformanceRatingRawScore < 0) then
                    PerformanceRatingRawScore := 0;

                if (PerformanceRatingRawScore > 5) then
                    PerformanceRatingRawScore := 5;

                PerfomanceScaleLine.Reset;
                PerfomanceScaleLine.SetRange("Performance Scale ID", "Performance Rating Scale");
                if PerfomanceScaleLine.Find('-') then begin
                    repeat
                        if ((PerformanceRatingRawScore >= PerfomanceScaleLine."Lower Limit Criteria Value") and
                           (PerformanceRatingRawScore <= PerfomanceScaleLine."Upper Limit Criteria Value")) then begin
                            "Raw Performance Grade" := PerfomanceScaleLine."Perfomance Grade";
                            //MESSAGE('Raw Performance Grade %1',"Raw Performance Grade");

                        end;
                    until PerfomanceScaleLine.Next = 0;
                end;

                Validate("Weight %");
            end;
        }
        // field(15; "Raw Performance Score"; Decimal)
        // {
        //     Caption = 'Performance Score';
        //     //AutoFormatType = 10;
        //     //AutoFormatExpression = '<precision, 2:4><standard format,0>%';

        //     trigger OnValidate()
        //     begin
        //         if "Raw Performance Score" > 99 then begin
        //             "Rating Scale" := "Rating Scale"::Excellent;
        //         end else begin
        //             if "Raw Performance Score" >= 90 then
        //                 "Rating Scale" := "Rating Scale"::"Very Good";
        //             if "Raw Performance Score" >= 70 then
        //                 "Rating Scale" := "Rating Scale"::Good;
        //             if "Raw Performance Score" >= 50 then begin
        //                 "Rating Scale" := "Rating Scale"::Fair;
        //             end else begin
        //                 "Rating Scale" := "Rating Scale"::Poor;
        //             end;
        //         end;
        //     end;
        // }
        field(15; "Raw Performance Score"; Decimal)
        {
            Caption = 'Performance Score';
            //AutoFormatType = 10;
            //AutoFormatExpression = '<precision, 2:4><standard format,0>%';

            trigger OnValidate()
            begin
                if "Raw Performance Score" >= 121 then
                    "Rating Scale" := "Rating Scale"::"Transformational Impact"
                else
                    if "Raw Performance Score" >= 100 then
                        "Rating Scale" := "Rating Scale"::"Significant Impact"
                    else
                        if "Raw Performance Score" >= 61 then
                            "Rating Scale" := "Rating Scale"::"Expected Impact"
                        else
                            "Rating Scale" := "Rating Scale"::"Developing Impact";
            end;
        }
        field(16; "Weight %"; Decimal)
        {


            trigger OnValidate()
            begin
                "Final Weighted Line Score" := ("Weight %" / 100) * "Raw Performance Score";
            end;
        }
        field(17; "Final Weighted Line Score"; Decimal)
        {

        }
        field(18; "Intiative No"; Code[100])
        {

        }
        field(19; "Primary Department"; Code[50])
        {

            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        //field(20; "Primary Division"; Code[50])
        //{
        //
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        //}
        field(21; "Raw Performance Grade"; Code[50])
        {

        }
        field(22; "Key Performance Indicator"; Text[2048])
        {

        }
        field(23; Comments; Text[2048])
        {

        }
        field(24; "Average Quantity"; Decimal)
        {


        }
        field(25; "Departmental Objective"; Text[2048])
        {
            TableRelation = AppraisalDeptObjectives.Description where("Primary Department" = field("Primary Department"), "Appraisal Period" = field("Appraisal Period"));
            // TableRelation = "Departmental Objectives Lines".Objective where("Department Code" = field("Primary Department"), "Appraisal Period" = field("Appraisal Period"));
            trigger OnLookup()
            var
                DepartmentalObjectives: Record AppraisalDeptObjectives;
                DepartmentalObjectives1: Record AppraisalDeptObjectives;
            begin
                DepartmentalObjectives.Reset();
                DepartmentalObjectives.SetRange("Primary Department", Rec."Primary Department");
                DepartmentalObjectives.SetRange("Appraisal Period", "Appraisal Period");
                if Page.RunModal(Page::"Dep Objectives", DepartmentalObjectives) = Action::LookupOK then begin
                    //     DepartmentalObjectives1.Reset();
                    // DepartmentalObjectives1.SetRange("Primary Department",Rec."Primary Department");
                    // DepartmentalObjectives1.SetRange("Appraisal Period","Year Reporting Code");
                    // if DepartmentalObjectives1.FindFirst() then begin
                    // end;
                    Rec."Departmental Objective" := DepartmentalObjectives.Description;
                end;
            end;
        }
        field(26; "Appraisal Period"; Code[30])
        {
            TableRelation = "Appraisal Periods";
        }
        field(27; "Achieved Result"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Results Achieved';

            trigger OnValidate()
            begin
                if "Target Qty" <> 0 then
                    "Performance Appraisal" := ("Achieved Result" / "Target Qty") * 100;
            end;
        }
        field(28; "Rating Scale"; Enum "Rating Scale")
        {
            DataClassification = ToBeClassified;
            Caption = 'Rating Scale';
            Editable = false;
        }
        field(29; "Performance Appraisal"; Decimal)
        {
            Caption = 'Performance Score';
            // Editable = false;
        }
        field(30; Reasons; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Performance Indicator"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Performance Evaluation ID", "Appraisal Period", "Scorecard ID", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

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
        PerfomanceRatingScale: Record "Perfomance Rating Scale";
        PerfomanceScaleLine: Record "Perfomance Scale Line";
        PerformanceRatingRawScore: Decimal;
        Perfomance: Record "Performance Evaluation";

    local procedure RecalculateScores()
    begin
        Perfomance.Reset();
        Perfomance.SetRange(No, "Performance Evaluation ID");
        if Perfomance.FindFirst() then
            Perfomance.GetFinalScore(Perfomance);
    end;
}
