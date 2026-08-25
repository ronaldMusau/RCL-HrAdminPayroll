#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211731 "Sub Objective Evaluation"
{

    fields
    {
        field(1; "Performance Evaluation ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Evaluation".No;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Scorecard ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"));
        }
        field(4; "Scorecard Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Objective/Initiative"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Outcome Perfomance Indicator"; Code[100])
        {
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(8; "Desired Perfomance Direction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Increasing KPI,Decreasing KPI,Not Applicable';
            OptionMembers = "Increasing KPI","Decreasing KPI","Not Applicable";
        }
        field(9; "Performance Rating Scale"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Rating Scale".Code;

            trigger OnValidate()
            begin
                /*PerfomanceRatingScale.RESET;
                PerfomanceRatingScale.SETRANGE(Code,"Performance Rating Scale");
                IF PerfomanceRatingScale.FIND('-') THEN BEGIN
                  "Scale Type":=PerfomanceRatingScale."Scale Type";
                END;*/

            end;
        }
        field(10; "Scale Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Excellent-Poor(5-1),Excellent-Poor(1-5)';
            OptionMembers = "Excellent-Poor(5-1)","Excellent-Poor(1-5)";
        }
        field(11; "Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Self-Review Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "AppraiserReview Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Final/Actual Qty"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*PerformanceRatingRawScore:=0;
                
                VALIDATE("Performance Rating Scale");
                IF ("Desired Perfomance Direction"="Desired Perfomance Direction"::"Increasing KPI") THEN BEGIN
                   IF "Scale Type"="Scale Type"::"Excellent-Poor(5-1)" THEN BEGIN
                      "Raw Performance Score":=(((((2*"Target Qty")-"Final/Actual Qty")/(2*"Target Qty"))*-4)+5);
                   END;
                   IF "Scale Type"="Scale Type"::"Excellent-Poor(1-5)" THEN BEGIN
                      "Raw Performance Score":= (((((2*"Target Qty")-"Final/Actual Qty")/(2*"Target Qty"))*4)+1);
                   END;
                END;
                
                IF ("Desired Perfomance Direction"="Desired Perfomance Direction"::"Decreasing KPI") THEN BEGIN
                   IF "Scale Type"="Scale Type"::"Excellent-Poor(5-1)" THEN BEGIN
                      "Raw Performance Score":=((5+(-4*("Final/Actual Qty"/(2*"Target Qty")))));
                   END;
                   IF "Scale Type"="Scale Type"::"Excellent-Poor(1-5)" THEN BEGIN
                     "Raw Performance Score":=((1+(4*("Final/Actual Qty"/(2*"Target Qty")))));
                   END;
                END;
                
                
                PerformanceRatingRawScore:="Raw Performance Score";
                
                IF (PerformanceRatingRawScore<0) THEN
                    PerformanceRatingRawScore:=0;
                
                IF (PerformanceRatingRawScore>5) THEN
                   PerformanceRatingRawScore:=5;
                
                PerfomanceScaleLine.RESET;
                PerfomanceScaleLine.SETRANGE("Performance Scale ID","Performance Rating Scale");
                IF PerfomanceScaleLine.FIND('-') THEN BEGIN
                   REPEAT
                    IF  ((PerformanceRatingRawScore>=PerfomanceScaleLine."Lower Limit Criteria Value") AND
                       (PerformanceRatingRawScore<=PerfomanceScaleLine."Upper Limit Criteria Value")) THEN BEGIN
                         "Raw Performance Grade":=PerfomanceScaleLine."Perfomance Grade";
                         //MESSAGE('Raw Performance Grade %1',"Raw Performance Grade");
                
                    END;
                   UNTIL PerfomanceScaleLine.NEXT=0;
                END;
                
                VALIDATE("Weight %");
                */

            end;
        }
        field(15; "Raw Performance Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Weight %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //"Final Weighted Line Score":=("Weight %"/100)*"Raw Performance Score";
            end;
        }
        field(17; "Final Weighted Line Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Intiative No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Primary Department"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        //field(20; "Primary Division"; Code[50])
        //{
        //DataClassification = ToBeClassified;
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Division/Section"));
        //}
        field(21; "Raw Performance Grade"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Key Performance Indicator"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Sub Intiative No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Sub Intiative Description"; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Performance Indicator"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Performance Evaluation ID", "Scorecard ID", "Sub Intiative No", "Line No")
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
    }
    trigger OnInsert()
    var
        SubObjectiveEvaluation: Record "Sub Objective Evaluation";
    begin
        SubObjectiveEvaluation.Reset();
        SubObjectiveEvaluation.SetRange("Performance Evaluation ID", Rec."Performance Evaluation ID");
        SubObjectiveEvaluation.SetRange("Scorecard ID", Rec."Scorecard ID");
        SubObjectiveEvaluation.SetRange("Sub Intiative No", Rec."Sub Intiative No");
        if SubObjectiveEvaluation.findlast() then
            Rec."Line No" := SubObjectiveEvaluation."Line No" + 1
        else
            Rec."Line No" := 1;
    end;

    var
        PerformanceIndicator: Record "Performance Indicator";
        PerfomanceRatingScale: Record "Perfomance Rating Scale";
        PerfomanceScaleLine: Record "Perfomance Scale Line";
        PerformanceRatingRawScore: Decimal;
}
