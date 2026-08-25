#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Codeunit 52211659 "Strategic Planning"
{

    trigger OnRun()
    begin
    end;

    var
        WPLines: Record "Strategy Workplan Lines";
        StrategicAct: Record "Strategic Initiative";
        ServerFileName: Text;
        SheetName: Text;
        FIleManagement: Codeunit "File Management";
        ExcelExt: Text;
        AnnualWorkPlan: Record "Strategy Workplan Lines";
        StrategyEntry: Record "Strategy Sub_Activity Entry";
        WPlanLines: Record "Strategy Workplan Lines";
        I: Integer;
        ThemeID: Code[50];
        ObjectiveID: Code[50];
        StrategicInt: Record "Strategic Initiative";
        SourceType: Option "Strategic Plan","Perfomance Contract";
        YearCode: Record "Annual Reporting Codes";
        QYearCode: Record "Quarterly Reporting Periods";
        QCount: Integer;
        Q1: Code[20];
        Q1date: Date;
        Q2: Code[20];
        Q2date: Date;
        Q3: Code[20];
        Q3date: Date;
        Q4: Code[20];
        Q4date: Date;
        PCObjective: Record "PC Objective";
        ObjectiveOutcome: Record "Objective Evaluation Result";
        CompetencyLines: Record "Competency Template Line";
        ProEvaluation: Record "Proficiency Evaluation Result";
        ReviewPeriods: Record "Review Periods";
        SPMGeneralSetup: Record "SPM General Setup";
        PCJobDescription: Record "PC Job Description";
        SubJDObjective: Record "Sub JD Objective";


    procedure fnPostPlanEntry(WPlanLines: Record "Strategy Workplan Lines")
    var
        StrategyEntry: Record "Strategy Sub_Activity Entry";
    begin
        StrategicInt.Reset;
        StrategicInt.SetRange(Code, WPlanLines."Activity ID");
        if StrategicInt.Find('-') then begin
            ThemeID := StrategicInt."Theme ID";
            ObjectiveID := StrategicInt."Objective ID";
        end;

        QYearCode.Reset;
        QYearCode.SetRange("Year Code", WPlanLines."Year Reporting Code");
        if QYearCode.Find('-') then begin
            repeat
                QCount := QCount + 1;
                if (QCount = 1) then begin
                    Q1 := QYearCode.Code;
                    Q1date := QYearCode."Reporting Start Date";
                end;
                if (QCount = 2) then begin
                    Q2 := QYearCode.Code;
                    Q2date := QYearCode."Reporting Start Date";
                end;
                if (QCount = 3) then begin
                    Q3 := QYearCode.Code;
                    Q3date := QYearCode."Reporting Start Date";
                end;
                if (QCount = 4) then begin
                    Q4 := QYearCode.Code;
                    Q4date := QYearCode."Reporting Start Date";
                end;
            until QYearCode.Next = 0;
        end;


        // I:=0;
        for I := 1 to 4 do begin
            if (I = 1) then begin
                FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
                WPlanLines."Year Reporting Code", Q1, Q1date, WPlanLines."Primary Department", WPlanLines."Q1 Target", WPlanLines."Q1 Budget",
                WPlanLines.No, Sourcetype::"Strategic Plan");
            end;
            if (I = 2) then begin
                FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
                WPlanLines."Year Reporting Code", Q2, Q2date, WPlanLines."Primary Department", WPlanLines."Q2 Target", WPlanLines."Q2 Budget",
                WPlanLines.No, Sourcetype::"Strategic Plan");
            end;

            if (I = 3) then begin
                FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
                WPlanLines."Year Reporting Code", Q3, Q3date, WPlanLines."Primary Department", WPlanLines."Q3 Target", WPlanLines."Q3 Budget",
                WPlanLines.No, Sourcetype::"Strategic Plan");

            end;
            if (I = 4) then begin
                FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
                WPlanLines."Year Reporting Code", Q4, Q4date, WPlanLines."Primary Department", WPlanLines."Q4 Target", WPlanLines."Q4 Budget",
                WPlanLines.No, Sourcetype::"Strategic Plan");
            end;


            // if (I = 1) then begin
            //     FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
            //     WPlanLines."Year Reporting Code", Q1, Q1date, WPlanLines."Primary Department", WPlanLines."Primary Division", WPlanLines."Q1 Target", WPlanLines."Q1 Budget",
            //     WPlanLines.No, Sourcetype::"Strategic Plan");
            // end;
            // if (I = 2) then begin
            //     FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
            //     WPlanLines."Year Reporting Code", Q2, Q2date, WPlanLines."Primary Department", WPlanLines."Primary Division", WPlanLines."Q2 Target", WPlanLines."Q2 Budget",
            //     WPlanLines.No, Sourcetype::"Strategic Plan");
            // end;

            // if (I = 3) then begin
            //     FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
            //     WPlanLines."Year Reporting Code", Q3, Q3date, WPlanLines."Primary Department", WPlanLines."Primary Division", WPlanLines."Q3 Target", WPlanLines."Q3 Budget",
            //     WPlanLines.No, Sourcetype::"Strategic Plan");

            // end;
            // if (I = 4) then begin
            //     FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
            //     WPlanLines."Year Reporting Code", Q4, Q4date, WPlanLines."Primary Department", WPlanLines."Primary Division", WPlanLines."Q4 Target", WPlanLines."Q4 Budget",
            //     WPlanLines.No, Sourcetype::"Strategic Plan");
            // end;
        end;
    end;


    procedure FnInsertEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDepartment: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract")
    var
        StrategyEntry: Record "Strategy Sub_Activity Entry";
    begin

        StrategyEntry.Init;
        StrategyEntry."Strategic Plan ID" := PlanID;
        StrategyEntry."Theme ID" := ThemeID;
        StrategyEntry."Objective ID" := ObjectiveID;
        StrategyEntry."Strategy ID" := StrategyID;
        StrategyEntry."Activity ID" := Actitvityid;
        StrategyEntry."Entry Description" := Description;
        StrategyEntry."Entry Type" := EntryType;
        StrategyEntry."Year Reporting Code" := YearCode;
        StrategyEntry."Quarter Reporting Code" := QYearCode;
        StrategyEntry."Planning Date" := PlanningDate;
        StrategyEntry."Primary Department" := PrimaryDepartment;
        StrategyEntry.Quantity := Quantity;
        StrategyEntry."Cost Amount" := CostAmount;
        StrategyEntry."External Document No" := Extdoc;
        StrategyEntry."Source Type" := SourceType;
        StrategyEntry.Insert(true);
    end;

    // procedure FnInsertEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDepartment: Code[100]; PrimaryDivision: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract")
    // var
    //     StrategyEntry: Record "Strategy Sub_Activity Entry";
    // begin

    //     StrategyEntry.Init;
    //     StrategyEntry."Strategic Plan ID" := PlanID;
    //     StrategyEntry."Theme ID" := ThemeID;
    //     StrategyEntry."Objective ID" := ObjectiveID;
    //     StrategyEntry."Strategy ID" := StrategyID;
    //     StrategyEntry."Activity ID" := Actitvityid;
    //     StrategyEntry."Entry Description" := Description;
    //     StrategyEntry."Entry Type" := EntryType;
    //     StrategyEntry."Year Reporting Code" := YearCode;
    //     StrategyEntry."Quarter Reporting Code" := QYearCode;
    //     StrategyEntry."Planning Date" := PlanningDate;
    //     StrategyEntry."Primary Department" := PrimaryDepartment;
    //     StrategyEntry."Primary Division" := PrimaryDivision;
    //     StrategyEntry.Quantity := Quantity;
    //     StrategyEntry."Cost Amount" := CostAmount;
    //     StrategyEntry."External Document No" := Extdoc;
    //     StrategyEntry."Source Type" := SourceType;
    //     StrategyEntry.Insert(true);
    // end;


    procedure fnPostObjectiveEntry(ObjectiveOutcome: Record "Objective Evaluation Result")
    var
        StrategyEntry: Record "Strategy Sub_Activity Entry";
        PerformanceEvaluation: Record "Performance Evaluation";
        ReviewQuarterlyPeriods: Record "Review Quarterly Periods";
        StrategicPlan: Code[50];
        EntryType: Option Planned,Actual;
    begin
        StrategicInt.Reset;
        StrategicInt.SetRange(Code, ObjectiveOutcome."Intiative No");
        if StrategicInt.Find('-') then begin
            StrategicPlan := StrategicInt."Strategic Plan ID";
            ThemeID := StrategicInt."Theme ID";
            ObjectiveID := StrategicInt."Objective ID";
        end;

        PerformanceEvaluation.Reset;
        PerformanceEvaluation.SetRange(No, ObjectiveOutcome."Performance Evaluation ID");
        if PerformanceEvaluation.FindFirst then begin
            ReviewPeriods.Reset;
            ReviewPeriods.SetRange(Code, PerformanceEvaluation."Review Period");
            if ReviewPeriods.FindFirst then begin
                QCount := 0;
                case ReviewPeriods."Review Type" of
                    ReviewPeriods."review type"::Quartely:
                        begin
                            ReviewQuarterlyPeriods.Reset;
                            ReviewQuarterlyPeriods.SetRange("Review Period Code", ReviewPeriods.Code);
                            if ReviewQuarterlyPeriods.Find('-') then begin
                                FnInsertEntry(StrategicPlan, ThemeID, ObjectiveID, StrategicPlan, ObjectiveOutcome."Intiative No", ObjectiveOutcome."Objective/Initiative", Entrytype::Actual,
                               ReviewQuarterlyPeriods."Year Code", ReviewQuarterlyPeriods.Code, ReviewQuarterlyPeriods."Reporting Start Date", ObjectiveOutcome."Primary Department",
                               ObjectiveOutcome."AppraiserReview Qty", 0,
                               ObjectiveOutcome."Performance Evaluation ID", Sourcetype::"Perfomance Contract");
                            end;
                        end;
                    ReviewPeriods."review type"::"Semi-Quartely":
                        begin
                            ReviewQuarterlyPeriods.Reset;
                            ReviewQuarterlyPeriods.SetRange("Review Period Code", ReviewPeriods.Code);
                            if ReviewQuarterlyPeriods.Find('-') then begin
                                repeat
                                    FnInsertEntry(StrategicPlan, ThemeID, ObjectiveID, StrategicPlan, ObjectiveOutcome."Intiative No", ObjectiveOutcome."Objective/Initiative", Entrytype::Actual,
                                    ReviewQuarterlyPeriods."Year Code", ReviewQuarterlyPeriods.Code, ReviewQuarterlyPeriods."Reporting Start Date", ObjectiveOutcome."Primary Department",
                                 ObjectiveOutcome."AppraiserReview Qty" / ReviewPeriods."No of Quarters", 0,
                                    ObjectiveOutcome."Performance Evaluation ID", Sourcetype::"Perfomance Contract");
                                until ReviewQuarterlyPeriods.Next = 0;
                            end;

                        end;
                    ReviewPeriods."review type"::Annually:
                        begin
                            ReviewQuarterlyPeriods.Reset;
                            ReviewQuarterlyPeriods.SetRange("Review Period Code", ReviewPeriods.Code);
                            if ReviewQuarterlyPeriods.Find('-') then begin
                                repeat
                                    FnInsertEntry(StrategicPlan, ThemeID, ObjectiveID, StrategicPlan, ObjectiveOutcome."Intiative No", ObjectiveOutcome."Objective/Initiative", Entrytype::Actual,
                                    ReviewQuarterlyPeriods."Year Code", ReviewQuarterlyPeriods.Code, ReviewQuarterlyPeriods."Reporting Start Date", ObjectiveOutcome."Primary Department",
                                     ObjectiveOutcome."AppraiserReview Qty" / ReviewPeriods."No of Quarters", 0,
                                    ObjectiveOutcome."Performance Evaluation ID", Sourcetype::"Perfomance Contract");
                                until ReviewQuarterlyPeriods.Next = 0;
                            end;

                        end else
                                Error('Review Type Category must be selected for Review Period %1', ReviewPeriods.Code);
                end;
            end;
        end;

        // PerformanceEvaluation.Reset;
        // PerformanceEvaluation.SetRange(No, ObjectiveOutcome."Performance Evaluation ID");
        // if PerformanceEvaluation.FindFirst then begin
        //     ReviewPeriods.Reset;
        //     ReviewPeriods.SetRange(Code, PerformanceEvaluation."Review Period");
        //     if ReviewPeriods.FindFirst then begin
        //         QCount := 0;
        //         case ReviewPeriods."Review Type" of
        //             ReviewPeriods."review type"::Quartely:
        //                 begin
        //                     ReviewQuarterlyPeriods.Reset;
        //                     ReviewQuarterlyPeriods.SetRange("Review Period Code", ReviewPeriods.Code);
        //                     if ReviewQuarterlyPeriods.Find('-') then begin
        //                         FnInsertEntry(StrategicPlan, ThemeID, ObjectiveID, StrategicPlan, ObjectiveOutcome."Intiative No", ObjectiveOutcome."Objective/Initiative", Entrytype::Actual,
        //                        ReviewQuarterlyPeriods."Year Code", ReviewQuarterlyPeriods.Code, ReviewQuarterlyPeriods."Reporting Start Date", ObjectiveOutcome."Primary Department",
        //                        ObjectiveOutcome."Primary Division", ObjectiveOutcome."AppraiserReview Qty", 0,
        //                        ObjectiveOutcome."Performance Evaluation ID", Sourcetype::"Perfomance Contract");
        //                     end;
        //                 end;
        //             ReviewPeriods."review type"::"Semi-Quartely":
        //                 begin
        //                     ReviewQuarterlyPeriods.Reset;
        //                     ReviewQuarterlyPeriods.SetRange("Review Period Code", ReviewPeriods.Code);
        //                     if ReviewQuarterlyPeriods.Find('-') then begin
        //                         repeat
        //                             FnInsertEntry(StrategicPlan, ThemeID, ObjectiveID, StrategicPlan, ObjectiveOutcome."Intiative No", ObjectiveOutcome."Objective/Initiative", Entrytype::Actual,
        //                             ReviewQuarterlyPeriods."Year Code", ReviewQuarterlyPeriods.Code, ReviewQuarterlyPeriods."Reporting Start Date", ObjectiveOutcome."Primary Department",
        //                             ObjectiveOutcome."Primary Division", ObjectiveOutcome."AppraiserReview Qty" / ReviewPeriods."No of Quarters", 0,
        //                             ObjectiveOutcome."Performance Evaluation ID", Sourcetype::"Perfomance Contract");
        //                         until ReviewQuarterlyPeriods.Next = 0;
        //                     end;

        //                 end;
        //             ReviewPeriods."review type"::Annually:
        //                 begin
        //                     ReviewQuarterlyPeriods.Reset;
        //                     ReviewQuarterlyPeriods.SetRange("Review Period Code", ReviewPeriods.Code);
        //                     if ReviewQuarterlyPeriods.Find('-') then begin
        //                         repeat
        //                             FnInsertEntry(StrategicPlan, ThemeID, ObjectiveID, StrategicPlan, ObjectiveOutcome."Intiative No", ObjectiveOutcome."Objective/Initiative", Entrytype::Actual,
        //                             ReviewQuarterlyPeriods."Year Code", ReviewQuarterlyPeriods.Code, ReviewQuarterlyPeriods."Reporting Start Date", ObjectiveOutcome."Primary Department",
        //                             ObjectiveOutcome."Primary Division", ObjectiveOutcome."AppraiserReview Qty" / ReviewPeriods."No of Quarters", 0,
        //                             ObjectiveOutcome."Performance Evaluation ID", Sourcetype::"Perfomance Contract");
        //                         until ReviewQuarterlyPeriods.Next = 0;
        //                     end;

        //                 end else
        //                         Error('Review Type Category must be selected for Review Period %1', ReviewPeriods.Code);
        //         end;
        //     end;
        // end;

    end;


    procedure FnGenerateBatchAppraisals(PerformancePlanTask: Record "Performance Plan Task"; StrategicID: Code[10])
    var
        Employee: Record Employee;
        PerfomanceEvaluation: Record "Performance Evaluation";
        PerformanceManagementPlan: Record "Performance Management Plan";
        SPMSetup: Record "SPM General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        AnnualReportingCode: Code[30];
        PerfomanceEvaluationNo: Code[30];
    begin
        Employee.Reset;
        Employee.SetRange(Status, Employee.Status::Active);
        //Employee.SETRANGE("Primary Bank %",TRUE);
        if Employee.Find('-') then begin
            repeat
                SPMSetup.Get;
                PerfomanceEvaluation.Init;
                PerfomanceEvaluation."Document Type" := PerfomanceEvaluation."document type"::"Performance Appraisal";
                PerformanceManagementPlan.Reset;
                PerformanceManagementPlan.SetRange(No, PerformancePlanTask."Performance Mgt Plan ID");
                if PerformanceManagementPlan.Find('-') then begin
                    // PerformanceManagementPlan.TESTFIELD("Evaluation Type");
                    PerformanceManagementPlan.TestField("Strategy Plan ID");
                    PerformanceManagementPlan.TestField("Annual Reporting Code");
                    StrategicID := PerformanceManagementPlan."Strategy Plan ID";
                    AnnualReportingCode := PerformanceManagementPlan."Annual Reporting Code";
                    PerfomanceEvaluation."Evaluation Type" := PerformanceManagementPlan."Evaluation Type";
                end;
                PerfomanceEvaluation.No := '';
                PerfomanceEvaluation."Performance Mgt Plan ID" := PerformancePlanTask."Performance Mgt Plan ID";
                PerfomanceEvaluation."Strategy Plan ID" := StrategicID;
                PerfomanceEvaluation.Validate("Performance Mgt Plan ID");
                PerfomanceEvaluation."Performance Task ID" := PerformancePlanTask."Task Code";
                PerfomanceEvaluation.Validate("Performance Task ID");
                PerfomanceEvaluation."Employee No." := Employee."No.";
                PerfomanceEvaluation.Validate("Employee No.");
                PerfomanceEvaluation."Personal Scorecard ID" := FnGetPersonalScorecard(Employee."No.", AnnualReportingCode);
                PerfomanceEvaluation."Annual Reporting Code" := AnnualReportingCode;
                if PerfomanceEvaluation.Insert(true) then begin
                    FnSuggestObjectives(PerfomanceEvaluation);
                    FnSuggestEvaluations(PerfomanceEvaluation);
                end;
            until Employee.Next = 0;
        end;
        Message('Employees Performance Appraisals Generated Successfully');
    end;


    procedure FnGetPersonalScorecard(EmployeeNo: Code[30]; AnnualReportingCode: Code[10]) PersonalScoreCard: Code[10]
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange("Responsible Employee No.", EmployeeNo);
        PerfomanceContractHeader.SetRange("Annual Reporting Code", AnnualReportingCode);
        PerfomanceContractHeader.SetRange("Document Type", PerfomanceContractHeader."document type"::"Staff Performance Contract");
        PerfomanceContractHeader.SetRange(Status, PerfomanceContractHeader.Status::Signed);
        if PerfomanceContractHeader.FindFirst then begin
            PersonalScoreCard := PerfomanceContractHeader.No;
            exit(PersonalScoreCard);
        end else
            Error('Employee No %1 does not have a Signed Performance Contract for Annual Period %2', EmployeeNo, AnnualReportingCode);
    end;

    procedure FnUpdateAnnualWorkplan(AnnualStrategyWorkplan: record "Annual Strategy Workplan")
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        StrategyWorkplanLines: Record "Strategy Workplan Lines";
        StrategyWorkplanLines1: Record "Strategy Workplan Lines";
        BoardActivities: Record "Board Activities";
        BoardActivities1: Record "Board Activities";
        BoardSubActivities: Record "Board Sub Activities";
        BoardSubActivities1: Record "Board Sub Activities";
        SubWorkplanActivity: Record "Sub Workplan Activity";
        SubWorkplanActivity1: Record "Sub Workplan Activity";
        WorkplanCostElements: Record "Workplan Cost Elements";
        WorkplanCostElement1: Record "Workplan Cost Elements";
    begin
        AnnualStrategyWorkplan.TESTFIELD("Annual Workplan");
        //AnnualStrategyWorkplan.TESTFIELD("Functional Procurment Plan No");
        AnnualStrategyWorkplan.TESTFIELD("Approval Status", AnnualStrategyWorkplan."Approval Status"::Released);

        AnnualStrategyWorkplan.TESTFIELD("Annual Workplan");
        AnnualStrategyWorkplan.TESTFIELD(Posted, FALSE);
        AnnualStrategyWorkplan.CALCFIELDS("Total Assigned Weight(%)");
        // IF AnnualStrategyWorkplan."Total Assigned Weight(%)" <> 100 THEN
        //     ERROR('Assigned Weight should be equals to 100%');

        IF NOT CONFIRM('Are you sure you want to update the Selected Annual Workplan?', TRUE) THEN BEGIN
            ERROR('Annual Workplan not Updated');
        END;
        //Insert Strategy Workplan Lines
        StrategyWorkplanLines.RESET;
        StrategyWorkplanLines.SETRANGE(No, AnnualStrategyWorkplan.No);
        IF StrategyWorkplanLines.FINDSET THEN BEGIN
            REPEAT
                StrategyWorkplanLines.TESTFIELD("Primary Department");
                // StrategyWorkplanLines.TESTFIELD("Primary Department");

                StrategyWorkplanLines1.INIT;
                StrategyWorkplanLines1.No := AnnualStrategyWorkplan."Annual Workplan";
                StrategyWorkplanLines1."Strategy Plan ID" := StrategyWorkplanLines."Strategy Plan ID";
                StrategyWorkplanLines1."Activity ID" := StrategyWorkplanLines."Activity ID";
                StrategyWorkplanLines1.Description := StrategyWorkplanLines.Description;
                StrategyWorkplanLines1."Cross Cutting" := StrategyWorkplanLines."Cross Cutting";
                StrategyWorkplanLines1."Imported Annual Target Qty" := StrategyWorkplanLines."Imported Annual Target Qty";
                StrategyWorkplanLines1."Imported Annual Budget Est." := StrategyWorkplanLines."Imported Annual Budget Est.";
                // StrategyWorkplanLines1."Primary Department" := StrategyWorkplanLines."Primary Department";
                // StrategyWorkplanLines1."Primary Department Name" := StrategyWorkplanLines."Primary Department Name";
                StrategyWorkplanLines1."Primary Department" := StrategyWorkplanLines."Primary Department";
                StrategyWorkplanLines1."Primary Department Name" := StrategyWorkplanLines."Primary Department Name";
                StrategyWorkplanLines1."Q1 Target" := StrategyWorkplanLines."Q1 Target";
                StrategyWorkplanLines1."Q1 Budget" := StrategyWorkplanLines."Q1 Budget";
                StrategyWorkplanLines1."Q2 Target" := StrategyWorkplanLines."Q2 Target";
                StrategyWorkplanLines1."Q2 Budget" := StrategyWorkplanLines."Q2 Budget";
                StrategyWorkplanLines1."Q3 Target" := StrategyWorkplanLines."Q3 Target";
                StrategyWorkplanLines1."Q3 Budget" := StrategyWorkplanLines."Q3 Budget";
                StrategyWorkplanLines1."Q4 Target" := StrategyWorkplanLines."Q4 Target";
                StrategyWorkplanLines1."Q4 Budget" := StrategyWorkplanLines."Q4 Budget";
                StrategyWorkplanLines1."Entry Type" := StrategyWorkplanLines."Entry Type";
                StrategyWorkplanLines1."Year Reporting Code" := StrategyWorkplanLines."Year Reporting Code";
                StrategyWorkplanLines1."Perfomance Indicator" := FORMAT(StrategyWorkplanLines."Perfomance Indicator");
                StrategyWorkplanLines1."Source Of Fund" := StrategyWorkplanLines."Source Of Fund";
                StrategyWorkplanLines1."Unit of Measure" := StrategyWorkplanLines."Unit of Measure";
                StrategyWorkplanLines1."Desired Perfomance Direction" := StrategyWorkplanLines."Desired Perfomance Direction";
                StrategyWorkplanLines1."Strategy Framework" := StrategyWorkplanLines."Strategy Framework";
                StrategyWorkplanLines1."Framework Perspective" := StrategyWorkplanLines."Framework Perspective";
                StrategyWorkplanLines1."Key Performance Indicator" := StrategyWorkplanLines."Key Performance Indicator";
                StrategyWorkplanLines1."Assigned Weight(%)" := StrategyWorkplanLines."Assigned Weight(%)";
                StrategyWorkplanLines1."Annual Budget" := StrategyWorkplanLines."Annual Budget";
                StrategyWorkplanLines1."Annual Target" := StrategyWorkplanLines."Annual Target";
                StrategyWorkplanLines1."Total Subactivity budget" := StrategyWorkplanLines."Total Subactivity budget";
                StrategyWorkplanLines1."Departmental Activity Weight" := StrategyWorkplanLines."Departmental Activity Weight";
                StrategyWorkplanLines1.Outcome := StrategyWorkplanLines.Outcome;
                StrategyWorkplanLines1.INSERT(TRUE);

                //Insert Annual Workplan Sub-Activities
                SubWorkplanActivity.RESET;
                SubWorkplanActivity.SETRANGE("Workplan No.", AnnualStrategyWorkplan.No);
                SubWorkplanActivity.SETRANGE("Activity Id", StrategyWorkplanLines."Activity ID");
                IF SubWorkplanActivity.FINDSET THEN BEGIN
                    REPEAT
                        // ERROR('Testing');
                        SubWorkplanActivity1.INIT;
                        SubWorkplanActivity1."Workplan No." := AnnualStrategyWorkplan."Annual Workplan";
                        SubWorkplanActivity1."Initiative No." := SubWorkplanActivity."Initiative No.";
                        SubWorkplanActivity1."Activity Id" := SubWorkplanActivity."Activity Id";
                        SubWorkplanActivity1."Objective/Initiative" := SubWorkplanActivity."Objective/Initiative";
                        SubWorkplanActivity1."Sub Initiative No." := SubWorkplanActivity."Sub Initiative No.";
                        SubWorkplanActivity1."Unit of Measure" := SubWorkplanActivity."Unit of Measure";
                        SubWorkplanActivity1."Outcome Perfomance Indicator" := SubWorkplanActivity."Outcome Perfomance Indicator";
                        SubWorkplanActivity1."Imported Annual Target Qty" := SubWorkplanActivity."Imported Annual Target Qty";
                        SubWorkplanActivity1.Weight := SubWorkplanActivity.Weight;
                        SubWorkplanActivity1."Total Budget" := SubWorkplanActivity."Total Budget";
                        SubWorkplanActivity1."Due Date" := SubWorkplanActivity."Due Date";
                        SubWorkplanActivity1."Strategy Plan ID" := SubWorkplanActivity."Strategy Plan ID";
                        IF SubWorkplanActivity1.INSERT = TRUE THEN BEGIN
                            //removed for now
                            // //work plan cost elements
                            // WorkplanCostElements.RESET;
                            // WorkplanCostElements.SETRANGE("Workplan No.", AnnualStrategyWorkplan.No);
                            // WorkplanCostElements.SETRANGE("Activity Id", SubWorkplanActivity."Activity Id");
                            // WorkplanCostElements.SETRANGE("Sub Activity No", SubWorkplanActivity."Sub Initiative No.");
                            // IF WorkplanCostElements.FINDSET THEN BEGIN
                            //     REPEAT
                            //         // WorkplanCostElements.TESTFIELD("Plan Item No");
                            //         //WorkplanCostElements.TESTFIELD("Unit Cost");
                            //         //                       WorkplanCostElements.TESTFIELD(Quantity);
                            //         //                       WorkplanCostElements.TESTFIELD(Amount);// to be uncommented in future

                            //         WorkplanCostElement1.INIT;
                            //         WorkplanCostElement1."Workplan No." := AnnualStrategyWorkplan."Annual Workplan";
                            //         WorkplanCostElement1."Activity Id" := WorkplanCostElements."Activity Id";
                            //         WorkplanCostElement1."Sub Activity No" := WorkplanCostElements."Sub Activity No";
                            //         WorkplanCostElement1."Initiative No." := WorkplanCostElements."Initiative No.";
                            //         WorkplanCostElement1.TRANSFERFIELDS(WorkplanCostElements, FALSE);
                            //         WorkplanCostElement1."Functional Procurment Plan No" := AnnualStrategyWorkplan."Functional Procurment Plan No";
                            //         WorkplanCostElement1.INSERT;
                            //     UNTIL WorkplanCostElements.NEXT = 0;
                            // END;
                        END;
                    UNTIL SubWorkplanActivity.NEXT = 0;
                END;
            UNTIL StrategyWorkplanLines.NEXT = 0;
        END;
        //Insert Board Activities
        BoardActivities.RESET;
        BoardActivities.SETRANGE("AWP No", AnnualStrategyWorkplan.No);
        IF BoardActivities.FINDSET THEN BEGIN
            REPEAT
                BoardActivities1.INIT;
                BoardActivities1."AWP No" := AnnualStrategyWorkplan."Annual Workplan";
                BoardActivities1."Board Activity Code" := BoardActivities."Board Activity Code";
                BoardActivities1."Activity Code" := BoardActivities."Activity Code";
                BoardActivities1."Board Activity Description" := BoardActivities."Board Activity Description";
                BoardActivities1."Activity Description" := BoardActivities."Activity Description";
                BoardActivities1."Unit of Measure" := BoardActivities."Unit of Measure";
                BoardActivities1."WT(%)" := BoardActivities."WT(%)";
                BoardActivities1.Target := BoardActivities.Target;
                BoardActivities1."Framework Perspective" := BoardActivities."Framework Perspective";
                BoardActivities1."Strategy Framework" := BoardActivities."Strategy Framework";
                BoardActivities1."Achieved Targets" := BoardActivities."Achieved Targets";
                //BoardActivities1."Outcome Performance Indicator":=BoardActivities."Outcome Performance Indicator";
                //BoardActivities1."Previous Annual Target Qty":=BoardActivities."Previous Annual Target Qty";
                IF BoardActivities1.INSERT = TRUE THEN BEGIN
                    //Insert Board sub-Activities
                    BoardSubActivities.RESET;
                    BoardSubActivities.SETRANGE("Workplan No.", AnnualStrategyWorkplan.No);
                    BoardSubActivities.SETRANGE("Initiative No.", BoardActivities."Board Activity Code");
                    BoardSubActivities.SETRANGE("Activity Id", BoardActivities."Activity Code");
                    IF BoardSubActivities.FINDSET THEN BEGIN
                        REPEAT
                            BoardSubActivities1.INIT;
                            BoardSubActivities1."Workplan No." := AnnualStrategyWorkplan."Annual Workplan";
                            BoardSubActivities1."Initiative No." := BoardSubActivities."Initiative No.";
                            BoardSubActivities1."Activity Id" := BoardSubActivities."Activity Id";
                            BoardSubActivities1."Entry Number" := BoardSubActivities."Entry Number";
                            BoardSubActivities1."Objective/Initiative" := BoardSubActivities."Objective/Initiative";
                            BoardSubActivities1."Initiative Type" := BoardSubActivities."Initiative Type";
                            BoardSubActivities1."Task Type" := BoardSubActivities."Task Type";
                            BoardSubActivities1.Indentation := BoardSubActivities.Indentation;
                            BoardSubActivities1."Strategy Plan ID" := BoardSubActivities."Strategy Plan ID";
                            BoardSubActivities1."Year Reporting Code" := BoardSubActivities."Year Reporting Code";
                            BoardSubActivities1."Start Date" := BoardSubActivities."Start Date";
                            BoardSubActivities1."Due Date" := BoardSubActivities."Due Date";
                            // BoardSubActivities1."Primary Department" := BoardSubActivities."Primary Department";
                            BoardSubActivities1."Primary Department" := BoardSubActivities."Primary Department";
                            BoardSubActivities1."Outcome Perfomance Indicator" := BoardSubActivities."Outcome Perfomance Indicator";
                            BoardSubActivities1."Q1 Target Qty" := BoardSubActivities."Q1 Target Qty";
                            BoardSubActivities1."Q2 Target Qty" := BoardSubActivities."Q2 Target Qty";
                            BoardSubActivities1."Q3 Target Qty" := BoardSubActivities."Q3 Target Qty";
                            BoardSubActivities1."Q4 Target Qty" := BoardSubActivities."Q4 Target Qty";
                            BoardSubActivities1."Sub Initiative No." := BoardSubActivities."Sub Initiative No.";
                            BoardSubActivities1."Sub Targets" := BoardSubActivities."Sub Targets";
                        UNTIL BoardSubActivities.NEXT = 0;
                    END;
                END;
            UNTIL BoardActivities.NEXT = 0;
        END;

        AnnualStrategyWorkplan.Posted := TRUE;
        AnnualStrategyWorkplan.MODIFY;
        MESSAGE('Workplan Consolidated Successfully!');
    end;
    ///
    procedure FnSuggestObjectives(PerfomanceEvaluation: Record "Performance Evaluation")
    begin
        PCObjective.Reset;
        PCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
        PCObjective.SetRange("Due Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
        if PCObjective.FindFirst then begin
            repeat

                ObjectiveOutcome.Init;
                ObjectiveOutcome."Performance Evaluation ID" := PerfomanceEvaluation.No;
                ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                ObjectiveOutcome."Scorecard ID" := PCObjective."Workplan No.";
                ObjectiveOutcome."Intiative No" := PCObjective."Initiative No.";
                ObjectiveOutcome."Objective/Initiative" := PCObjective."Objective/Initiative";
                ObjectiveOutcome."Primary Department" := PerfomanceEvaluation.Department;
                // // ObjectiveOutcome."Primary Division" := PerfomanceEvaluation.Division;
                ObjectiveOutcome."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                //ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                ObjectiveOutcome."Target Qty" := PCObjective."Imported Annual Target Qty";
                ObjectiveOutcome."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                ObjectiveOutcome.Insert(true);

            until PCObjective.Next = 0;

        end;
    end;

    local procedure FnGetLastLineNo() LineNumber: Integer
    var
        Billable: Record "Objective Evaluation Result";
    begin
        Billable.Reset;
        if Billable.Find('+') then
            LineNumber := Billable."Line No"
        else
            LineNumber := 1;
        exit(LineNumber);
    end;

    local procedure FnGetLastLineNoB() LineNumber: Integer
    var
        ProEvalution: Record "Proficiency Evaluation Result";
    begin
        ProEvalution.Reset;
        if ProEvalution.Find('+') then
            LineNumber := ProEvalution."Line No"
        else
            LineNumber := 1;
        exit(LineNumber);
    end;


    procedure FnSuggestEvaluations(PerfomanceEvaluation: Record "Performance Evaluation")
    begin
        CompetencyLines.Reset;
        CompetencyLines.SetRange("Competency Template ID", PerfomanceEvaluation."Competency Template ID");
        if CompetencyLines.Find('-') then begin
            repeat

                ProEvaluation.Init;
                ProEvaluation."Performance Evaluation ID" := PerfomanceEvaluation.No;
                ProEvaluation."Line No" := FnGetLastLineNoB + 1;
                ProEvaluation."Competency Template ID" := PerfomanceEvaluation."Competency Template ID";
                ProEvaluation."Competency Code" := CompetencyLines."Competency Code";
                ProEvaluation."Competency Category" := CompetencyLines."Competency Category";
                ProEvaluation.Description := CompetencyLines.Description;
                ProEvaluation."Profiency Rating Scale" := PerfomanceEvaluation."Proficiency Rating Scale";
                ProEvaluation."Target Qty" := CompetencyLines."Weight %";
                ProEvaluation."Weight %" := CompetencyLines."Weight %";
                ProEvaluation.Insert(true);
            until CompetencyLines.Next = 0;
        end;
    end;


    procedure FnUpdateOrganizationalPC(AnnualStrategyWorkplan: Record "Annual Strategy Workplan")
    var
        PlogLines: Record "Plog Lines";
        PCObjective: Record "PC Objective";
        SecondaryPCObjective: Record "Secondary PC Objective";
        SubPlogLines: Record "Sub Plog Lines";
        SubPCObjective: Record "Sub PC Objective";
        PCJobDescription: Record "PC Job Description";
        SubJDObjective: Record "Sub JD Objective";
        StrategyWorkplanLines: record "Strategy Workplan Lines";
        StrategyWorkplanLines1: record "Strategy Workplan Lines";
        BoardActivities: Record "Board Activities";
        BoardActivities1: Record "Board Activities";
        BoardSubActivities: Record "Board Sub Activities";
        BoardSubActivities1: Record "Board Sub Activities";
        SubWorkplanActivity: Record "Sub Workplan Activity";
        SubWorkplanActivity1: Record "Sub Workplan Activity";
        WorkplanCostElements: Record "Workplan Cost Elements";
        WorkplanCostElements1: Record "Workplan Cost Elements";
    //  AnnualStrategyWorkplan: Record "Annual Strategy Workplan";

    begin
        //  AnnualStRategyWorkplan.TestField("Organiztional PC");

        // AnnualStrategyWorkplan.TESTFIELD("Annual Workplan");
        // AnnualStrategyWorkplan.TESTFIELD(Posted, FALSE);
        // AnnualStrategyWorkplan.CALCFIELDS("Total Assigned Weight(%)");
        // IF AnnualStrategyWorkplan."Total Assigned Weight(%)"<>100 THEN
        //   ERROR('Assigned Weight should be equals to 100%');
        // 
        // IF NOT CONFIRM('Are you sure you want to update the Selected Annual Workplan?', TRUE) THEN BEGIN
        //  ERROR('Annual Workplan not Updated');
        //  END;
        //Insert Strategy Workplan Lines
        // StrategyWorkplanLines.RESET;
        // StrategyWorkplanLines.SETRANGE(No, AnnualStrategyWorkplan.No);
        // IF StrategyWorkplanLines.FINDSET THEN BEGIN
        //  REPEAT
        //    StrategyWorkplanLines.TESTFIELD("Primary Directorate");
        //    StrategyWorkplanLines.TESTFIELD("Primary Department");
        // 
        //    StrategyWorkplanLines1.INIT;
        //    StrategyWorkplanLines1.No:=AnnualStrategyWorkplan."Annual Workplan";
        //    StrategyWorkplanLines1."Strategy Plan ID":=StrategyWorkplanLines."Strategy Plan ID";
        //    StrategyWorkplanLines1."Activity ID":=StrategyWorkplanLines."Activity ID";
        //    StrategyWorkplanLines1.Description:=StrategyWorkplanLines.Description;
        //    StrategyWorkplanLines1."Cross Cutting":=StrategyWorkplanLines."Cross Cutting";
        //    StrategyWorkplanLines1."Imported Annual Target Qty":=StrategyWorkplanLines."Imported Annual Target Qty";
        //    StrategyWorkplanLines1."Imported Annual Budget Est.":=StrategyWorkplanLines."Imported Annual Budget Est.";
        //    StrategyWorkplanLines1."Primary Department":=StrategyWorkplanLines."Primary Department";
        //    StrategyWorkplanLines1."Primary Department Name":=StrategyWorkplanLines."Primary Department Name";
        //    StrategyWorkplanLines1."Primary Directorate":=StrategyWorkplanLines."Primary Directorate";
        //    StrategyWorkplanLines1."Primary Directorate Name":=StrategyWorkplanLines."Primary Directorate Name";
        //    StrategyWorkplanLines1."Q1 Target":=StrategyWorkplanLines."Q1 Target";
        //    StrategyWorkplanLines1."Q1 Budget":=StrategyWorkplanLines."Q1 Budget";
        //    StrategyWorkplanLines1."Q2 Target":=StrategyWorkplanLines."Q2 Target";
        //    StrategyWorkplanLines1."Q2 Budget":=StrategyWorkplanLines."Q2 Budget";
        //    StrategyWorkplanLines1."Q3 Target":=StrategyWorkplanLines."Q3 Target";
        //    StrategyWorkplanLines1."Q3 Budget":=StrategyWorkplanLines."Q3 Budget";
        //    StrategyWorkplanLines1."Q4 Target":=StrategyWorkplanLines."Q4 Target";
        //    StrategyWorkplanLines1."Q4 Budget":=StrategyWorkplanLines."Q4 Budget";
        //    StrategyWorkplanLines1."Entry Type":=StrategyWorkplanLines."Entry Type";
        //    StrategyWorkplanLines1."Year Reporting Code":=StrategyWorkplanLines."Year Reporting Code";
        //    StrategyWorkplanLines1."Perfomance Indicator":=FORMAT(StrategyWorkplanLines."Perfomance Indicator");
        //    StrategyWorkplanLines1."Source Of Fund":=StrategyWorkplanLines."Source Of Fund";
        //    StrategyWorkplanLines1."Unit of Measure":=StrategyWorkplanLines."Unit of Measure";
        //    StrategyWorkplanLines1."Desired Perfomance Direction":=StrategyWorkplanLines."Desired Perfomance Direction";
        //    StrategyWorkplanLines1."Strategy Framework":=StrategyWorkplanLines."Strategy Framework";
        //    StrategyWorkplanLines1."Framework Perspective":=StrategyWorkplanLines."Framework Perspective";
        //    StrategyWorkplanLines1."Key Performance Indicator":=StrategyWorkplanLines."Key Performance Indicator";
        //    StrategyWorkplanLines1."Assigned Weight(%)":=StrategyWorkplanLines."Assigned Weight(%)";
        //    StrategyWorkplanLines1."Annual Budget":=StrategyWorkplanLines."Annual Budget";
        //    StrategyWorkplanLines1."Annual Target":=StrategyWorkplanLines."Annual Target";
        //    StrategyWorkplanLines1."Total Subactivity budget":=StrategyWorkplanLines."Total Subactivity budget";
        //    StrategyWorkplanLines1."Departmental Activity Weight":=StrategyWorkplanLines."Departmental Activity Weight";
        //    StrategyWorkplanLines1.INSERT(TRUE);
        // 
        //        //Insert Annual Workplan Sub-Activities
        //  SubWorkplanActivity.RESET;
        //  SubWorkplanActivity.SETRANGE("Workplan No.", AnnualStrategyWorkplan.No);
        //  SubWorkplanActivity.SETRANGE("Activity Id",StrategyWorkplanLines."Activity ID");
        //  IF SubWorkplanActivity.FINDSET THEN BEGIN
        //    REPEAT
        //     // ERROR('Testing');
        //      SubWorkplanActivity1.INIT;
        //      SubWorkplanActivity1."Workplan No.":=AnnualStrategyWorkplan."Annual Workplan";
        //      SubWorkplanActivity1."Initiative No.":=SubWorkplanActivity."Initiative No.";
        //      SubWorkplanActivity1."Activity Id":=SubWorkplanActivity."Activity Id";
        //      SubWorkplanActivity1."Objective/Initiative":=SubWorkplanActivity."Objective/Initiative";
        //      SubWorkplanActivity1."Sub Initiative No.":=SubWorkplanActivity."Sub Initiative No.";
        //      SubWorkplanActivity1."Unit of Measure":=SubWorkplanActivity."Unit of Measure";
        //      SubWorkplanActivity1."Imported Annual Target Qty":=SubWorkplanActivity."Imported Annual Target Qty";
        //      SubWorkplanActivity1.Weight:=SubWorkplanActivity.Weight;
        //      SubWorkplanActivity1."Total Budget":=SubWorkplanActivity."Total Budget";
        //      SubWorkplanActivity1."Due Date":=SubWorkplanActivity."Due Date";
        //      SubWorkplanActivity1."Strategy Plan ID":=SubWorkplanActivity."Strategy Plan ID";
        //      IF SubWorkplanActivity1.INSERT=TRUE THEN BEGIN
        //       //work plan cost elements
        //       WorkplanCostElements.RESET;
        //       WorkplanCostElements.SETRANGE("Workplan No.",AnnualStrategyWorkplan.No);
        //       WorkplanCostElements.SETRANGE("Activity Id",SubWorkplanActivity."Activity Id");
        //       WorkplanCostElements.SETRANGE("Sub Activity No",SubWorkplanActivity."Sub Initiative No.");
        //       IF WorkplanCostElements.FINDSET THEN BEGIN
        //         REPEAT
        //           // WorkplanCostElements.TESTFIELD("Plan Item No");
        //            {WorkplanCostElements.TESTFIELD("Unit Cost");
        //            WorkplanCostElements.TESTFIELD(Quantity);
        //            WorkplanCostElements.TESTFIELD(Amount);}// to be uncommented in future
        // 
        //            WorkplanCostElement1.INIT;
        //            WorkplanCostElement1."Workplan No.":=AnnualStrategyWorkplan."Annual Workplan";
        //            WorkplanCostElement1."Activity Id":= WorkplanCostElements."Activity Id";
        //            WorkplanCostElement1."Sub Activity No":= WorkplanCostElements."Sub Activity No";
        //            WorkplanCostElement1."Initiative No.":= WorkplanCostElements."Initiative No.";
        //            WorkplanCostElement1.TRANSFERFIELDS( WorkplanCostElements,FALSE);
        //            WorkplanCostElement1."Functional Procurment Plan No":=AnnualStrategyWorkplan."Functional Procurment Plan No";
        //            WorkplanCostElement1.INSERT;
        //         UNTIL WorkplanCostElements.NEXT=0;
        //         END;
        //        END;
        //      UNTIL SubWorkplanActivity.NEXT=0;
        //    END;
        //    UNTIL StrategyWorkplanLines.NEXT=0;
        //  END;

        IF NOT CONFIRM('Are you sure you want to update the Selected Annual Workplan?', TRUE) THEN BEGIN
            ERROR('Annual Workplan not Updated');
        end;
        //Insert Board Activities
        BoardActivities.RESET;
        BoardActivities.SETRANGE("AWP No", AnnualStrategyWorkplan.No);
        //  Message('%1', AnnualStrategyWorkplan.No);
        IF BoardActivities.FINDSET THEN BEGIN
            REPEAT
                BoardActivities1.INIT;
                BoardActivities1."AWP No" := AnnualStrategyWorkplan."Organiztional PC";
                // BoardActivities1."Primary Directorate" := AnnualStrategyWorkplan."Primary Directorate";
                // BoardActivities1."Primary Department" := AnnualStrategyWorkplan.Department;
                BoardActivities1."Primary Department" := AnnualStrategyWorkplan."Primary Department";
                // BoardActivities1."Primary Division" := AnnualStrategyWorkplan."Primary Division";
                BoardActivities1."Board Activity Code" := BoardActivities."Board Activity Code";
                BoardActivities1."Activity Code" := BoardActivities."Activity Code";
                BoardActivities1."Board Activity Description" := BoardActivities."Board Activity Description";
                BoardActivities1."Activity Description" := BoardActivities."Activity Description";
                BoardActivities1."Unit of Measure" := BoardActivities."Unit of Measure";
                BoardActivities1."WT(%)" := BoardActivities."WT(%)";
                BoardActivities1.Target := BoardActivities.Target;
                BoardActivities1."Framework Perspective" := BoardActivities."Framework Perspective";
                BoardActivities1."Strategy Framework" := BoardActivities."Strategy Framework";
                //cc// BoardActivities1."Achieved Target" := BoardActivities."Achieved Target";
                //BoardActivities1."Outcome Performance Indicator":=BoardActivities."Outcome Performance Indicator";
                //BoardActivities1."Previous Annual Target Qty":=BoardActivities."Previous Annual Target Qty";
                IF BoardActivities1.INSERT = TRUE THEN BEGIN
                    //Insert Board sub-Activities
                    MESSAGE('Test Sub One');
                    BoardSubActivities.RESET;
                    BoardSubActivities.SETRANGE("Workplan No.", AnnualStrategyWorkplan.No);
                    BoardSubActivities.SETRANGE("Initiative No.", BoardActivities."Board Activity Code");
                    BoardSubActivities.SETRANGE("Activity Id", BoardActivities."Activity Code");
                    IF BoardSubActivities.FINDSET THEN BEGIN
                        REPEAT
                            MESSAGE('Test Sub Two');
                            BoardSubActivities1.INIT;
                            BoardSubActivities1."Workplan No." := AnnualStrategyWorkplan."Organiztional PC";
                            BoardSubActivities1."Initiative No." := BoardSubActivities."Initiative No.";
                            BoardSubActivities1."Activity Id" := BoardSubActivities."Activity Id";
                            BoardSubActivities1."Entry Number" := BoardSubActivities."Entry Number";
                            BoardSubActivities1."Sub Initiative No." := BoardSubActivities."Sub Initiative No.";
                            IF BoardSubActivities1."Objective/Initiative" <> BoardSubActivities."Objective/Initiative" THEN BEGIN
                                BoardSubActivities1."Objective/Initiative" := BoardSubActivities."Objective/Initiative";
                            END;
                            BoardSubActivities1."Initiative Type" := BoardSubActivities."Initiative Type";
                            BoardSubActivities1."Task Type" := BoardSubActivities."Task Type";
                            BoardSubActivities1.Indentation := BoardSubActivities.Indentation;
                            BoardSubActivities1."Strategy Plan ID" := BoardSubActivities."Strategy Plan ID";
                            BoardSubActivities1."Year Reporting Code" := BoardSubActivities."Year Reporting Code";
                            BoardSubActivities1."Start Date" := BoardSubActivities."Start Date";
                            BoardSubActivities1."Due Date" := BoardSubActivities."Due Date";
                            BoardSubActivities1."Unit of Measure" := BoardSubActivities."Unit of Measure";
                            BoardSubActivities1."Imported Annual Target Qty" := BoardSubActivities."Imported Annual Target Qty";
                            // BoardSubActivities1."Primary Division" := BoardSubActivities."Primary Division";
                            BoardSubActivities1."Primary Department" := BoardSubActivities."Primary Department";
                            BoardSubActivities1."Outcome Perfomance Indicator" := BoardSubActivities."Outcome Perfomance Indicator";
                            BoardSubActivities1."Q1 Target Qty" := BoardSubActivities."Q1 Target Qty";
                            BoardSubActivities1."Q2 Target Qty" := BoardSubActivities."Q2 Target Qty";
                            BoardSubActivities1."Q3 Target Qty" := BoardSubActivities."Q3 Target Qty";
                            BoardSubActivities1."Q4 Target Qty" := BoardSubActivities."Q4 Target Qty";
                            BoardSubActivities1."Sub Targets" := BoardSubActivities."Sub Targets";
                            BoardSubActivities1.INSERT;
                        UNTIL BoardSubActivities.NEXT = 0;
                    END;
                END;
            UNTIL BoardActivities.NEXT = 0;
        END;

        AnnualStrategyWorkplan.Posted := TRUE;
        AnnualStrategyWorkplan.MODIFY;
        MESSAGE('Annual Workplan Updated Successfully!');
    end;

    procedure fnGetStaffPerformanceContractHeader(IndividualPCNo: Code[30]) data: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset();
        PerfomanceContractHeader.SetRange(No, IndividualPCNo);
        PerfomanceContractHeader.SetRange("Score Card Type", PerfomanceContractHeader."score card type"::Staff);
        //PerfomanceContractHeader.SetRange("Document Type", PerfomanceContractHeader."document type"::"Individual Scorecard");

        if PerfomanceContractHeader.FindFirst() then begin
            data := PerfomanceContractHeader.No + '*' +
                    PerfomanceContractHeader.Description + '*' +
                    //PerfomanceContractHeader."Department Plan ID" + '*' +
                    PerfomanceContractHeader."Strategy Plan ID" + '*' +
                    PerfomanceContractHeader."Annual Reporting Code" + '*' +
                    Format(PerfomanceContractHeader."Start Date") + '*' +
                    Format(PerfomanceContractHeader."End Date") + '*' +
                    Format(PerfomanceContractHeader."Approval Status") + '*' +
                    PerfomanceContractHeader."Responsible Employee No." + '*' +
                    PerfomanceContractHeader.Department + '*' +
                    PerfomanceContractHeader."Department Name";
        end else begin
            data := 'error*Performance Contract not found';
        end;
    end;

    procedure fnNewStaffPerformanceContract(contractNo: Code[100]; employeeNo: Code[100]; description: Text; cspNo: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        tbl_AnnualStrategyWorkplan: Record "Annual Strategy Workplan";
    begin
        // Get CSP/Functional Workplan details
        tbl_AnnualStrategyWorkplan.Reset();
        tbl_AnnualStrategyWorkplan.SetRange(No, cspNo);
        if not tbl_AnnualStrategyWorkplan.FindFirst() then begin
            status := 'danger*CSP not found. Please select a valid CSP!';
            exit;
        end;

        // Check if updating existing contract
        PerfomanceContractHeader.Reset();
        PerfomanceContractHeader.SetRange("Responsible Employee No.", employeeNo);
        PerfomanceContractHeader.SetRange(No, contractNo);
        PerfomanceContractHeader.SetRange("Approval Status", PerfomanceContractHeader."approval status"::Open);
        PerfomanceContractHeader.SetRange("Score Card Type", PerfomanceContractHeader."score card type"::Staff);
        //PerfomanceContractHeader.SetRange("Document Type", PerfomanceContractHeader."document type"::"Individual Scorecard");

        if PerfomanceContractHeader.FindSet() then begin
            // Update existing contract
            PerfomanceContractHeader.Description := description;
            //PerfomanceContractHeader."Department Plan ID" := cspNo;
            PerfomanceContractHeader."Strategy Plan ID" := tbl_AnnualStrategyWorkplan."Strategy Plan ID";
            PerfomanceContractHeader."Annual Reporting Code" := tbl_AnnualStrategyWorkplan."Year Reporting Code";
            PerfomanceContractHeader."Start Date" := tbl_AnnualStrategyWorkplan."Start Date";
            PerfomanceContractHeader."End Date" := tbl_AnnualStrategyWorkplan."End Date";
            PerfomanceContractHeader."Functional WorkPlan" := cspNo;
            PerfomanceContractHeader.Department := tbl_AnnualStrategyWorkplan.Department;
            PerfomanceContractHeader."Department Name" := tbl_AnnualStrategyWorkplan."Department Name";

            if PerfomanceContractHeader.Modify(true) then begin
                status := 'success*Your staff performance contract was successfully updated*' +
                         PerfomanceContractHeader.No + '*' +
                         PerfomanceContractHeader."Strategy Plan ID" + '*' +
                         cspNo + '*' +
                         PerfomanceContractHeader."Annual Reporting Code";
            end else begin
                status := 'danger*Your staff performance contract was not updated, kindly try again!';
            end;
        end else begin
            // Create new contract
            PerfomanceContractHeader.Init();
            //PerfomanceContractHeader."Document Type" := PerfomanceContractHeader."document type"::"Individual Scorecard";
            PerfomanceContractHeader."Evaluation Type" := PerfomanceContractHeader."evaluation type"::"Standard Appraisal/Supervisor Score Only";
            PerfomanceContractHeader."Score Card Type" := PerfomanceContractHeader."score card type"::Staff;
            PerfomanceContractHeader."Responsible Employee No." := employeeNo;
            PerfomanceContractHeader.Validate("Responsible Employee No.");
            PerfomanceContractHeader.Description := description;
            // PerfomanceContractHeader."Department Plan ID" := cspNo;
            PerfomanceContractHeader."Strategy Plan ID" := tbl_AnnualStrategyWorkplan."Strategy Plan ID";
            PerfomanceContractHeader."Annual Reporting Code" := tbl_AnnualStrategyWorkplan."Year Reporting Code";
            PerfomanceContractHeader."Start Date" := tbl_AnnualStrategyWorkplan."Start Date";
            PerfomanceContractHeader."End Date" := tbl_AnnualStrategyWorkplan."End Date";
            PerfomanceContractHeader."Functional WorkPlan" := cspNo;
            PerfomanceContractHeader.Department := tbl_AnnualStrategyWorkplan.Department;
            PerfomanceContractHeader."Department Name" := tbl_AnnualStrategyWorkplan."Department Name";

            if PerfomanceContractHeader.Insert(true) then begin
                FnSuggestJD(PerfomanceContractHeader.No);
                status := 'success*Your staff performance contract was successfully created*' +
                         PerfomanceContractHeader.No + '*' +
                         PerfomanceContractHeader."Strategy Plan ID" + '*' +
                         cspNo + '*' +
                         PerfomanceContractHeader."Annual Reporting Code";
            end else begin
                status := 'danger*Your staff performance contract was not created, kindly try again!';
            end;
        end;
    end;

    procedure FnSuggestJD(workplan: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        SpmGeneralSetup: Record "SPM General Setup";
        JobResponsibilities: Record "Positions Responsibility";
        PCJobDescription: Record "PC Job Description";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, workplan);
        if PerfomanceContractHeader.FindSet then begin
            JobResponsibilities.Reset;
            JobResponsibilities.SetRange("Position ID", PerfomanceContractHeader.Position);
            if JobResponsibilities.Find('-') then begin
                repeat
                    PCJobDescription.Init;
                    PCJobDescription."Workplan No." := PerfomanceContractHeader.No;
                    PCJobDescription."Line Number" := Format(JobResponsibilities."Line No");
                    PCJobDescription.Validate("Line Number");
                    PCJobDescription.Description := JobResponsibilities.Description;
                    PCJobDescription."Primary Department" := PerfomanceContractHeader."Responsibility Center";
                    PCJobDescription.Validate("Primary Department");
                    PCJobDescription."Start Date" := PerfomanceContractHeader."Start Date";
                    PCJobDescription."Due Date" := PerfomanceContractHeader."End Date";
                    PCJobDescription.Insert(true);
                until JobResponsibilities.Next = 0;
            end;
        end;
    end;

    procedure fnGetApprovedFunctionalWorkplans(employeeNumber: Code[30]) data: Text
    var
        tbl_AnnualStrategyWorkplan: Record "Annual Strategy Workplan";
    begin
        tbl_AnnualStrategyWorkplan.Reset();
        tbl_AnnualStrategyWorkplan.SetRange("Annual Strategy Type", tbl_AnnualStrategyWorkplan."Annual Strategy Type"::Functional);
        tbl_AnnualStrategyWorkplan.SetRange("Approval Status", tbl_AnnualStrategyWorkplan."Approval Status"::Released);
        tbl_AnnualStrategyWorkplan.SetRange(Archived, false);

        if tbl_AnnualStrategyWorkplan.FindSet(true) then begin
            repeat
                data := data +
                        tbl_AnnualStrategyWorkplan.No + '*' +
                        tbl_AnnualStrategyWorkplan.Description + '*' +
                        tbl_AnnualStrategyWorkplan."Strategy Plan ID" + '*' +
                        tbl_AnnualStrategyWorkplan."Year Reporting Code" + '*' +
                        Format(tbl_AnnualStrategyWorkplan."Start Date") + '*' +
                        Format(tbl_AnnualStrategyWorkplan."End Date") + '*' +
                        tbl_AnnualStrategyWorkplan.Department + '*' +
                        tbl_AnnualStrategyWorkplan."Department Name" + '::::';
            until tbl_AnnualStrategyWorkplan.Next = 0;
            EXIT(data);
        end;
    end;

    procedure fnGetApprovedDepartmentalWorkplans(employeeNumber: Code[30]) data: Text
    var
        PerfContractHeader: Record "Perfomance Contract Header";
    begin
        PerfContractHeader.Reset();
        PerfContractHeader.SetRange("Score Card Type", PerfContractHeader."score card type"::Departmental);
        PerfContractHeader.SetRange("Approval Status", PerfContractHeader."approval status"::Released);
        PerfContractHeader.SetRange("Document Type", PerfContractHeader."Document Type"::"Staff Performance Contract");
        if PerfContractHeader.FindSet() then begin
            repeat
                data := data +
                        PerfContractHeader.No + '*' +
                        PerfContractHeader.Description + '*' +
                        PerfContractHeader."Strategy Plan ID" + '*' +
                        PerfContractHeader."Annual Reporting Code" + '*' +
                        Format(PerfContractHeader."Start Date") + '*' +
                        Format(PerfContractHeader."End Date") + '*' +
                        PerfContractHeader."Responsibility Center" + '*' +
                        PerfContractHeader."Responsibility Center Name" + '::::';
            until PerfContractHeader.Next() = 0;
            EXIT(data);
        end;
    end;

    // procedure fnSuggestActivityLines(IndividualPCNo: Code[30]; cspNo: Code[30]) result: Text
    // var
    //     StrategicIntPlanningLines: Record "Strategy Workplan Lines";
    //     WPLines: Record "PC Objective";
    //     linesAdded: Integer;
    // begin
    //     // Validate inputs
    //     if IndividualPCNo = '' then
    //         exit('error*Performance Contract Number is required');

    //     if cspNo = '' then
    //         exit('error*CSP Number is required');

    //     // Delete existing lines for this workplan
    //     WPLines.SetRange("Workplan No.", IndividualPCNo);
    //     if WPLines.FindSet() then
    //         WPLines.DeleteAll();

    //     // Get Strategy Workplan Lines for the selected CSP
    //     StrategicIntPlanningLines.Reset();
    //     StrategicIntPlanningLines.SetRange(No, cspNo);

    //     if StrategicIntPlanningLines.FindSet() then begin
    //         linesAdded := 0;
    //         repeat
    //             WPLines.Init();
    //             WPLines."Workplan No." := IndividualPCNo;
    //             //WPLines."Department Plan ID" := StrategicIntPlanningLines.No;
    //             WPLines."Initiative No." := StrategicIntPlanningLines."Activity ID";
    //             //WPLines."Activity Description" := StrategicIntPlanningLines.Description;
    //             WPLines."Key Performance Indicator" := StrategicIntPlanningLines."Perfomance Indicator";
    //             //WPLines.Outcome := StrategicIntPlanningLines.Outcome;
    //             WPLines."Imported Annual Target Qty" := StrategicIntPlanningLines."Q1 Target";
    //             WPLines."Year Reporting Code" := StrategicIntPlanningLines."Year Reporting Code";
    //             WPLines."Assigned Weight (%)" := StrategicIntPlanningLines."Departmental Activity Weight";
    //             WPLines.Insert(true);
    //             linesAdded += 1;
    //         until StrategicIntPlanningLines.Next() = 0;

    //         result := 'success*Core Initiatives Populated Successfully*' + Format(linesAdded) + ' activities added';
    //     end else begin
    //         result := 'error*No activities found for CSP: ' + cspNo;
    //     end;
    // end;
    procedure fnAddNewAdditionalInitiative(
    workplanNo: Code[30];
    primaryDepartment: Code[100];
    objectiveDescription: Text[255];
    outcomeIndicator: Code[100];
    startDate: Date;
    dueDate: Date;
    agreedTarget: Decimal;
    assignedWeight: Decimal;
    comments: Text[250]
) result: Text
    var
        SecondaryPCObjective: Record "Secondary PC Objective";
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        PerformanceIndicator: Record "Performance Indicator";
    begin
        PerfomanceContractHeader.Reset();
        PerfomanceContractHeader.SetRange(No, workplanNo);
        if not PerfomanceContractHeader.FindFirst() then begin
            result := 'error*Performance contract not found: ' + workplanNo;
            exit;
        end;

        SecondaryPCObjective.Init();
        SecondaryPCObjective."Workplan No." := workplanNo;
        SecondaryPCObjective."Objective/Initiative" := objectiveDescription;
        SecondaryPCObjective."Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
        SecondaryPCObjective."Year Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
        SecondaryPCObjective."Primary Department" := primaryDepartment;
        SecondaryPCObjective."Outcome Perfomance Indicator" := outcomeIndicator;
        SecondaryPCObjective."Start Date" := startDate;
        SecondaryPCObjective."Due Date" := dueDate;
        SecondaryPCObjective."Imported Annual Target Qty" := agreedTarget;
        SecondaryPCObjective."Assigned Weight (%)" := assignedWeight;
        SecondaryPCObjective.Comments := comments;

        // Auto-fill UoM from KPI
        if PerformanceIndicator.Get(outcomeIndicator) then
            SecondaryPCObjective."Unit of Measure" := PerformanceIndicator."Unit of Measure";

        if SecondaryPCObjective.Insert(true) then
            result := 'success*Additional initiative added*' +
                      Format(SecondaryPCObjective.EntryNo) + '*' +
                      SecondaryPCObjective."Unit of Measure" + '*' +
                      PerfomanceContractHeader."Strategy Plan ID"
        else
            result := 'error*Failed to insert additional initiative';
    end;

    procedure fnSuggestActivityLines(IndividualPCNo: Code[30]; cspNo: Code[30]) result: Text
    var
        ParentPCObjective: Record "PC Objective";
        WPLines: Record "PC Objective";
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        SubPCObjective: Record "Sub PC Objective";
        NewSubPCObjective: Record "Sub PC Objective";
        linesAdded: Integer;
    begin
        if IndividualPCNo = '' then
            exit('error*Performance Contract Number is required');
        if cspNo = '' then
            exit('error*CSP Number is required');

        // Get the staff PC header to know department, dates, strategy plan
        PerfomanceContractHeader.Reset();
        PerfomanceContractHeader.SetRange(No, IndividualPCNo);
        if not PerfomanceContractHeader.FindFirst() then
            exit('error*Performance Contract not found: ' + IndividualPCNo);

        // Delete existing lines
        WPLines.Reset();
        WPLines.SetRange("Workplan No.", IndividualPCNo);
        if WPLines.FindSet() then
            WPLines.DeleteAll();

        // Pull from parent departmental PC's PC Objective lines
        // filtered by department to match page cascade logic
        ParentPCObjective.Reset();
        //ParentPCObjective.SetRange("Strategy Plan ID", PerfomanceContractHeader."Strategy Plan ID");
        ParentPCObjective.SetRange("Workplan No.", cspNo);  // cspNo = Departmental PC No e.g. "0009"
        //ParentPCObjective.SetRange("Primary Department", PerfomanceContractHeader.Department);
        if ParentPCObjective.FindSet() then begin
            linesAdded := 0;
            repeat
                WPLines.Init();
                WPLines."Workplan No." := IndividualPCNo;
                WPLines."Strategy Plan ID" := ParentPCObjective."Strategy Plan ID";
                WPLines."Initiative Type" := ParentPCObjective."Initiative Type";
                WPLines."Initiative No." := ParentPCObjective."Initiative No.";
                WPLines."Objective/Initiative" := ParentPCObjective."Objective/Initiative";
                WPLines."Year Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
                WPLines."Primary Department" := ParentPCObjective."Primary Department";
                WPLines."Primary Department Name" := ParentPCObjective."Primary Department Name";
                WPLines."Outcome Perfomance Indicator" := ParentPCObjective."Outcome Perfomance Indicator";
                WPLines."Key Performance Indicator" := ParentPCObjective."Key Performance Indicator";
                WPLines."Unit of Measure" := ParentPCObjective."Unit of Measure";
                WPLines."Start Date" := PerfomanceContractHeader."Start Date";
                WPLines."Due Date" := PerfomanceContractHeader."End Date";
                WPLines."Imported Annual Target Qty" := ParentPCObjective."Imported Annual Target Qty";
                WPLines."Assigned Weight (%)" := ParentPCObjective."Assigned Weight (%)";
                WPLines."Q1 Target Qty" := ParentPCObjective."Q1 Target Qty";
                WPLines."Q2 Target Qty" := ParentPCObjective."Q2 Target Qty";
                WPLines."Q3 Target Qty" := ParentPCObjective."Q3 Target Qty";
                WPLines."Q4 Target Qty" := ParentPCObjective."Q4 Target Qty";
                WPLines."Desired Perfomance Direction" := ParentPCObjective."Desired Perfomance Direction";
                WPLines.Insert(true);
                linesAdded += 1;

                // Cascade sub-activities from parent PC
                SubPCObjective.Reset();
                SubPCObjective.SetRange("Strategy Plan ID", PerfomanceContractHeader."Strategy Plan ID");
                SubPCObjective.SetRange("Workplan No.", cspNo);
                SubPCObjective.SetRange("Initiative No.", ParentPCObjective."Initiative No.");
                if SubPCObjective.FindSet() then begin
                    repeat
                        NewSubPCObjective.Init();
                        NewSubPCObjective.TransferFields(SubPCObjective, false);
                        NewSubPCObjective."Workplan No." := IndividualPCNo;
                        NewSubPCObjective."Strategy Plan ID" := SubPCObjective."Strategy Plan ID";
                        NewSubPCObjective."Initiative No." := SubPCObjective."Initiative No.";
                        NewSubPCObjective."Sub Initiative No." := SubPCObjective."Sub Initiative No.";
                        NewSubPCObjective.Insert(true);
                    until SubPCObjective.Next() = 0;
                end;

            until ParentPCObjective.Next() = 0;

            result := 'success*Core Initiatives Populated Successfully*' + Format(linesAdded) + ' activities added';
        end else begin
            // Try without department filter as fallback    
            result := 'error*No activities found in departmental PC: ' + cspNo +
                      ' for department: ' + PerfomanceContractHeader.Department;
        end;
    end;

    procedure fnGetStaffScorecards(employeeNo: Code[30]) data: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        IsLocked: Boolean;
        IsSigned: Boolean;
        IsSupervisorSigned: Boolean;
        LockedTxt: Text;
        SignedTxt: Text;
        SuperSignedTxt: Text;
    begin
        PerfomanceContractHeader.Reset();
        PerfomanceContractHeader.SetRange("Responsible Employee No.", employeeNo);
        PerfomanceContractHeader.SetRange("Document Type",
            PerfomanceContractHeader."document type"::"Staff Performance Contract");
        PerfomanceContractHeader.SetRange("Score Card Type",
            PerfomanceContractHeader."score card type"::Staff);

        if PerfomanceContractHeader.FindSet() then begin
            repeat
                PerfomanceContractHeader.CalcFields(
                    "Total Assigned Weight(%)",
                    "Secondary Assigned Weight(%)",
                    "JD Assigned Weight(%)"
                );

                IsLocked := PerfomanceContractHeader."Change Status" =
                                       PerfomanceContractHeader."change status"::Locked;
                IsSigned := PerfomanceContractHeader.Status =
                                       PerfomanceContractHeader.Status::Signed;
                IsSupervisorSigned := PerfomanceContractHeader.Status =
                                       PerfomanceContractHeader.Status::"Supervisor Signed";

                if IsLocked then LockedTxt := 'true' else LockedTxt := 'false';
                if IsSigned then SignedTxt := 'true' else SignedTxt := 'false';
                if IsSupervisorSigned then SuperSignedTxt := 'true' else SuperSignedTxt := 'false';

                data := data +
                        PerfomanceContractHeader.No + '*' +
                        PerfomanceContractHeader.Description + '*' +
                        PerfomanceContractHeader."Strategy Plan ID" + '*' +
                        PerfomanceContractHeader."Annual Reporting Code" + '*' +
                        Format(PerfomanceContractHeader."Start Date") + '*' +
                        Format(PerfomanceContractHeader."End Date") + '*' +
                        PerfomanceContractHeader.Department + '*' +
                        PerfomanceContractHeader."Department Name" + '*' +
                        PerfomanceContractHeader."Employee Name" + '*' +
                        PerfomanceContractHeader.Designation + '*' +
                        Format(PerfomanceContractHeader."Approval Status") + '*' +
                        LockedTxt + '*' +
                        SignedTxt + '*' +
                        SuperSignedTxt + '*' +
                        Format(PerfomanceContractHeader."Total Assigned Weight(%)") + '*' +
                        Format(PerfomanceContractHeader."Secondary Assigned Weight(%)") + '*' +
                        Format(PerfomanceContractHeader."JD Assigned Weight(%)") +
                        '::::';
            until PerfomanceContractHeader.Next() = 0;
        end;
    end;

    procedure fnGetSignedScorecards(employeeNo: Code[30]) data: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset();
        PerfomanceContractHeader.SetRange("Responsible Employee No.", employeeNo);
        PerfomanceContractHeader.SetRange("Document Type",
            PerfomanceContractHeader."document type"::"Staff Performance Contract");
        PerfomanceContractHeader.SetRange("Score Card Type",
            PerfomanceContractHeader."score card type"::Staff);
        PerfomanceContractHeader.SetRange("Approval Status",
            PerfomanceContractHeader."approval status"::Released);
        PerfomanceContractHeader.SetRange(Status,
            PerfomanceContractHeader.Status::Signed);   // ← only signed

        if PerfomanceContractHeader.FindSet() then begin
            repeat
                data := data +
                        PerfomanceContractHeader.No + '*' +
                        PerfomanceContractHeader.Description + '*' +
                        PerfomanceContractHeader."Annual Reporting Code" + '*' +
                        PerfomanceContractHeader."Strategy Plan ID" + '*' +
                        PerfomanceContractHeader."Annual Workplan" + '*' +
                        Format(PerfomanceContractHeader."Start Date") + '*' +
                        Format(PerfomanceContractHeader."End Date") + '*' +
                        PerfomanceContractHeader.Department + '*' +
                        PerfomanceContractHeader."Department Name" + '*' +
                        PerfomanceContractHeader."Employee Name" +
                        '::::';
            until PerfomanceContractHeader.Next() = 0;
        end;
    end;

    // ─── Get quarterly periods for year code ─────────────────────────

    procedure fnGetQuarterlyPeriods(yearCode: Code[50]) data: Text
    var
        QYearCode: Record "Quarterly Reporting Periods";
    begin
        QYearCode.Reset();
        QYearCode.SetRange("Year Code", yearCode);
        if QYearCode.FindSet() then begin
            repeat
                data := data +
                        QYearCode.Code + '*' +
                        QYearCode."Year Code" + '*' +
                        Format(QYearCode."Reporting Start Date") + '*' +
                        Format(QYearCode."Reporting End Date") +
                        '::::';
            until QYearCode.Next() = 0;
        end;
    end;

    // ─── Get PLOGs for employee ───────────────────────────────────────

    procedure fnGetMyPlogs(employeeNo: Code[30]) data: Text
    var
        PerformanceDiaryLog: Record "Performance Diary Log";
    begin
        PerformanceDiaryLog.Reset();
        PerformanceDiaryLog.SetRange("Employee No.", employeeNo);
        if PerformanceDiaryLog.FindSet() then begin
            repeat
                data := data +
                        PerformanceDiaryLog.No + '*' +
                        PerformanceDiaryLog.Description + '*' +
                        PerformanceDiaryLog."Employee No." + '*' +
                        PerformanceDiaryLog."Employee Names" + '*' +
                        PerformanceDiaryLog."Personal Scorecard ID" + '*' +
                        PerformanceDiaryLog."Year Reporting Code" + '*' +
                        PerformanceDiaryLog."Reporting Quater Code" + '*' +
                        Format(PerformanceDiaryLog."Activity Start Date") + '*' +
                        Format(PerformanceDiaryLog."Activity End Date") + '*' +
                        Format(PerformanceDiaryLog."Approval Status") + '*' +
                        Format(PerformanceDiaryLog."Document Date") + '*' +
                        Format(PerformanceDiaryLog."Created On") + '*' +
                        PerformanceDiaryLog."CSP ID" + '*' +
                        PerformanceDiaryLog."AWP ID" + '*' +
                    '::::';
            until PerformanceDiaryLog.Next() = 0;
        end;
    end;

    // ─── Create PLOG header ───────────────────────────────────────────
    // Uses existing FnNewPerformanceLogEntry but wraps it cleanly

    procedure fnCreatePlogs(
    employeeNo: Code[30];
    scorecardId: Code[100];
    description: Text[250];
    quarterCode: Code[20];
    activityStartDate: Date;
    activityEndDate: Date
) result: Text
    var
        PerformanceDiaryLog: Record "Performance Diary Log";
        IndividualScorecard: Record "Perfomance Contract Header";
    begin
        IndividualScorecard.Reset();
        IndividualScorecard.SetRange(No, scorecardId);
        IndividualScorecard.SetRange("Approval Status",
            IndividualScorecard."approval status"::Released);
        IndividualScorecard.SetRange(Status,
            IndividualScorecard.Status::Signed);
        if not IndividualScorecard.FindFirst() then begin
            result := 'error*Scorecard ' + scorecardId + ' is not signed';
            exit;
        end;

        PerformanceDiaryLog.Init();
        PerformanceDiaryLog."Employee No." := employeeNo;
        PerformanceDiaryLog.Validate("Employee No.");
        PerformanceDiaryLog."Personal Scorecard ID" := scorecardId;
        PerformanceDiaryLog.Validate("Personal Scorecard ID");
        PerformanceDiaryLog.Description := description;
        PerformanceDiaryLog."Reporting Quater Code" := quarterCode;
        // ── Set dates BEFORE insert so FnSuggestPlogLines can filter by them ──
        PerformanceDiaryLog."Activity Start Date" := activityStartDate;
        PerformanceDiaryLog."Activity End Date" := activityEndDate;
        PerformanceDiaryLog."Approval Status" := PerformanceDiaryLog."approval status"::Open;

        if PerformanceDiaryLog.Insert(true) then begin
            PerformanceDiaryLog.Get(PerformanceDiaryLog.No);
            PerformanceDiaryLog."Activity Start Date" := activityStartDate;
            PerformanceDiaryLog."Activity End Date" := activityEndDate;
            PerformanceDiaryLog.Modify(true);
            FnSuggestPlogLines(PerformanceDiaryLog);

            result := 'success*Performance log created successfully*' +
                      PerformanceDiaryLog.No + '*' +
                      PerformanceDiaryLog."CSP ID" + '*' +
                      PerformanceDiaryLog."Personal Scorecard ID";
        end else
            result := 'error*Failed to create performance log';
    end;

    procedure fnCreatePlog(
    employeeNo: Code[30];
    scorecardId: Code[100];
    description: Text[250];
    quarterCode: Code[20]
) result: Text
    var
        PerformanceDiaryLog: Record "Performance Diary Log";
        IndividualScorecard: Record "Perfomance Contract Header";
    begin
        IndividualScorecard.Reset();
        IndividualScorecard.SetRange(No, scorecardId);
        IndividualScorecard.SetRange("Approval Status",
            IndividualScorecard."approval status"::Released);
        IndividualScorecard.SetRange(Status,
            IndividualScorecard.Status::Signed);
        if not IndividualScorecard.FindFirst() then begin
            result := 'error*Scorecard ' + scorecardId + ' is not signed';
            exit;
        end;

        PerformanceDiaryLog.Init();
        PerformanceDiaryLog."Employee No." := employeeNo;
        PerformanceDiaryLog.Validate("Employee No.");
        PerformanceDiaryLog."Personal Scorecard ID" := scorecardId;
        PerformanceDiaryLog.Validate("Personal Scorecard ID");
        PerformanceDiaryLog."Reporting Quater Code" := quarterCode;
        if description <> '' then
            PerformanceDiaryLog.Description := description;
        PerformanceDiaryLog."Approval Status" := PerformanceDiaryLog."approval status"::Open;

        if not PerformanceDiaryLog.Insert(true) then begin
            result := 'error*Failed to create performance log';
            exit;
        end;

        // ── Re-read from DB then re-validate scorecard ──────────────────────
        // This replicates exactly what BC does when you manually
        // re-validate the Personal Scorecard ID field on the card
        PerformanceDiaryLog.Get(PerformanceDiaryLog.No);
        PerformanceDiaryLog.Validate("Personal Scorecard ID",
            PerformanceDiaryLog."Personal Scorecard ID");
        PerformanceDiaryLog.Modify(true);

        // ── Re-read again after modify then suggest ──────────────────────────
        PerformanceDiaryLog.Get(PerformanceDiaryLog.No);
        FnSuggestPlogLines(PerformanceDiaryLog);

        result := 'success*Performance log created*' +
                  PerformanceDiaryLog.No + '*' +
                  PerformanceDiaryLog."CSP ID" + '*' +
                  PerformanceDiaryLog."Personal Scorecard ID" + '*' +
                  Format(PerformanceDiaryLog."Activity Start Date") + '*' +
                  Format(PerformanceDiaryLog."Activity End Date");
    end;

    // ─── Get PLOG lines ───────────────────────────────────────────────

    procedure fnGetPlogLines(plogNo: Code[30]) data: Text
    var
        PlogLines: Record "Plog Lines";
    begin
        PlogLines.Reset();
        PlogLines.SetRange("PLog No.", plogNo);
        if PlogLines.FindSet() then begin
            repeat
                data := data +
                        Format(PlogLines.EntryNo) + '*' +
                        PlogLines."PLog No." + '*' +
                        PlogLines."Initiative No." + '*' +
                        PlogLines."Sub Intiative No" + '*' +
                        Format(PlogLines."Activity Type") + '*' +
                        PlogLines.Description + '*' +
                        PlogLines."Key Performance Indicator" + '*' +
                        PlogLines."Unit of Measure" + '*' +
                        Format(PlogLines."Target Qty") + '*' +
                        Format(PlogLines."Remaining Targets") + '*' +
                        Format(PlogLines."Planned Date") + '*' +
                        Format(PlogLines."Achieved Date") + '*' +
                        Format(PlogLines."Achieved Target") + '*' +
                        Format(PlogLines."Weight %") + '*' +
                        Format(PlogLines."Achieved Weight(%)") + '*' +
                        PlogLines.Comments + '*' +
                        PlogLines.Variance + '*' +
                        Format(PlogLines."Q1 Achieved Target") + '*' +
                        Format(PlogLines."Q2 Achieved Target") + '*' +
                        Format(PlogLines."Q3 AchievedTarget") + '*' +
                        Format(PlogLines."Q4 Achieved Target") +
                        '::::';
            until PlogLines.Next() = 0;
        end;
    end;

    // ─── Update PLOG line (save achieved target) ─────────────────────

    procedure fnUpdatePlogLine(
        plogNo: Code[30];
        entryNo: Integer;
        achievedTarget: Decimal;
        achievedDate: Date;
        comments: Text[250]
    ) result: Text
    var
        PlogLines: Record "Plog Lines";
    begin
        PlogLines.Reset();
        PlogLines.SetRange("PLog No.", plogNo);
        PlogLines.SetRange(EntryNo, entryNo);
        if PlogLines.FindFirst() then begin
            PlogLines."Achieved Target" := achievedTarget;
            PlogLines."Achieved Date" := achievedDate;
            PlogLines.Comments := comments;
            if PlogLines.Modify(true) then
                result := 'success*Line updated successfully'
            else
                result := 'error*Failed to update line';
        end else
            result := 'error*Plog line not found: ' + plogNo + ' / ' + Format(entryNo);
    end;

    procedure fnAddNewAdditionalInitiative(
    workplanNo: Code[30];
    description: Text[255];
    assignedWeight: Decimal;
    startDate: Date;
    dueDate: Date;
    comments: Text[250]
) result: Text
    var
        SecondaryPCObjective: Record "Secondary PC Objective";
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset();
        PerfomanceContractHeader.SetRange(No, workplanNo);
        if not PerfomanceContractHeader.FindFirst() then begin
            result := 'error*Performance contract not found: ' + workplanNo;
            exit;
        end;

        SecondaryPCObjective.Init();
        SecondaryPCObjective."Workplan No." := workplanNo;
        SecondaryPCObjective."Initiative No." := 'OWN-' + Format(Today, 0, '<Year4><Month,2><Day,2>');
        SecondaryPCObjective."Objective/Initiative" := description;
        SecondaryPCObjective."Assigned Weight (%)" := assignedWeight;
        SecondaryPCObjective."Start Date" := startDate;
        SecondaryPCObjective."Due Date" := dueDate;
        SecondaryPCObjective.Comments := comments;
        SecondaryPCObjective."Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
        SecondaryPCObjective."Year Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
        SecondaryPCObjective."Primary Department" := PerfomanceContractHeader.Department;

        if SecondaryPCObjective.Insert(true) then
            result := 'success*Additional initiative added successfully*' + Format(SecondaryPCObjective.EntryNo)
        else
            result := 'error*Failed to add additional initiative';
    end;

    procedure fnUpdatePCObjectiveLine(workplanNo: Code[30]; initiativeNo: Code[30]; agreedTarget: Decimal; assignedWeight: Decimal; remarks: Text[250]) result: Text
    var
        WPLines: Record "PC Objective";
    begin
        WPLines.Reset();
        WPLines.SetRange("Workplan No.", workplanNo);
        WPLines.SetRange("Initiative No.", initiativeNo);

        if WPLines.FindFirst() then begin
            WPLines."Imported Annual Target Qty" := agreedTarget;
            WPLines."Assigned Weight (%)" := assignedWeight;
            WPLines."Additional Comments" := remarks;

            if WPLines.Modify(true) then
                result := 'success*Activity updated successfully'
            else
                result := 'error*Failed to update activity';
        end else begin
            result := 'error*Activity line not found. Workplan: ' + workplanNo + ', Initiative: ' + initiativeNo;
        end;
    end;

    procedure FnSuggestPlogLines(PerformanceDiaryLog: Record "Performance Diary Log")
    var
        PlogLines: Record "Plog Lines";
        PCObjective: Record "PC Objective";
        SecondaryPCObjective: Record "Secondary PC Objective";
        SubPlogLines: Record "Sub Plog Lines";
        SubPCObjective: Record "Sub PC Objective";
        PCJobDescription: Record "PC Job Description";
        SubJDObjective: Record "Sub JD Objective";
    begin
        PerformanceDiaryLog.TestField("Employee No.");
        PerformanceDiaryLog.TestField("Personal Scorecard ID");
        PerformanceDiaryLog.TestField("Activity Start Date");
        PerformanceDiaryLog.TestField("Activity End Date");

        SPMGeneralSetup.Get();
        if (SPMGeneralSetup."Allow Loading of  CSP" = true) then begin
            PCObjective.Reset;
            PCObjective.SetRange("Strategy Plan ID", PerformanceDiaryLog."CSP ID");
            PCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
            PCObjective.SetRange("Due Date", PerformanceDiaryLog."Activity Start Date", PerformanceDiaryLog."Activity End Date");//Commented for Kerra
            if PCObjective.FindSet then begin
                repeat
                    PCObjective.CalcFields("Individual Achieved Targets");
                    PCObjective.TestField("Due Date");
                    //PCObjective.TESTFIELD("Imported Annual Target Qty");
                    PlogLines.Init;
                    PlogLines.EntryNo := 0;
                    PlogLines."PLog No." := PerformanceDiaryLog.No;
                    PlogLines."Activity Type" := PlogLines."activity type"::"Primary Activity";
                    PlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                    PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                    PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                    PlogLines."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                    PlogLines."Key Performance Indicator" := PCObjective."Outcome Perfomance Indicator";
                    PlogLines."Initiative No." := PCObjective."Initiative No.";
                    PlogLines."Unit of Measure" := PCObjective."Unit of Measure";
                    //MESSAGE('PCObjective."Assigned Weight (%)" is %1',PCObjective."Assigned Weight (%)");
                    PlogLines."Weight %" := PCObjective."Assigned Weight (%)";
                    PlogLines.Validate("Initiative No.");
                    PlogLines."Remaining Targets" := PCObjective."Imported Annual Target Qty" - PCObjective."Individual Achieved Targets";
                    PlogLines.Insert;

                    //Sub Activities
                    SubPCObjective.Reset;
                    SubPCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                    SubPCObjective.SetRange("Initiative No.", PCObjective."Initiative No.");
                    if SubPCObjective.FindSet then begin
                        repeat
                            SubPlogLines.Init;
                            SubPlogLines.EntryNo := 0;
                            SubPlogLines."PLog No." := PerformanceDiaryLog.No;
                            SubPlogLines."Activity Type" := SubPlogLines."activity type"::"Primary Activity";
                            SubPlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                            SubPlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                            SubPlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                            SubPlogLines."Initiative No." := SubPCObjective."Initiative No.";
                            SubPlogLines."Sub Activity No." := SubPCObjective."Outcome Perfomance Indicator";
                            SubPlogLines.Description := SubPCObjective."Objective/Initiative";
                            SubPlogLines."Sub Activity No." := SubPCObjective."Sub Initiative No.";
                            SubPlogLines."Unit of Measure" := SubPCObjective."Unit of Measure";
                            SubPlogLines."Planned Date" := SubPCObjective."Due Date";
                            SubPlogLines."Target Qty" := SubPCObjective."Imported Annual Target Qty";
                            SubPlogLines."Weight %" := SubPCObjective."Assigned Weight (%)";
                            //SubPlogLines.VALIDATE("Initiative No.");
                            //SubPlogLines."Remaining Targets":=SubPCObjective."Imported Annual Target Qty"- SubPCObjective."Individual Achieved Targets";
                            if not SubPlogLines.Get(SubPlogLines."PLog No.", SubPlogLines."Initiative No.", SubPlogLines."Sub Activity No.", SubPlogLines."Personal Scorecard ID") then
                                SubPlogLines.Insert(true);
                        until SubPCObjective.Next = 0;
                    end;

                until PCObjective.Next = 0;
            end;

            SecondaryPCObjective.Reset;
            SecondaryPCObjective.SetRange("Strategy Plan ID", PerformanceDiaryLog."CSP ID");
            SecondaryPCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
            SecondaryPCObjective.SetRange("Due Date", PerformanceDiaryLog."Activity Start Date", PerformanceDiaryLog."Activity End Date");
            if SecondaryPCObjective.FindFirst then begin
                repeat
                    SecondaryPCObjective.CalcFields("Individual Achieved Targets");
                    SecondaryPCObjective.TestField("Due Date");
                    //SecondaryPCObjective.TESTFIELD("Imported Annual Target Qty");
                    PlogLines.Init;
                    PlogLines.EntryNo := 0;
                    PlogLines."PLog No." := PerformanceDiaryLog.No;
                    PlogLines."Activity Type" := PlogLines."activity type"::"Secondary Activity";
                    PlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                    PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                    PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                    PlogLines."Initiative No." := SecondaryPCObjective."Initiative No.";
                    //MESSAGE('SecondaryPCObjective."Assigned Weight (%)" is %1',SecondaryPCObjective."Assigned Weight (%)");
                    PlogLines."Weight %" := SecondaryPCObjective."Assigned Weight (%)";
                    PlogLines.Validate("Initiative No.");
                    PlogLines."Remaining Targets" := PCObjective."Imported Annual Target Qty" - PCObjective."Individual Achieved Targets";
                    PlogLines.Insert;

                    //Sub Activities
                    SubPCObjective.Reset;
                    SubPCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                    SubPCObjective.SetRange("Initiative No.", SecondaryPCObjective."Initiative No.");
                    if SubPCObjective.FindSet then begin
                        repeat
                            SubPlogLines.Init;
                            SubPlogLines.EntryNo := 0;
                            SubPlogLines."PLog No." := PerformanceDiaryLog.No;
                            SubPlogLines."Activity Type" := SubPlogLines."activity type"::"Primary Activity";
                            SubPlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                            SubPlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                            SubPlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                            SubPlogLines."Initiative No." := SubPCObjective."Initiative No.";
                            SubPlogLines."Sub Activity No." := SubPCObjective."Outcome Perfomance Indicator";
                            SubPlogLines.Description := SubPCObjective."Objective/Initiative";
                            SubPlogLines."Sub Activity No." := SubPCObjective."Sub Initiative No.";
                            SubPlogLines."Unit of Measure" := SubPCObjective."Unit of Measure";
                            SubPlogLines."Planned Date" := SubPCObjective."Due Date";
                            SubPlogLines."Target Qty" := SubPCObjective."Imported Annual Target Qty";
                            SubPlogLines."Weight %" := SubPCObjective."Assigned Weight (%)";
                            SubPlogLines.VALIDATE("Initiative No.");
                            SubPlogLines."Remaining Targets" := SubPCObjective."Imported Annual Target Qty" - SubPCObjective."Individual Achieved Targets";
                            if not SubPlogLines.Get(SubPlogLines."PLog No.", SubPlogLines."Initiative No.", SubPlogLines."Sub Activity No.", SubPlogLines."Personal Scorecard ID") then
                                SubPlogLines.Insert(true);
                        until SubPCObjective.Next = 0;
                    end;
                until SecondaryPCObjective.Next = 0;
            end;
        end;

        if (SPMGeneralSetup."Allow Loading of JD" = true) then begin
            PCJobDescription.Reset;
            PCJobDescription.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
            PCJobDescription.SetRange("Due Date", PerformanceDiaryLog."Activity Start Date", PerformanceDiaryLog."Activity End Date");
            if PCJobDescription.FindFirst then begin
                repeat
                    PCJobDescription.CalcFields("Individual Achieved Targets");
                    PCJobDescription.TestField("Due Date");
                    //PCJobDescription.TESTFIELD("Imported Annual Target Qty");
                    PlogLines.Init;
                    PlogLines.EntryNo := 0;
                    PlogLines."PLog No." := PerformanceDiaryLog.No;
                    PlogLines."Activity Type" := PlogLines."activity type"::"JD Activity";
                    PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                    PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                    PlogLines."Initiative No." := Format(PCJobDescription."Line Number");
                    PlogLines."Sub Intiative No" := PCJobDescription.Description;
                    PlogLines."Planned Date" := PCJobDescription."Start Date";
                    PlogLines."Achieved Date" := PerformanceDiaryLog."Document Date";
                    PlogLines."Due Date" := PCJobDescription."Due Date";
                    PlogLines."Target Qty" := PCJobDescription."Imported Annual Target Qty";
                    PlogLines."Weight %" := PCJobDescription."Assigned Weight (%)";
                    PlogLines."Remaining Targets" := PCJobDescription."Imported Annual Target Qty" - PCJobDescription."Individual Achieved Targets";
                    PlogLines.Insert;
                    //Sub JD Plog Lines
                    SubJDObjective.Reset;
                    SubJDObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                    SubJDObjective.SetRange("Line Number", PCJobDescription."Line Number");
                    if SubJDObjective.FindSet then begin
                        repeat
                            SubPlogLines.Init;
                            SubPlogLines.EntryNo := 0;
                            SubPlogLines."PLog No." := PerformanceDiaryLog.No;
                            SubPlogLines."Activity Type" := SubPlogLines."activity type"::"JD Activity";
                            SubPlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                            SubPlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                            SubPlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                            SubPlogLines."Initiative No." := SubJDObjective."Line Number";
                            SubPlogLines."Sub Activity No." := SubJDObjective."Sub Initiative No.";
                            SubPlogLines.Description := SubJDObjective.Description;
                            SubPlogLines."Unit of Measure" := SubJDObjective."Unit of Measure";
                            SubPlogLines."Planned Date" := SubJDObjective."Due Date";
                            SubPlogLines."Target Qty" := SubJDObjective."Imported Annual Target Qty";
                            SubPlogLines."Due Date" := SubJDObjective."Due Date";
                            if not SubPlogLines.Get(SubPlogLines."PLog No.", SubPlogLines."Initiative No.", SubPlogLines."Sub Activity No.", SubPlogLines."Personal Scorecard ID") then
                                SubPlogLines.Insert(true);
                        until SubJDObjective.Next = 0;
                    end;
                until PCJobDescription.Next = 0;
            end;
        end;

    end;

    procedure FnSuggestDepartmentPlogLines(PerformanceDiaryLog: Record "Performance Diary Log")
    var
        PlogLines: Record "Plog Lines";
        PCObjective: Record "PC Objective";
        SecondaryPCObjective: Record "Secondary PC Objective";
        SubPlogLines: Record "Sub Plog Lines";
        SubPCObjective: Record "Sub PC Objective";
        PCJobDescription: Record "PC Job Description";
        SubJDObjective: Record "Sub JD Objective";
    begin
        PerformanceDiaryLog.TestField("Employee No.");
        PerformanceDiaryLog.TestField("Personal Scorecard ID");
        PerformanceDiaryLog.TestField("Activity Start Date");
        PerformanceDiaryLog.TestField("Activity End Date");

        SPMGeneralSetup.Get();
        if (SPMGeneralSetup."Allow Loading of  CSP" = true) then begin
            PCObjective.Reset;
            PCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
            PCObjective.SetRange("Due Date", PerformanceDiaryLog."Activity Start Date", PerformanceDiaryLog."Activity End Date");//Commented for Kerra
            if PCObjective.FindSet then begin
                repeat
                    PCObjective.CalcFields("Individual Achieved Targets");
                    PCObjective.TestField("Due Date");
                    //PCObjective.TESTFIELD("Imported Annual Target Qty");
                    PlogLines.Init;
                    PlogLines."PLog No." := PerformanceDiaryLog.No;
                    PlogLines."Activity Type" := PlogLines."activity type"::"Primary Activity";
                    PlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                    PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                    PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                    PlogLines."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                    PlogLines."Key Performance Indicator" := PCObjective."Outcome Perfomance Indicator";
                    PlogLines."Initiative No." := PCObjective."Initiative No.";
                    PlogLines."Unit of Measure" := PCObjective."Unit of Measure";
                    //MESSAGE('PCObjective."Assigned Weight (%)" is %1',PCObjective."Assigned Weight (%)");
                    PlogLines."Weight %" := PCObjective."Assigned Weight (%)";
                    PlogLines.Validate("Initiative No.");
                    PlogLines."Remaining Targets" := PCObjective."Imported Annual Target Qty" - PCObjective."Individual Achieved Targets";
                    PlogLines.Insert;

                    //Sub Activities
                    SubPCObjective.Reset;
                    SubPCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                    SubPCObjective.SetRange("Initiative No.", PCObjective."Initiative No.");
                    if SubPCObjective.FindSet then begin
                        repeat
                            SubPlogLines.Init;
                            SubPlogLines."PLog No." := PerformanceDiaryLog.No;
                            SubPlogLines."Activity Type" := SubPlogLines."activity type"::"Primary Activity";
                            SubPlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                            SubPlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                            SubPlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                            SubPlogLines."Initiative No." := SubPCObjective."Initiative No.";
                            SubPlogLines."Sub Activity No." := SubPCObjective."Outcome Perfomance Indicator";
                            SubPlogLines.Description := SubPCObjective."Objective/Initiative";
                            SubPlogLines."Sub Activity No." := SubPCObjective."Sub Initiative No.";
                            SubPlogLines."Unit of Measure" := SubPCObjective."Unit of Measure";
                            SubPlogLines."Planned Date" := SubPCObjective."Due Date";
                            SubPlogLines."Target Qty" := SubPCObjective."Imported Annual Target Qty";
                            SubPlogLines."Weight %" := SubPCObjective."Assigned Weight (%)";
                            //SubPlogLines.VALIDATE("Initiative No.");
                            //SubPlogLines."Remaining Targets":=SubPCObjective."Imported Annual Target Qty"- SubPCObjective."Individual Achieved Targets";
                            if not SubPlogLines.Get(SubPlogLines."PLog No.", SubPlogLines."Initiative No.", SubPlogLines."Sub Activity No.", SubPlogLines."Personal Scorecard ID") then
                                SubPlogLines.Insert(true);
                        until SubPCObjective.Next = 0;
                    end;

                until PCObjective.Next = 0;
            end;
        end;
    end;

    procedure FnInsertPlogEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDepartment: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract"; EmployeeNo: Code[30]; PostingDate: Date; DocumentType: Option Plog,Appraisal; RegionCode: Code[30]; PerformanceContractID: Code[30]; AnnualWorkplan: Code[30]; BoardPCID: Code[30]; CEOPCID: Code[30]; FunctionalPCID: Code[30]; UnitofMeasure: Code[30]; Comments: Text[2048]; Q1AchievedTarget: Decimal; Q2AchievedTarget: Decimal; Q3AchievedTarget: Decimal; Q4AchievedTarget: Decimal; RemainingTargets: Decimal; AchievedWeight: Decimal; Variance: Text[255])
    var
        StrategyEntry: Record "Strategy Sub_Activity Entry";
        PerformanceDiaryLog: Record "Performance Diary Log";
        QuaterCode: code[10];
    begin

        StrategyEntry.Init;
        StrategyEntry."Strategic Plan ID" := PlanID;
        StrategyEntry."Theme ID" := ThemeID;
        StrategyEntry."Objective ID" := ObjectiveID;
        StrategyEntry."Strategy ID" := StrategyID;
        StrategyEntry."Activity ID" := Actitvityid;
        StrategyEntry."Entry Description" := Description;
        StrategyEntry."Entry Type" := EntryType;
        StrategyEntry."Year Reporting Code" := YearCode;
        QuaterCode := COPYSTR(QYearCode, 1, 2);
        StrategyEntry."Quarter Reporting Code" := QuaterCode;
        StrategyEntry."Q1 Achieved Target" := Q1AchievedTarget;
        StrategyEntry."Q2 Achieved Target" := Q2AchievedTarget;
        StrategyEntry."Q3 AchievedTarget" := Q3AchievedTarget;
        StrategyEntry."Q4 Achieved Target" := Q4AchievedTarget;
        StrategyEntry."Remaining Targets" := RemainingTargets;
        StrategyEntry."Achieved Weight(%)" := AchievedWeight;
        StrategyEntry."Variance" := Variance;
        StrategyEntry."Quarter Reporting Code" := QYearCode;
        StrategyEntry."Planning Date" := PlanningDate;
        StrategyEntry."Primary Department" := PrimaryDepartment;
        // StrategyEntry."Primary Division" := PrimaryDivision;
        StrategyEntry.Quantity := Quantity;
        StrategyEntry."Cost Amount" := CostAmount;
        StrategyEntry."External Document No" := Extdoc;
        StrategyEntry."Source Type" := SourceType;
        StrategyEntry."Employee No" := EmployeeNo;
        StrategyEntry."Region Code" := RegionCode;
        StrategyEntry."Performance Contract ID" := PerformanceContractID;
        StrategyEntry."Annual Workplan" := AnnualWorkplan;
        StrategyEntry."Board PC ID" := BoardPCID;
        StrategyEntry."CEOs PC ID" := CEOPCID;
        StrategyEntry."Functional PC ID" := FunctionalPCID;
        StrategyEntry.Comments := Comments;
        StrategyEntry."Posting Date" := Today;
        PerformanceDiaryLog.Reset;
        PerformanceDiaryLog.SetRange(No, Extdoc);
        if PerformanceDiaryLog.FindFirst then begin
            StrategyEntry."CEOs PC ID" := PerformanceDiaryLog."CEOs PC ID";
            StrategyEntry."Department/Center PC ID" := PerformanceDiaryLog."Department/Center PC ID";
        end;
        StrategyEntry."Unit of Measure" := UnitofMeasure;
        StrategyEntry.Insert(true);
    end;


    // procedure FnInsertPlogEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDepartment: Code[100]; PrimaryDivision: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract"; EmployeeNo: Code[30]; PostingDate: Date; DocumentType: Option Plog,Appraisal; RegionCode: Code[30]; PerformanceContractID: Code[30]; AnnualWorkplan: Code[30]; BoardPCID: Code[30]; CEOPCID: Code[30]; FunctionalPCID: Code[30]; UnitofMeasure: Code[30]; Comments: Text[2048]; Q1AchievedTarget: Decimal; Q2AchievedTarget: Decimal; Q3AchievedTarget: Decimal; Q4AchievedTarget: Decimal; RemainingTargets: Decimal; AchievedWeight: Decimal; Variance: Text[255])
    // var
    //     StrategyEntry: Record "Strategy Sub_Activity Entry";
    //     PerformanceDiaryLog: Record "Performance Diary Log";
    //     QuaterCode: code[10];
    // begin

    //     StrategyEntry.Init;
    //     StrategyEntry."Strategic Plan ID" := PlanID;
    //     StrategyEntry."Theme ID" := ThemeID;
    //     StrategyEntry."Objective ID" := ObjectiveID;
    //     StrategyEntry."Strategy ID" := StrategyID;
    //     StrategyEntry."Activity ID" := Actitvityid;
    //     StrategyEntry."Entry Description" := Description;
    //     StrategyEntry."Entry Type" := EntryType;
    //     StrategyEntry."Year Reporting Code" := YearCode;
    //     QuaterCode := COPYSTR(QYearCode, 1, 2);
    //     StrategyEntry."Quarter Reporting Code" := QuaterCode;
    //     StrategyEntry."Q1 Achieved Target" := Q1AchievedTarget;
    //     StrategyEntry."Q2 Achieved Target" := Q2AchievedTarget;
    //     StrategyEntry."Q3 AchievedTarget" := Q3AchievedTarget;
    //     StrategyEntry."Q4 Achieved Target" := Q4AchievedTarget;
    //     StrategyEntry."Remaining Targets" := RemainingTargets;
    //     StrategyEntry."Achieved Weight(%)" := AchievedWeight;
    //     StrategyEntry."Variance" := Variance;
    //     StrategyEntry."Quarter Reporting Code" := QYearCode;
    //     StrategyEntry."Planning Date" := PlanningDate;
    //     StrategyEntry."Primary Department" := PrimaryDepartment;
    //     StrategyEntry."Primary Division" := PrimaryDivision;
    //     StrategyEntry.Quantity := Quantity;
    //     StrategyEntry."Cost Amount" := CostAmount;
    //     StrategyEntry."External Document No" := Extdoc;
    //     StrategyEntry."Source Type" := SourceType;
    //     StrategyEntry."Employee No" := EmployeeNo;
    //     StrategyEntry."Region Code" := RegionCode;
    //     StrategyEntry."Performance Contract ID" := PerformanceContractID;
    //     StrategyEntry."Annual Workplan" := AnnualWorkplan;
    //     StrategyEntry."Board PC ID" := BoardPCID;
    //     StrategyEntry."CEO PC ID" := CEOPCID;
    //     StrategyEntry."Functional PC ID" := FunctionalPCID;
    //     StrategyEntry.Comments := Comments;
    //     StrategyEntry."Posting Date" := Today;
    //     PerformanceDiaryLog.Reset;
    //     PerformanceDiaryLog.SetRange(No, Extdoc);
    //     if PerformanceDiaryLog.FindFirst then begin
    //         StrategyEntry."CEOs PC ID" := PerformanceDiaryLog."CEOs PC ID";
    //         StrategyEntry."Department/Center PC ID" := PerformanceDiaryLog."Department/Center PC ID";
    //     end;
    //     StrategyEntry."Unit of Measure" := UnitofMeasure;
    //     StrategyEntry.Insert(true);
    // end;


    procedure FnInsertJDPlogEntry(PlogLines: Record "Plog Lines")
    var
        PerformanceDiaryEntry: Record "Performance Diary Entry";
    begin
        PerformanceDiaryEntry.Init;
        PerformanceDiaryEntry."Line Number" := PlogLines."Initiative No.";
        PerformanceDiaryEntry."Employee No" := PlogLines."Employee No.";
        PerformanceDiaryEntry."Posting Date" := PlogLines."Achieved Date";
        PerformanceDiaryEntry."Performance Entry Type" := PerformanceDiaryEntry."performance entry type"::"Positive Performance";
        PerformanceDiaryEntry."Diary Source" := PerformanceDiaryEntry."diary source"::"Self-Log";
        PerformanceDiaryEntry.Description := 'PLOG_' + Format(PlogLines."Achieved Date");
        PerformanceDiaryEntry."Personal Scorecard ID" := PlogLines."Personal Scorecard ID";
        PerformanceDiaryEntry.Quantity := PlogLines."Achieved Target";
        PerformanceDiaryEntry."Primary Department" := PlogLines."Primary Department";
        // PerformanceDiaryEntry."Primary Division" := PlogLines."Primary Division";
        PerformanceDiaryEntry."Posting Date" := Today;
        PerformanceDiaryEntry.Insert(true);
    end;

    procedure FnInsertSubPlogEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDepartment: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract"; EmployeeNo: Code[30]; PostingDate: Date; DocumentType: Option Plog,Appraisal; RegionCode: Code[30]; PerformanceContractID: Code[30]; AnnualWorkplan: Code[30]; BoardPCID: Code[30]; CEOPCID: Code[30]; FunctionalPCID: Code[30]; UnitofMeasure: Code[30]; Sub_Intiative_No: Code[30])
    var
        PerformanceDiaryLog: Record "Performance Diary Log";
        Sub_Strategy_Activity: Record Sub_Strategy_Activity;
    begin

        Sub_Strategy_Activity.Init;
        Sub_Strategy_Activity."Strategic Plan ID" := PlanID;
        Sub_Strategy_Activity."Theme ID" := ThemeID;
        Sub_Strategy_Activity."Objective ID" := ObjectiveID;
        Sub_Strategy_Activity."Strategy ID" := StrategyID;
        Sub_Strategy_Activity."Activity ID" := Actitvityid;
        Sub_Strategy_Activity."Entry Description" := Description;
        Sub_Strategy_Activity."Entry Type" := EntryType;
        Sub_Strategy_Activity."Year Reporting Code" := YearCode;
        Sub_Strategy_Activity."Quarter Reporting Code" := QYearCode;
        Sub_Strategy_Activity."Planning Date" := PlanningDate;
        Sub_Strategy_Activity."Primary Department" := PrimaryDepartment;
        // Sub_Strategy_Activity."Primary Division" := PrimaryDivision;
        Sub_Strategy_Activity.Quantity := Quantity;
        Sub_Strategy_Activity."Cost Amount" := CostAmount;
        Sub_Strategy_Activity."External Document No" := Extdoc;
        Sub_Strategy_Activity."Source Type" := SourceType;
        Sub_Strategy_Activity."Employee No" := EmployeeNo;
        Sub_Strategy_Activity."Region Code" := RegionCode;
        Sub_Strategy_Activity."Performance Contract ID" := PerformanceContractID;
        Sub_Strategy_Activity."Annual Workplan" := AnnualWorkplan;
        Sub_Strategy_Activity."Board PC ID" := BoardPCID;
        Sub_Strategy_Activity."CEO PC ID" := CEOPCID;
        Sub_Strategy_Activity."Functional PC ID" := FunctionalPCID;
        Sub_Strategy_Activity."Posting Date" := Today;
        PerformanceDiaryLog.Reset;
        PerformanceDiaryLog.SetRange(No, Extdoc);
        if PerformanceDiaryLog.FindFirst then begin
            Sub_Strategy_Activity."CEOs PC ID" := PerformanceDiaryLog."CEOs PC ID";
            Sub_Strategy_Activity."Department/Center PC ID" := PerformanceDiaryLog."Department/Center PC ID";
        end;
        Sub_Strategy_Activity."Unit of Measure" := UnitofMeasure;
        Sub_Strategy_Activity."Sub Initiative No." := Sub_Intiative_No;
        Sub_Strategy_Activity.Insert(true);
    end;


    // procedure FnInsertSubPlogEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDepartment: Code[100]; PrimaryDivision: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract"; EmployeeNo: Code[30]; PostingDate: Date; DocumentType: Option Plog,Appraisal; RegionCode: Code[30]; PerformanceContractID: Code[30]; AnnualWorkplan: Code[30]; BoardPCID: Code[30]; CEOPCID: Code[30]; FunctionalPCID: Code[30]; UnitofMeasure: Code[30]; Sub_Intiative_No: Code[30])
    // var
    //     PerformanceDiaryLog: Record "Performance Diary Log";
    //     Sub_Strategy_Activity: Record Sub_Strategy_Activity;
    // begin

    //     Sub_Strategy_Activity.Init;
    //     Sub_Strategy_Activity."Strategic Plan ID" := PlanID;
    //     Sub_Strategy_Activity."Theme ID" := ThemeID;
    //     Sub_Strategy_Activity."Objective ID" := ObjectiveID;
    //     Sub_Strategy_Activity."Strategy ID" := StrategyID;
    //     Sub_Strategy_Activity."Activity ID" := Actitvityid;
    //     Sub_Strategy_Activity."Entry Description" := Description;
    //     Sub_Strategy_Activity."Entry Type" := EntryType;
    //     Sub_Strategy_Activity."Year Reporting Code" := YearCode;
    //     Sub_Strategy_Activity."Quarter Reporting Code" := QYearCode;
    //     Sub_Strategy_Activity."Planning Date" := PlanningDate;
    //     Sub_Strategy_Activity."Primary Department" := PrimaryDepartment;
    //     Sub_Strategy_Activity."Primary Division" := PrimaryDivision;
    //     Sub_Strategy_Activity.Quantity := Quantity;
    //     Sub_Strategy_Activity."Cost Amount" := CostAmount;
    //     Sub_Strategy_Activity."External Document No" := Extdoc;
    //     Sub_Strategy_Activity."Source Type" := SourceType;
    //     Sub_Strategy_Activity."Employee No" := EmployeeNo;
    //     Sub_Strategy_Activity."Region Code" := RegionCode;
    //     Sub_Strategy_Activity."Performance Contract ID" := PerformanceContractID;
    //     Sub_Strategy_Activity."Annual Workplan" := AnnualWorkplan;
    //     Sub_Strategy_Activity."Board PC ID" := BoardPCID;
    //     Sub_Strategy_Activity."CEO PC ID" := CEOPCID;
    //     Sub_Strategy_Activity."Functional PC ID" := FunctionalPCID;
    //     Sub_Strategy_Activity."Posting Date" := Today;
    //     PerformanceDiaryLog.Reset;
    //     PerformanceDiaryLog.SetRange(No, Extdoc);
    //     if PerformanceDiaryLog.FindFirst then begin
    //         Sub_Strategy_Activity."CEOs PC ID" := PerformanceDiaryLog."CEOs PC ID";
    //         Sub_Strategy_Activity."Department/Center PC ID" := PerformanceDiaryLog."Department/Center PC ID";
    //     end;
    //     Sub_Strategy_Activity."Unit of Measure" := UnitofMeasure;
    //     Sub_Strategy_Activity."Sub Initiative No." := Sub_Intiative_No;
    //     Sub_Strategy_Activity.Insert(true);
    // end;

    /// <summary>
    /// AutoCreatePIPFromEvaluation — BRD Phase 1: auto-trigger PIP when final score is in
    /// Developing Impact (0-60%) or Expected Impact (61-99%) bands (4-point scale ≤ 2).
    /// </summary>
    procedure AutoCreatePIPFromEvaluation(EvalNo: Code[30])
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
        PIP: Record "Performance Improvement Plan";
        SPMSetupLocal: Record "SPM General Setup";
        NoSeriesMgtLocal: Codeunit "No. Series";
        PIPAlreadyExistsErr: Label 'A Performance Improvement Plan already exists for evaluation %1.';
        PIPCreatedMsg: Label 'Performance Improvement Plan %1 has been automatically created for %2 (Final Score: %3%).';
    begin
        PerfomanceEvaluation.Reset();
        PerfomanceEvaluation.SetRange(No, EvalNo);
        if not PerfomanceEvaluation.FindFirst() then
            exit;

        // Refresh final score
        PerfomanceEvaluation.GetFinalScore(PerfomanceEvaluation);

        // Only auto-trigger for Developing Impact (0-60%) or Expected Impact (61-99%)
        // i.e., final score < 100% on the BRD 4-point Impact Rating Scale
        if PerfomanceEvaluation."Final Score" >= 100 then
            exit;

        PIP.Reset();
        PIP.SetRange("Primary Evaluation ID", EvalNo);
        PIP.SetRange("Document Type", PIP."document type"::PIP);
        if not PIP.IsEmpty() then begin
            Message(PIPAlreadyExistsErr, EvalNo);
            exit;
        end;

        SPMSetupLocal.Get();

        PIP.Init();
        PIP."Document Type" := PIP."document type"::PIP;
        PIP.No := NoSeriesMgtLocal.GetNextNo(SPMSetupLocal."Performance Improv Review Nos", Today, true);
        PIP."Primary Evaluation ID" := EvalNo;
        PIP."Employee No." := PerfomanceEvaluation."Employee No.";
        PIP."Employee Name" := PerfomanceEvaluation."Employee Name";
        PIP."Immediate Supervisor No." := PerfomanceEvaluation."Immediate Supervisor No.";
        PIP."Immediate Supervisor Name" := PerfomanceEvaluation."Immediate Supervisor Name";
        PIP.Department := PerfomanceEvaluation.Department;
        PIP."Annual Reporting Code" := PerfomanceEvaluation."Annual Reporting Code";
        PIP."Strategy Plan ID" := PerfomanceEvaluation."Strategy Plan ID";
        PIP."Personal Scorecard ID" := PerfomanceEvaluation."Personal Scorecard ID";
        PIP."Approval Status" := PIP."approval status"::Open;
        PIP."Document Date" := Today;
        PIP."Created By" := UserId();
        PIP."Created On" := Today;
        PIP.Insert(true);

        Message(PIPCreatedMsg, PIP.No, PerfomanceEvaluation."Employee Name", PerfomanceEvaluation."Final Score");
    end;

    procedure fnNewStaffPerformanceContracts(contractNo: Code[100]; employeeNo: Code[100]; description: Text;
     departmentWorkplanNo: Code[100]; hasSenior: Boolean) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        PerfomanceContractHeader1: Record "Perfomance Contract Header";
        DeptPC: Record "Perfomance Contract Header";
    begin
        // First, find the parent PC to copy plan details from
        if hasSenior then begin
            // Senior path: departmentWorkplanNo is actually the Senior Officer PC No
            PerfomanceContractHeader1.Reset;
            PerfomanceContractHeader1.SetRange(No, departmentWorkplanNo);
            if not PerfomanceContractHeader1.FindFirst then begin
                status := 'danger*Senior Officer PC ' + departmentWorkplanNo + ' not found!';
                exit;
            end;
        end else begin
            // No senior path: departmentWorkplanNo is the Annual Workplan No e.g. "0009"
            // Find the released Departmental PC that uses this workplan
            PerfomanceContractHeader1.Reset;
            PerfomanceContractHeader1.SetRange("Document Type", PerfomanceContractHeader1."document type"::"Staff Performance Contract");
            PerfomanceContractHeader1.SetRange("Score Card Type", PerfomanceContractHeader1."score card type"::Departmental);
            PerfomanceContractHeader1.SetRange(No, departmentWorkplanNo);
            PerfomanceContractHeader1.SetRange("Approval Status", PerfomanceContractHeader1."approval status"::Released);
            if not PerfomanceContractHeader1.FindFirst then begin
                status := 'danger*No released departmental PC found for workplan ' + departmentWorkplanNo;
                exit;
            end;
        end;

        // Check if contract already exists - if so, update it
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange("Responsible Employee No.", employeeNo);
        PerfomanceContractHeader.SetRange(No, contractNo);
        PerfomanceContractHeader.SetRange("Approval Status", PerfomanceContractHeader."approval status"::Open);
        PerfomanceContractHeader.SetRange("Score Card Type", PerfomanceContractHeader."score card type"::Staff);
        //PerfomanceContractHeader.SetRange("Document Type", PerfomanceContractHeader."document type"::"Staff Performance Contract");
        if PerfomanceContractHeader.FindSet then begin
            // UPDATE existing contract
            PerfomanceContractHeader.Description := description;

            // Copy plan details from parent PC
            PerfomanceContractHeader."Strategy Plan ID" := PerfomanceContractHeader1."Strategy Plan ID";
            PerfomanceContractHeader."Annual Workplan" := PerfomanceContractHeader1."Annual Workplan";
            PerfomanceContractHeader."Start Date" := PerfomanceContractHeader1."Start Date";
            PerfomanceContractHeader."End Date" := PerfomanceContractHeader1."End Date";
            PerfomanceContractHeader."Annual Reporting Code" := PerfomanceContractHeader1."Annual Reporting Code";
            PerfomanceContractHeader."Functional WorkPlan" := PerfomanceContractHeader1."Functional WorkPlan";
            PerfomanceContractHeader."CEOs PC ID" := PerfomanceContractHeader1."CEOs PC ID";
            PerfomanceContractHeader."CEO WorkPlan" := PerfomanceContractHeader1."CEO WorkPlan";
            PerfomanceContractHeader."Department/Center PC ID" := PerfomanceContractHeader1.No;

            if hasSenior then begin
                PerfomanceContractHeader."Do you have a senior?" := true;
                PerfomanceContractHeader."Senior Officer PC ID" := departmentWorkplanNo;
            end;

            if PerfomanceContractHeader.Modify(true) then
                status := 'success*Your staff performance contract was successfully updated*' +
                           PerfomanceContractHeader.No + '*' +
                           PerfomanceContractHeader."Strategy Plan ID" + '*' +
                           departmentWorkplanNo + '*' +
                           PerfomanceContractHeader."Annual Reporting Code"
            else
                status := 'danger*Your staff performance contract could not be updated, kindly try again!';
        end else begin
            // INSERT new contract
            PerfomanceContractHeader.Init;
            PerfomanceContractHeader."Document Type" := PerfomanceContractHeader."document type"::"Staff Performance Contract";
            PerfomanceContractHeader."Evaluation Type" := PerfomanceContractHeader."evaluation type"::"Standard Appraisal/Supervisor Score Only";
            PerfomanceContractHeader."Score Card Type" := PerfomanceContractHeader."score card type"::Staff;
            PerfomanceContractHeader."Responsible Employee No." := employeeNo;
            PerfomanceContractHeader.Validate("Responsible Employee No.");
            PerfomanceContractHeader.Description := description;

            // Copy plan details from parent PC
            PerfomanceContractHeader."Strategy Plan ID" := PerfomanceContractHeader1."Strategy Plan ID";
            PerfomanceContractHeader."Annual Workplan" := PerfomanceContractHeader1."Annual Workplan";
            PerfomanceContractHeader."Start Date" := PerfomanceContractHeader1."Start Date";
            PerfomanceContractHeader."End Date" := PerfomanceContractHeader1."End Date";
            PerfomanceContractHeader."Annual Reporting Code" := PerfomanceContractHeader1."Annual Reporting Code";
            PerfomanceContractHeader."Functional WorkPlan" := PerfomanceContractHeader1."Functional WorkPlan";
            PerfomanceContractHeader."CEOs PC ID" := PerfomanceContractHeader1."CEOs PC ID";
            PerfomanceContractHeader."CEO WorkPlan" := PerfomanceContractHeader1."CEO WorkPlan";
            PerfomanceContractHeader."Department/Center PC ID" := PerfomanceContractHeader1.No;

            if hasSenior then begin
                PerfomanceContractHeader."Do you have a senior?" := true;
                PerfomanceContractHeader."Senior Officer PC ID" := departmentWorkplanNo;
            end;

            if PerfomanceContractHeader.Insert(true) then begin
                FnSuggestJD(PerfomanceContractHeader.No);
                status := 'success*Your staff performance contract was successfully created*' +
                           PerfomanceContractHeader.No + '*' +
                           PerfomanceContractHeader."Strategy Plan ID" + '*' +
                           departmentWorkplanNo + '*' +
                           PerfomanceContractHeader."Annual Reporting Code"
            end else
                status := 'danger*Your staff performance contract was not created, kindly try again!';
        end;
    end;

    procedure fnNewStaffPerformanceContract(contractNo: Code[100]; employeeNo: Code[100]; description: Text; seniorOfficerPC: Code[100]; hasSenior: Boolean) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        PerfomanceContractHeader1: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange("Responsible Employee No.", employeeNo);
        PerfomanceContractHeader.SetRange(No, contractNo);
        PerfomanceContractHeader.SetRange("Approval Status", PerfomanceContractHeader."approval status"::Open);
        PerfomanceContractHeader.SetRange("Score Card Type", PerfomanceContractHeader."score card type"::Staff);
        PerfomanceContractHeader.SetRange("Document Type", PerfomanceContractHeader."document type"::"Staff Performance Contract");
        if PerfomanceContractHeader.FindSet then begin
            PerfomanceContractHeader.Description := description;
            // if hasSenior then begin
            //     PerfomanceContractHeader."Do you have a senior?" := true;
            //     PerfomanceContractHeader."Senior Officer PC ID" := seniorOfficerPC;
            // end else begin
            //     PerfomanceContractHeader."Regional PC ID" := seniorOfficerPC;
            // end;
            if hasSenior then begin
                PerfomanceContractHeader."Do you have a senior?" := true;
                PerfomanceContractHeader."Senior Officer PC ID" := seniorOfficerPC;
            end;
            PerfomanceContractHeader1.Reset;
            PerfomanceContractHeader1.SetRange(No, seniorOfficerPC);
            if PerfomanceContractHeader1.FindSet then begin
                PerfomanceContractHeader."Strategy Plan ID" := PerfomanceContractHeader1."Strategy Plan ID";
                PerfomanceContractHeader."Annual Workplan" := PerfomanceContractHeader1."Annual Workplan";
                PerfomanceContractHeader."Start Date" := PerfomanceContractHeader1."Start Date";
                PerfomanceContractHeader."End Date" := PerfomanceContractHeader1."End Date";
                PerfomanceContractHeader."Annual Reporting Code" := PerfomanceContractHeader1."Annual Reporting Code";
                PerfomanceContractHeader."Functional WorkPlan" := PerfomanceContractHeader1."Functional WorkPlan";
                PerfomanceContractHeader."CEOs PC ID" := PerfomanceContractHeader1."CEOs PC ID";
                PerfomanceContractHeader."CEO WorkPlan" := PerfomanceContractHeader1."CEO WorkPlan";
            end;
            if PerfomanceContractHeader.Modify(true) then begin
                //FnSuggestJD(PerfomanceContractHeader.No);
                status := 'success*Your staff perfomance contract was successfully created*' + PerfomanceContractHeader.No + '*' + PerfomanceContractHeader."Strategy Plan ID" + '*' + seniorOfficerPC + '*' + PerfomanceContractHeader."Annual Reporting Code";
            end else begin
                status := 'danger*Your staff perfomance contract was not created, kindly try again!';
            end;
        end else begin
            //  PerfomanceContractHeader.RESET;
            //  PerfomanceContractHeader.SETRANGE("Responsible Employee No.",employeeNo);
            //  PerfomanceContractHeader.SETRANGE("Approval Status",PerfomanceContractHeader."Approval Status"::Open);
            //  IF PerfomanceContractHeader.FINDSET THEN BEGIN
            //    ERROR:='You have an open individual performance contract, kindly re-use it!';
            //  END;
            PerfomanceContractHeader.Init;
            PerfomanceContractHeader."Document Type" := PerfomanceContractHeader."document type"::"Staff Performance Contract";
            PerfomanceContractHeader."Evaluation Type" := PerfomanceContractHeader."evaluation type"::"Standard Appraisal/Supervisor Score Only";
            PerfomanceContractHeader."Score Card Type" := PerfomanceContractHeader."score card type"::Staff;
            PerfomanceContractHeader."Responsible Employee No." := employeeNo;
            PerfomanceContractHeader.Validate("Responsible Employee No.");
            PerfomanceContractHeader.Description := description;
            // if hasSenior then begin
            //     PerfomanceContractHeader."Do you have a senior?" := true;
            //     PerfomanceContractHeader."Senior Officer PC ID" := seniorOfficerPC;
            // end else begin
            //     PerfomanceContractHeader."Regional PC ID" := seniorOfficerPC;
            // end;
            if hasSenior then begin
                PerfomanceContractHeader."Do you have a senior?" := true;
                PerfomanceContractHeader."Senior Officer PC ID" := seniorOfficerPC;
            end;
            // if type = 'HQ' then begin
            //     PerfomanceContractHeader."Senior Officer PC ID" := seniorOfficerPC;
            // end else begin
            //     PerfomanceContractHeader."Regional PC ID" := seniorOfficerPC;
            // end;
            PerfomanceContractHeader1.Reset;
            PerfomanceContractHeader1.SetRange(No, seniorOfficerPC);
            if PerfomanceContractHeader1.FindSet then begin
                PerfomanceContractHeader."Strategy Plan ID" := PerfomanceContractHeader1."Strategy Plan ID";
                PerfomanceContractHeader."Annual Workplan" := PerfomanceContractHeader1."Annual Workplan";
                PerfomanceContractHeader."Start Date" := PerfomanceContractHeader1."Start Date";
                PerfomanceContractHeader."End Date" := PerfomanceContractHeader1."End Date";
                PerfomanceContractHeader."Annual Reporting Code" := PerfomanceContractHeader1."Annual Reporting Code";
                PerfomanceContractHeader."Functional WorkPlan" := PerfomanceContractHeader1."Functional WorkPlan";
                PerfomanceContractHeader."CEOs PC ID" := PerfomanceContractHeader1."CEOs PC ID";
                PerfomanceContractHeader."CEO WorkPlan" := PerfomanceContractHeader1."CEO WorkPlan";
            end;
            if PerfomanceContractHeader.Insert(true) then begin
                FnSuggestJD(PerfomanceContractHeader.No);
                status := 'success*Your staff perfomance contract was successfully created*' + PerfomanceContractHeader.No + '*' + PerfomanceContractHeader."Strategy Plan ID" + '*' + seniorOfficerPC + '*' + PerfomanceContractHeader."Annual Reporting Code";
            end else begin
                status := 'danger*Your staff perfomance contract was not created, kindly try again!';
            end;
        end;
    end;

    procedure fnNewStaffPerformanceContract1(
    contractNo: Code[100];
    employeeNo: Code[100];
    description: Text;
    seniorOfficerPC: Code[100];
    hasSenior: Boolean
) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        PerfomanceContractHeader1: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange("Responsible Employee No.", employeeNo);
        PerfomanceContractHeader.SetRange(No, contractNo);
        PerfomanceContractHeader.SetRange("Approval Status", PerfomanceContractHeader."Approval Status"::Open);
        PerfomanceContractHeader.SetRange("Score Card Type", PerfomanceContractHeader."Score Card Type"::Staff);
        PerfomanceContractHeader.SetRange("Document Type", PerfomanceContractHeader."Document Type"::"Staff Performance Contract");

        if PerfomanceContractHeader.FindFirst then begin
            PerfomanceContractHeader.Description := description;

            // if hasSenior then begin
            //     PerfomanceContractHeader."Do you have a senior?" := true;
            //     PerfomanceContractHeader."Senior Officer PC ID" := seniorOfficerPC;
            // end else begin
            //     PerfomanceContractHeader."Regional PC ID" := seniorOfficerPC;
            // end;
            if hasSenior then begin
                PerfomanceContractHeader."Do you have a senior?" := true;
                PerfomanceContractHeader."Senior Officer PC ID" := seniorOfficerPC;
            end;
            PerfomanceContractHeader1.Reset;
            PerfomanceContractHeader1.SetRange(No, seniorOfficerPC);
            if PerfomanceContractHeader1.FindFirst then begin
                PerfomanceContractHeader."Strategy Plan ID" := PerfomanceContractHeader1."Strategy Plan ID";
                PerfomanceContractHeader."Annual Workplan" := PerfomanceContractHeader1."Annual Workplan";
                PerfomanceContractHeader."Start Date" := PerfomanceContractHeader1."Start Date";
                PerfomanceContractHeader."End Date" := PerfomanceContractHeader1."End Date";
                PerfomanceContractHeader."Annual Reporting Code" := PerfomanceContractHeader1."Annual Reporting Code";
                PerfomanceContractHeader."Functional WorkPlan" := PerfomanceContractHeader1."Functional WorkPlan";
                PerfomanceContractHeader."CEOs PC ID" := PerfomanceContractHeader1."CEOs PC ID";
                PerfomanceContractHeader."CEO WorkPlan" := PerfomanceContractHeader1."CEO WorkPlan";
            end;
            PerfomanceContractHeader.Modify(true);
            status := 'success*Your staff performance contract was successfully updated*' + PerfomanceContractHeader.No + '*' + PerfomanceContractHeader."Strategy Plan ID" + '*' + seniorOfficerPC + '*' + PerfomanceContractHeader."Annual Reporting Code";

        end else begin

            PerfomanceContractHeader.Init;
            PerfomanceContractHeader."Document Type" := PerfomanceContractHeader."Document Type"::"Staff Performance Contract";
            PerfomanceContractHeader."Evaluation Type" := PerfomanceContractHeader."Evaluation Type"::"Standard Appraisal/Supervisor Score Only";
            PerfomanceContractHeader."Score Card Type" := PerfomanceContractHeader."Score Card Type"::Staff;
            PerfomanceContractHeader."Responsible Employee No." := employeeNo;
            PerfomanceContractHeader.Validate("Responsible Employee No.");
            PerfomanceContractHeader.Description := description;

            // if hasSenior then begin
            //     PerfomanceContractHeader."Do you have a senior?" := true;
            //     PerfomanceContractHeader."Senior Officer PC ID" := seniorOfficerPC;
            // end else begin
            //     PerfomanceContractHeader."Regional PC ID" := seniorOfficerPC;
            // end;
            if hasSenior then begin
                PerfomanceContractHeader."Do you have a senior?" := true;
                PerfomanceContractHeader."Senior Officer PC ID" := seniorOfficerPC;
            end;

            // Fetch details from selected Senior Officer PC ID
            PerfomanceContractHeader1.Reset;
            PerfomanceContractHeader1.SetRange(No, seniorOfficerPC);
            if PerfomanceContractHeader1.FindFirst then begin
                PerfomanceContractHeader."Strategy Plan ID" := PerfomanceContractHeader1."Strategy Plan ID";
                PerfomanceContractHeader."Annual Workplan" := PerfomanceContractHeader1."Annual Workplan";
                PerfomanceContractHeader."Start Date" := PerfomanceContractHeader1."Start Date";
                PerfomanceContractHeader."End Date" := PerfomanceContractHeader1."End Date";
                PerfomanceContractHeader."Annual Reporting Code" := PerfomanceContractHeader1."Annual Reporting Code";
                PerfomanceContractHeader."Functional WorkPlan" := PerfomanceContractHeader1."Functional WorkPlan";
                PerfomanceContractHeader."CEOs PC ID" := PerfomanceContractHeader1."CEOs PC ID";
                PerfomanceContractHeader."CEO WorkPlan" := PerfomanceContractHeader1."CEO WorkPlan";
            end;

            PerfomanceContractHeader.Insert(true);
            FnSuggestJD(PerfomanceContractHeader.No);
            status := 'success*Your staff performance contract was successfully created*' + PerfomanceContractHeader.No + '*' + PerfomanceContractHeader."Strategy Plan ID" + '*' + seniorOfficerPC + '*' + PerfomanceContractHeader."Annual Reporting Code";
        end;
    end;


    procedure FnSubmitSelectedCoreInitiatives(strategyid: Code[100]; personalscorecardid: Code[100]; workplanNumber: Code[50]; initiativeNumber: Code[50]) status: Text
    var
        PlogLines: Record "Plog Lines";
        PerformanceDiaryLog: Record "Performance Diary Log";
        PCObjective: Record "PC Objective";
        SecondaryPCObjective: Record "Secondary PC Objective";
        PerformanceContract: Record "Perfomance Contract Header";
        PcObjective1: Record "PC Objective";
        OriginalSubActivities: Record "Sub PC Objective";
        PCSubActivities: Record "Sub PC Objective";
    begin
        PerformanceContract.Reset;
        PerformanceContract.SetRange(No, personalscorecardid);
        if PerformanceContract.FindSet then begin
            PcObjective1.Reset;
            PcObjective1.SetRange("Strategy Plan ID", strategyid);
            PcObjective1.SetRange("Workplan No.", workplanNumber);
            PcObjective1.SetRange("Outcome Perfomance Indicator", initiativeNumber);
            //PcObjective1.SetRange("Initiative No.", initiativeNumber);
            if PcObjective1.FindSet then begin
                PCObjective.Reset;
                PCObjective.SetRange("Strategy Plan ID", strategyid);
                PCObjective.SetRange("Workplan No.", personalscorecardid);
                PcObjective.SetRange("Outcome Perfomance Indicator", initiativeNumber);
                //PCObjective.SetRange("Initiative No.", initiativeNumber);
                if PCObjective.FindSet then begin
                    status := 'The selected activity already exists, kindly select another activity!';
                end;
                repeat
                    PCObjective.Init;
                    PCObjective."Workplan No." := personalscorecardid;
                    PCObjective."Strategy Plan ID" := PcObjective1."Strategy Plan ID";
                    PCObjective."Initiative Type" := PcObjective1."Initiative Type";
                    PCObjective."Outcome Perfomance Indicator" := initiativeNumber;
                    //PCObjective."Initiative No." := initiativeNumber;
                    PCObjective.Validate("Initiative No.");
                    PCObjective."Goal Template ID" := PcObjective1."Goal Template ID";
                    PCObjective."Objective/Initiative" := PcObjective1."Objective/Initiative";
                    PCObjective."Year Reporting Code" := PcObjective1."Year Reporting Code";
                    PCObjective."Primary Department" := PcObjective1."Primary Department";
                    // PCObjective."Primary Division" := PcObjective1."Primary Division";
                    PCObjective."Outcome Perfomance Indicator" := PcObjective1."Outcome Perfomance Indicator";
                    PCObjective."Unit of Measure" := PcObjective1."Unit of Measure";
                    PCObjective."Imported Annual Target Qty" := PcObjective1."Imported Annual Target Qty";
                    PCObjective."Q1 Target Qty" := PcObjective1."Q1 Target Qty";
                    PCObjective."Q2 Target Qty" := PcObjective1."Q2 Target Qty";
                    PCObjective."Q3 Target Qty" := PcObjective1."Q3 Target Qty";
                    PCObjective."Q4 Target Qty" := PcObjective1."Q4 Target Qty";
                    PCObjective."Start Date" := PerformanceContract."Start Date";
                    PCObjective."Due Date" := PerformanceContract."End Date";
                    if PCObjective.Insert(true) then begin
                        Fnsuggestsubindicators(PcObjective1."Strategy Plan ID", PcObjective1."Workplan No.", PcObjective1."Initiative No.", personalscorecardid);
                        status := 'success*success';
                    end else begin
                        status := 'danger*failed';
                    end;
                until PcObjective1.Next = 0;
            end;
        end;
    end;

    procedure Fnsuggestsubindicators(strategyid: Code[100]; docNo: Code[100]; initiativeNumber: Code[50]; No: Code[100]) status: Text
    var
        PlogLines: Record "Plog Lines";
        PerformanceDiaryLog: Record "Performance Diary Log";
        PCObjective: Record "PC Objective";
        SecondaryPCObjective: Record "Secondary PC Objective";
        PerformanceContract: Record "Perfomance Contract Header";
        PcObjective1: Record "PC Objective";
        OriginalSubActivities: Record "Sub PC Objective";
        PCSubActivities: Record "Sub PC Objective";
    begin
        OriginalSubActivities.Reset;
        OriginalSubActivities.SetRange("Workplan No.", docNo);
        OriginalSubActivities.SetRange("Initiative No.", initiativeNumber);
        OriginalSubActivities.SetRange("Strategy Plan ID", strategyid);
        if OriginalSubActivities.FindSet then begin
            Message(strategyid, docNo, initiativeNumber);
            repeat
                PCSubActivities.Init;
                PCSubActivities."Strategy Plan ID" := OriginalSubActivities."Strategy Plan ID";
                PCSubActivities."Workplan No." := No;
                PCSubActivities."Initiative No." := OriginalSubActivities."Initiative No.";
                PCSubActivities."Sub Initiative No." := OriginalSubActivities."Sub Initiative No.";
                PCSubActivities."Entry Number" := OriginalSubActivities."Entry Number";
                PCSubActivities.TransferFields(OriginalSubActivities, false);
                if PCSubActivities.Insert(true) then begin
                    status := 'success*success';
                end else begin
                    status := 'danger*failed';
                end;
            until OriginalSubActivities.Next = 0;
        end;
    end;

    procedure FnSaveCoreInitiatives(entryNumber: Integer; startdate: Datetime; enddate: DateTime; agreedTarget: Decimal; assignedweight: Decimal; comments: Text) status: Text
    var
        PcLines: Record "PC Objective";
        JobResponsiblities: Record "Job Application Table";
        PCJobDescription: Record "PC Job Description";
        PCObjective: Record "PC Objective";
        performanceContractHeader: Record "Perfomance Contract Header";
    begin
        PCObjective.Reset;
        PCObjective.SetRange(EntryNo, entryNumber);
        if PCObjective.FindSet then begin
            repeat
                PCObjective."Start Date" := Dt2date(startdate);
                PCObjective."Due Date" := DT2Date(enddate);
                PCObjective."Imported Annual Target Qty" := agreedTarget;
                PCObjective."Assigned Weight (%)" := assignedweight;
                PCObjective."Additional Comments" := comments;
                if PCObjective.Modify(true) then begin
                    status := 'success*Core Initiatives Details was successfully saved';
                end else begin
                    status := 'danger*Core Initiatives Details Was not successfully saved';
                end;
            until PCObjective.Next = 0;
        end;
    end;

    procedure FnRemoveCoreInitiatives(docNo: Code[100]; entryNumber: Integer) status: Text
    var
        PcLines: Record "PC Objective";
        JobResponsiblities: Record "Job Application Table";
        PCJobDescription: Record "PC Job Description";
        PCObjective: Record "PC Objective";
        performanceContractHeader: Record "Perfomance Contract Header";
    begin
        PCObjective.Reset;
        PCObjective.SetRange("Workplan No.", docNo);
        PCObjective.SetRange(EntryNo, entryNumber);
        if PCObjective.FindSet then begin
            if PCObjective.Delete(true) then begin
                status := 'success*Core Initiative was successfully removed';
            end else begin
                status := 'danger*Core Initiative could not be removed, kindly try again!';
            end;
        end;
    end;

    procedure fnAddNewAdditionalInitiative(
     workplanNo: Code[30];
     primaryDepartment: Code[100];
     objectiveDescription: Text[255];
     initiativeNo: Code[100];   // the KPI/activity code user selects
     outcomeIndicator: Code[100];   // Outcome Performance Indicator
     startDate: Date;
     dueDate: Date;
     agreedTarget: Decimal;
     assignedWeight: Decimal;
     comments: Text[250]
 ) result: Text
    var
        SecondaryPCObjective: Record "Secondary PC Objective";
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset();
        PerfomanceContractHeader.SetRange(No, workplanNo);
        if not PerfomanceContractHeader.FindFirst() then begin
            result := 'error*Performance contract not found: ' + workplanNo;
            exit;
        end;

        SecondaryPCObjective.Init();
        SecondaryPCObjective."Workplan No." := workplanNo;
        SecondaryPCObjective."Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
        SecondaryPCObjective."Year Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
        SecondaryPCObjective."Primary Department" := primaryDepartment;
        SecondaryPCObjective."Initiative Type" := SecondaryPCObjective."initiative type"::Activity;
        if initiativeNo <> '' then
            SecondaryPCObjective.Validate("Initiative No.", initiativeNo);
        if objectiveDescription <> '' then
            SecondaryPCObjective."Objective/Initiative" := objectiveDescription;
        SecondaryPCObjective.Validate("Outcome Perfomance Indicator", outcomeIndicator);
        SecondaryPCObjective."Imported Annual Target Qty" := agreedTarget;
        SecondaryPCObjective."Assigned Weight (%)" := assignedWeight;
        SecondaryPCObjective."Start Date" := startDate;
        SecondaryPCObjective."Due Date" := dueDate;
        SecondaryPCObjective.Comments := comments;

        // EntryNo is AutoIncrement — BC assigns on Insert
        if SecondaryPCObjective.Insert(true) then
            result := 'success*Additional initiative added*' +
                      Format(SecondaryPCObjective.EntryNo) + '*' +
                      SecondaryPCObjective."Unit of Measure" + '*' +
                      SecondaryPCObjective."Strategy Plan ID" + '*' +
                      SecondaryPCObjective."Initiative No." + '*' +
                      SecondaryPCObjective."Objective/Initiative"
        else
            result := 'error*Failed to insert additional initiative';
    end;

    procedure fnSaveAditionalInitiatives(
        entryno: Integer;
        agreedTarget: Decimal;
        assignedWeight: Decimal;
        startDate: Date;
        endDate: Date;
        comments: Text[250];
        outcomeIndicator: Code[100]
    ) status: Text
    var
        SecondaryPCObjective: Record "Secondary PC Objective";
    begin
        SecondaryPCObjective.Reset();
        SecondaryPCObjective.SetRange(EntryNo, entryno);
        if not SecondaryPCObjective.FindFirst() then begin
            status := 'danger*Entry not found: ' + Format(entryno);
            exit;
        end;

        if (outcomeIndicator <> '') and
           (outcomeIndicator <> SecondaryPCObjective."Outcome Perfomance Indicator") then
            SecondaryPCObjective.Validate("Outcome Perfomance Indicator", outcomeIndicator);

        SecondaryPCObjective."Imported Annual Target Qty" := agreedTarget;
        SecondaryPCObjective."Assigned Weight (%)" := assignedWeight;
        SecondaryPCObjective."Start Date" := startDate;
        SecondaryPCObjective."Due Date" := endDate;
        SecondaryPCObjective.Comments := comments;

        if SecondaryPCObjective.Modify(true) then
            status := 'success*Additional initiative saved successfully'
        else
            status := 'danger*Failed to save additional initiative';
    end;

    procedure fnRemoveAditionalInitiative(docNo: Code[100]; entryno: Integer) status: Text
    var
        SecondaryPCObjective: Record "Secondary PC Objective";
    begin
        SecondaryPCObjective.Reset();
        SecondaryPCObjective.SetRange("Workplan No.", docNo);
        SecondaryPCObjective.SetRange(EntryNo, entryno);
        if SecondaryPCObjective.FindFirst() then begin
            if SecondaryPCObjective.Delete(true) then
                status := 'success*Additional initiative removed successfully'
            else
                status := 'danger*Could not remove additional initiative';
        end else
            status := 'danger*Entry not found';
    end;

    procedure FnDeleteIndividualCardSubActivities(empNo: Text[30]; scorecardNumber: Code[100]; ActivityNo: Text; EntryNumber: Integer) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        PerformanceDiaryLog: Record "Performance Diary Log";
        SubPCObjective: Record "Sub PC Objective";
    begin
        SubPCObjective.Reset;
        SubPCObjective.SetRange("Workplan No.", scorecardNumber);
        SubPCObjective.SetRange("Initiative No.", ActivityNo);
        SubPCObjective.SetRange("Entry Number", EntryNumber);
        if SubPCObjective.FindSet then begin
            if SubPCObjective.Delete(true) then begin
                status := 'success* Staff Performance Appraisal Form Sub Activities was successfully Removed';
            end else begin
                status := 'danger* Staff Performance Appraisal Form Sub Activities was not  Removed';
            end;
        end;
    end;

    procedure FnNewIndividualCardSubActivities(scorecardNumber: Code[100]; ActivityNo: Text; subinitiative: Text; subindicator: Text; uom: Text; targets: Integer; completiondate: Date; assweight: Decimal) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        PerformanceDiaryLog: Record "Performance Diary Log";
        SubPCObjective: Record "Sub PC Objective";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, scorecardNumber);
        if PerfomanceContractHeader.FindSet then begin
            SubPCObjective.Init;
            SubPCObjective."Workplan No." := scorecardNumber;
            SubPCObjective."Initiative No." := ActivityNo;
            SubPCObjective."Objective/Initiative" := subinitiative;
            SubPCObjective."Outcome Perfomance Indicator" := subindicator;
            SubPCObjective."Unit of Measure" := uom;
            SubPCObjective."Imported Annual Target Qty" := targets;
            SubPCObjective."Due Date" := completiondate;
            SubPCObjective."Assigned Weight (%)" := assweight;
            SubPCObjective."Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
            SubPCObjective."Year Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
            if SubPCObjective.Insert(true) then begin
                status := 'success* Staff Performance Appraisal Form Sub Activities was successfully  submitted';
            end else begin
                status := 'danger* Staff Performance Appraisal Form Sub Activities was not  submitted';
            end;
        end;
    end;

    procedure FnEditIndividualCardSubActivities(scorecardNumber: Code[100]; ActivityNo: Text; lineno: Integer; subinitiative: Text; subindicator: Text; uom: Text; targets: Integer; completiondate: Date; agreedweight: Decimal) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        PerformanceDiaryLog: Record "Performance Diary Log";
        SubPCObjective: Record "Sub PC Objective";
    begin
        SubPCObjective.Reset;
        SubPCObjective.SetRange("Workplan No.", scorecardNumber);
        SubPCObjective.SetRange("Initiative No.", ActivityNo);
        SubPCObjective.SetRange("Entry Number", lineno);
        if SubPCObjective.FindSet then begin
            SubPCObjective."Objective/Initiative" := subinitiative;
            SubPCObjective."Outcome Perfomance Indicator" := subindicator;
            SubPCObjective."Unit of Measure" := uom;
            SubPCObjective."Imported Annual Target Qty" := targets;
            SubPCObjective."Due Date" := completiondate;
            SubPCObjective."Assigned Weight (%)" := agreedweight;
            if SubPCObjective.Modify(true) then begin
                status := 'success* Staff Performance Appraisal Form Sub Activities was successfully updated';
            end else begin
                status := 'danger* Staff Performance Appraisal Form Sub Activities was not updated';
            end;
        end;
    end;

    procedure fnSendStaffPerformanceContractApproval(contractNo: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, contractNo);
        PerfomanceContractHeader.SetRange("Approval Status", PerfomanceContractHeader."approval status"::Open);
        if PerfomanceContractHeader.FindSet then begin
            PerfomanceContractHeader."Approval Status" := PerfomanceContractHeader."approval status"::"Pending Approval";
            if PerfomanceContractHeader.Modify(true) then begin
                status := 'success*Your staff perfomance contract was successfully send for approval*';
            end else begin
                status := 'danger*Your staff perfomance contract was not send for approval, kindly try again!';
            end;
        end;
    end;

    procedure fnCancelStaffPerformanceContract(contractNo: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, contractNo);
        PerfomanceContractHeader.SetRange("Approval Status", PerfomanceContractHeader."approval status"::"Pending Approval");
        if PerfomanceContractHeader.FindSet then begin
            PerfomanceContractHeader."Approval Status" := PerfomanceContractHeader."approval status"::Open;
            if PerfomanceContractHeader.Modify(true) then begin
                status := 'success*Approval for staff perfomance contract was successfully cancelled*';
            end else begin
                status := 'danger*Approval for staff perfomance contract was not cancelled, kindly try again!';
            end;
        end;
    end;

    procedure fnLockStaffPerformanceContract(contractNo: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, contractNo);
        PerfomanceContractHeader.SetRange("Approval Status", PerfomanceContractHeader."approval status"::Released);
        if PerfomanceContractHeader.FindSet then begin
            PerfomanceContractHeader."Change Status" := PerfomanceContractHeader."change status"::Locked;
            if PerfomanceContractHeader.Modify(true) then begin
                status := 'success*The perfomance contract was successfully locked, kindy proceed to sign*';
            end else begin
                status := 'danger*The perfomance contract was not locked, kindly try again!';
            end;
        end;
    end;

    procedure fnSignStaffPerformanceContract(contractNo: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, contractNo);
        PerfomanceContractHeader.SetRange("Approval Status", PerfomanceContractHeader."approval status"::Released);
        PerfomanceContractHeader.SetRange("Change Status", PerfomanceContractHeader."change status"::Locked);
        if PerfomanceContractHeader.FindSet then begin
            PerfomanceContractHeader.Status := PerfomanceContractHeader.Status::Signed;
            if PerfomanceContractHeader.Modify(true) then begin
                status := 'success*The perfomance contract was successfully signed*';
            end else begin
                status := 'danger*The perfomance contract was not signed, kindly try again!';
            end;
        end else begin
            status := 'danger*You must lock the performance contract before signing!!';
        end;
        exit(status)
    end;

    procedure FnSubmitSelectedPLogCategories(strategyid: Code[100]; personalscorecardid: Code[100]; plogNumber: Code[50]; initiativeNumber: Code[50]) status: Text
    var
        PlogLines: Record "Plog Lines";
        PerformanceDiaryLog: Record "Performance Diary Log";
        PCObjective: Record "PC Objective";
        SecondaryPCObjective: Record "Secondary PC Objective";
    begin
        PerformanceDiaryLog.Reset;
        PerformanceDiaryLog.SetRange(No, plogNumber);
        if PerformanceDiaryLog.FindSet then begin
            PCObjective.Reset;
            PCObjective.SetRange("Strategy Plan ID", PerformanceDiaryLog."CSP ID");
            PCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
            PCObjective.SetRange("Initiative No.", initiativeNumber);
            if PCObjective.FindSet then begin
                repeat
                    PlogLines.Init;
                    PlogLines."PLog No." := PerformanceDiaryLog.No;
                    PlogLines."Activity Type" := PlogLines."activity type"::"Primary Activity";
                    PlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                    PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                    PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                    PlogLines."Initiative No." := PCObjective."Initiative No.";
                    PlogLines.Validate("Initiative No.");
                    PlogLines."Sub Intiative No" := PCObjective."Objective/Initiative";
                    PlogLines.Description := PCObjective."Objective/Initiative";
                    if PlogLines.Insert(true) then begin
                        status := 'success*The PlogLines was successfully submitted';
                    end else begin
                        status := 'danger*The PlogLines was successfully submitted';
                    end;
                until PCObjective.Next = 0;
            end;
        end;
    end;

    procedure FnNewPerformanceLogEntry(docNo: Code[100]; empNo: Text[30]; scorecardNumber: Code[100]; description: Text; quarter: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        PerformanceDiaryLog: Record "Performance Diary Log";
    begin
        PerformanceDiaryLog.Reset;
        PerformanceDiaryLog.SetRange("Employee No.", empNo);
        PerformanceDiaryLog.SetRange(No, docNo);
        PerformanceDiaryLog.SetRange("Approval Status", PerformanceDiaryLog."approval status"::Open);
        PerformanceDiaryLog.SetRange(Posted, false);
        if PerformanceDiaryLog.FindSet then begin
            PerformanceDiaryLog."Personal Scorecard ID" := scorecardNumber;
            PerformanceDiaryLog.Validate("Personal Scorecard ID");
            PerformanceDiaryLog."Reporting Quater Code" := quarter;
            //PerformanceDiaryLog.Validate("Reporting Quater Code");
            PerformanceDiaryLog.Description := description;
            if PerformanceDiaryLog.Modify(true) then begin
                ;
                //FnSuggestPlogLines(PerformanceDiaryLog.No,PerformanceDiaryLog."CSP ID",scorecardNumber,empNo);
                //fnSuggestPlogandSubPlogData(PerformanceDiaryLog.No);
                status := 'success* Performance Diary Logs was successfully updated*' + PerformanceDiaryLog.No + '*' + PerformanceDiaryLog."CSP ID" + '*' + PerformanceDiaryLog."Personal Scorecard ID";
            end else begin
                status := 'danger* Performance Diary Logs Was not successfully updated*' + PerformanceDiaryLog.No;
            end;
        end else begin
            //---//
            //  PerformanceDiaryLog.RESET;
            //  PerformanceDiaryLog.SETRANGE("Employee No.",empNo);
            //  PerformanceDiaryLog.SETRANGE("Approval Status",PerformanceDiaryLog."Approval Status"::Open);
            //  IF PerformanceDiaryLog.FINDSET THEN BEGIN
            //    ERROR:='You have an open performance log, kindly re-use it!';
            //  END;
            PerformanceDiaryLog.Init;
            PerformanceDiaryLog."Employee No." := empNo;
            PerformanceDiaryLog.Validate("Employee No.");
            PerformanceDiaryLog."Personal Scorecard ID" := scorecardNumber;
            PerformanceDiaryLog.Validate("Personal Scorecard ID");
            PerformanceDiaryLog.Description := description;
            PerformanceDiaryLog."Approval Status" := PerformanceDiaryLog."approval status"::Open;
            if PerformanceDiaryLog.Insert(true) then begin
                fnSuggestPlogandSubPlogData(PerformanceDiaryLog.No);
                status := 'success* Performance Diary Logs was successfully submitted*' + PerformanceDiaryLog.No;
            end else begin
                status := 'danger* Performance Diary Logs was not successfully submitted*';
            end;
        end;
    end;

    // procedure fnGetPlogLines(docNo: Code[100]; empNo: Code[100]) PlogData: Text
    // var
    //     PlogLines: Record "Plog Lines";
    // begin
    //     PlogLines.Reset;
    //     PlogLines.SetRange("PLog No.", docNo);
    //     PlogLines.SetRange("Employee No.", empNo);
    //     if PlogLines.FindSet then begin
    //         repeat
    //             PlogData := PlogData + Format(PlogLines.EntryNo) + '*' + Format(PlogLines."PLog No.") + '*' + Format(PlogLines."Initiative No.") + '*' + Format(PlogLines."Personal Scorecard ID") + '*' + Format(PlogLines."Sub Intiative No") + '*' +
    //             Format(PlogLines."Weight %") + '*' + Format(PlogLines."Achieved Date") + '*' + Format(PlogLines."Target Qty") + '*' + Format(PlogLines."Q1 Achieved Target") + '*' + Format(PlogLines."Q2 Achieved Target") + '*' +
    //             Format(PlogLines."Q3 AchievedTarget") + '*' + Format(PlogLines."Q4 Achieved Target") + '*' + Format(PlogLines."Achieved Target") + '*' + Format(PlogLines.Comments) + '*' + Format(PlogLines."Achieved Weight(%)") + ':';
    //         until PlogLines.Next = 0;
    //     end;
    //     exit(PlogData)
    // end;

    // procedure fnGetSubPlogLines(plogNo: Code[100]; initiativeNo: Code[100]; pcNo: Code[100]) PlogData: Text
    // var
    //     SubPlogLines: Record "Sub Plog Lines";
    // begin
    //     SubPlogLines.Reset;
    //     SubPlogLines.SetRange("PLog No.", plogNo);
    //     SubPlogLines.SetRange("Initiative No.", initiativeNo);
    //     SubPlogLines.SetRange("Personal Scorecard ID", pcNo);
    //     if SubPlogLines.FindSet then begin
    //         repeat
    //             PlogData := PlogData + Format(SubPlogLines.EntryNo) + '*' + Format(SubPlogLines.Description) + '*' + Format(SubPlogLines."Achieved Date") + '*' + Format(SubPlogLines."Target Qty") + '*' + Format(SubPlogLines."Achieved Target") + '*' +
    //             Format(SubPlogLines.Comments) + '*' + Format(SubPlogLines."Weight %") + ':';
    //         until SubPlogLines.Next = 0;
    //     end;
    //     exit(PlogData)
    // end;

    procedure FnSuggestPlogLines(docNo: Code[100]; strategyid: Code[100]; personalscorecardid: Code[100]; empNumber: Code[100]) status: Text
    var
        PlogLines: Record "Plog Lines";
        PerformanceDiaryLog: Record "Performance Diary Log";
        PCObjective: Record "PC Objective";
        SecondaryPCObjective: Record "Secondary PC Objective";
        StrategicInitiative: Record "PC Objective";
    begin
        PerformanceDiaryLog.Reset;
        PerformanceDiaryLog.SetFilter(No, '<>%1', '');
        PerformanceDiaryLog.SetRange(No, docNo);
        PerformanceDiaryLog.SetRange("Employee No.", empNumber);
        PerformanceDiaryLog.SetRange("Personal Scorecard ID", personalscorecardid);
        PerformanceDiaryLog.SetRange("CSP ID", strategyid);
        if PerformanceDiaryLog.FindSet then begin
            PerformanceDiaryLog.TestField("Employee No.");
            PerformanceDiaryLog.TestField("Personal Scorecard ID");
            PerformanceDiaryLog.TestField("Activity Start Date");
            PerformanceDiaryLog.TestField("Activity End Date");
            PCObjective.Reset;
            PCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
            PCObjective.SetRange("Strategy Plan ID", PerformanceDiaryLog."CSP ID");
            if PCObjective.FindSet then begin
                repeat
                    PlogLines.Init;
                    PlogLines."PLog No." := PerformanceDiaryLog.No;
                    PlogLines."Initiative No." := PCObjective."Initiative No.";
                    PlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                    PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                    PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                    PlogLines."Activity Type" := PlogLines."activity type"::"Primary Activity";
                    PlogLines.Validate("Initiative No.");
                    if PlogLines.Insert(true) then begin
                        status := 'success*The PlogLines was successfully submitted';
                    end else begin
                        status := 'danger*The PlogLines was not successfully submitted';
                    end;
                until PCObjective.Next = 0;
            end;
        end;
        SecondaryPCObjective.Reset;
        SecondaryPCObjective.SetRange("Strategy Plan ID", strategyid);
        SecondaryPCObjective.SetRange("Workplan No.", personalscorecardid);
        if SecondaryPCObjective.FindFirst then begin
            repeat
                PlogLines.Init;
                PlogLines."PLog No." := PerformanceDiaryLog.No;
                PlogLines."Activity Type" := PlogLines."activity type"::"Secondary Activity";
                PlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                PlogLines."Initiative No." := SecondaryPCObjective."Initiative No.";
                PlogLines.Validate("Initiative No.");
                if PlogLines.Insert(true) then begin
                    status := 'success*The PlogLines was successfully submitted';
                end else begin
                    status := 'danger*The PlogLines was not successfully submitted';
                end;
            until SecondaryPCObjective.Next = 0;
        end;
    end;

    procedure fnSuggestPlogandSubPlogData(docNo: Code[100])
    var
        PerformanceDiaryLog: Record "Performance Diary Log";
        PlogLines: Record "Plog Lines";
        PCObjective: Record "PC Objective";
        SecondaryPCObjective: Record "Secondary PC Objective";
        SubPlogLines: Record "Sub Plog Lines";
        SubPCObjective: Record "Sub PC Objective";
        SPMGeneralSetup: Record "SPM General Setup";
        PCJobDescription: Record "PC Job Description";
        SubJDObjective: Record "Sub JD Objective";
    begin
        // PerformanceDiaryLog.TESTFIELD("Employee No.");
        // PerformanceDiaryLog.TESTFIELD("Personal Scorecard ID");
        // PerformanceDiaryLog.TESTFIELD("Activity Start Date");
        // PerformanceDiaryLog.TESTFIELD("Activity End Date");
        PerformanceDiaryLog.Reset;
        PerformanceDiaryLog.SetRange(No, docNo);
        if PerformanceDiaryLog.FindSet then begin
            SPMGeneralSetup.Get();
            if (SPMGeneralSetup."Allow Loading of  CSP" = true) then begin
                PCObjective.Reset;
                PCObjective.SetRange("Strategy Plan ID", PerformanceDiaryLog."CSP ID");
                PCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                PCObjective.SetRange("Due Date", PerformanceDiaryLog."Activity Start Date", PerformanceDiaryLog."Activity End Date");//Commented for Kerra
                if PCObjective.FindSet then begin
                    repeat
                        PCObjective.CalcFields("Individual Achieved Targets");
                        PCObjective.TestField("Due Date");
                        //PCObjective.TESTFIELD("Imported Annual Target Qty");
                        PlogLines.Init;
                        PlogLines."PLog No." := PerformanceDiaryLog.No;
                        PlogLines."Activity Type" := PlogLines."activity type"::"Primary Activity";
                        PlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                        PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                        PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                        PlogLines."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                        //PlogLines."Key Performance Indicator":=PCObjective."Outcome Perfomance Indicator";
                        PlogLines."Initiative No." := PCObjective."Initiative No.";
                        PlogLines."Unit of Measure" := PCObjective."Unit of Measure";
                        //MESSAGE('PCObjective."Assigned Weight (%)" is %1',PCObjective."Assigned Weight (%)");
                        PlogLines."Weight %" := PCObjective."Assigned Weight (%)";
                        PlogLines.Validate("Initiative No.");
                        PlogLines."Remaining Targets" := PCObjective."Imported Annual Target Qty" - PCObjective."Individual Achieved Targets";
                        PlogLines.Insert;

                        //Sub Activities
                        SubPCObjective.Reset;
                        SubPCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                        SubPCObjective.SetRange("Initiative No.", PCObjective."Initiative No.");
                        if SubPCObjective.FindSet then begin
                            repeat
                                SubPlogLines.Init;
                                SubPlogLines."PLog No." := PerformanceDiaryLog.No;
                                SubPlogLines."Activity Type" := SubPlogLines."activity type"::"Primary Activity";
                                SubPlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                                SubPlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                                SubPlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                                SubPlogLines."Initiative No." := SubPCObjective."Initiative No.";
                                SubPlogLines."Sub Activity No." := SubPCObjective."Outcome Perfomance Indicator";
                                SubPlogLines.Description := SubPCObjective."Objective/Initiative";
                                SubPlogLines."Sub Activity No." := SubPCObjective."Sub Initiative No.";
                                SubPlogLines."Unit of Measure" := SubPCObjective."Unit of Measure";
                                SubPlogLines."Planned Date" := SubPCObjective."Due Date";
                                SubPlogLines."Target Qty" := SubPCObjective."Imported Annual Target Qty";
                                SubPlogLines."Weight %" := SubPCObjective."Assigned Weight (%)";
                                //SubPlogLines.VALIDATE("Initiative No.");
                                //SubPlogLines."Remaining Targets":=SubPCObjective."Imported Annual Target Qty"- SubPCObjective."Individual Achieved Targets";
                                if not SubPlogLines.Get(SubPlogLines."PLog No.", SubPlogLines."Initiative No.", SubPlogLines."Sub Activity No.", SubPlogLines."Personal Scorecard ID") then
                                    SubPlogLines.Insert(true);
                            until SubPCObjective.Next = 0;
                        end;

                    until PCObjective.Next = 0;
                end;

                SecondaryPCObjective.Reset;
                SecondaryPCObjective.SetRange("Strategy Plan ID", PerformanceDiaryLog."CSP ID");
                SecondaryPCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                SecondaryPCObjective.SetRange("Due Date", PerformanceDiaryLog."Activity Start Date", PerformanceDiaryLog."Activity End Date");
                if SecondaryPCObjective.FindFirst then begin
                    repeat
                        SecondaryPCObjective.CalcFields("Individual Achieved Targets");
                        SecondaryPCObjective.TestField("Due Date");
                        //SecondaryPCObjective.TESTFIELD("Imported Annual Target Qty");
                        PlogLines.Init;
                        PlogLines."PLog No." := PerformanceDiaryLog.No;
                        PlogLines."Activity Type" := PlogLines."activity type"::"Secondary Activity";
                        PlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                        PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                        PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                        PlogLines."Initiative No." := SecondaryPCObjective."Initiative No.";
                        //MESSAGE('SecondaryPCObjective."Assigned Weight (%)" is %1',SecondaryPCObjective."Assigned Weight (%)");
                        PlogLines."Weight %" := SecondaryPCObjective."Assigned Weight (%)";
                        PlogLines.Validate("Initiative No.");
                        PlogLines."Remaining Targets" := PCObjective."Imported Annual Target Qty" - PCObjective."Individual Achieved Targets";
                        PlogLines.Insert;

                        //Sub Activities
                        SubPCObjective.Reset;
                        SubPCObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                        SubPCObjective.SetRange("Initiative No.", SecondaryPCObjective."Initiative No.");
                        if SubPCObjective.FindSet then begin
                            repeat
                                SubPlogLines.Init;
                                SubPlogLines."PLog No." := PerformanceDiaryLog.No;
                                SubPlogLines."Activity Type" := SubPlogLines."activity type"::"Primary Activity";
                                SubPlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                                SubPlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                                SubPlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                                SubPlogLines."Initiative No." := SubPCObjective."Initiative No.";
                                SubPlogLines."Sub Activity No." := SubPCObjective."Outcome Perfomance Indicator";
                                SubPlogLines.Description := SubPCObjective."Objective/Initiative";
                                SubPlogLines."Sub Activity No." := SubPCObjective."Sub Initiative No.";
                                SubPlogLines."Unit of Measure" := SubPCObjective."Unit of Measure";
                                SubPlogLines."Planned Date" := SubPCObjective."Due Date";
                                SubPlogLines."Target Qty" := SubPCObjective."Imported Annual Target Qty";
                                SubPlogLines."Weight %" := SubPCObjective."Assigned Weight (%)";
                                //SubPlogLines.VALIDATE("Initiative No.");
                                //SubPlogLines."Remaining Targets":=SubPCObjective."Imported Annual Target Qty"- SubPCObjective."Individual Achieved Targets";
                                if not SubPlogLines.Get(SubPlogLines."PLog No.", SubPlogLines."Initiative No.", SubPlogLines."Sub Activity No.", SubPlogLines."Personal Scorecard ID") then
                                    SubPlogLines.Insert(true);
                            until SubPCObjective.Next = 0;
                        end;
                    until SecondaryPCObjective.Next = 0;
                end;
            end;

            if (SPMGeneralSetup."Allow Loading of JD" = true) then begin
                PCJobDescription.Reset;
                PCJobDescription.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                PCJobDescription.SetRange("Due Date", PerformanceDiaryLog."Activity Start Date", PerformanceDiaryLog."Activity End Date");
                if PCJobDescription.FindFirst then begin
                    repeat
                        PCJobDescription.CalcFields("Individual Achieved Targets");
                        PCJobDescription.TestField("Due Date");
                        //PCJobDescription.TESTFIELD("Imported Annual Target Qty");
                        PlogLines.Init;
                        PlogLines."PLog No." := PerformanceDiaryLog.No;
                        PlogLines."Activity Type" := PlogLines."activity type"::"JD Activity";
                        PlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                        PlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                        PlogLines."Initiative No." := Format(PCJobDescription."Line Number");
                        PlogLines."Sub Intiative No" := PCJobDescription.Description;
                        PlogLines."Planned Date" := PCJobDescription."Start Date";
                        PlogLines."Achieved Date" := PerformanceDiaryLog."Document Date";
                        PlogLines."Due Date" := PCJobDescription."Due Date";
                        PlogLines."Target Qty" := PCJobDescription."Imported Annual Target Qty";
                        PlogLines."Weight %" := PCJobDescription."Assigned Weight (%)";
                        PlogLines."Remaining Targets" := PCJobDescription."Imported Annual Target Qty" - PCJobDescription."Individual Achieved Targets";
                        PlogLines.Insert;
                        //Sub JD Plog Lines
                        SubJDObjective.Reset;
                        SubJDObjective.SetRange("Workplan No.", PerformanceDiaryLog."Personal Scorecard ID");
                        SubJDObjective.SetRange("Line Number", PCJobDescription."Line Number");
                        if SubJDObjective.FindSet then begin
                            repeat
                                SubPlogLines.Init;
                                SubPlogLines."PLog No." := PerformanceDiaryLog.No;
                                SubPlogLines."Activity Type" := SubPlogLines."activity type"::"JD Activity";
                                SubPlogLines."Strategy Plan ID" := PerformanceDiaryLog."CSP ID";
                                SubPlogLines."Personal Scorecard ID" := PerformanceDiaryLog."Personal Scorecard ID";
                                SubPlogLines."Employee No." := PerformanceDiaryLog."Employee No.";
                                SubPlogLines."Initiative No." := SubJDObjective."Line Number";
                                SubPlogLines."Sub Activity No." := SubJDObjective."Sub Initiative No.";
                                SubPlogLines.Description := SubJDObjective.Description;
                                SubPlogLines."Unit of Measure" := SubJDObjective."Unit of Measure";
                                SubPlogLines."Planned Date" := SubJDObjective."Due Date";
                                SubPlogLines."Target Qty" := SubJDObjective."Imported Annual Target Qty";
                                SubPlogLines."Due Date" := SubJDObjective."Due Date";
                                if not SubPlogLines.Get(SubPlogLines."PLog No.", SubPlogLines."Initiative No.", SubPlogLines."Sub Activity No.", SubPlogLines."Personal Scorecard ID") then
                                    SubPlogLines.Insert(true);
                            until SubJDObjective.Next = 0;
                        end;
                    until PCJobDescription.Next = 0;
                end;
            end;
        end;
    end;

    procedure FnUpdatePerformanceTargetLinesDetails(docNo: Code[100]; entryNumber: Integer; agreedTarget: Decimal; comments: Text) status: Text
    var
        PcLines: Record "PC Objective";
        JobResponsiblities: Record "Job Application Table";
        PCJobDescription: Record "PC Job Description";
        PCObjective: Record "PC Objective";
        performanceContractHeader: Record "Perfomance Contract Header";
        PlogLines: Record "Plog Lines";
    begin
        PlogLines.Reset;
        PlogLines.SetRange(EntryNo, entryNumber);
        PlogLines.SetRange("PLog No.", docNo);
        if PlogLines.FindSet then begin
            PlogLines."Achieved Target" := agreedTarget;
            PlogLines.Comments := comments;
            if PlogLines.Modify(true) then begin
                status := 'success*Performance Target Details was successfully updated';
            end else begin
                status := 'danger*Performance Target Details Was not successfully updated';
            end;
        end;
    end;

    procedure FnRemovePerformanceLogLine(docNo: Code[100]; entryNumber: Integer) status: Text
    var
        PcLines: Record "PC Objective";
        JobResponsiblities: Record "Job Application Table";
        PCJobDescription: Record "PC Job Description";
        PCObjective: Record "PC Objective";
        performanceContractHeader: Record "Perfomance Contract Header";
        PlogLines: Record "Plog Lines";
    begin
        PlogLines.Reset;
        PlogLines.SetRange(EntryNo, entryNumber);
        PlogLines.SetRange("PLog No.", docNo);
        if PlogLines.FindSet then begin
            if PlogLines.Delete(true) then begin
                status := 'success*Performance update line was successfully removed';
            end else begin
                status := 'danger*Performance update line was not removed, kindly try again!!';
            end;
        end;
    end;

    procedure fnInsertPlogSubActivities(entryNo: Integer; plogno: Code[100]; initiativeno: Code[100]; pcid: Code[100]; achievedtarget: Decimal; comments: Text) status: Text
    var
        SubPlogLines: Record "Sub Plog Lines";
        PlogLines: Record "Plog Lines";
        SubPlogLines1: Record "Sub Plog Lines";
        TotalTarget: Decimal;
        TotalWeight: Decimal;
    begin
        SubPlogLines.Reset;
        SubPlogLines.SetRange(EntryNo, entryNo);
        SubPlogLines.SetRange("PLog No.", plogno);
        SubPlogLines.SetRange("Initiative No.", initiativeno);
        SubPlogLines.SetRange("Personal Scorecard ID", pcid);
        if SubPlogLines.FindSet then begin
            SubPlogLines."Achieved Target" := achievedtarget;
            SubPlogLines.Comments := comments;
            if SubPlogLines.Modify(true) then begin
                PlogLines.Reset;
                PlogLines.SetRange("PLog No.", plogno);
                PlogLines.SetRange("Initiative No.", initiativeno);
                if PlogLines.FindSet then begin
                    //      SubPlogLines.RESET;
                    //      SubPlogLines.SETRANGE("PLog No.",PlogLines."PLog No.");
                    //      SubPlogLines.SETRANGE("Employee No.",PlogLines."Employee No.");
                    //      SubPlogLines.SETRANGE("Personal Scorecard ID",PlogLines."Personal Scorecard ID");
                    //      SubPlogLines.SETRANGE("Strategy Plan ID",PlogLines."Strategy Plan ID");
                    //      SubPlogLines.SETRANGE("Initiative No.",PlogLines."Initiative No.");
                    //      SubPlogLines.CALCSUMS("Target Qty");
                    //      IF SubPlogLines."Target Qty">PlogLines."Target Qty" THEN
                    //         ERROR('Total Sub Activity Targets %1 should be equal to Activity Target %2 ',
                    //               SubPlogLines."Target Qty",PlogLines."Target Qty");


                    SubPlogLines.Reset;
                    SubPlogLines.SetRange("PLog No.", PlogLines."PLog No.");
                    SubPlogLines.SetRange("Employee No.", PlogLines."Employee No.");
                    SubPlogLines.SetRange("Personal Scorecard ID", PlogLines."Personal Scorecard ID");
                    SubPlogLines.SetRange("Strategy Plan ID", PlogLines."Strategy Plan ID");
                    SubPlogLines.SetRange("Initiative No.", PlogLines."Initiative No.");
                    SubPlogLines.CalcSums("Achieved Target");

                    PlogLines."Achieved Target" := SubPlogLines."Achieved Target";
                    TotalWeight := ((PlogLines."Achieved Target" / PlogLines."Target Qty") * 100) * (PlogLines."Weight %" / 100);
                    if TotalWeight > PlogLines."Weight %" then
                        TotalWeight := PlogLines."Weight %";

                    PlogLines."Achieved Weight(%)" := TotalWeight;
                    PlogLines.Modify(true);
                end;
                status := 'success*The plog sub activity has been saved successfully';
            end else begin
                status := 'danger*The plog sub activity was not saved successfully, kindly try again!';
            end;
        end;
    end;

    procedure fnSendPlogApproval(contractNo: Code[100]) status: Text
    var
        PerformanceDiaryLog: Record "Performance Diary Log";
    begin
        PerformanceDiaryLog.Reset;
        PerformanceDiaryLog.SetRange(No, contractNo);
        PerformanceDiaryLog.SetRange("Approval Status", PerformanceDiaryLog."approval status"::Open);
        if PerformanceDiaryLog.FindSet then begin
            PerformanceDiaryLog."Approval Status" := PerformanceDiaryLog."approval status"::"Pending Approval";
            if PerformanceDiaryLog.Modify(true) then begin
                status := 'success*Your performance update was successfully send for approval*';
            end else begin
                status := 'danger*Your performance update was not send for approval, kindly try again!';
            end;
        end else begin
            status := 'danger*Sorry, you have already sent your performance diary for approval.';
        end;
    end;

    procedure fnCancelPlogApproval(contractNo: Code[100]) status: Text
    var
        PerformanceDiaryLog: Record "Performance Diary Log";
    begin
        PerformanceDiaryLog.Reset;
        PerformanceDiaryLog.SetRange(No, contractNo);
        PerformanceDiaryLog.SetRange("Approval Status", PerformanceDiaryLog."approval status"::"Pending Approval");
        if PerformanceDiaryLog.FindSet then begin
            PerformanceDiaryLog."Approval Status" := PerformanceDiaryLog."approval status"::Open;
            if PerformanceDiaryLog.Modify(true) then begin
                status := 'success*Approval for performance update was successfully cancelled*';
            end else begin
                status := 'danger*Approval for performance update was not cancelled, kindly try again!';
            end;
        end;
    end;

    procedure FnNewStandardAppraisal(docNo: Code[100]; empNo: Code[100]; strategicPlan: Code[100]; Pmp: Code[100]; Tasks: Code[100]; supervisor: Code[100]; description: Text; personalSC: Code[100]) status: Text
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        if Pmp = '' then Pmp := '0002';
        if Tasks = '' then Tasks := '001';
        if strategicPlan = '' then begin
            PerfomanceContractHeader.Reset();
            PerfomanceContractHeader.SetRange(No, personalSC);
            if PerfomanceContractHeader.FindFirst() then
                strategicPlan := PerfomanceContractHeader."Strategy Plan ID";
        end;

        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        PerfomanceEvaluation.SetRange("Employee No.", empNo);
        PerfomanceEvaluation.SetRange("Approval Status", PerfomanceEvaluation."approval status"::Open);
        if PerfomanceEvaluation.FindSet then begin
            PerfomanceEvaluation."Document Type" := PerfomanceEvaluation."document type"::"Performance Appraisal";
            PerfomanceEvaluation."Evaluation Type" := PerfomanceEvaluation."evaluation type"::"Self-Appraisal with Supervisor Score";
            PerfomanceEvaluation."Strategy Plan ID" := strategicPlan;
            PerfomanceEvaluation.Validate("Strategy Plan ID");
            PerfomanceEvaluation."Performance Mgt Plan ID" := Pmp;
            PerfomanceEvaluation.Validate("Performance Mgt Plan ID");
            PerfomanceEvaluation."Performance Task ID" := Tasks;
            PerfomanceEvaluation.Validate("Performance Task ID");
            PerfomanceEvaluation."Personal Scorecard ID" := personalSC;
            PerfomanceEvaluation.Validate("Personal Scorecard ID");
            PerfomanceEvaluation."Immediate Supervisor No." := supervisor;
            PerfomanceEvaluation.Validate("Immediate Supervisor No.");
            PerfomanceEvaluation.Description := description;
            if PerfomanceEvaluation.Modify(true) then begin
                FnLoadCompetencies(PerfomanceEvaluation.No);
                FnAppraisalSuggestObjectivesOutcomes(PerfomanceEvaluation.No);
                status := 'success*New appraisal created*' + PerfomanceEvaluation.No;
            end else
                status := 'danger*New appraisal was not created*';
        end else begin
            PerfomanceEvaluation.Init;
            PerfomanceEvaluation."Document Type" := PerfomanceEvaluation."document type"::"Performance Appraisal";
            PerfomanceEvaluation."Evaluation Type" := PerfomanceEvaluation."evaluation type"::"Self-Appraisal with Supervisor Score";
            PerfomanceEvaluation."Employee No." := empNo;
            PerfomanceEvaluation.Validate("Employee No.");
            PerfomanceEvaluation."Strategy Plan ID" := strategicPlan;
            PerfomanceEvaluation.Validate("Strategy Plan ID");
            PerfomanceEvaluation."Performance Mgt Plan ID" := Pmp;
            PerfomanceEvaluation.Validate("Performance Mgt Plan ID");
            PerfomanceEvaluation."Performance Task ID" := Tasks;
            PerfomanceEvaluation.Validate("Performance Task ID");
            PerfomanceEvaluation."Personal Scorecard ID" := personalSC;
            PerfomanceEvaluation.Validate("Personal Scorecard ID");
            PerfomanceEvaluation."Immediate Supervisor No." := supervisor;
            PerfomanceEvaluation.Validate("Immediate Supervisor No.");
            PerfomanceEvaluation.Description := description;
            if PerfomanceEvaluation.Insert(true) then begin
                FnLoadCompetencies(PerfomanceEvaluation.No);
                FnAppraisalSuggestObjectivesOutcomes(PerfomanceEvaluation.No);
                status := 'success*New appraisal created*' + PerfomanceEvaluation.No;
            end else
                status := 'danger*New appraisal was not created*';
        end;
    end;

    procedure FnLoadCompetencies(docNo: Code[100]) status: Text
    var
        PCObjective: Record "PC Objective";
        ObjectiveOutcome: Record "Objective Evaluation Result";
        CompetencyLines: Record "Competency Template Line";
        ProEvaluation: Record "Proficiency Evaluation Result";
        SPMGeneralSetup: Record "SPM General Setup";
        AchievedTarget: Decimal;
        PlogLines: Record "Plog Lines";
        SecondaryPCObjective: Record "Secondary PC Objective";
        PCJobDescription: Record "PC Job Description";
        PerfomanceEvaluation: Record "Performance Evaluation";
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            CompetencyLines.Reset;
            CompetencyLines.SetRange("Competency Template ID", PerfomanceEvaluation."Competency Template ID");
            //CompetencyLines.SetRange("Job Grade", PerfomanceEvaluation."Current Grade");
            if CompetencyLines.FindSet then begin
                repeat
                    ProEvaluation.Init;
                    ProEvaluation."Performance Evaluation ID" := PerfomanceEvaluation.No;
                    ProEvaluation."Line No" := FnGetLastLineNoB + 1;
                    ProEvaluation."Competency Template ID" := PerfomanceEvaluation."Competency Template ID";
                    ProEvaluation."Competency Code" := CompetencyLines."Competency Code";
                    ProEvaluation.Validate("Competency Code");
                    ProEvaluation."Competency Category" := CompetencyLines."Competency Category";
                    ProEvaluation."Competency Description" := CompetencyLines."Competency Description";
                    ProEvaluation.Description := CompetencyLines.Description;
                    ProEvaluation."Profiency Rating Scale" := PerfomanceEvaluation."Proficiency Rating Scale";
                    ProEvaluation."Target Qty" := CompetencyLines."Weight %";
                    ProEvaluation."Weight %" := CompetencyLines."Weight %";
                    if ProEvaluation.Insert(true) then begin
                        status := 'success*success*';
                    end else begin
                        status := 'danger*failed*';
                    end;
                until CompetencyLines.Next = 0;
            end;
        end;
    end;

    procedure FnAddEvaluationPIP(docNo: Code[100]; category: Code[100]; description: Text) status: Text
    var
        EvaluationPIP: Record "Evaluation PIP";
    begin
        EvaluationPIP.Init;
        EvaluationPIP."Perfomance Evaluation No" := docNo;
        EvaluationPIP."PIP Category" := category;
        EvaluationPIP.Description := description;
        if EvaluationPIP.Insert(true) then begin
            status := 'success*Evaluation PIP has been added successfully';
        end else begin
            status := 'danger*Evaluation PIP was not saved, please try again!';
        end;
    end;

    procedure fnGenerateStandardAppraisalReport(docNo: Code[100]) status: Text
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            // if FILE.Exists(FILESPATH14 + docNo + '.pdf') then begin
            //     FILE.Erase(FILESPATH14 + docNo + '.pdf');
            //     // Report.SaveAsPdf(80016, FILESPATH14 + docNo + '.pdf', PerfomanceEvaluation);
            //     status := 'success*Generated*Downloads\StandardAppraisalReport\' + docNo + '.pdf';
            // end else begin
            //     // Report.SaveAsPdf(80016, FILESPATH14 + docNo + '.pdf', PerfomanceEvaluation);
            //     status := 'success*Generated*Downloads\StandardAppraisalReport\' + docNo + '.pdf';
            // end
        end else begin
            status := 'danger*The Report could not be generated';
        end;
    end;

    procedure fnGeneratePlogReport(docNo: Code[100]) status: Text
    var
        PerformanceDiaryLog: Record "Performance Diary Log";
    begin
        PerformanceDiaryLog.Reset;
        PerformanceDiaryLog.SetRange(No, docNo);
        if PerformanceDiaryLog.FindSet then begin
            // if FILE.Exists(FILESPATH15 + docNo + '.pdf') then begin
            //     FILE.Erase(FILESPATH15 + docNo + '.pdf');
            //     // Report.SaveAsPdf(52211646, FILESPATH15 + docNo + '.pdf', PerformanceDiaryLog);
            //     status := 'success*Generated*finance\PlogReport\' + docNo + '.pdf';
            // end else begin
            //     // Report.SaveAsPdf(52211646, FILESPATH15 + docNo + '.pdf', PerformanceDiaryLog);
            //     status := 'success*Generated*finance\PlogReport\' + docNo + '.pdf';
            // end
        end else begin
            status := 'danger*The Report could not be generated';
        end;
    end;

    procedure fnGenerateIndividualPcReport(docNo: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, docNo);
        if PerfomanceContractHeader.FindSet then begin
            // if FILE.Exists(FILESPATH16 + docNo + '.pdf') then begin
            //     FILE.Erase(FILESPATH16 + docNo + '.pdf');
            //     // Report.SaveAsPdf(52211645, FILESPATH16 + docNo + '.pdf', PerfomanceContractHeader);
            //     status := 'success*Generated*finance\IndividualPCReport\' + docNo + '.pdf';
            // end else begin
            //     // Report.SaveAsPdf(52211645, FILESPATH16 + docNo + '.pdf', PerfomanceContractHeader);
            //     status := 'success*Generated*finance\IndividualPCReport\' + docNo + '.pdf';
            // end
        end else begin
            status := 'danger*The Report could not be generated';
        end;
    end;

    procedure fnGenerateIndividualPcSubIndicatorReport(docNo: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, docNo);
        if PerfomanceContractHeader.FindSet then begin
            // if FILE.Exists(FILESPATH24 + docNo + '.pdf') then begin
            //     FILE.Erase(FILESPATH24 + docNo + '.pdf');
            //     // Report.SaveAsPdf(80024, FILESPATH24 + docNo + '.pdf', PerfomanceContractHeader);
            //     status := 'success*Generated*Downloads\IndividualSubIndicator\' + docNo + '.pdf';
            // end else begin
            //     // Report.SaveAsPdf(80024, FILESPATH24 + docNo + '.pdf', PerfomanceContractHeader);
            //     status := 'success*Generated*Downloads\IndividualSubIndicator\' + docNo + '.pdf';
            // end
        end else begin
            status := 'danger*The Report could not be generated';
        end;
    end;

    procedure fnInsertJDTargets(lineno: Code[100]; workplanno: Code[100]; annualtarget: Integer; assignedtarget: Integer) status: Text
    var
        PCJobDescription: Record "PC Job Description";
    begin
        PCJobDescription.Reset;
        PCJobDescription.SetRange("Line Number", lineno);
        PCJobDescription.SetRange(Description, workplanno);
        // PCJobDescription.SetRange("Workplan No.", workplanno);
        if PCJobDescription.FindSet then begin
            PCJobDescription."Start Date" := Today;
            PCJobDescription."Due Date" := Today;
            PCJobDescription."Imported Annual Target Qty" := annualtarget;
            PCJobDescription."Assigned Weight (%)" := assignedtarget;
            if PCJobDescription.Modify(true) then begin
                status := 'success*Your Plog target were submitted successfully!*';
            end else begin
                status := 'danger*Your Plog target were not saved successfully, kindly try again!*';
            end;
        end;
    end;

    procedure FnSuggestJD2(workplan: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        SpmGeneralSetup: Record "SPM General Setup";
        JobResponsibilities: Record "Positions Responsibility";
        PCJobDescription: Record "PC Job Description";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, workplan);
        if PerfomanceContractHeader.FindSet then begin
            JobResponsibilities.Reset;
            JobResponsibilities.SetRange("Position ID", PerfomanceContractHeader.Position);
            if JobResponsibilities.Find('-') then begin
                repeat
                    PCJobDescription.Init;
                    PCJobDescription."Workplan No." := PerfomanceContractHeader.No;
                    PCJobDescription."Line Number" := Format(JobResponsibilities."Line No");
                    PCJobDescription.Validate("Line Number");
                    PCJobDescription.Description := JobResponsibilities.Description;
                    PCJobDescription."Primary Department" := PerfomanceContractHeader."Responsibility Center";
                    PCJobDescription.Validate("Primary Department");
                    PCJobDescription."Start Date" := PerfomanceContractHeader."Start Date";
                    PCJobDescription."Due Date" := PerfomanceContractHeader."End Date";
                    PCJobDescription.Insert(true);
                until JobResponsibilities.Next = 0;
            end;
        end;
    end;

    procedure fnGetAnnualWorkplanLines(csp: Code[100]; annualcode: Code[100]) AnnualLines: Text
    var
        StrategyWorkplanLines: Record "Strategy Workplan Lines";
    begin
        StrategyWorkplanLines.Reset;
        StrategyWorkplanLines.SetRange("Strategy Plan ID", csp);
        StrategyWorkplanLines.SetRange("Year Reporting Code", annualcode);
        if StrategyWorkplanLines.FindSet then begin
            repeat
                AnnualLines := AnnualLines + '*' + StrategyWorkplanLines."Activity ID" + '*' + StrategyWorkplanLines.Description + '*' + StrategyWorkplanLines."Primary Department Name" + ':';
            until StrategyWorkplanLines.Next = 0;
        end;
        exit(AnnualLines);
    end;

    procedure fnInsertSelectedAdditionalActivities(csp: Code[100]; annualcode: Code[100]; personalPc: Code[100]; activityID: Code[100]) status: Text
    var
        SecondaryPCObjective: Record "Secondary PC Objective";
        StrategyWorkplanLines: Record "Strategy Workplan Lines";
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        StrategyWorkplanLines.Reset;
        StrategyWorkplanLines.SetRange("Activity ID", activityID);
        StrategyWorkplanLines.SetRange("Strategy Plan ID", csp);
        StrategyWorkplanLines.SetRange("Year Reporting Code", annualcode);
        if StrategyWorkplanLines.FindSet then begin
            PerfomanceContractHeader.Reset;
            PerfomanceContractHeader.SetRange(No, personalPc);
            if PerfomanceContractHeader.FindSet then begin
                SecondaryPCObjective.Init;
                SecondaryPCObjective."Workplan No." := personalPc;
                SecondaryPCObjective."Initiative No." := activityID;
                SecondaryPCObjective."Strategy Plan ID" := StrategyWorkplanLines."Strategy Plan ID";
                SecondaryPCObjective."Year Reporting Code" := StrategyWorkplanLines."Year Reporting Code";
                SecondaryPCObjective."Primary Department" := StrategyWorkplanLines."Primary Department";
                SecondaryPCObjective."Unit of Measure" := StrategyWorkplanLines."Unit of Measure";
                SecondaryPCObjective."Outcome Perfomance Indicator" := StrategyWorkplanLines."Perfomance Indicator";
                SecondaryPCObjective."Objective/Initiative" := StrategyWorkplanLines.Description;
                SecondaryPCObjective."Start Date" := PerfomanceContractHeader."Start Date";
                SecondaryPCObjective."Due Date" := PerfomanceContractHeader."End Date";
                if SecondaryPCObjective.Insert(true) then begin
                    status := 'success*Inserted';
                end else begin
                    status := 'danger*Inserted';
                end;
            end;
        end;
    end;

    procedure fnGenerateCSPReport(docNo: Code[100]) status: Text
    var
        CorporateStrategicPlans: Record "Corporate Strategic Plans";
    begin
        CorporateStrategicPlans.Reset;
        CorporateStrategicPlans.SetRange(Code, docNo);
        if CorporateStrategicPlans.FindSet then begin
            // if FILE.Exists(FILESPATH17 + docNo + '.pdf') then begin
            //     FILE.Erase(FILESPATH17 + docNo + '.pdf');
            //     // Report.SaveAsPdf(52211643, FILESPATH17 + docNo + '.pdf', CorporateStrategicPlans);
            //     status := 'success*Generated*finance\CSP\' + docNo + '.pdf';
            // end else begin
            //     // Report.SaveAsPdf(52211643, FILESPATH17 + docNo + '.pdf', CorporateStrategicPlans);
            //     status := 'success*Generated*finance\CSP\' + docNo + '.pdf';
            // end
        end else begin
            status := 'danger*The Report could not be generated';
        end;
    end;

    procedure fnGenerateAWPReport(docNo: Code[100]) status: Text
    var
        AnnualStrategyWorkplan: Record "Annual Strategy Workplan";
    begin
        AnnualStrategyWorkplan.Reset;
        AnnualStrategyWorkplan.SetRange(No, docNo);
        if AnnualStrategyWorkplan.FindSet then begin
            // if FILE.Exists(FILESPATH18 + docNo + '.pdf') then begin
            //     FILE.Erase(FILESPATH18 + docNo + '.pdf');
            //     // Report.SaveAsPdf(80002, FILESPATH18 + docNo + '.pdf', AnnualStrategyWorkplan);
            //     status := 'success*Generated*finance\AWP\' + docNo + '.pdf';
            // end else begin
            //     // Report.SaveAsPdf(80002, FILESPATH18 + docNo + '.pdf', AnnualStrategyWorkplan);
            //     status := 'success*Generated*finance\AWP\' + docNo + '.pdf';
            // end
        end else begin
            status := 'danger*The Report could not be generated';
        end;
    end;

    procedure fnGenerateBoardPCReport(docNo: Code[100]) status: Text
    var
        PerfomanceContractHeader: Record "Perfomance Contract Header";
    begin
        PerfomanceContractHeader.Reset;
        PerfomanceContractHeader.SetRange(No, docNo);
        if PerfomanceContractHeader.FindSet then begin
            // if FILE.Exists(FILESPATH19 + docNo + '.pdf') then begin
            //     FILE.Erase(FILESPATH19 + docNo + '.pdf');
            //     // Report.SaveAsPdf(80019, FILESPATH19 + docNo + '.pdf', PerfomanceContractHeader);
            //     status := 'success*Generated*finance\BoardPC\' + docNo + '.pdf';
            // end else begin
            //     // Report.SaveAsPdf(80019, FILESPATH19 + docNo + '.pdf', PerfomanceContractHeader);
            //     status := 'success*Generated*finance\BoardPC\' + docNo + '.pdf';
            // end
        end else begin
            status := 'danger*The Report could not be generated';
        end;
    end;

    procedure fnSubmitStandardAppraisal(docNo: Code[100]) status: Text
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            PerfomanceEvaluation."Document Status" := PerfomanceEvaluation."document status"::Evaluation;
            PerfomanceEvaluation."Approval Status" := PerfomanceEvaluation."approval status"::Released;
            if PerfomanceEvaluation.Modify(true) then begin
                status := 'success*Your appraisal has been sent to your supervisor for review';
            end else begin
                status := 'danger*Your appraisal could not be sent to your supervisor for review, kindy try again!';
            end;
        end;
    end;

    procedure fnCancelSubmitofStandardAppraisal(docNo: Code[100]) status: Text
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            PerfomanceEvaluation."Document Status" := PerfomanceEvaluation."document status"::Draft;
            PerfomanceEvaluation."Approval Status" := PerfomanceEvaluation."approval status"::Open;
            if PerfomanceEvaluation.Modify(true) then begin
                status := 'success*Your appraisal submission to your supervisor was successfully cancelled';
            end else begin
                status := 'danger*Your appraisal submission to your supervisor was not cancelled, kindy try again!';
            end;
        end;
    end;

    procedure fnSubmitStandardAppraisalObj(docNo: Code[100]; lineno: Integer; appraiserQty: Decimal; comments: Text) status: Text
    var
        ObjectiveEvaluationResult: Record "Objective Evaluation Result";
        tDoc: Code[100];
    begin
        ObjectiveEvaluationResult.Reset;
        ObjectiveEvaluationResult.SetRange("Line No", lineno);
        ObjectiveEvaluationResult.SetRange("Performance Evaluation ID", docNo);
        if ObjectiveEvaluationResult.FindSet then begin
            ObjectiveEvaluationResult."AppraiserReview Qty" := appraiserQty;
            ObjectiveEvaluationResult."Final/Actual Qty" := appraiserQty;
            ObjectiveEvaluationResult.Comments := comments;
            if ObjectiveEvaluationResult.Modify(true) then begin
                status := 'success*Employee appraisal has been submitted successfully';
            end else begin
                status := 'danger*Employee appraisal could not be submitted, kindy try again!';
            end;
        end;
    end;

    procedure fnSubmitStandardAppraisalPE(docNo: Code[100]; lineno: Integer; appraiserQty: Decimal; comments: Text) status: Text
    var
        ProficiencyEvaluationResult: Record "Proficiency Evaluation Result";
        tDoc: Code[100];
    begin
        ProficiencyEvaluationResult.Reset;
        ProficiencyEvaluationResult.SetRange("Line No", lineno);
        ProficiencyEvaluationResult.SetRange("Performance Evaluation ID", docNo);
        if ProficiencyEvaluationResult.FindSet then begin
            ProficiencyEvaluationResult."AppraiserReview Qty" := appraiserQty;
            ProficiencyEvaluationResult."Final/Actual Qty" := appraiserQty;
            ProficiencyEvaluationResult.Comments := comments;
            if ProficiencyEvaluationResult.Modify(true) then begin
                status := 'success*Employee appraisal has been submitted successfully';
            end else begin
                status := 'danger*Employee appraisal could not be submitted, kindy try again!';
            end;
        end;
    end;

    procedure fnInsertStandardAppraisalPIP(docNo: Code[100]; pipcategory: Code[100]; desc: Text) status: Text
    var
        EvaluationPIP: Record "Evaluation PIP";
        tDoc: Code[100];
    begin
        EvaluationPIP.Init;
        EvaluationPIP."Perfomance Evaluation No" := docNo;
        EvaluationPIP."PIP Category" := pipcategory;
        EvaluationPIP.Description := desc;
        if EvaluationPIP.Insert(true) then begin
            status := 'success*Employee appraisal has been submitted successfully';
        end else begin
            status := 'danger*Employee appraisal could not be submitted, kindy try again!';
        end;
    end;

    procedure fnEditStandardAppraisalPIP(docNo: Code[100]; lineno: Integer; pipcategory: Code[100]; desc: Text) status: Text
    var
        EvaluationPIP: Record "Evaluation PIP";
        tDoc: Code[100];
    begin
        EvaluationPIP.Reset;
        EvaluationPIP.SetRange("PIP Number", lineno);
        EvaluationPIP.SetRange("Perfomance Evaluation No", docNo);
        if EvaluationPIP.FindSet then begin
            EvaluationPIP."PIP Category" := pipcategory;
            EvaluationPIP.Description := desc;
            if EvaluationPIP.Modify(true) then begin
                status := 'success*Employee appraisal has been submitted successfully';
            end else begin
                status := 'danger*Employee appraisal could not be submitted, kindy try again!';
            end;
        end;
    end;

    procedure fnRemoveStandardAppraisalPIP(docNo: Code[100]; lineno: Integer) status: Text
    var
        EvaluationPIP: Record "Evaluation PIP";
        tDoc: Code[100];
    begin
        EvaluationPIP.Reset;
        EvaluationPIP.SetRange("PIP Number", lineno);
        EvaluationPIP.SetRange("Perfomance Evaluation No", docNo);
        if EvaluationPIP.FindSet then begin
            if EvaluationPIP.Delete(true) then begin
                status := 'success*The line has been successfully removed';
            end else begin
                status := 'danger*The line would not be removed, kindy try again!';
            end;
        end;
    end;

    procedure fnInsertStandardAppraisalTrainigNeeds(docNo: Code[100]; category: Code[100]; desc: Text) status: Text
    var
        EvaluationTrainingneeds: Record "Evaluation Training needs";
        tDoc: Code[100];
    begin
        EvaluationTrainingneeds.Init;
        EvaluationTrainingneeds."Perfomance Evaluation No" := docNo;
        EvaluationTrainingneeds."Training Need Category" := category;
        EvaluationTrainingneeds.Description := desc;
        if EvaluationTrainingneeds.Insert(true) then begin
            status := 'success*Employee appraisal training needs has been submitted successfully';
        end else begin
            status := 'danger*Employee appraisal could not be submitted, kindy try again!';
        end;
    end;

    procedure fnRemoveStandardAppraisalTrainigNeeds(docNo: Code[100]; lineno: Integer) status: Text
    var
        EvaluationTrainingneeds: Record "Evaluation Training needs";
        tDoc: Code[100];
    begin
        EvaluationTrainingneeds.Reset;
        EvaluationTrainingneeds.SetRange("Training Need Number", lineno);
        EvaluationTrainingneeds.SetRange("Perfomance Evaluation No", docNo);
        if EvaluationTrainingneeds.FindSet then begin
            if EvaluationTrainingneeds.Delete(true) then begin
                status := 'success*The line has been successfully removed';
            end else begin
                status := 'danger*The line would not be removed, kindy try again!';
            end;
        end;
    end;

    procedure fnEditStandardAppraisalTrainigNeeds(docNo: Code[100]; lineno: Integer; category: Code[100]; desc: Text) status: Text
    var
        EvaluationTrainingneeds: Record "Evaluation Training needs";
        tDoc: Code[100];
    begin
        EvaluationTrainingneeds.Reset;
        EvaluationTrainingneeds.SetRange("Training Need Number", lineno);
        EvaluationTrainingneeds.SetRange("Perfomance Evaluation No", docNo);
        if EvaluationTrainingneeds.FindSet then begin
            EvaluationTrainingneeds."Training Need Category" := category;
            EvaluationTrainingneeds.Description := desc;
            if EvaluationTrainingneeds.Modify(true) then begin
                status := 'success*Employee appraisal has been submitted successfully';
            end else begin
                status := 'danger*Employee appraisal could not be submitted, kindy try again!';
            end;
        end;
    end;

    procedure fnSubmitStandardAppraisalConfirmation(docNo: Code[100]) status: Text
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
        tDoc: Code[100];
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            PerfomanceEvaluation."Employee Confirm" := true;
            PerfomanceEvaluation."Supervisor Confirm" := true;
            PerfomanceEvaluation."Document Status" := PerfomanceEvaluation."document status"::Submitted;
            if PerfomanceEvaluation.Modify(true) then begin
                fnSendAppraisalEmail(PerfomanceEvaluation.No);
                status := 'success*Employee appraisal has been submitted successfully';
            end else begin
                status := 'danger*Employee appraisal could not be submitted, kindy try again!';
            end;
        end;
    end;

    procedure fnSendAppraisalEmail(docNo: Code[100]) status: Text
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
        SupplierReq: Record Contact;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        FileDirectory: Text[100];
        FileName: Text[100];
        ReportID: Integer;
        Employee: Record Employee;
        Window: Dialog;
        RunOnceFile: Text[1000];
        TimeOut: Integer;
        Customer2: Record Customer;
        Cust: Record Customer;
        cr: Integer;
        lf: Integer;
        EmailBody: array[2] of Text[30];
        BodyText: Text[250];
        mymail: Codeunit Mail;
        DefaultPrinter: Text[200];
        WindowisOpen: Boolean;
        FileDialog: Codeunit Mail;
        SendingDate: Date;
        SendingTime: Time;
        Counter: Integer;
        cu400: Codeunit Mail;
        BranchName: Code[80];
        DimValue: Record "Dimension Value";
        SenderAddress: Text[100];
        CustEmail: Text[100];
        UserSetup: Record "User Setup";
        HRSetup: Record "Company Information";
        Emp: Record Vendor;
        PayrollMonth: Date;
        PayrollMonthText: Text[30];
        PayPeriodtext: Text;
        CompInfo: Record "Company Information";
        DateFilter: Text;
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text;
        ToDateS: Text;
        vend: Record Vendor;
        StartDate: Date;
        EndDAte: Date;
        IsEmailValid: Boolean;
        RequesterName: Text[100];
        RequesterEmail: Text[100];
        emailhdr: Text[100];
        CompanyDetails: Text[250];
        SupplierDetails: Text[1000];
        SenderMessage: Text[1000];
        ProcNote: Text[1000];
        LoginDetails: Text[1000];
        Password: Text[50];
        ActivationDetails: Text[1000];
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            HRSetup.Get;

            Employee.Reset;
            Employee.SetRange(Employee."No.", PerfomanceEvaluation."Employee No.");
            if Employee.FindSet then begin
                RequesterEmail := Employee."Company E-Mail";
                RequesterName := PerfomanceEvaluation."Employee Name";

                Counter := Counter + 1;

                if HRSetup."E-Mail" = '' then
                    Error('Please Contact the IT Admin to specify the E-mail address under Company Information Setup page!!');
                SenderAddress := HRSetup."E-Mail";

                CompanyDetails := 'Dear,  ' + RequesterName;
                SenderMessage := '<BR>This is to notify you that your appraisal was successfully submitted: ' + PerfomanceEvaluation.No + '</BR>';
                LoginDetails := 'Attached herein, please find an e-copy of your aappraisal report';

                FileDirectory := 'C:\DOCS\';
                FileName := 'AppraisalReport_' + PerfomanceEvaluation.No + '.pdf';

                PerfomanceEvaluation.Reset;
                PerfomanceEvaluation.SetRange(No, PerfomanceEvaluation.No);
                if PerfomanceEvaluation.FindSet then begin
                    // // Report.SaveAsPdf(80016, FileDirectory + FileName, PerfomanceEvaluation);
                end;

                //emailhdr := 'PERFORMANCE APPRAISAL ' + PerfomanceEvaluation.No;
                //cu400.CreateMessage(CompInfo.Name, SenderAddress, RequesterEmail, emailhdr,
                //CompanyDetails + '<BR></BR>' + SenderMessage + SupplierDetails + LoginDetails + ActivationDetails, true);
                //cu400.AddAttachment(FileDirectory + FileName, FileName);
                //cu400.AddBodyline(ProcNote);
                // cu400.Send;
                //SendingDate := Today;
                // SendingTime := Time;
            end;
        end;
    end;

    // procedure addTrainingParticipants(type: Text[100]; participantEmpno: Text[100]; Destination: Text[100]; noOfDays: Decimal; reqNo: Text[100]) status: Text
    // var
    //     TrainingParticipants: Record "Training Participants";
    //     TrainingRequests: Record "Training Requests";
    // begin
    //     TrainingRequests.Reset;
    //     TrainingRequests.SetRange(Code, reqNo);
    //     if TrainingRequests.FindSet then begin
    //         TrainingParticipants.Reset;
    //         TrainingParticipants.SetRange("Training Code", reqNo);
    //         TrainingParticipants.SetRange("Employee Code", participantEmpno);
    //         if TrainingParticipants.FindSet then begin
    //             status := 'error*The participants already exists.'
    //         end else begin
    //             TrainingParticipants.Init;
    //             TrainingParticipants.Type := type;
    //             TrainingParticipants."Employee Code" := participantEmpno;
    //             TrainingParticipants.Validate("Employee Code");
    //             TrainingParticipants.Destination := Destination;
    //             TrainingParticipants.Validate(Destination);
    //             TrainingParticipants."Training Code" := reqNo;
    //             TrainingParticipants."No. of Days" := noOfDays;
    //             TrainingParticipants.Validate("No. of Days");
    //             //TrainingParticipants.Destination:=TrainingRequests."Training Venue Region";
    //             if TrainingParticipants.Insert(true) then begin
    //                 status := 'success*Training Participant successfully added';
    //             end else begin
    //                 status := 'danger*Training Participant was not added, please try again!';
    //             end
    //         end;
    //     end;
    // end;

    // procedure editTrainingParticipants(lineno: Integer; type: Text[100]; teammember: Text[100]; noOfDays: Integer; docNo: Code[100]) status: Text
    // begin
    //     TrainingParticipants.Reset;
    //     TrainingParticipants.SetRange("Training Code", docNo);
    //     TrainingParticipants.SetRange("Line No", lineno);
    //     if TrainingParticipants.FindSet then begin
    //         TrainingParticipants.Type := type;
    //         TrainingParticipants."Employee Code" := teammember;
    //         //TrainingParticipants.VALIDATE("Employee Code");
    //         TrainingParticipants."No. of Days" := noOfDays;
    //         TrainingParticipants.Validate("No. of Days");
    //         if TrainingParticipants.Modify(true) then begin
    //             status := 'success*The training Participant was successfully updated';
    //         end else begin
    //             status := 'error*The participant could not be updated.Please try again!';
    //         end;
    //     end;
    // end;

    // procedure deleteTrainingParticipants(id: Integer; reqNo: Text[100]) status: Text
    // begin
    //     TrainingParticipants.Reset;
    //     TrainingParticipants.SetRange("Training Code", reqNo);
    //     TrainingParticipants.SetRange("Line No", id);
    //     if TrainingParticipants.FindSet then begin
    //         TrainingParticipants.Delete;
    //         status := 'success*Participant was successfully removed';
    //     end else begin
    //         status := 'error*The participant could not be removed. Please try again!';
    //     end
    // end;

    // procedure addTrainingCost(docNo: Code[100]; costcategory: Integer; unitcost: Decimal; quantity: Integer; description: Text) status: Text
    // var
    //     TrainingCost: Record "Training Cost";
    //     TrainingRequests: Record "Training Requests";
    // begin
    //     TrainingRequests.Reset;
    //     TrainingRequests.SetRange(Code, docNo);
    //     if TrainingRequests.FindSet then begin
    //         TrainingCost.Init;
    //         TrainingCost."Training ID" := docNo;
    //         //  TrainingCost."Employee No.":=empNo;
    //         //  TrainingCost.VALIDATE("Employee No.");
    //         TrainingCost."Cost Category" := costcategory;
    //         TrainingCost."Unit Cost (LCY)" := unitcost;
    //         TrainingCost.Quantity := quantity;
    //         TrainingCost.Validate(Quantity);
    //         TrainingCost.Description := description;
    //         if TrainingCost.Insert(true) then begin
    //             status := 'success*The training cost was successfully added*';
    //         end else begin
    //             status := 'danger*The training cost was not added, please try again';
    //         end;
    //     end;
    // end;

    // procedure RemoveTrainingCost(docNo: Code[100]; lineno: Integer) status: Text
    // var
    //     TrainingCost: Record "Training Cost";
    //     TrainingRequests: Record "Training Requests";
    // begin
    //     TrainingCost.Reset;
    //     TrainingCost.SetRange("Training ID", docNo);
    //     //TrainingCost.SETRANGE("Line No",lineno);
    //     if TrainingCost.FindSet then begin
    //         if TrainingCost.Delete(true) then begin
    //             status := 'success*The training cost was successfully removed*';
    //         end else begin
    //             status := 'danger*The training cost was not removed, please try again';
    //         end;
    //     end;
    // end;

    procedure FnAppraisalSuggestObjectivesOutcomes(docNo: Code[100]) status: Text
    var
        PCObjective: Record "PC Objective";
        ObjectiveOutcome: Record "Objective Evaluation Result";
        CompetencyLines: Record "Competency Template Line";
        ProEvaluation: Record "Proficiency Evaluation Result";
        SPMGeneralSetup: Record "SPM General Setup";
        AchievedTarget: Decimal;
        PlogLines: Record "Plog Lines";
        SecondaryPCObjective: Record "Secondary PC Objective";
        PCJobDescription: Record "PC Job Description";
        PerfomanceEvaluation: Record "Performance Evaluation";
        SubObjectiveEvaluation: Record "Sub Objective Evaluation";
        SubPCObjective: Record "Sub PC Objective";
        AchievedSubActivityTarget: Decimal;
        SubPlogLines: Record "Sub Plog Lines";
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            SPMGeneralSetup.Get;
            SPMGeneralSetup.TestField("Appraisal Based On");

            if SPMGeneralSetup."Appraisal Based On" = SPMGeneralSetup."appraisal based on"::"Direct Input" then begin
                SPMGeneralSetup.Get();
                if (SPMGeneralSetup."Allow Loading of  CSP" = true) then begin
                    PCObjective.Reset;
                    PCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    if PCObjective.FindFirst then begin
                        repeat
                            PCObjective.TestField("Due Date");
                        until PCObjective.Next = 0;
                    end;

                    PCObjective.Reset;
                    PCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    PCObjective.TestField("Due Date");
                    PCObjective.SetRange("Due Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                    if PCObjective.FindFirst then begin
                        repeat
                            ObjectiveOutcome.Init;
                            ObjectiveOutcome."Performance Evaluation ID" := PerfomanceEvaluation.No;
                            ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                            ObjectiveOutcome."Scorecard ID" := PCObjective."Workplan No.";
                            ObjectiveOutcome."Intiative No" := PCObjective."Initiative No.";
                            ObjectiveOutcome."Objective/Initiative" := PCObjective."Objective/Initiative";
                            ObjectiveOutcome."Primary Department" := PerfomanceEvaluation.Department;
                            // ObjectiveOutcome."Primary Division" := PerfomanceEvaluation.Division;
                            ObjectiveOutcome."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                            ObjectiveOutcome."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                            //ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                            ObjectiveOutcome."Target Qty" := PCObjective."Imported Annual Target Qty";
                            ObjectiveOutcome."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                            ObjectiveOutcome.Validate("Performance Rating Scale");
                            ObjectiveOutcome."Desired Perfomance Direction" := PCObjective."Desired Perfomance Direction";
                            ObjectiveOutcome."Weight %" := PCObjective."Assigned Weight (%)";
                            ObjectiveOutcome.Insert(true);
                            //Sub Objective OutCome
                            SubPCObjective.Reset;
                            SubPCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                            SubPCObjective.SetRange("Initiative No.", PCObjective."Initiative No.");
                            if SubPCObjective.FindSet then begin
                                repeat
                                    SubObjectiveEvaluation.Init;
                                    SubObjectiveEvaluation."Performance Evaluation ID" := PerfomanceEvaluation.No;
                                    SubObjectiveEvaluation."Line No" := FnGetLastSubPcLineNo + 1;
                                    SubObjectiveEvaluation."Scorecard ID" := PCObjective."Workplan No.";
                                    SubObjectiveEvaluation."Intiative No" := PCObjective."Initiative No.";
                                    SubObjectiveEvaluation."Objective/Initiative" := PCObjective."Objective/Initiative";
                                    SubObjectiveEvaluation."Sub Intiative No" := SubPCObjective."Sub Initiative No.";
                                    SubObjectiveEvaluation."Sub Intiative Description" := SubPCObjective."Objective/Initiative";
                                    SubObjectiveEvaluation."Primary Department" := PerfomanceEvaluation.Department;
                                    // SubObjectiveEvaluation."Primary Division" := PerfomanceEvaluation.Division;
                                    SubObjectiveEvaluation."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                                    SubObjectiveEvaluation."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                                    //SubObjectiveEvaluation.Validate("Outcome Perfomance Indicator");
                                    SubObjectiveEvaluation."Target Qty" := PCObjective."Imported Annual Target Qty";
                                    SubObjectiveEvaluation."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                                    SubObjectiveEvaluation.Validate("Performance Rating Scale");
                                    SubObjectiveEvaluation."Desired Perfomance Direction" := PCObjective."Desired Perfomance Direction";
                                    SubObjectiveEvaluation."Weight %" := SubPCObjective."Assigned Weight (%)";
                                    SubObjectiveEvaluation.Insert(true);

                                until SubPCObjective.Next = 0;
                            end;
                        //End Sub Objective OutCome
                        until PCObjective.Next = 0;
                    end;

                    SecondaryPCObjective.Reset;
                    SecondaryPCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    if SecondaryPCObjective.FindFirst then begin
                        repeat
                        //SecondaryPCObjective.TESTFIELD("Due Date");
                        until SecondaryPCObjective.Next = 0;
                    end;

                    SecondaryPCObjective.Reset;
                    SecondaryPCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    SecondaryPCObjective.SetRange("Due Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                    if SecondaryPCObjective.FindFirst then begin
                        repeat
                            ObjectiveOutcome.Init;
                            ObjectiveOutcome."Performance Evaluation ID" := PerfomanceEvaluation.No;
                            ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                            ObjectiveOutcome."Scorecard ID" := SecondaryPCObjective."Workplan No.";
                            ObjectiveOutcome."Intiative No" := SecondaryPCObjective."Initiative No.";
                            ObjectiveOutcome."Objective/Initiative" := SecondaryPCObjective."Objective/Initiative";
                            ObjectiveOutcome."Primary Department" := PerfomanceEvaluation.Department;
                            // ObjectiveOutcome."Primary Division" := PerfomanceEvaluation.Division;
                            ObjectiveOutcome."Outcome Perfomance Indicator" := SecondaryPCObjective."Outcome Perfomance Indicator";
                            //ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                            ObjectiveOutcome."Target Qty" := SecondaryPCObjective."Imported Annual Target Qty";
                            ObjectiveOutcome."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                            ObjectiveOutcome.Validate("Performance Rating Scale");
                            ObjectiveOutcome."Desired Perfomance Direction" := SecondaryPCObjective."Desired Perfomance Direction";
                            ObjectiveOutcome."Weight %" := SecondaryPCObjective."Assigned Weight (%)";
                            ObjectiveOutcome.Insert(true);
                            //Insert Sub Objective Outcome
                            //Sub Objective OutCome
                            SubPCObjective.Reset;
                            SubPCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                            SubPCObjective.SetRange("Initiative No.", SecondaryPCObjective."Initiative No.");
                            if SubPCObjective.FindSet then begin
                                repeat
                                    SubObjectiveEvaluation.Init;
                                    SubObjectiveEvaluation."Performance Evaluation ID" := PerfomanceEvaluation.No;
                                    SubObjectiveEvaluation."Line No" := FnGetLastSubPcLineNo + 1;
                                    SubObjectiveEvaluation."Scorecard ID" := SecondaryPCObjective."Workplan No.";
                                    SubObjectiveEvaluation."Intiative No" := SecondaryPCObjective."Initiative No.";
                                    SubObjectiveEvaluation."Objective/Initiative" := SecondaryPCObjective."Objective/Initiative";
                                    SubObjectiveEvaluation."Sub Intiative No" := SubPCObjective."Sub Initiative No.";
                                    SubObjectiveEvaluation."Sub Intiative Description" := SubPCObjective."Objective/Initiative";
                                    SubObjectiveEvaluation."Primary Department" := PerfomanceEvaluation.Department;
                                    // SubObjectiveEvaluation."Primary Division" := PerfomanceEvaluation.Division;
                                    SubObjectiveEvaluation."Outcome Perfomance Indicator" := SecondaryPCObjective."Outcome Perfomance Indicator";
                                    SubObjectiveEvaluation."Key Performance Indicator" := SecondaryPCObjective."Outcome Perfomance Indicator";
                                    //SubObjectiveEvaluation.Validate("Outcome Perfomance Indicator");
                                    SubObjectiveEvaluation."Target Qty" := PCObjective."Imported Annual Target Qty";
                                    SubObjectiveEvaluation."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                                    SubObjectiveEvaluation.Validate("Performance Rating Scale");
                                    SubObjectiveEvaluation."Desired Perfomance Direction" := SecondaryPCObjective."Desired Perfomance Direction";
                                    SubObjectiveEvaluation."Weight %" := SubPCObjective."Assigned Weight (%)";
                                    SubObjectiveEvaluation.Insert(true);

                                until SubPCObjective.Next = 0;
                            end;
                        //End Sub Objective OutCome
                        //End Insert Sub Objective Outcome

                        until SecondaryPCObjective.Next = 0;
                    end;
                end;

                if (SPMGeneralSetup."Allow Loading of JD" = true) then begin
                    PCJobDescription.Reset;
                    PCJobDescription.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    PCJobDescription.SetRange("Due Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                    if PCJobDescription.FindFirst then begin
                        repeat
                            ObjectiveOutcome.Init;
                            ObjectiveOutcome."Performance Evaluation ID" := PerfomanceEvaluation.No;
                            ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                            ObjectiveOutcome."Scorecard ID" := PCJobDescription."Workplan No.";
                            ObjectiveOutcome."Intiative No" := Format(PCJobDescription."Line Number");
                            ObjectiveOutcome."Objective/Initiative" := PCJobDescription.Description;
                            ObjectiveOutcome."Primary Department" := PerfomanceEvaluation.Department;
                            // ObjectiveOutcome."Primary Division" := PerfomanceEvaluation.Division;
                            ObjectiveOutcome."Outcome Perfomance Indicator" := PCJobDescription."Outcome Perfomance Indicator";
                            //ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                            ObjectiveOutcome."Target Qty" := PCJobDescription."Imported Annual Target Qty";
                            ObjectiveOutcome."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                            ObjectiveOutcome.Validate("Performance Rating Scale");
                            ObjectiveOutcome."Desired Perfomance Direction" := PCJobDescription."Desired Perfomance Direction";
                            ObjectiveOutcome."Weight %" := PCJobDescription."Assigned Weight (%)";
                            ObjectiveOutcome.Insert(true);
                        until PCJobDescription.Next = 0;
                    end;
                end;
            end;

            if SPMGeneralSetup."Appraisal Based On" = SPMGeneralSetup."appraisal based on"::"Plog Input" then begin
                SPMGeneralSetup.Get();
                if (SPMGeneralSetup."Allow Loading of  CSP" = true) then begin
                    PCObjective.Reset;
                    PCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    if PCObjective.FindFirst then begin
                        repeat
                            PCObjective.TestField("Due Date");
                        until PCObjective.Next = 0;
                    end;

                    PCObjective.Reset;
                    PCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    //PCObjective.TESTFIELD("Due Date");
                    PCObjective.SetRange("Due Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                    if PCObjective.FindFirst then begin
                        repeat

                            AchievedTarget := 0;
                            PlogLines.Reset;
                            PlogLines.SetRange("Personal Scorecard ID", PCObjective."Workplan No.");
                            PlogLines.SetRange("Initiative No.", PCObjective."Initiative No.");
                            PlogLines.SetRange("Achieved Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                            PlogLines.CalcSums("Achieved Target");
                            AchievedTarget := PlogLines."Achieved Target";

                            /* IF AchievedTarget=0 THEN
                                ERROR('Performance Logs for Appraisal of Period  %1 and to %2 must be Updated first',"Evaluation Start Date","Evaluation End Date");*/

                            ObjectiveOutcome.Init;
                            ObjectiveOutcome."Performance Evaluation ID" := PerfomanceEvaluation.No;
                            ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                            ObjectiveOutcome."Scorecard ID" := PCObjective."Workplan No.";
                            ObjectiveOutcome."Intiative No" := PCObjective."Initiative No.";
                            ObjectiveOutcome."Objective/Initiative" := PCObjective."Objective/Initiative";
                            ObjectiveOutcome."Primary Department" := PerfomanceEvaluation.Department;
                            // ObjectiveOutcome."Primary Division" := PerfomanceEvaluation.Division;
                            ObjectiveOutcome."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                            //ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                            ObjectiveOutcome."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                            ObjectiveOutcome.Validate("Performance Rating Scale");
                            ObjectiveOutcome."Desired Perfomance Direction" := PCObjective."Desired Perfomance Direction";
                            ObjectiveOutcome."Weight %" := PCObjective."Assigned Weight (%)";
                            ObjectiveOutcome."Target Qty" := PCObjective."Imported Annual Target Qty";
                            ObjectiveOutcome."Self-Review Qty" := AchievedTarget;
                            ObjectiveOutcome."AppraiserReview Qty" := AchievedTarget;
                            ObjectiveOutcome."Final/Actual Qty" := AchievedTarget;
                            ObjectiveOutcome.Validate("Final/Actual Qty");
                            ObjectiveOutcome.Insert;

                            //Sub Objective OutCome
                            AchievedSubActivityTarget := 0;
                            SubPlogLines.Reset;
                            SubPlogLines.SetRange("Personal Scorecard ID", PCObjective."Workplan No.");
                            SubPlogLines.SetRange("Initiative No.", PCObjective."Initiative No.");
                            SubPlogLines.SetRange("Achieved Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                            SubPlogLines.CalcSums("Achieved Target");
                            AchievedTarget := PlogLines."Achieved Target";

                            SubPCObjective.Reset;
                            SubPCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                            SubPCObjective.SetRange("Initiative No.", PCObjective."Initiative No.");
                            if SubPCObjective.FindSet then begin
                                repeat
                                    SubObjectiveEvaluation.Init;
                                    SubObjectiveEvaluation."Performance Evaluation ID" := PerfomanceEvaluation.No;
                                    SubObjectiveEvaluation."Line No" := FnGetLastSubPcLineNo + 1;
                                    SubObjectiveEvaluation."Scorecard ID" := SubPCObjective."Workplan No.";
                                    SubObjectiveEvaluation."Intiative No" := SubPCObjective."Initiative No.";
                                    SubObjectiveEvaluation."Objective/Initiative" := SubPCObjective."Objective/Initiative";
                                    SubObjectiveEvaluation."Sub Intiative No" := SubPCObjective."Sub Initiative No.";
                                    SubObjectiveEvaluation."Sub Intiative Description" := SubPCObjective."Objective/Initiative";
                                    SubObjectiveEvaluation."Primary Department" := PerfomanceEvaluation.Department;
                                    // SubObjectiveEvaluation."Primary Division" := PerfomanceEvaluation.Division;
                                    SubObjectiveEvaluation."Outcome Perfomance Indicator" := PCObjective."Outcome Perfomance Indicator";
                                    SubObjectiveEvaluation."Key Performance Indicator" := PCObjective."Key Performance Indicator";
                                    //SubObjectiveEvaluation.Validate("Outcome Perfomance Indicator");
                                    SubObjectiveEvaluation."Target Qty" := SubPCObjective."Sub Targets";
                                    SubObjectiveEvaluation."Self-Review Qty" := AchievedSubActivityTarget;
                                    SubObjectiveEvaluation."AppraiserReview Qty" := AchievedSubActivityTarget;
                                    SubObjectiveEvaluation."Final/Actual Qty" := AchievedSubActivityTarget;
                                    SubObjectiveEvaluation.Validate("Final/Actual Qty");
                                    SubObjectiveEvaluation."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                                    SubObjectiveEvaluation.Validate("Performance Rating Scale");
                                    SubObjectiveEvaluation."Desired Perfomance Direction" := PCObjective."Desired Perfomance Direction";
                                    SubObjectiveEvaluation."Weight %" := SubPCObjective."Assigned Weight (%)";
                                    SubObjectiveEvaluation.Insert(true);

                                until SubPCObjective.Next = 0;
                            end;
                        //End Sub Objective OutCome


                        until PCObjective.Next = 0;
                    end;

                    SecondaryPCObjective.Reset;
                    SecondaryPCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    if SecondaryPCObjective.FindFirst then begin
                        repeat
                        //SecondaryPCObjective.TESTFIELD("Due Date");
                        until SecondaryPCObjective.Next = 0;
                    end;

                    SecondaryPCObjective.Reset;
                    SecondaryPCObjective.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    SecondaryPCObjective.SetRange("Due Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                    if SecondaryPCObjective.FindFirst then begin
                        repeat
                            AchievedTarget := 0;
                            PlogLines.Reset;
                            PlogLines.SetRange("Personal Scorecard ID", SecondaryPCObjective."Workplan No.");
                            PlogLines.SetRange("Initiative No.", SecondaryPCObjective."Initiative No.");
                            PlogLines.SetRange("Achieved Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                            PlogLines.CalcSums("Achieved Target");
                            AchievedTarget := PlogLines."Achieved Target";

                            /* IF AchievedTarget=0 THEN
                                ERROR('Performance Logs for Appraisal of Period  %1 and to %2 must be Updated first',"Evaluation Start Date","Evaluation End Date"); */


                            ObjectiveOutcome.Init;
                            ObjectiveOutcome."Performance Evaluation ID" := PerfomanceEvaluation.No;
                            ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                            ObjectiveOutcome."Scorecard ID" := SecondaryPCObjective."Workplan No.";
                            ObjectiveOutcome."Intiative No" := SecondaryPCObjective."Initiative No.";
                            ObjectiveOutcome."Objective/Initiative" := SecondaryPCObjective."Objective/Initiative";
                            ObjectiveOutcome."Primary Department" := PerfomanceEvaluation.Department;
                            // ObjectiveOutcome."Primary Division" := PerfomanceEvaluation.Division;
                            ObjectiveOutcome."Outcome Perfomance Indicator" := SecondaryPCObjective."Outcome Perfomance Indicator";
                            //ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                            ObjectiveOutcome."Target Qty" := SecondaryPCObjective."Imported Annual Target Qty";
                            ObjectiveOutcome."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                            ObjectiveOutcome.Validate("Performance Rating Scale");
                            ObjectiveOutcome."Self-Review Qty" := AchievedTarget;
                            ObjectiveOutcome."AppraiserReview Qty" := AchievedTarget;
                            ObjectiveOutcome."Final/Actual Qty" := AchievedTarget;
                            ObjectiveOutcome."Desired Perfomance Direction" := SecondaryPCObjective."Desired Perfomance Direction";
                            ObjectiveOutcome."Weight %" := SecondaryPCObjective."Assigned Weight (%)";
                            ObjectiveOutcome.Insert(true);
                        until SecondaryPCObjective.Next = 0;
                    end;
                end;
                if (SPMGeneralSetup."Allow Loading of JD" = true) then begin
                    PCJobDescription.Reset;
                    PCJobDescription.SetRange("Workplan No.", PerfomanceEvaluation."Personal Scorecard ID");
                    PCJobDescription.SetRange("Due Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                    if PCJobDescription.FindFirst then begin
                        repeat
                            AchievedTarget := 0;
                            PlogLines.Reset;
                            PlogLines.SetRange("Personal Scorecard ID", PCJobDescription."Workplan No.");
                            PlogLines.SetRange("Initiative No.", Format(PCJobDescription."Line Number"));
                            PlogLines.SetRange("Achieved Date", PerfomanceEvaluation."Evaluation Start Date", PerfomanceEvaluation."Evaluation End Date");
                            PlogLines.CalcSums("Achieved Target");
                            AchievedTarget := PlogLines."Achieved Target";

                            /*IF AchievedTarget=0 THEN
                               ERROR('Performance Logs for Appraisal of Period  %1 and to %2 must be Updated first',"Evaluation Start Date","Evaluation End Date"); */

                            ObjectiveOutcome.Init;
                            ObjectiveOutcome."Performance Evaluation ID" := PerfomanceEvaluation.No;
                            ObjectiveOutcome."Line No" := FnGetLastLineNo + 1;
                            ObjectiveOutcome."Scorecard ID" := PCJobDescription."Workplan No.";
                            ObjectiveOutcome."Intiative No" := Format(PCJobDescription."Line Number");
                            ObjectiveOutcome."Objective/Initiative" := PCJobDescription.Description;
                            ObjectiveOutcome."Primary Department" := PerfomanceEvaluation.Department;
                            // ObjectiveOutcome."Primary Division" := PerfomanceEvaluation.Division;
                            ObjectiveOutcome."Outcome Perfomance Indicator" := PCJobDescription."Outcome Perfomance Indicator";
                            //ObjectiveOutcome.Validate("Outcome Perfomance Indicator");
                            ObjectiveOutcome."Target Qty" := PCJobDescription."Imported Annual Target Qty";
                            ObjectiveOutcome."Performance Rating Scale" := PerfomanceEvaluation."Performance Rating Scale";
                            ObjectiveOutcome."Desired Perfomance Direction" := PCJobDescription."Desired Perfomance Direction";
                            ObjectiveOutcome.Validate("Performance Rating Scale");
                            ObjectiveOutcome."Weight %" := PCJobDescription."Assigned Weight (%)";
                            ObjectiveOutcome."Self-Review Qty" := AchievedTarget;
                            ObjectiveOutcome."AppraiserReview Qty" := AchievedTarget;
                            ObjectiveOutcome."Final/Actual Qty" := AchievedTarget;
                            ObjectiveOutcome.Validate("Final/Actual Qty");
                            ObjectiveOutcome.Insert(true);
                        until PCJobDescription.Next = 0;
                    end;
                end;
            end;
        end;

    end;

    procedure FnInsertSubObjectiveEvaluation(lineno: Integer; docNo: Code[100]; initiativeNo: Code[100]; finalTarget: Decimal) status: Text
    var
        SubObjectiveEvaluation: Record "Sub Objective Evaluation";
    begin
        SubObjectiveEvaluation.Reset;
        SubObjectiveEvaluation.SetRange("Line No", lineno);
        SubObjectiveEvaluation.SetRange("Intiative No", initiativeNo);
        SubObjectiveEvaluation.SetRange("Performance Evaluation ID", docNo);
        if SubObjectiveEvaluation.FindSet then begin
            SubObjectiveEvaluation."Final/Actual Qty" := finalTarget;
            if SubObjectiveEvaluation.Modify(true) then begin
                status := 'success*The sub objectives outcome final quantity has been saved successfully';
            end else begin
                status := 'danger*The sub objectives outcome final quantity could not be saved, kindly try again!';
            end;
        end;
    end;

    procedure FnGetLastSubPcLineNo() LineNumber: Integer
    var
        Billable: Record "Sub Objective Evaluation";
    begin
    end;

    procedure SendSelfSupervisorAppraisalToEmployee(PerfomanceEvaluation: Record "Performance Evaluation")
    var

    begin
        PerfomanceEvaluation."Supervisor Confirm" := true;
        PerfomanceEvaluation.Modify;
    end;

    procedure fnSubmitSelfAppraisalObj(docNo: Code[100]; lineno: Integer; selfReviewQty: Decimal; comments: Text) status: Text
    var
        ObjectiveEvaluationResult: Record "Objective Evaluation Result";
    begin
        ObjectiveEvaluationResult.Reset;
        ObjectiveEvaluationResult.SetRange("Line No", lineno);
        ObjectiveEvaluationResult.SetRange("Performance Evaluation ID", docNo);
        if ObjectiveEvaluationResult.FindSet then begin
            ObjectiveEvaluationResult."Self-Review Qty" := selfReviewQty;
            ObjectiveEvaluationResult.Comments := comments;
            if ObjectiveEvaluationResult.Modify(true) then
                status := 'success*Self review submitted successfully'
            else
                status := 'danger*Self review could not be submitted';
        end;
    end;

    procedure fnSubmitSelfAppraisalPE(docNo: Code[100]; lineno: Integer; selfReviewQty: Decimal; comments: Text) status: Text
    var
        ProficiencyEvaluationResult: Record "Proficiency Evaluation Result";
    begin
        ProficiencyEvaluationResult.Reset;
        ProficiencyEvaluationResult.SetRange("Line No", lineno);
        ProficiencyEvaluationResult.SetRange("Performance Evaluation ID", docNo);
        if ProficiencyEvaluationResult.FindSet then begin
            ProficiencyEvaluationResult."Self-Review Qty" := selfReviewQty;
            ProficiencyEvaluationResult.Comments := comments;
            if ProficiencyEvaluationResult.Modify(true) then
                status := 'success*Self review submitted successfully'
            else
                status := 'danger*Self review could not be submitted';
        end else
            status := 'danger*Proficiency evaluation line not found';
    end;


    procedure fnDisputeCheckIn(docNo: Code[100]; reason: Text) status: Text
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            PerfomanceEvaluation."Document Status" := PerfomanceEvaluation."document status"::Draft;
            PerfomanceEvaluation."Approval Status" := PerfomanceEvaluation."approval status"::Open;
            PerfomanceEvaluation."Employee Confirm" := false;
            PerfomanceEvaluation."Supervisor Confirm" := false;
            PerfomanceEvaluation.Comments := reason;
            if PerfomanceEvaluation.Modify(true) then
                status := 'success*Check-in disputed successfully'
            else
                status := 'danger*Could not dispute check-in';
        end;
    end;

    procedure fnConfirmCheckIn(docNo: Code[100]): Text
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            PerfomanceEvaluation."Employee Confirm" := true;
            if PerfomanceEvaluation.Modify(true) then
                exit('success*Check-in confirmed successfully')
            else
                exit('danger*Could not confirm check-in');
        end else
            exit('error*Appraisal not found');
    end;

    procedure fnSubmitSupervisorAppraisalObj(docNo: Code[100]; lineno: Integer; appraiserQty: Decimal; comments: Text) status: Text
    var
        ObjectiveEvaluationResult: Record "Objective Evaluation Result";
    begin
        ObjectiveEvaluationResult.Reset;
        ObjectiveEvaluationResult.SetRange("Line No", lineno);
        ObjectiveEvaluationResult.SetRange("Performance Evaluation ID", docNo);
        if ObjectiveEvaluationResult.FindSet then begin
            ObjectiveEvaluationResult."AppraiserReview Qty" := appraiserQty;
            ObjectiveEvaluationResult.Comments := comments;
            if ObjectiveEvaluationResult.Modify(true) then
                status := 'success*Appraiser score saved successfully'
            else
                status := 'danger*Appraiser score could not be saved';
        end else
            status := 'danger*Objective evaluation line not found';
    end;

    procedure fnSubmitSupervisorAppraisalPE(docNo: Code[100]; lineno: Integer; appraiserQty: Decimal; comments: Text) status: Text
    var
        ProficiencyEvaluationResult: Record "Proficiency Evaluation Result";
    begin
        ProficiencyEvaluationResult.Reset;
        ProficiencyEvaluationResult.SetRange("Line No", lineno);
        ProficiencyEvaluationResult.SetRange("Performance Evaluation ID", docNo);
        if ProficiencyEvaluationResult.FindSet then begin
            ProficiencyEvaluationResult."AppraiserReview Qty" := appraiserQty;
            ProficiencyEvaluationResult.Comments := comments;
            if ProficiencyEvaluationResult.Modify(true) then
                status := 'success*Appraiser score saved successfully'
            else
                status := 'danger*Appraiser score could not be saved';
        end else
            status := 'danger*Proficiency evaluation line not found';
    end;

    procedure fnConfirmSupervisorAppraisal(docNo: Code[100]): Text
    var
        PerfomanceEvaluation: Record "Performance Evaluation";
    begin
        PerfomanceEvaluation.Reset;
        PerfomanceEvaluation.SetRange(No, docNo);
        if PerfomanceEvaluation.FindSet then begin
            PerfomanceEvaluation."Supervisor Confirm" := true;
            if PerfomanceEvaluation.Modify(true) then
                exit('success*Supervisor review confirmed successfully')
            else
                exit('danger*Could not confirm supervisor review');
        end else
            exit('error*Appraisal not found');
    end;
}

