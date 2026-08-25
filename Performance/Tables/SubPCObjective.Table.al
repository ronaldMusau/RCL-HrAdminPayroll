#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211713 "Sub PC Objective"
{

    fields
    {
        field(1; "Workplan No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No;
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

            trigger OnValidate()
            begin
                PCObjective.Reset;
                PCObjective.SetRange("Workplan No.", "Workplan No.");
                PCObjective.SetRange("Initiative No.", "Initiative No.");
                if PCObjective.FindSet then begin
                    if "Due Date" > PCObjective."Due Date" then
                        Error('Sub Activity Due Date should not be later than Activity Due Date. Activity Due Date is (%1)', PCObjective."Due Date");
                end;
            end;
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
            CalcFormula = sum(Sub_Strategy_Activity.Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                    "Performance Contract ID" = field("Workplan No."),
                                                                    "Activity ID" = field("Initiative No."),
                                                                    "Sub Initiative No." = field("Sub Initiative No.")));
            FieldClass = FlowField;
        }
        field(48; "Functional Achieved Targets"; Decimal)
        {
            CalcFormula = sum(Sub_Strategy_Activity.Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                    "Functional PC ID" = field("Workplan No."),
                                                                    "Activity ID" = field("Initiative No."),
                                                                    "Sub Initiative No." = field("Sub Initiative No.")));
            FieldClass = FlowField;
        }
        field(49; "CEO Achieved Targets"; Decimal)
        {
            CalcFormula = sum(Sub_Strategy_Activity.Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                    "CEO PC ID" = field("Workplan No."),
                                                                    "Activity ID" = field("Initiative No."),
                                                                    "Sub Initiative No." = field("Sub Initiative No.")));
            FieldClass = FlowField;
        }
        field(50; "Board Achieved Targets"; Decimal)
        {
            CalcFormula = sum(Sub_Strategy_Activity.Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                    "Board PC ID" = field("Workplan No."),
                                                                    "Activity ID" = field("Initiative No."),
                                                                    "Sub Initiative No." = field("Sub Initiative No.")));
            FieldClass = FlowField;
        }
        field(51; "AnnualWorkplan Achieved Target"; Decimal)
        {
            CalcFormula = sum(Sub_Strategy_Activity.Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                    "Annual Workplan" = field("Workplan No."),
                                                                    "Activity ID" = field("Initiative No."),
                                                                    "Sub Initiative No." = field("Sub Initiative No.")));
            FieldClass = FlowField;
        }
        field(52; "Directors Achieved Targets"; Decimal)
        {
            CalcFormula = sum(Sub_Strategy_Activity.Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                    "CEOs PC ID" = field("Workplan No."),
                                                                    "Activity ID" = field("Initiative No."),
                                                                    "Sub Initiative No." = field("Sub Initiative No.")));
            FieldClass = FlowField;
        }
        field(53; "Department Achieved Target"; Decimal)
        {
            CalcFormula = sum(Sub_Strategy_Activity.Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                    "Department/Center PC ID" = field("Workplan No."),
                                                                    "Activity ID" = field("Initiative No."),
                                                                    "Sub Initiative No." = field("Sub Initiative No.")));
            FieldClass = FlowField;
        }
        field(54; "Assigned Weight (%)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TotalAssignedweight := 0;
                AssignedCoreWeight := 0;
                AssignedSecondaryWeight := 0;
                TotalActivitiyAssignedWeight := 0;

                SubPCObjective.Reset;
                SubPCObjective.SetRange("Workplan No.", "Workplan No.");
                SubPCObjective.SetRange("Initiative No.", "Initiative No.");
                SubPCObjective.SetRange("Strategy Plan ID", "Strategy Plan ID");
                SubPCObjective.CalcSums("Assigned Weight (%)");
                TotalAssignedweight := SubPCObjective."Assigned Weight (%)" + "Assigned Weight (%)";

                /*
                AssignedCoreWeight:=FnGetActivityWeight("Strategy Plan ID",'',"Workplan No.","Initiative No.","Goal Template ID");
                AssignedSecondaryWeight:=FnGetActivityWeightSC("Strategy Plan ID",'',"Workplan No.","Initiative No.","Goal Template ID");
                TotalActivitiyAssignedWeight:=AssignedCoreWeight+AssignedSecondaryWeight;
                
                
                IF TotalAssignedweight>TotalActivitiyAssignedWeight THEN
                   ERROR('The Activity Assigned Weight is %1, Total Weight of the Sub-Activities (%2) should not be more than Activity Assigned Weight',
                TotalActivitiyAssignedWeight,TotalAssignedweight);
                *///Commented to use percentage instead

                if TotalAssignedweight > 100 then
                    Error('Total Assigned Weight for All Sub-Activities should be equals to 100,Curently Total Weight is %1', TotalAssignedweight);

            end;
        }
        field(55; "Sub Indicator Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Core,Secondary';
            OptionMembers = " ",Core,Secondary;
        }
        field(56; "Sub Activity weight %"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(57; "Budget"; text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(58; "Sub Activity Description"; text[250]) { }
        field(59; "Expense Amount"; text[250]) { }
        field(60; "Planning Budget Type"; text[250]) { }

    }


    keys
    {
        key(Key1; "Workplan No.", "Initiative No.", "Goal Template ID", "Strategy Plan ID", "Sub Initiative No.", "Entry Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    var
        Objective: Record "Sub PC Objective";
    begin
        Objective.Reset();
        Objective.SetRange("Workplan No.", Rec."Workplan No.");
        // Objective.SetRange("Initiative No.",Rec."Initiative No.");
        // Objective.SetRange("Goal Template ID",Rec."Goal Template ID");
        // Objective.SetRange("Strategy Plan ID",Rec."Strategy Plan ID");
        // Objective.SetRange("Sub Initiative No.",Rec."Sub Initiative No.");
        if Objective.FindLast() then
            Rec."Entry Number" := Objective."Entry Number" + 1
        else
            Rec."Entry Number" := 1;
    end;

    var
        PCObjective: Record "PC Objective";
        SubPCObjective: Record "Sub PC Objective";
        TotalAssignedweight: Decimal;
        AssignedCoreWeight: Decimal;
        AssignedSecondaryWeight: Decimal;
        TotalActivitiyAssignedWeight: Decimal;

    local procedure FnGetActivityWeight(CorporateStrategicPlan: Code[30]; AnnualWorkPlan: Code[30]; WorkPlanNo: Code[30]; IntiativeNo: Code[30]; GoalTemplateId: Code[30]) Weight: Decimal
    var
        PCObjective: Record "PC Objective";
    begin
        PCObjective.Reset;
        PCObjective.SetRange("Strategy Plan ID", CorporateStrategicPlan);
        PCObjective.SetRange("Workplan No.", WorkPlanNo);
        PCObjective.SetRange("Initiative No.", IntiativeNo);
        PCObjective.SetRange("Goal Template ID", GoalTemplateId);
        if PCObjective.FindSet then begin
            Weight := PCObjective."Assigned Weight (%)";
        end;

        exit(Weight);
    end;

    local procedure FnGetActivityWeightSC(CorporateStrategicPlan: Code[30]; AnnualWorkPlan: Code[30]; WorkPlanNo: Code[30]; IntiativeNo: Code[30]; GoalTemplateId: Code[30]) Weight: Decimal
    var
        ScPCObjective: Record "Secondary PC Objective";
    begin
        ScPCObjective.Reset;
        ScPCObjective.SetRange("Strategy Plan ID", CorporateStrategicPlan);
        ScPCObjective.SetRange("Workplan No.", WorkPlanNo);
        ScPCObjective.SetRange("Initiative No.", IntiativeNo);
        ScPCObjective.SetRange("Goal Template ID", GoalTemplateId);
        if ScPCObjective.FindSet then begin
            Weight := ScPCObjective."Assigned Weight (%)";
        end;

        exit(Weight);
    end;
}

