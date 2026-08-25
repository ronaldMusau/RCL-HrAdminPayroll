#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211688 "PC Objective"
{
    DrillDownPageID = "Workplan Initiatives";
    LookupPageID = "Workplan Initiatives";

    fields
    {
        field(1; "Workplan No."; Code[30])
        {

            TableRelation = "Perfomance Contract Header".No;
        }
        field(2; "Initiative No."; Code[30])
        {


            trigger OnValidate()
            begin
                StrategicInitiative.Reset;
                StrategicInitiative.SetRange(Code, "Initiative No.");
                if StrategicInitiative.FindFirst then begin
                    "Objective/Initiative" := StrategicInitiative.Code;
                    "Unit of Measure" := StrategicInitiative."Unit of Measure";
                end;
                if "Initiative Type" = "initiative type"::Activity then begin
                    StrategicInitiative.Reset;
                    StrategicInitiative.SetRange(Code, "Initiative No.");
                    if StrategicInitiative.FindFirst then begin
                        "Objective/Initiative" := StrategicInitiative.Code;
                        "Unit of Measure" := StrategicInitiative."Unit of Measure";
                        // "Goal ID" := StrategicInitiative."Goal ID";

                    end;
                end;
                if "Initiative Type" = "initiative type"::Board then begin
                    BoardActivities.Reset;
                    BoardActivities.SetRange("Board Activity Code", "Initiative No.");
                    if BoardActivities.FindFirst then begin
                        "Objective/Initiative" := BoardActivities."Board Activity Description";
                        "Unit of Measure" := BoardActivities."Unit of Measure";

                    end;
                end;
            end;
        }
        field(3; "Objective/Initiative"; Text[2048])
        {
            TableRelation = "Corporate Objectives".Description;
            ValidateTableRelation = false;
        }
        field(4; "Goal ID"; Code[30])
        {

            //TableRelation = "Stategic Goals"."Goal ID" where("Strategic Plan ID" = field("Strategy Plan ID"));
        }
        field(5; "Initiative Type"; Option)
        {
            Caption = 'Initiative Type';
            OptionCaption = 'CSP Activity,Project,Board PC,Employee-Defined';
            OptionMembers = Activity,Project,Board,"Employee-Defined";
        }
        field(6; "Task Type"; Option)
        {

            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";
        }
        field(7; Indentation; Decimal)
        {

        }
        field(8; Totaling; Decimal)
        {

        }
        field(9; Progress; Option)
        {

            OptionCaption = 'Not started,In progress,Completed';
            OptionMembers = "Not started","In progress",Completed;
        }
        field(10; "%Complete"; Decimal)
        {

        }
        field(11; "Priority Level"; Option)
        {

            OptionCaption = 'Urgent,Important,Medium,Low';
            OptionMembers = Urgent,Important,Medium,Low;
        }
        field(12; "Strategy Plan ID"; Code[30])
        {

            TableRelation = "Corporate Strategic Plans";
        }
        field(13; "Year Reporting Code"; Code[30])
        {

            TableRelation = "Annual Reporting Codes";
        }
        field(14; "Start Date"; Date)
        {

        }
        field(15; "Due Date"; Date)
        {

        }
        field(16; "Primary Department"; Code[100])
        {

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
        //field(17; "Primary Division"; Code[100])
        //{
        //
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
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
        // field(77; "Responsible Section"; Code[100])
        // {

        //     TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Duty Station"));

        //     // trigger OnValidate()
        //     // begin
        //     //     RC.Reset;
        //     //     RC.SetRange(Code, "Primary Department");
        //     //     if RC.FindSet then begin
        //     //         "Primary Department Name" := RC.Name;
        //     //     end;
        //     // end;
        // }
        field(18; "Overall Owner"; Code[100])
        {

        }
        field(19; "Outcome Perfomance Indicator"; Code[100])
        {

            TableRelation = "Performance Indicator".KPI;

            trigger OnValidate()
            begin
                if PerformanceIndicator.Get("Outcome Perfomance Indicator") then begin
                    "Unit of Measure" := PerformanceIndicator."Unit of Measure";
                    "Key Performance Indicator" := PerformanceIndicator.Description;
                end;
            end;
        }
        field(20; "Unit of Measure"; Code[100])
        {

            TableRelation = "Unit of Measure";
        }
        field(21; "Desired Perfomance Direction"; Option)
        {

            OptionCaption = 'Increasing KPI,Decreasing KPI,Not Applicable';
            OptionMembers = "Increasing KPI","Decreasing KPI","Not Applicable";
        }
        field(22; "KPI Type"; Option)
        {

            OptionCaption = 'Lagging,Leading,Not Applicable';
            OptionMembers = Lagging,Leading,"Not Applicable";
        }
        field(23; "Imported Annual Target Qty"; Decimal)
        {

        }
        field(24; "Q1 Target Qty"; Decimal)
        {

        }
        field(25; "Q1 Self-Review Qty"; Decimal)
        {

        }
        field(26; "Q1 ManagerReview Qty"; Decimal)
        {

        }
        field(27; "Q1 Actual Qty"; Decimal)
        {
            // 
            FieldClass = FlowField;
            CalcFormula = Sum("Strategy Sub_Activity Entry".Quantity WHERE("Strategic Plan ID" = FIELD("Strategy Plan ID"), "Year Reporting Code" = FIELD("Year Reporting Code"), "Performance Contract ID" = FIELD("Workplan No."), "Activity ID" = FIELD("Initiative No."), "Quarter Reporting Code" = filter('Q1')));

        }
        field(28; "Q2 Target Qty"; Decimal)
        {

        }
        field(29; "Q2 Self-Review Qty"; Decimal)
        {

        }
        field(30; "Q2 ManagerReview Qty"; Decimal)
        {

        }
        field(31; "Q2 Actual Qty"; Decimal)
        {
            // 
            FieldClass = FlowField;
            CalcFormula = Sum("Strategy Sub_Activity Entry".Quantity WHERE("Strategic Plan ID" = FIELD("Strategy Plan ID"), "Year Reporting Code" = FIELD("Year Reporting Code"), "Performance Contract ID" = FIELD("Workplan No."), "Activity ID" = FIELD("Initiative No."), "Quarter Reporting Code" = filter('Q2')));
        }
        field(32; "Q3 Target Qty"; Decimal)
        {


        }
        field(33; "Q3 Self-Review Qty"; Decimal)
        {

        }
        field(34; "Q3 ManagerReview Qty"; Decimal)
        {

        }
        field(35; "Q3 Actual Qty"; Decimal)
        {
            // 
            FieldClass = FlowField;
            CalcFormula = Sum("Strategy Sub_Activity Entry".Quantity WHERE("Strategic Plan ID" = FIELD("Strategy Plan ID"), "Year Reporting Code" = FIELD("Year Reporting Code"), "Performance Contract ID" = FIELD("Workplan No."), "Activity ID" = FIELD("Initiative No."), "Quarter Reporting Code" = filter('Q3')));
        }
        field(36; "Q4 Target Qty"; Decimal)
        {

        }
        field(37; "Q4 Self-Review Qty"; Decimal)
        {

        }
        field(38; "Q4 ManagerReview Qty"; Decimal)
        {

        }
        field(39; "Q4 Actual Qty"; Decimal)
        {
            // 
            FieldClass = FlowField;
            CalcFormula = Sum("Strategy Sub_Activity Entry".Quantity WHERE("Strategic Plan ID" = FIELD("Strategy Plan ID"), "Year Reporting Code" = FIELD("Year Reporting Code"), "Performance Contract ID" = FIELD("Workplan No."), "Activity ID" = FIELD("Initiative No."), "Quarter Reporting Code" = filter('Q4')));
        }
        field(40; "Global Dimension 1 Code"; Code[30])
        {

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Global Dimension 2 Code"; Code[30])
        {

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(42; "Planning Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(43; "Goal Template ID"; Code[50])
        {

            TableRelation = "Goal Template";
        }
        field(44; "Individual Achieved Targets"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                            "Year Reporting Code" = field("Year Reporting Code"),
                                                                            "Performance Contract ID" = field("Workplan No."),
                                                                            "Activity ID" = field("Initiative No.")));
            FieldClass = FlowField;
        }
        field(45; "Functional Achieved Targets"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                            "Year Reporting Code" = field("Year Reporting Code"),
                                                                                                                                            "Functional PC ID" = field("Workplan No."),
                                                                            "Activity ID" = field("Initiative No.")));
            FieldClass = FlowField;
        }
        field(46; "CEO Achieved Targets"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                            "Year Reporting Code" = field("Year Reporting Code"),
                                                                            "CEO PC ID" = field("Workplan No."),
                                                                            "Activity ID" = field("Initiative No.")));
            FieldClass = FlowField;
        }
        field(47; "Board Achieved Targets"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                            "Year Reporting Code" = field("Year Reporting Code"),
                                                                            "Board PC ID" = field("Workplan No."),
                                                                            "Activity ID" = field("Initiative No.")));
            FieldClass = FlowField;
        }
        field(48; "AnnualWorkplan Achieved Target"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                            "Year Reporting Code" = field("Year Reporting Code"),
                                                                            "Annual Workplan" = field("Workplan No."),
                                                                            "Activity ID" = field("Initiative No.")));
            FieldClass = FlowField;
        }
        field(49; EntryNo; Integer)
        {
            // AutoIncrement = true;

        }
        field(50; "Assigned Weight (%)"; Decimal)
        {

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
        field(53; "Framework Perspective"; Code[255])
        {

            TableRelation = "Strategy Framework Perspective".Code where("Strategy Framework" = field("Strategy Framework"));
        }
        field(54; "Strategy Framework"; Code[10])
        {

            TableRelation = "Strategy Framework";
        }
        field(55; "Previous Annual Target Qty"; Decimal)
        {

        }
        field(56; "Additional Comments"; Text[2048])
        {

        }
        field(57; "Activity Type"; Option)
        {

            OptionMembers = " ",Board,CSP;
        }
        field(58; "Directors Achieved Targets"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                            "Year Reporting Code" = field("Year Reporting Code"),
                                                                            "CEO PC ID" = field("Workplan No."),
                                                                            "Activity ID" = field("Initiative No.")));
            FieldClass = FlowField;
        }
        field(59; "Department Achieved Target"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Strategic Plan ID" = field("Strategy Plan ID"),
                                                                            "Year Reporting Code" = field("Year Reporting Code"),
                                                                            "Department/Center PC ID" = field("Workplan No."),
                                                                            "Activity ID" = field("Initiative No.")));
            FieldClass = FlowField;
        }
        field(60; "Key Performance Indicator"; Text[2048])
        {

        }
        field(61; "Primary Department Name"; Text[2048])
        {

        }
        //field(62; "Primary Division Name"; Text[2048])
        //{
        //
        //}
        field(63; "Principals Achieved Targets"; Decimal)
        {

        }
        field(64; "Seniors Achieved Targets"; Decimal)
        {

        }
        field(65; Selected; boolean)
        {

        }
        field(66; "Summary of subactivities"; Text[2048])
        {

        }
        field(67; Notify; Text[250])
        {

        }
        field(68; Budget; Text[250])
        {

        }
        field(69; "Planning Budget Type"; Text[250])
        {

        }
        field(70; "Departmental Objective"; Text[2048])
        {
            // TableRelation = AppraisalDeptObjectives.Description where("Primary Department" = field("Primary Department"), "Appraisal Period" = field("Appraisal Period"));
            // ValidateTableRelation = false;
            TableRelation = "Departmental Objectives L".Description where("Primary Department" = field("Primary Department"), "Appraisal Period" = field("Appraisal Period"));
            ValidateTableRelation = false;
            // TableRelation = "Departmental Objectives Lines".Objective where("Department Code" = field("Primary Department"), "Appraisal Period" = field("Appraisal Period"));
            // trigger OnLookup()
            // var
            //     DepartmentalObjectives: Record AppraisalDeptObjectives;
            //     DepartmentalObjectives1: Record AppraisalDeptObjectives;
            // begin
            //     DepartmentalObjectives.Reset();
            //     DepartmentalObjectives.SetRange("Primary Department", Rec."Primary Department");
            //     DepartmentalObjectives.SetRange("Appraisal Period", "Year Reporting Code");
            //     if Page.RunModal(Page::"Dep Objectives", DepartmentalObjectives) = Action::LookupOK then begin
            //         //     DepartmentalObjectives1.Reset();
            //         // DepartmentalObjectives1.SetRange("Primary Department",Rec."Primary Department");
            //         // DepartmentalObjectives1.SetRange("Appraisal Period","Year Reporting Code");
            //         // if DepartmentalObjectives1.FindFirst() then begin
            //         // end;
            //         Rec."Departmental Objective" := DepartmentalObjectives.Description;
            //     end;
            // end;
        }
        field(71; "PC Achieved Target"; Decimal)
        {
            CalcFormula = sum("Strategy Sub_Activity Entry".Quantity where("Performance Contract ID" = field("Workplan No."),
                                                                            "Activity ID" = field("Initiative No.")));
            FieldClass = FlowField;
        }
        field(72; "Appraisal Period"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Periods";
        }
        field(73; "Performance Indicator"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Workplan No.", "Initiative No.", "Goal Template ID", "Strategy Plan ID", EntryNo)
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
    }
    trigger OnInsert()
    var
        PCObjective: Record "PC Objective";
    begin
        PCObjective.Reset();
        PCObjective.SetRange("Workplan No.", Rec."Workplan No.");
        PCObjective.SetRange("Initiative No.", Rec."Initiative No.");
        PCObjective.SetRange("Goal Template ID", Rec."Goal Template ID");
        PCObjective.SetRange("Strategy Plan ID", Rec."Strategy Plan ID");
        if PCObjective.findlast() then
            Rec.EntryNo := PCObjective.EntryNo + 1
        else
            Rec.EntryNo := 1;
    end;

    var
        PerformanceIndicator: Record "Performance Indicator";
        StrategicInitiative: Record "Strategic Initiative";
        BoardActivities: Record "Board Activities";
        RC: Record "Responsibility Center";
}
