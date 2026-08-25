#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211721 "Secondary PC Objective"
{
    DrillDownPageID = "Secondary Workplan Initiatives";
    LookupPageID = "Secondary Workplan Initiatives";

    fields
    {
        field(1; "Workplan No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No;
        }
        field(2; "Initiative No."; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategy Workplan Lines"."Activity ID" where("Strategy Plan ID" = field("Strategy Plan ID"),
                                                                           "Year Reporting Code" = field("Year Reporting Code"),
                                                                           "Primary Department" = field("Primary Department"));

            trigger OnValidate()
            begin
                StrategicInitiative.Reset;
                StrategicInitiative.SetRange("Strategy Plan ID", "Strategy Plan ID");
                StrategicInitiative.SetRange("Year Reporting Code", "Year Reporting Code");
                StrategicInitiative.SetRange("Activity ID", "Initiative No.");
                if StrategicInitiative.FindFirst then begin
                    "Objective/Initiative" := StrategicInitiative.Description;
                    "Imported Annual Target Qty" := StrategicInitiative."Imported Annual Target Qty";
                    //MESSAGE('%1', "Year Reporting Code");
                    "Year Reporting Code" := StrategicInitiative."Year Reporting Code";
                end;
            end;
        }
        field(3; "Objective/Initiative"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Goal ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "PC Goal Hub"."Goal ID" where("Performance Contract ID" = field("Workplan No."));
        }
        field(5; "Initiative Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Activity,Project,Board';
            OptionMembers = Activity,Project,Board;
        }
        field(6; "Task Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";
        }
        field(7; Indentation; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Totaling; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Progress; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Not started,In progress,Completed';
            OptionMembers = "Not started","In progress",Completed;
        }
        field(10; "%Complete"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Priority Level"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Urgent,Important,Medium,Low';
            OptionMembers = Urgent,Important,Medium,Low;
        }
        field(12; "Strategy Plan ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans";
        }
        field(13; "Year Reporting Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes";
        }
        field(14; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Primary Department"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        //field(17; "Primary Division"; Code[100])
        //{
        //DataClassification = ToBeClassified;
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Division/Section"));
        //}
        field(18; "Overall Owner"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Outcome Perfomance Indicator"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Indicator".KPI;

            trigger OnValidate()
            begin
                if PerformanceIndicator.Get("Outcome Perfomance Indicator") then begin
                    "Unit of Measure" := PerformanceIndicator."Unit of Measure";
                end;
            end;
        }
        field(20; "Unit of Measure"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(21; "Desired Perfomance Direction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Increasing KPI,Decreasing KPI,Not Applicable';
            OptionMembers = "Increasing KPI","Decreasing KPI","Not Applicable";
        }
        field(22; "KPI Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Lagging,Leading,Not Applicable';
            OptionMembers = Lagging,Leading,"Not Applicable";
        }
        field(23; "Imported Annual Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Q1 Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Q1 Self-Review Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Q1 ManagerReview Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Q1 Actual Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Q2 Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Q2 Self-Review Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Q2 ManagerReview Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Q2 Actual Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Q3 Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Q3 Self-Review Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Q3 ManagerReview Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Q3 Actual Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Q4 Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Q4 Self-Review Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Q4 ManagerReview Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Q4 Actual Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Global Dimension 1 Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Global Dimension 2 Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(42; "Planning Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(43; "Goal Template ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Goal Template";
        }
        field(44; EntryNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(45; "Individual Achieved Targets"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                            "Year Reporting Code" = field("Year Reporting Code"),
                                                                            "Performance Contract ID" = field("Workplan No."),
                                                                            "Activity ID" = field("Initiative No.")));
            FieldClass = FlowField;
        }
        field(46; "Functional Achieved Targets"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "CEO Achieved Targets"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Board Achieved Targets"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "AnnualWorkplan Achieved Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Assigned Weight (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Plog Achieved Targets"; Decimal)
        {
            CalcFormula = sum("Plog Lines"."Achieved Target" where("Personal Scorecard ID" = field("Workplan No."),
                                                                    "Initiative No." = field("Initiative No."),
                                                                    "Achieved Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(52; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(53; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Workplan No.", "Initiative No.", "Goal Template ID", "Strategy Plan ID", "Year Reporting Code", EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PerformanceIndicator: Record "Performance Indicator";
        StrategicInitiative: Record "Strategy Workplan Lines";
}

