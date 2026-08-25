#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211675 "Strategic Initiative"
{
    DrillDownPageID = "Strategic Initiatives";
    LookupPageID = "Strategic Initiatives";

    fields
    {
        field(1; "Strategic Plan ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans".Code;
        }
        field(2; "Theme ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Theme"."Theme ID" where("Strategic Plan ID" = field("Strategic Plan ID"));
        }
        field(3; "Objective ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Objective"."Objective ID" where("Theme ID" = field("Theme ID"),
                                                                        "Strategic Plan ID" = field("Strategic Plan ID"));
        }
        field(4; "Strategy ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Strategy."Strategy ID" where("Objective ID" = field("Objective ID"),
                                                          "Theme ID" = field("Theme ID"),
                                                          "Objective ID" = field("Objective ID"),
                                                          "Strategic Plan ID" = field("Strategic Plan ID"));
        }
        field(5; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Framework Perspective"; Code[255])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategy Framework Perspective".Code where("Strategy Framework" = field("Strategy Framework"));
        }
        field(8; "Total Posted Planned Target"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategic Plan ID"),
                                                                            "Entry Type" = const(Planned),
                                                                            "Activity ID" = field(Code)));
            Caption = 'Total Posted Planned Target';
            FieldClass = FlowField;
        }
        field(9; "PC Planned Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Total Achieved Target"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategic Plan ID"),
                                                                            "Entry Type" = const(Actual),
                                                                            "Activity ID" = field(Code)));
            FieldClass = FlowField;
        }
        field(11; "Total Posted Planned Budget"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry"."Cost Amount" where("Strategic Plan ID" = field("Strategic Plan ID"),
                                                                                 "Entry Type" = const(Planned),
                                                                                 "Activity ID" = field(Code)));
            FieldClass = FlowField;
        }
        field(12; "Total Usage Budget"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry"."Cost Amount" where("Strategic Plan ID" = field("Strategic Plan ID"),
                                                                                 "Entry Type" = const(Actual),
                                                                                 "Activity ID" = field(Code)));
            FieldClass = FlowField;
        }
        field(13; "Strategy Framework"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategy Framework";
        }
        field(14; "Primary Department"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Directorate));
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
            trigger OnValidate()
            begin
                RC.Reset;
                RC.SetRange(Code, "Primary Department");
                if RC.FindSet then begin
                    "Primary Department Name" := RC.Name;
                end;
            end;
        }
        //field(15; "Primary Division"; Code[50])
        //{
        //DataClassification = ToBeClassified;
        //// TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Division/Section"));
        //
        //trigger OnValidate()
        //begin
        //RC.Reset;
        //RC.SetRange(Code, "Primary Division");
        //if RC.FindSet then begin
        //"Primary Division Name" := RC.Name;
        //end;
        //end;
        //}
        field(16; "Collective target"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Strategic Int Planning Lines"."Target Budget" where("Strategic Plan ID" = field("Strategic Plan ID"),
                                                                                 "Theme ID" = field("Theme ID"),
                                                                                 "Objective ID" = field("Objective ID"),
                                                                                 "Strategy ID" = field("Strategy ID"),
                                                                                 Code = field(Code), "Primary Department" = field("Primary Department")));

        }
        field(17; "Collective Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Annual Reporting Codes"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes".Code;
        }
        field(19; "CSP Planned Target"; Decimal)
        {
            CalcFormula = sum("Strategic Int Planning Lines"."Target Qty" where("Strategic Plan ID" = field("Strategic Plan ID"),
                                                                                 "Theme ID" = field("Theme ID"),
                                                                                 "Objective ID" = field("Objective ID"),
                                                                                 "Strategy ID" = field("Strategy ID"),
                                                                                 Code = field(Code),
                                                                                 "Primary Department" = field("Primary Department")));
            FieldClass = FlowField;
        }
        field(20; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(21; "Perfomance Indicator"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Indicator";

            trigger OnValidate()
            begin
                PIndicator.Reset;
                PIndicator.SetRange(KPI, "Perfomance Indicator");
                if PIndicator.FindSet then begin
                    "Key Perfromance Indicator" := PIndicator.Description;
                    "Unit of Measure" := PIndicator."Unit of Measure";
                end;
            end;
        }
        field(22; "Source Of Fund"; Code[50])
        {
            Caption = 'Source Of Fund';
            DataClassification = ToBeClassified;
            TableRelation = "Funding Source".Code where(Blocked = const(false));
        }
        field(23; "Desired Perfomance Direction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Increasing KPI,Decreasing KPI,Not Applicable';
            OptionMembers = "Increasing KPI","Decreasing KPI","Not Applicable";
        }
        field(24; "Key Perfromance Indicator"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Primary Department Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        //field(26; "Primary Division Name"; Text[250])
        //{
        //    DataClassification = ToBeClassified;
        //}
        field(27; Outcomes; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Goal ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Goals"."Goal ID" where("Theme ID" = field("Theme ID"),
                                                                        "Strategic Plan ID" = field("Strategic Plan ID"));
        }
        field(29; "Expected Output"; Code[250])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Strategic Plan ID", "Theme ID", "Goal ID", "Objective ID", "Strategy ID", "Code", "Strategy Framework", "Primary Department")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PIndicator: Record "Performance Indicator";
        RC: Record "Responsibility Center";
}

