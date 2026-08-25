#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211698 "Performance Evaluation"
{

    fields
    {
        field(1; No; Code[20])
        {


            trigger OnValidate()
            begin
                if "Document Type" = "document type"::"Performance Appraisal" then begin
                    if "Evaluation Type" = "evaluation type"::"Standard Appraisal/Supervisor Score Only" then begin
                        if No <> xRec.No then begin
                            SPMSetup.Get;
                            NoSeriesMgt.TestManual(SPMSetup."Performance Evaluation Nos");
                            "No. Series" := '';
                        end;
                    end;
                    if "Evaluation Type" = "evaluation type"::"Self-Appraisal with Supervisor Score" then begin
                        if No <> xRec.No then begin
                            SPMSetup.Get;
                            NoSeriesMgt.TestManual(SPMSetup."Performance Evaluation Nos");
                            "No. Series" := '';
                        end;
                    end;
                    if "Evaluation Type" = "evaluation type"::"360-Degree/Group Appraisal" then begin
                        if No <> xRec.No then begin
                            SPMSetup.Get;
                            NoSeriesMgt.TestManual(SPMSetup."Performance Evaluation Nos");
                            "No. Series" := '';
                        end;
                    end;
                end;

                if "Document Type" = "document type"::"Performance Appeal" then begin
                    if No <> xRec.No then begin
                        SPMSetup.Get;
                        NoSeriesMgt.TestManual(SPMSetup."Performance Appeals No. Series");
                        "No. Series" := '';
                    end;
                end;
            end;
        }
        field(2; "Performance Mgt Plan ID"; Code[100])
        {

            TableRelation = if ("Document Type" = const("Performance Appraisal")) "Performance Management Plan".No;

            trigger OnValidate()
            begin
                PerformanceManagementPlan.Reset;
                PerformanceManagementPlan.SetRange(No, "Performance Mgt Plan ID");
                if PerformanceManagementPlan.Find('-') then begin
                    PerfomanceEvaluationTemplate.Reset;
                    PerfomanceEvaluationTemplate.SetRange(Code, PerformanceManagementPlan."HR Performance Template");
                    if PerfomanceEvaluationTemplate.Find('-') then begin
                        PerfomanceEvaluationTemplate.CalcFields("Total Allocated Weight (%)");
                        if ("Evaluation Type" = "evaluation type"::"Standard Appraisal/Supervisor Score Only") or ("Evaluation Type" = "evaluation type"::"Self-Appraisal with Supervisor Score") then
                            "Appraisal Template ID" := PerfomanceEvaluationTemplate."General A_Questionnaire"
                        else
                            "Appraisal Template ID" := PerfomanceEvaluationTemplate."Peer Reviewer FB_Questionnaire";
                        "Competency Template ID" := PerfomanceEvaluationTemplate."Default Competency A_Template";
                        "Performance Rating Scale" := PerfomanceEvaluationTemplate."Performance Rating Scale";
                        "Proficiency Rating Scale" := PerfomanceEvaluationTemplate."Proficiency Rating Scale";

                        PerformanceEvaluationWeight.Reset;
                        PerformanceEvaluationWeight.SetRange("Per_Evaluation Template ID", PerfomanceEvaluationTemplate.Code);
                        if PerformanceEvaluationWeight.Find('-') then begin
                            repeat
                                if PerformanceEvaluationWeight."Key Evaluation Section" = PerformanceEvaluationWeight."key evaluation section"::"Objectives & Outcomes" then begin
                                    "Objective & Outcome Weight %" := PerformanceEvaluationWeight."Total Weight (%)";
                                end;
                                if PerformanceEvaluationWeight."Key Evaluation Section" = PerformanceEvaluationWeight."key evaluation section"::"Competency & Company Values" then begin
                                    "Competency Weight %" := PerformanceEvaluationWeight."Total Weight (%)";
                                end;
                            until PerformanceEvaluationWeight.Next = 0;
                        end;
                        "Total Weight %" := PerfomanceEvaluationTemplate."Total Allocated Weight (%)";
                    end;
                end;
            end;
        }
        field(3; "Performance Task ID"; Code[100])
        {

            TableRelation = "Performance Plan Task"."Task Code" where("Performance Mgt Plan ID" = field("Performance Mgt Plan ID"),
                                                                       "Task Category" = const("Performance Review"));
            //  "Review Periods"=filter(<>' '));

            trigger OnValidate()
            begin
                PerformancePlanTask.Reset;
                PerformancePlanTask.SetRange("Performance Mgt Plan ID", "Performance Mgt Plan ID");
                PerformancePlanTask.SetRange("Task Code", "Performance Task ID");
                if PerformancePlanTask.Find('-') then begin
                    PerformancePlanTask.TestField("Processing Start Date");
                    PerformancePlanTask.TestField("Processing Due Date");
                    PerformancePlanTask.TestField("Review Periods");

                    "Evaluation Start Date" := PerformancePlanTask."Processing Start Date";
                    "Evaluation End Date" := PerformancePlanTask."Processing Due Date";
                    "Review Period" := PerformancePlanTask."Review Periods";
                end;
            end;
        }
        field(4; "Employee No."; Code[20])
        {

            TableRelation = Employee where(Status = filter(Active));

            trigger OnValidate()
            var
                DeptObjectives: Record AppraisalDeptObjectives;
                StrategyWPL: Record "Strategy Workplan Lines";
                BoardActivities: Record "Board Activities";
                PositionsResp: Record "Positions Responsibility";
                AnnualStrategyWP: Record "Annual Strategy Workplan";
                NextLineNo: Integer;
                CurrentDate: date;
                LastLineNo: Integer;
            begin
                if Emp.Get("Employee No.") then begin
                    "Employee Name" := Emp.FullName;
                    "Current Designation" := Emp.Position;
                    "Current Grade" := Emp."Salary Scale";
                    // Directorate := Emp."Directorate Code";
                    if Emp."Responsibility Center" <> '' then begin
                        Department := Emp."Responsibility Center";
                        // Division := Emp.Division;
                    end else begin
                        // Division := Emp."Shortcut Dimension 3";
                    end;
                    // "Region Code" := Emp."Global Dimension 1 Code";
                    // "Work Station" := Emp.Workstation;
                    // "Employement Terms" := Emp."Employement Terms";
                    // "Job Group" := Emp."Current Job Grade";
                    "Salary Scale" := Emp."Salary Scale";
                    CurrentDate := Today;
                    "Length of Service" := GetServiceLength(Emp."Employment Date", CurrentDate);

                    Validate("Immediate Supervisor No.", Emp."Manager No.");
                    // // MESSAGE('Emp.Workstation is %1',Emp.Workstation);
                    // ResponsibityC.Reset;
                    // //ResponsibityC.SETRANGE("Operating Unit Type",ResponsibityC."Operating Unit Type"::Region);
                    // ResponsibityC.SetFilter(ResponsibityC.Code, Emp."Responsibility Center");
                    // if ResponsibityC.FindFirst() then begin
                    //     "Immediate Supervisor No." := ResponsibityC."Current Head";
                    //     Validate("Immediate Supervisor No.");
                    // end;

                    DeptObjectives.Reset();
                    DeptObjectives.SetRange("Document No.", Rec.No);
                    DeptObjectives.SetRange("Primary Department", Emp."Responsibility Center");
                    DeptObjectives.SetRange("Appraisal Period", Rec."Review Period");
                    if DeptObjectives.FindFirst() then
                        DeptObjectives.DeleteAll();

                    DeptObjHeader.Reset();
                    DeptObjHeader.SetRange("Primary Department", Rec.Department);
                    // DeptObjHeader.SetRange("Primary Directorate", Rec.Directorate);
                    DeptObjHeader.SetRange("Appraisal Period", Rec."Review Period");
                    if DeptObjHeader.FindFirst() then begin

                        DeptObjLines.Reset();
                        DeptObjLines.SetRange("Document No.", DeptObjHeader."Document No.");
                        if DeptObjLines.FindSet then begin
                            repeat
                                DeptObjectives.Reset();
                                if DeptObjectives.FindLast() then begin
                                    LastLineNo := DeptObjectives."Line No.";
                                end else begin
                                    LastLineNo := 1000;
                                end;

                                DeptObjectives.Init();
                                DeptObjectives."Document No." := Rec.No;
                                DeptObjectives."Line No." := LastLineNo + 1000;
                                DeptObjectives."No." := DeptObjLines."No.";
                                DeptObjectives."Appraisal Period" := Rec."Review Period";
                                DeptObjectives."Annual Reporting Code" := Rec."Annual Reporting Code";
                                DeptObjectives.Description := DeptObjLines.Description;
                                DeptObjectives."Primary Department" := DeptObjLines."Primary Department";
                                // DeptObjectives."Primary Directorate" := DeptObjLines."Primary Directorate";
                                DeptObjectives."Appraisal Period" := Rec."Review Period";
                                DeptObjectives.Target := DeptObjLines.Target;
                                DeptObjectives."Unit of Measure" := DeptObjLines."Unit of Measure";
                                DeptObjectives.Insert(true);
                            until DeptObjLines.Next = 0;
                        end;
                    end;

                    //Revert of Comments

                    // PositionsResp.Reset();
                    // PositionsResp.SetRange("Position ID", Emp."Job ID");
                    // if PositionsResp.FindSet() then begin
                    //     repeat
                    //         DeptObjectives.Init();
                    //         DeptObjectives."Document No." := Rec.No;
                    //         DeptObjectives."No." := PositionsResp."Position ID";
                    //         // DeptObjectives."Line No." := NextLineNo;
                    //         DeptObjectives."Line No." := FnGetDeptLastLineNo + 1;
                    //         DeptObjectives."Objective Type" := DeptObjectives."Objective Type"::Positions;
                    //         DeptObjectives."Appraisal Period" := Rec."Review Period";
                    //         DeptObjectives."Annual Reporting Code" := Rec."Annual Reporting Code";
                    //         DeptObjectives.Description := PositionsResp.Description;
                    //         DeptObjectives."Primary Division" := Emp."Responsibility Center";
                    //         // DeptObjectives."Primary Directorate" := Emp."Directorate Code";
                    //         DeptObjectives."Appraisal Period" := Rec."Review Period";
                    //         //DeptObjectives."Employee No." := Rec."Employee No.";
                    //         DeptObjectives.Insert(true);
                    //         NextLineNo := NextLineNo + 1000;
                    //     until PositionsResp.Next() = 0;
                    // end;
                    // StrategyWPL.Reset();
                    // StrategyWPL.SetRange("Primary Division", Emp.Division);
                    // StrategyWPL.SetRange("Primary Department", Emp."Responsibility Center");
                    // if StrategyWPL.FindSet() then begin
                    //     repeat
                    //         DeptObjectives.Init();
                    //         DeptObjectives."Document No." := Rec.No;
                    //         DeptObjectives."No." := StrategyWPL."Strategy Plan ID";
                    //         // DeptObjectives."No." := StrategyWPL.No;
                    //         // DeptObjectives."Line No." := NextLineNo;
                    //         DeptObjectives."Line No." := FnGetDeptLastLineNo + 1;
                    //         DeptObjectives."Objective Type" := DeptObjectives."Objective Type"::"Strategy Workplan";
                    //         DeptObjectives."Appraisal Period" := Rec."Review Period";
                    //         DeptObjectives."Annual Reporting Code" := Rec."Annual Reporting Code";
                    //         DeptObjectives.Description := StrategyWPL.Description;
                    //         DeptObjectives."Activity ID" := StrategyWPL."Activity ID";
                    //         DeptObjectives."Unit of Measure" := StrategyWPL."Unit of Measure";
                    //         DeptObjectives.Target := StrategyWPL."Annual Target";
                    //         DeptObjectives."Primary Division" := Emp."Responsibility Center";
                    //         // DeptObjectives."Primary Directorate" := Emp."Directorate Code";
                    //         DeptObjectives."Appraisal Period" := Rec."Review Period";
                    //         //DeptObjectives."Employee No." := Rec."Employee No.";
                    //         DeptObjectives.Insert(true);
                    //     // NextLineNo := NextLineNo + 1000;
                    //     until StrategyWPL.Next() = 0;
                    // end;
                    // BoardActivities.Reset();
                    // BoardActivities.SetRange("Primary Division", Emp.Division);
                    // BoardActivities.SetRange("Primary Department", Emp."Responsibility Center");
                    // if BoardActivities.FindSet() then begin
                    //     repeat
                    //         DeptObjectives.Init();
                    //         DeptObjectives."Document No." := Rec.No;
                    //         DeptObjectives."No." := BoardActivities."Board Activity Code";
                    //         // DeptObjectives."Line No." := NextLineNo;
                    //         DeptObjectives."Line No." := FnGetDeptLastLineNo + 1;
                    //         DeptObjectives."Objective Type" := DeptObjectives."Objective Type"::"Board Activities";
                    //         DeptObjectives."Appraisal Period" := Rec."Review Period";
                    //         DeptObjectives."Annual Reporting Code" := Rec."Annual Reporting Code";
                    //         DeptObjectives.Description := BoardActivities."Board Activity Description";
                    //         DeptObjectives."Unit of Measure" := BoardActivities."Unit of Measure";
                    //         DeptObjectives.Target := BoardActivities.Target;
                    //         DeptObjectives."Primary Division" := Emp."Responsibility Center";
                    //         // DeptObjectives."Primary Directorate" := Emp."Directorate Code";
                    //         DeptObjectives."Appraisal Period" := Rec."Review Period";
                    //         //DeptObjectives."Employee No." := Rec."Employee No.";
                    //         DeptObjectives.Insert(true);
                    //     //   NextLineNo := NextLineNo + 1000;
                    //     until BoardActivities.Next() = 0;
                    // end;
                    //Revert of Comments
                end;
            end;
        }
        field(5; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(6; "Current Designation"; Text[200])
        {
            Editable = false;
        }
        field(7; "Current Grade"; Code[100])
        {
            Editable = false;
        }
        field(8; "Immediate Supervisor No."; Code[50])
        {

            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Immediate Supervisor No.") then begin
                    "Immediate Supervisor Name" := Emp.FullName;
                end;
            end;
        }
        field(9; "Immediate Supervisor Name"; Text[100])
        {

        }
        field(10; "Strategy Plan ID"; Code[255])
        {

            TableRelation = "Corporate Strategic Plans".Code;
        }
        field(11; Description; Text[255])
        {

        }
        field(12; "Document Date"; Date)
        {

        }
        field(13; "Evaluation Start Date"; Date)
        {

        }
        field(14; "Evaluation End Date"; Date)
        {

        }
        field(15; "Appraisal Template ID"; Code[100])
        {

            TableRelation = "Appraisal Questionnaire Temp";
        }
        field(16; "Evaluation Type"; Option)
        {

            OptionCaption = 'Standard Appraisal/Supervisor Score Only,Self-Appraisal with Supervisor Score,360-Degree/Group Appraisal';
            OptionMembers = "Standard Appraisal/Supervisor Score Only","Self-Appraisal with Supervisor Score","360-Degree/Group Appraisal";
        }
        field(17; "Personal Scorecard ID"; Code[100])
        {

            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"),
                                                                   "Responsible Employee No." = field("Employee No.")
                                                                   /*Status = const(Signed)*/);

            trigger OnValidate()
            begin
                if PerfomanceContractHeader.Get("Personal Scorecard ID") then begin
                    "Annual Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
                    Description := PerfomanceContractHeader.Description;
                end;
            end;
        }
        field(18; "Competency Template ID"; Code[100])
        {
            // TableRelation = "Competency Per Template".Code where("Global?" = const(true));
            TableRelation = "Competency Per Template".Code;
        }
        field(19; "General Assessment Template ID"; Code[100])
        {

        }
        field(20; "360-Degree Assessment Temp ID"; Code[50])
        {

        }
        field(21; "Objective & Outcome Weight %"; Decimal)
        {

        }
        field(22; "Competency Weight %"; Decimal)
        {

        }
        field(23; "Total Weight %"; Decimal)
        {

        }
        field(24; "Performance Rating Scale"; Code[100])
        {

            TableRelation = "Perfomance Rating Scale".Code;
        }
        field(25; "Proficiency Rating Scale"; Code[100])
        {

            TableRelation = "Competency Proficiency Scale".Code;
        }
        field(26; Department; Code[50])
        {

            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
            Editable = false;
        }
        // field(27; Division; Code[50])
        // {

        //     TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        //     Editable = false;
        // }
        field(28; "Annual Reporting Code"; Code[50])
        {

            TableRelation = "Annual Reporting Codes".Code where("Current Year" = const(true));
        }
        field(29; "Approval Status"; Option)
        {

            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
        }
        field(30; "Blocked?"; Boolean)
        {

        }
        field(31; "Created By"; Code[50])
        {

        }
        field(32; "Created On"; Date)
        {

        }
        field(33; "Last Evaluation Date"; Date)
        {

        }
        field(34; "Document Type"; Option)
        {

            OptionCaption = 'Performance Appraisal,Performance Appeal';
            OptionMembers = "Performance Appraisal","Performance Appeal";
        }
        field(35; "Appealed Performance Eval id"; Code[50])
        {

            TableRelation = "Performance Evaluation" where("Document Type" = const("Performance Appraisal"));
        }
        field(36; "No. Series"; Code[10])
        {

        }
        field(37; "Document Status"; Option)
        {
            OptionCaption = 'Draft,Evaluation,Submitted,Closed';
            OptionMembers = Draft,Evaluation,Submitted,Closed;
        }
        field(38; Closed; Boolean)
        {

        }
        field(39; "Closed By"; Code[30])
        {

        }
        field(40; "Closed On"; Code[30])
        {

        }
        field(41; "Review Period"; Code[30])
        {
            TableRelation = "Appraisal Periods";
            trigger OnValidate()
            var
                AppraisalPeriod: Record "Appraisal Periods";
            begin
                AppraisalPeriod.Reset();
                AppraisalPeriod.SetRange(Period, Rec."Review Period");
                if AppraisalPeriod.FindFirst() then begin
                    //AppraisalPeriod.TestField("Strategic Plan");
                    //Rec.Validate("Strategy Plan ID", AppraisalPeriod."Strategic Plan");
                    Rec.Validate("Evaluation Start Date", AppraisalPeriod."Start Date");
                    Rec.Validate("Evaluation End Date", AppraisalPeriod."End Date");
                end;
            end;
        }
        field(42; "Total Final Weighted Score"; Decimal)
        {
            CalcFormula = sum("Objective Evaluation Result"."Final Weighted Line Score" where("Performance Evaluation ID" = field(No)));
            FieldClass = FlowField;
        }
        field(43; "Total Proficiency Score"; Decimal)
        {
            CalcFormula = sum("Proficiency Evaluation Result"."Raw Profiency Score" where("Performance Evaluation ID" = field(No)));
            FieldClass = FlowField;
        }
        field(44; "Total Raw Score"; Decimal)
        {
            CalcFormula = sum("Objective Evaluation Result"."Raw Performance Score" where("Performance Evaluation ID" = field(No)));
            FieldClass = FlowField;
        }
        field(45; "Employee Confirm"; Boolean)
        {

        }
        field(46; "Supervisor Confirm"; Boolean)
        {

        }
        field(47; "Work Station"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            Editable = false;
        }
        field(48; "Employement Terms"; Enum "Employment Terms")
        {
            Editable = false;
        }
        field(49; "Job Group"; Code[30])
        {
            Editable = false;
        }
        field(50; "Salary Scale"; Code[30])
        {
            Editable = false;
        }
        field(51; "Second Immediate Supervisor No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Second Immediate Supervisor No.") then begin
                    "Second Immediate Supervisor Name" := Emp.FullName;
                end;
            end;
        }
        field(52; "Second Immediate Supervisor Name"; Text[100])
        {
            Editable = false;
        }
        field(53; "HOD (Head of Department) Comments"; Text[550])
        {
            DataClassification = ToBeClassified;
        }
        field(54; Comments; Text[550])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Appraisee's Comments"; Text[550])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "PIP Supervisor Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "PIP Employee Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "PIP Final Review"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Recommendation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Reward,Intervention,Sanction;
        }
        field(60; "Recommendation Reward/Sanction"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Total Objectives Result"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Objective Evaluation Result"."Achieved Result" where("Performance Evaluation ID" = field(No)));
            Editable = false;
        }
        field(62; "Total PEval Result"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Proficiency Evaluation Result"."Achieved Result" where("Performance Evaluation ID" = field(No)));
            Editable = false;
        }
        field(63; "Objectives Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Objective Evaluation Result" where("Performance Evaluation ID" = field(No)));
            Editable = false;
        }
        field(64; "Proficiency Eval Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Proficiency Evaluation Result" where("Performance Evaluation ID" = field(No)));
            Editable = false;
        }
        field(65; "Final Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(66; "Objectives & Outcomes Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(67; "Competency Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(68; "Length of Service"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Total Objectives Qty"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Objective Evaluation Result"."Target Qty" where("Performance Evaluation ID" = field(No)));
        }
        field(70; "Total PEval Qty"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Proficiency Evaluation Result"."Target Qty" where("Performance Evaluation ID" = field(No)));
        }
        // field(71; "Region Code"; Code[50])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Region));
        // }
        field(72; "Departmental Objectives ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Departmental Objectives Header" where("Primary Department" = field(Department), "Appraisal Period" = field("Review Period"));

            trigger OnValidate()
            var
                DeptObjectives: Record AppraisalDeptObjectives;
                LastLineNo: Integer;
            begin
                DeptObjectives.Reset();
                DeptObjectives.SetRange("Document No.", Rec.No);
                DeptObjectives.SetRange("Primary Department", Emp."Responsibility Center");
                DeptObjectives.SetRange("Appraisal Period", Rec."Review Period");
                DeptObjectives.DeleteAll();

                DeptObjLines.Reset();
                DeptObjLines.SetRange("Document No.", Rec."Departmental Objectives ID");
                if DeptObjLines.FindSet then begin
                    repeat
                        DeptObjectives.Reset();
                        if DeptObjectives.FindLast() then begin
                            LastLineNo := DeptObjectives."Line No.";
                        end else begin
                            LastLineNo := 1000;
                        end;

                        DeptObjectives.Init();
                        DeptObjectives."Document No." := Rec.No;
                        DeptObjectives."Line No." := LastLineNo + 1000;
                        DeptObjectives."No." := DeptObjLines."No.";
                        DeptObjectives."Appraisal Period" := Rec."Review Period";
                        DeptObjectives."Annual Reporting Code" := Rec."Annual Reporting Code";
                        DeptObjectives.Description := DeptObjLines.Description;
                        DeptObjectives."Primary Department" := DeptObjLines."Primary Department";
                        //DeptObjectives."Primary Department" := DeptObjLines."Primary Directorate";
                        DeptObjectives."Appraisal Period" := Rec."Review Period";
                        DeptObjectives.Target := DeptObjLines.Target;
                        DeptObjectives."Unit of Measure" := DeptObjLines."Unit of Measure";
                        DeptObjectives.Insert(true);
                    until DeptObjLines.Next = 0;
                end;
            end;
        }
        field(73; "Evaluation Stage"; Option)
        {
            Caption = 'Evaluation Stage';
            DataClassification = ToBeClassified;
            OptionCaption = 'Draft,Employee Self-Assessment,Manager Evaluation,HR Review,Calibration,Final Approved';
            OptionMembers = Draft,"Employee Self-Assessment","Manager Evaluation","HR Review",Calibration,"Final Approved";
        }
        field(74; "Employee Acknowledgment Date"; Date)
        {
            Caption = 'Employee Acknowledgment Date';
            DataClassification = ToBeClassified;
        }
        field(75; "Supervisor Acknowledgment Date"; Date)
        {
            Caption = 'Supervisor Acknowledgment Date';
            DataClassification = ToBeClassified;
        }
        field(76; "HR Reviewer No."; Code[50])
        {
            Caption = 'HR Reviewer No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(77; "HR Review Date"; Date)
        {
            Caption = 'HR Review Date';
            DataClassification = ToBeClassified;
        }
        field(78; "Final Approval Date"; Date)
        {
            Caption = 'Final Approval Date';
            DataClassification = ToBeClassified;
        }
        field(79; "Final Approved By"; Code[50])
        {
            Caption = 'Final Approved By';
            DataClassification = ToBeClassified;
        }
        field(80; "Are Objectives On Track?"; Boolean)
        {
            Caption = 'Are Objectives On Track against Plan?';
        }
        field(81; "Received Ongoing Feedback"; Boolean)
        {
            Caption = 'Did you receive ongoing feedback from your line manager?';
        }
        field(82; "Development Actions On Track"; Boolean)
        {
            Caption = 'Are your development actions on track against plan?';
        }
    }

    keys
    {
        key(Key1; No, "Review Period")
        {
            Clustered = true;
        }
        key(Key2; "Performance Mgt Plan ID", "Performance Task ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Err001: Label 'Posting is only allowed from dates within %1 to %2';
    begin
        HRSetup.Get();
        // HRSetup.TestField("Allow Appr. Create From");
        // HRSetup.TestField("Allow Appr. Create To");

        // if CheckIfAllowedAppraisalCreation(HRSetup."Allow Appr. Create From", HRSetup."Allow Appr. Create To") <> true then
        //     Error(Err001, HRSetup."Allow Appr. Create From", HRSetup."Allow Appr. Create To");

        if "Document Type" = "document type"::"Performance Appraisal" then begin
            if "Evaluation Type" = "evaluation type"::"Standard Appraisal/Supervisor Score Only" then begin
                if No = '' then begin
                    SPMSetup.Get;
                    SPMSetup.TestField("Performance Evaluation Nos");
                    No := NoSeriesMgt.GetNextNo(SPMSetup."Performance Evaluation Nos", 0D, true);
                end;
            end;
            if "Evaluation Type" = "evaluation type"::"Self-Appraisal with Supervisor Score" then begin
                if No = '' then begin
                    SPMSetup.Get;
                    SPMSetup.TestField("Performance Evaluation Nos");
                    No := NoSeriesMgt.GetNextNo(SPMSetup."Performance Evaluation Nos", 0D, true);
                end;
            end;
            if "Evaluation Type" = "evaluation type"::"360-Degree/Group Appraisal" then begin
                if No = '' then begin
                    SPMSetup.Get;
                    SPMSetup.TestField("Performance Evaluation Nos");
                    No := NoSeriesMgt.GetNextNo(SPMSetup."Performance Evaluation Nos", 0D, true);
                end;
            end;
        end;

        if "Document Type" = "document type"::"Performance Appeal" then begin
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("Performance Appeals No. Series");
                No := NoSeriesMgt.GetNextNo(SPMSetup."Performance Appeals No. Series", 0D, true);
            end;
        end;

        "Created By" := UserId;
        "Created On" := Today;
        "Document Date" := Today;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnModify()
    begin
        CheckCalibrationLock();
    end;

    var
        SPMSetup: Record "SPM General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Emp: Record Employee;
        ResponsibityC: Record "Responsibility Center";
        PerformancePlanTask: Record "Performance Plan Task";
        PerfomanceEvaluationTemplate: Record "Perfomance Evaluation Template";
        PerformanceManagementPlan: Record "Performance Management Plan";
        PerformanceEvaluationWeight: Record "Performance Evaluation Weight";
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        UserSetup: Record "User Setup";
        HRSetup: Record "Human Resources Setup";
        ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';
        DeptObjLines: Record "Departmental Objectives L";
        DeptObjHeader: Record "Departmental Objectives Header";

    procedure SetPIPSupervisorComments(NewDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("PIP Supervisor Comments");
        "PIP Supervisor Comments".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewDescription);
        Modify;
    end;

    procedure GetPIPSupervisorComments() Description: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("PIP Supervisor Comments");
        "PIP Supervisor Comments".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), Description) then
            Message(ReadingDataSkippedMsg, FieldCaption("PIP Supervisor Comments"));
    end;

    procedure SetPIPEmployeeComments(NewDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("PIP Employee Comments");
        "PIP Employee Comments".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewDescription);
        Modify;
    end;

    procedure GetPIPEmployeeComments() Description: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("PIP Employee Comments");
        "PIP Employee Comments".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), Description) then
            Message(ReadingDataSkippedMsg, FieldCaption("PIP Employee Comments"));
    end;

    procedure SetPIPFinalReview(NewDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("PIP Final Review");
        "PIP Final Review".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewDescription);
        Modify;
    end;

    procedure GetPIPFinalReview() Description: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("PIP Final Review");
        "PIP Final Review".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), Description) then
            Message(ReadingDataSkippedMsg, FieldCaption("PIP Final Review"));
    end;

    procedure SetRecommendationOfRewardOrSanction(NewDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Recommendation Reward/Sanction");
        "Recommendation Reward/Sanction".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewDescription);
        Modify;
    end;

    procedure GetRecommendationOfRewardOrSanction() Description: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Recommendation Reward/Sanction");
        "Recommendation Reward/Sanction".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), Description) then
            Message(ReadingDataSkippedMsg, FieldCaption("Recommendation Reward/Sanction"));
    end;

    local procedure CheckIfAllowedAppraisalCreation(var StartDate: Date; var EndDate: Date): Boolean
    begin
        if Today >= StartDate then begin
            if Today <= EndDate then
                exit(true);
        end;
    end;

    /// <summary>
    /// GetFinalScore.
    /// </summary>
    procedure GetFinalScore(var Perfomance: Record "Performance Evaluation")
    var
        ObjectivePerc: Decimal;
        ProficiencyPerc: Decimal;
        FinalScore: Decimal;
        AvgObjectivesQty: Decimal;
        AvgProficiencyQty: Decimal;
        AvgObjectivesAch: Decimal;
        AvgProficiencyAch: Decimal;
    begin
        Perfomance.CalcFields("Total Objectives Qty", "Total Objectives Result", "Total PEval Qty", "Objectives Count", "Proficiency Eval Count", "Total PEval Result");

        if Perfomance."Objectives Count" <> 0 then begin
            if Perfomance."Total Objectives Result" <> 0 then begin
                AvgObjectivesQty := Perfomance."Total Objectives Qty" / Perfomance."Objectives Count";
                AvgObjectivesAch := Perfomance."Total Objectives Result" / Perfomance."Objectives Count";
                ObjectivePerc := AvgObjectivesAch / AvgObjectivesQty * 80;
            end;
        end;

        if "Proficiency Eval Count" <> 0 then begin
            if Perfomance."Total PEval Result" <> 0 then begin
                AvgProficiencyQty := Perfomance."Total PEval Qty" / Perfomance."Proficiency Eval Count";
                AvgProficiencyAch := Perfomance."Total PEval Result" / Perfomance."Proficiency Eval Count";
                ProficiencyPerc := AvgProficiencyAch / AvgProficiencyQty * 20;
            end;
        end;

        FinalScore := ObjectivePerc + ProficiencyPerc;

        Perfomance."Final Score" := FinalScore;
        Perfomance."Competency Score" := ProficiencyPerc;
        Perfomance."Objectives & Outcomes Score" := ObjectivePerc;
        Perfomance.Modify(true);
    end;

    /// <summary>
    /// GetServiceLength.
    /// </summary>
    /// <param name="StartDate">VAR Date.</param>
    /// <param name="EndDate">VAR Date.</param>
    /// <returns>Return variable ServiceLength of type Text[50].</returns>
    procedure GetServiceLength(var StartDate: Date; var EndDate: Date) ServiceLength: Text[50]
    var
        recDate: Record Date;
        TotalDays: Integer;
        TempDate: Date;
        LastFoundDate: Date;
        CountYears: Integer;
        CountMonths: Integer;
        CountDays: Integer;
        Found: Boolean;
        Text001: Label 'Total Days: %1\Years: %2\Months: %3\Days: %4';
    begin
        recDate.RESET;
        recDate.SETRANGE("Period Type", recDate."Period Type"::Date);
        recDate.SETRANGE("Period Start", StartDate, EndDate);

        TotalDays := RecDate.COUNT;

        IF RecDate.FINDSET THEN BEGIN

            LastFoundDate := StartDate;

            // *** find count of years ***
            TempDate := CALCDATE('+1Y', StartDate);
            Found := TRUE;

            REPEAT
                IF (TempDate <= EndDate) AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                    CountYears += 1;
                    LastFoundDate := TempDate;
                    TempDate := CALCDATE('+1Y', TempDate);
                END ELSE
                    Found := FALSE;
            UNTIL NOT Found;

            // *** find count of months ***
            TempDate := CALCDATE('+1M', LastFoundDate);
            Found := TRUE;

            REPEAT
                IF (TempDate <= EndDate) AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                    CountMonths += 1;
                    LastFoundDate := TempDate;
                    TempDate := CALCDATE('+1M', TempDate);
                END ELSE
                    Found := FALSE;
            UNTIL NOT Found;

            // *** find count of days ***
            TempDate := CALCDATE('+1D', LastFoundDate);
            Found := TRUE;

            REPEAT
                IF (TempDate <= EndDate) AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                    CountDays += 1;
                    LastFoundDate := TempDate;
                    TempDate := CALCDATE('+1D', TempDate);
                END ELSE
                    Found := FALSE;
            UNTIL NOT Found;
        END;

        // MESSAGE(Text001, TotalDays, CountYears, CountMonths, CountDays);

        ServiceLength := Format(CountYears) + ' Years ' + Format(CountMonths) + ' Months ' + Format(CountDays) + ' Days';
        exit(ServiceLength);
    end;

    local procedure FnGetDeptLastLineNo() LineNumber: Integer
    var
        DepartmentalObjectives: Record AppraisalDeptObjectives;
    begin
        DepartmentalObjectives.Reset;
        DepartmentalObjectives.SetRange("Document No.", Rec.No);
        DepartmentalObjectives.SetRange("Primary Department", Emp."Responsibility Center");
        DepartmentalObjectives.SetRange("Appraisal Period", Rec."Review Period");
        if DepartmentalObjectives.FindLast() then begin
            LineNumber := DepartmentalObjectives."Line No.";
        end;
        exit(LineNumber);
    end;

    procedure CheckCalibrationLock()
    var
        CalibLockErr: Label 'Rating changes are not allowed during the Calibration window (%1 to %2). Contact HR to unlock.';
    begin
        SPMSetup.Get();
        if (SPMSetup."Calibration Start Date" <> 0D) and (SPMSetup."Calibration End Date" <> 0D) then
            if (Today >= SPMSetup."Calibration Start Date") and (Today <= SPMSetup."Calibration End Date") then
                if (Rec."Evaluation Stage" = Rec."evaluation stage"::Calibration) or
                   (Rec."Evaluation Stage" = Rec."evaluation stage"::"HR Review")
                then
                    Error(CalibLockErr, SPMSetup."Calibration Start Date", SPMSetup."Calibration End Date");
    end;

    procedure IsCalibrationActive(): Boolean
    begin
        SPMSetup.Get();
        if (SPMSetup."Calibration Start Date" <> 0D) and (SPMSetup."Calibration End Date" <> 0D) then
            exit((Today >= SPMSetup."Calibration Start Date") and (Today <= SPMSetup."Calibration End Date"));
        exit(false);
    end;
}
