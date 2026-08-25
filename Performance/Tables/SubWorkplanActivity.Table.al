#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211732 "Sub Workplan Activity"
{
    // DrillDownPageID = "Sub Workplan Activity";
    // LookupPageID = "Sub Workplan Activity";

    fields
    {
        field(1; "Workplan No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Initiative No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Objective/Initiative"; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Goal ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Initiative Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Activity,Project';
            OptionMembers = Activity,Project;
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
        field(12; "Strategy Plan ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans";
        }
        field(13; "Year Reporting Code"; Code[30])
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
        //field(16; "Primary Directorate"; Code[100])
        //{
        //    DataClassification = ToBeClassified;
        //    TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Directorate));
        //}
        field(17; "Primary Department"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        field(18; "Overall Owner"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Outcome Perfomance Indicator"; Code[100])
        {
            DataClassification = ToBeClassified;
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
        field(40; "Global Dimension 1 Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Global Dimension 2 Code"; Code[30])
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
        field(44; "Sub Initiative No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Sub Targets"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Entry Number"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(47; "Individual Achieved Targets"; Decimal)
        {
            FieldClass = Normal;
        }
        field(48; "Functional Achieved Targets"; Decimal)
        {
            FieldClass = Normal;
        }
        field(49; "CEO Achieved Targets"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50; "Board Achieved Targets"; Decimal)
        {
            FieldClass = Normal;
        }
        field(51; "AnnualWorkplan Achieved Target"; Decimal)
        {
            FieldClass = Normal;
        }
        field(52; "Directors Achieved Targets"; Decimal)
        {
            FieldClass = Normal;
        }
        field(53; "Department Achieved Target"; Decimal)
        {
            FieldClass = Normal;
        }
        field(54; "Annual Achieved Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Total Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Activity Id"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                StrategyWorkplanLines.Reset;
                StrategyWorkplanLines.SetRange(No, "Workplan No.");
                StrategyWorkplanLines.SetRange("Activity ID", "Activity Id");
                if StrategyWorkplanLines.FindSet then begin
                    // "Primary Directorate" := StrategyWorkplanLines."Primary Department";
                    "Primary Department" := StrategyWorkplanLines."Primary Department";
                end;
            end;
        }
        field(57; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Expense Amount"; Decimal)
        {
            CalcFormula = sum("Workplan Expenditure Entry"."Expenditure Amount" where("Workplan No." = field("Workplan No."),
                                                                                       "Initiative No." = field("Activity Id"),
                                                                                       "Sub Initiative No." = field("Sub Initiative No.")));
            FieldClass = FlowField;
        }
        field(59; "Elements Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Total Autocalculated Amount"; Decimal)
        {
            CalcFormula = sum("Workplan Cost Elements".Amount where("Workplan No." = field("Workplan No."),
                                                                     "Activity Id" = field("Activity Id"),
                                                                     "Sub Activity No" = field("Sub Initiative No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Workplan No.", "Activity Id", "Initiative No.", "Sub Initiative No.", "Strategy Plan ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        StrategyWorkplanLines: Record "Strategy Workplan Lines";
}

