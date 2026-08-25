#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211678 "Strategy Workplan Lines"
{
    DrillDownPageID = "Strategy Workplan Lines";
    LookupPageID = "Strategy Workplan Lines";

    fields
    {
        field(1; No; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Strategy Plan ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans".Code;
        }
        field(3; "Activity ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Initiative".Code where("Strategic Plan ID" = field("Strategy Plan ID"));

            // TableRelation = if ("Cross Cutting" = const(false)) "Strategic Initiative".Code where("Strategic Plan ID" = field("Strategy Plan ID"));//
            //else if ("Cross Cutting"=const(true)) "Cross Cutting Activity"."Entry No";

            trigger OnValidate()
            begin
                StrategicInt.Reset;
                StrategicInt.SetRange(Code, "Activity ID");
                if StrategicInt.Find('-') then begin
                    Description := StrategicInt.Description;
                    Outcome := StrategicInt.Outcomes;
                    "Objective ID" := StrategicInt."Objective ID";
                end;
            end;
        }
        field(4; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Imported Annual Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // if "Imported Annual Target Qty" <> 0 then begin
                //     Remainder := ROUND("Imported Annual Target Qty" MOD 4, 1, '=');
                //     "Q1 Target" := ("Imported Annual Target Qty" - Remainder) / 4 + Remainder;
                //     "Q2 Target" := ("Imported Annual Target Qty" - Remainder) / 4;
                //     "Q3 Target" := ("Imported Annual Target Qty" - Remainder) / 4;
                //     "Q4 Target" := ("Imported Annual Target Qty" - Remainder) / 4;
                // end;
            end;
        }
        field(6; "Imported Annual Budget Est."; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            Begin



                // if ("Imported Annual Budget Est." <> 0) then begin
                //     "Q1 Budget" := ROUND("Imported Annual Budget Est." * ("Q1 Target" / "Imported Annual Target Qty"), 0.01, '=');
                //     "Q2 Budget" := ROUND("Imported Annual Budget Est." * ("Q2 Target" / "Imported Annual Target Qty"), 0.01, '=');
                //     "Q3 Budget" := ROUND("Imported Annual Budget Est." * ("Q3 Target" / "Imported Annual Target Qty"), 0.01, '=');
                //     "Q4 Budget" := ROUND("Imported Annual Budget Est." * ("Q4 Target" / "Imported Annual Target Qty"), 0.01, '=');
                // end;
            end;
        }
        field(7; "Primary Department"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Directorate));
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));

            trigger OnValidate()
            var
                ResponsibilityCenter: Record "Responsibility Center";
            begin
                ResponsibilityCenter.Reset;
                ResponsibilityCenter.SetRange(code, "Primary Department");
                if ResponsibilityCenter.FindFirst then
                    "Primary Department Name" := ResponsibilityCenter.Name;
            end;
        }
        //field(8; "Primary Division"; Code[50])
        //{
        //DataClassification = ToBeClassified;
        //// TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department),
        ////                                                "Direct Reports To" = field("Primary Directorate"));
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        //
        //trigger OnValidate()
        //var
        //ResponsibilityCenter: Record "Responsibility Center";
        //begin
        //ResponsibilityCenter.Reset;
        //ResponsibilityCenter.SetRange(code, "Primary Division");
        //if ResponsibilityCenter.FindFirst then
        //"Primary Division Name" := ResponsibilityCenter.Name;
        //end;
        //}
        field(9; "Q1 Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Q1 Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Q2 Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Q2 Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Q3 Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Q3 Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Q4 Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Q4 Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Planned,Actual';
            OptionMembers = Planned,Actual;
        }
        field(18; "Year Reporting Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes".Code;
        }
        field(19; "Perfomance Indicator"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Indicator".KPI;

            trigger OnValidate()
            var
                PerfomanceIndicator: Record "Performance Indicator";
            begin
                PerfomanceIndicator.Reset();
                PerfomanceIndicator.SetRange(KPI, Rec."Perfomance Indicator");
                if PerfomanceIndicator.FindFirst() then
                    "Key Performance Indicator" := PerfomanceIndicator.Description;

            end;
        }
        field(20; "Source Of Fund"; Code[50])
        {
            Caption = 'Source Of Fund';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(21; "Unit of Measure"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Desired Perfomance Direction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Increasing KPI,Decreasing KPI,Not Applicable';
            OptionMembers = "Increasing KPI","Decreasing KPI","Not Applicable";
        }
        field(23; "Framework Perspective"; Code[255])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategy Framework Perspective".Code where("Strategy Framework" = field("Strategy Framework"));
        }
        field(24; "Strategy Framework"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategy Framework".Code;
        }
        field(25; "AnnualWorkplan Achieved Target"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                            "Annual Workplan" = field(No),
                                                                            "Activity ID" = field("Activity ID")));
            FieldClass = FlowField;
        }
        field(26; "Primary Department Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        //field(27; "Primary Division Name"; Text[250])
        //{
        //    DataClassification = ToBeClassified;
        //}
        field(28; "Key Performance Indicator"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Assigned Weight(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Summation of Subactivity Weight(%)';
        }
        field(65; "Departmental Activity Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Annual Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Annual Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Achieved Performance Level"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(34; "Cross Cutting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Total Subactivity budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Sub Activity Budget Sum"; Decimal)
        {
            CalcFormula = sum("Sub Workplan Activity"."Total Budget" where("Workplan No." = field(No),
                                                                            "Activity Id" = field("Activity ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Sub Workplan Activity" where("Activity Id" = field("Activity ID"), "Workplan No." = field(No)));
        }
        field(38; Outcome; Text[255])
        {
            DataClassification = ToBeClassified;

        }
        field(39; "Objective ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; No, "Strategy Plan ID", "Activity ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        StrategicInt: Record "Strategic Initiative";
        QQuantity: Integer;
        Remainder: Integer;
        RC: Record "Responsibility Center";
        PerformanceIndicator: Record "Performance Indicator";
}

