#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211715 "Board Activities"
{
    DrillDownPageID = "Board Activities";
    LookupPageID = "Board Activities";

    fields
    {
        field(1; "AWP No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Strategy Workplan".No;

        }
        field(2; "Board Activity Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Board Activities Setup".Code;

            trigger OnValidate()
            var
                annual: record "Annual Strategy Workplan";

                BOARD: Record "Board Activities";
            begin
                if BoardSetup.Get("Board Activity Code") then begin
                    "Board Activity Description" := BoardSetup.Description;
                end;

                annual.Reset();
                annual.SetRange(annual.No, BOArd."AWP No");
                IF annual.FindSet then
                    //     rec."Primary Directorate" := annual."Primary Directorate";
                    // rec."Primary Department" := annual.Department;
                    rec."Primary Department" := annual."Primary Department";

            end;
        }
        field(3; "Board Activity Description"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Activity Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Activity Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Unit of Measure"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(7; "WT(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Target; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Achieved Targets"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Framework Perspective"; Code[255])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategy Framework Perspective".Code where("Strategy Framework" = field("Strategy Framework"));
        }
        field(11; "Strategy Framework"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategy Framework";
        }
        field(12; "Key Performance Indicator"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Indicator";

            trigger OnValidate()
            begin
                PerformanceIndicator.Reset;
                PerformanceIndicator.SetRange(KPI, "Key Performance Indicator");
                if PerformanceIndicator.FindSet then begin
                    "Outcome Performance Indicator" := PerformanceIndicator.Description;
                    "Unit of Measure" := PerformanceIndicator."Unit of Measure";
                end;
            end;
        }
        field(13; "Outcome Performance Indicator"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Previous Annual Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        //field(15; "Primary Division"; Code[50])
        //{
        //DataClassification = ToBeClassified;
        //TableRelation = "Responsibility Center".Code where("Operating Unit Type" = filter("Division/Section"));
        //// TableRelation = "Annual Strategy Workplan" where(No = FIELD("AWP No")));
        //// TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Department///center"));//
        ////                                      "Direct Reports To"=field("Primary Directorate"));
        //}
        field(16; "Item Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Primary Department"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code where("Operating Unit Type" = filter(Department));
            //TableRelation = "Annual Strategy Workplan" where(No = FIELD("AWP No"));
            // TableRelation = "Responsibility Center" WHERE("Operating Unit Type" = filter(Directorate));
        }
        field(18; "AnnualWorkplan Achieved Target"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("AWP No"),
                                                                            "Activity ID" = field("Activity Code")));
            //"Annual Workplan" = field(No),
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "AWP No", "Board Activity Code", "Activity Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        BoardSetup: Record "Board Activities Setup";
        PerformanceIndicator: Record "Performance Indicator";
}

