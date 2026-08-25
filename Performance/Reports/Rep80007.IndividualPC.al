#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Report 52211645 "Individual PC"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './src/Performance/Layouts/Individual PC.rdlc';

    dataset
    {
        dataitem("Perfomance Contract Header"; "Perfomance Contract Header")
        {
            RequestFilterFields = No;
            column(ReportForNavId_1; 1)
            {
            }
            column(No_PerfomanceContractHeader; "Perfomance Contract Header".No)
            {
            }
            column(DocumentType_PerfomanceContractHeader; "Perfomance Contract Header"."Document Type")
            {
            }
            column(Description_PerfomanceContractHeader; "Perfomance Contract Header".Description)
            {
            }
            column(DocumentDate_PerfomanceContractHeader; "Perfomance Contract Header"."Document Date")
            {
            }
            column(ObjectiveSettingDueDate_PerfomanceContractHeader; "Perfomance Contract Header"."Objective Setting Due Date")
            {
            }
            column(StrategyPlanID_PerfomanceContractHeader; "Perfomance Contract Header"."Strategy Plan ID")
            {
            }
            column(AnnualReportingCode_PerfomanceContractHeader; "Perfomance Contract Header"."Annual Reporting Code")
            {
            }
            column(StartDate_PerfomanceContractHeader; "Perfomance Contract Header"."Start Date")
            {
            }
            column(EndDate_PerfomanceContractHeader; "Perfomance Contract Header"."End Date")
            {
            }
            column(AnnualWorkplan_PerfomanceContractHeader; "Perfomance Contract Header"."Annual Workplan")
            {
            }
            column(CompanyInfoName; CompInfo.Name)
            {
            }
            column(CompanyInfoPicture; CompInfo.Picture)
            {
            }
            column(ResponsibleEmployeeNo_PerfomanceContractHeader; "Perfomance Contract Header"."Responsible Employee No.")
            {
            }
            column(EmployeeName_PerfomanceContractHeader; "Perfomance Contract Header"."Employee Name")
            {
            }
            column(Designation_PerfomanceContractHeader; "Perfomance Contract Header".Designation)
            {
            }
            column(Grade_PerfomanceContractHeader; "Perfomance Contract Header".Grade)
            {
            }
            column(ResponsibilityCenter_PerfomanceContractHeader; "Perfomance Contract Header"."Responsibility Center")
            {
            }
            column(ResponsibilityCenterName_PerfomanceContractHeader; "Perfomance Contract Header"."Responsibility Center Name")
            {
            }
            dataitem("PC Job Description"; "PC Job Description")
            {
                DataItemLink = "Workplan No." = field(No);
                column(ReportForNavId_127; 127)
                {
                }
                column(WorkplanNo_PCJobDescription; "PC Job Description"."Workplan No.")
                {
                }
                column(LineNumber_PCJobDescription; "PC Job Description"."Line Number")
                {
                }
                column(Description_PCJobDescription; "PC Job Description".Description)
                {
                }
                column(Progress_PCJobDescription; "PC Job Description".Progress)
                {
                }
                column(Complete_PCJobDescription; "PC Job Description"."%Complete")
                {
                }
                column(PriorityLevel_PCJobDescription; "PC Job Description"."Priority Level")
                {
                }
                column(YearReportingCode_PCJobDescription; "PC Job Description"."Year Reporting Code")
                {
                }
                column(StartDate_PCJobDescription; Format("PC Job Description"."Start Date"))
                {
                }
                column(DueDate_PCJobDescription; Format("PC Job Description"."Due Date"))
                {
                }
                column(PrimaryDirectorate_PCJobDescription; "PC Job Description"."Primary Department")
                {
                }
                column(OverallOwner_PCJobDescription; "PC Job Description"."Overall Owner")
                {
                }
                column(OutcomePerfomanceIndicator_PCJobDescription; "PC Job Description"."Outcome Perfomance Indicator")
                {
                }
                column(UnitofMeasure_PCJobDescription; "PC Job Description"."Unit of Measure")
                {
                }
                column(DesiredPerfomanceDirection_PCJobDescription; "PC Job Description"."Desired Perfomance Direction")
                {
                }
                column(KPIType_PCJobDescription; "PC Job Description"."KPI Type")
                {
                }
                column(ImportedAnnualTargetQty_PCJobDescription; "PC Job Description"."Imported Annual Target Qty")
                {
                }
                column(GlobalDimension1Code_PCJobDescription; "PC Job Description"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_PCJobDescription; "PC Job Description"."Global Dimension 2 Code")
                {
                }
                column(IndividualAchievedTargets_PCJobDescription; "PC Job Description"."Individual Achieved Targets")
                {
                }
                column(AssignedWeight_PCJobDescription; "PC Job Description"."Assigned Weight (%)")
                {
                }
                column(PlogAchievedTargets_PCJobDescription; "PC Job Description"."Plog Achieved Targets")
                {
                }
                column(Datefilter_PCJobDescription; "PC Job Description"."Date filter")
                {
                }
                column(EntryNo_PCJobDescription; "PC Job Description"."Entry No")
                {
                }
            }
            dataitem("PC Objective"; "PC Objective")
            {
                DataItemLink = "Workplan No." = field(No);
                column(ReportForNavId_17; 17)
                {
                }
                column(WorkplanNo_PCObjective; "PC Objective"."Workplan No.")
                {
                }
                column(InitiativeNo_PCObjective; "PC Objective"."Initiative No.")
                {
                }
                column(ObjectiveInitiative_PCObjective; "PC Objective"."Objective/Initiative")
                {
                }
                column(GoalID_PCObjective; "PC Objective"."Goal ID")
                {
                }
                column(InitiativeType_PCObjective; "PC Objective"."Initiative Type")
                {
                }
                column(TaskType_PCObjective; "PC Objective"."Task Type")
                {
                }
                column(Indentation_PCObjective; "PC Objective".Indentation)
                {
                }
                column(Totaling_PCObjective; "PC Objective".Totaling)
                {
                }
                column(Progress_PCObjective; "PC Objective".Progress)
                {
                }
                column(Complete_PCObjective; "PC Objective"."%Complete")
                {
                }
                column(PriorityLevel_PCObjective; "PC Objective"."Priority Level")
                {
                }
                column(StrategyPlanID_PCObjective; "PC Objective"."Strategy Plan ID")
                {
                }
                column(YearReportingCode_PCObjective; "PC Objective"."Year Reporting Code")
                {
                }
                column(StartDate_PCObjective; "PC Objective"."Start Date")
                {
                }
                column(DueDate_PCObjective; "PC Objective"."Due Date")
                {
                }
                column(PrimaryDirectorate_PCObjective; "PC Objective"."Primary Department")
                {
                }
                column(OverallOwner_PCObjective; "PC Objective"."Overall Owner")
                {
                }
                column(OutcomePerfomanceIndicator_PCObjective; "PC Objective"."Outcome Perfomance Indicator")
                {
                }
                column(UnitofMeasure_PCObjective; "PC Objective"."Unit of Measure")
                {
                }
                column(DesiredPerfomanceDirection_PCObjective; "PC Objective"."Desired Perfomance Direction")
                {
                }
                column(KPIType_PCObjective; "PC Objective"."KPI Type")
                {
                }
                column(ImportedAnnualTargetQty_PCObjective; "PC Objective"."Imported Annual Target Qty")
                {
                }
                column(Q1TargetQty_PCObjective; "PC Objective"."Q1 Target Qty")
                {
                }
                column(Q1SelfReviewQty_PCObjective; "PC Objective"."Q1 Self-Review Qty")
                {
                }
                column(Q1ManagerReviewQty_PCObjective; "PC Objective"."Q1 ManagerReview Qty")
                {
                }
                column(Q1ActualQty_PCObjective; "PC Objective"."Q1 Actual Qty")
                {
                }
                column(Q2TargetQty_PCObjective; "PC Objective"."Q2 Target Qty")
                {
                }
                column(Q2SelfReviewQty_PCObjective; "PC Objective"."Q2 Self-Review Qty")
                {
                }
                column(Q2ManagerReviewQty_PCObjective; "PC Objective"."Q2 ManagerReview Qty")
                {
                }
                column(Q2ActualQty_PCObjective; "PC Objective"."Q2 Actual Qty")
                {
                }
                column(Q3TargetQty_PCObjective; "PC Objective"."Q3 Target Qty")
                {
                }
                column(Q3SelfReviewQty_PCObjective; "PC Objective"."Q3 Self-Review Qty")
                {
                }
                column(Q3ManagerReviewQty_PCObjective; "PC Objective"."Q3 ManagerReview Qty")
                {
                }
                column(Q3ActualQty_PCObjective; "PC Objective"."Q3 Actual Qty")
                {
                }
                column(Q4TargetQty_PCObjective; "PC Objective"."Q4 Target Qty")
                {
                }
                column(Q4SelfReviewQty_PCObjective; "PC Objective"."Q4 Self-Review Qty")
                {
                }
                column(Q4ManagerReviewQty_PCObjective; "PC Objective"."Q4 ManagerReview Qty")
                {
                }
                column(Q4ActualQty_PCObjective; "PC Objective"."Q4 Actual Qty")
                {
                }
                column(GlobalDimension1Code_PCObjective; "PC Objective"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_PCObjective; "PC Objective"."Global Dimension 2 Code")
                {
                }
                column(PlanningDateFilter_PCObjective; "PC Objective"."Planning Date Filter")
                {
                }
                column(GoalTemplateID_PCObjective; "PC Objective"."Goal Template ID")
                {
                }
                column(AnnualWorkplanAchievedTarget_PCObjective; AchievedTargets)
                {
                }
                column(KeyPerformanceIndicator_PCObjective; "PC Objective"."Key Performance Indicator")
                {
                }
                column(PrimaryDirectorateName_PCObjective; "PC Objective"."Primary Department Name")
                {
                }
                column(AssignedWeight_PCObjective; "PC Objective"."Assigned Weight (%)")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //"PC Objective".CALCFIELDS("PC Objective"."Individual Achieved Targets");
                    AchievedTargets := 0;
                    AchievedTargets := FnGetAchievedTargets("PC Objective"."Workplan No.", "PC Objective"."Initiative No.");
                end;
            }
            dataitem("Secondary PC Objective"; "Secondary PC Objective")
            {
                DataItemLink = "Workplan No." = field(No);
                column(ReportForNavId_76; 76)
                {
                }
                column(WorkplanNo_SecondaryPCObjective; "Secondary PC Objective"."Workplan No.")
                {
                }
                column(InitiativeNo_SecondaryPCObjective; "Secondary PC Objective"."Initiative No.")
                {
                }
                column(ObjectiveInitiative_SecondaryPCObjective; "Secondary PC Objective"."Objective/Initiative")
                {
                }
                column(GoalID_SecondaryPCObjective; "Secondary PC Objective"."Goal ID")
                {
                }
                column(InitiativeType_SecondaryPCObjective; "Secondary PC Objective"."Initiative Type")
                {
                }
                column(TaskType_SecondaryPCObjective; "Secondary PC Objective"."Task Type")
                {
                }
                column(Indentation_SecondaryPCObjective; "Secondary PC Objective".Indentation)
                {
                }
                column(Totaling_SecondaryPCObjective; "Secondary PC Objective".Totaling)
                {
                }
                column(Progress_SecondaryPCObjective; "Secondary PC Objective".Progress)
                {
                }
                column(Complete_SecondaryPCObjective; "Secondary PC Objective"."%Complete")
                {
                }
                column(PriorityLevel_SecondaryPCObjective; "Secondary PC Objective"."Priority Level")
                {
                }
                column(StrategyPlanID_SecondaryPCObjective; "Secondary PC Objective"."Strategy Plan ID")
                {
                }
                column(YearReportingCode_SecondaryPCObjective; "Secondary PC Objective"."Year Reporting Code")
                {
                }
                column(StartDate_SecondaryPCObjective; "Secondary PC Objective"."Start Date")
                {
                }
                column(DueDate_SecondaryPCObjective; "Secondary PC Objective"."Due Date")
                {
                }
                column(PrimaryDirectorate_SecondaryPCObjective; "Secondary PC Objective"."Primary Department")
                {
                }
                column(OverallOwner_SecondaryPCObjective; "Secondary PC Objective"."Overall Owner")
                {
                }
                column(OutcomePerfomanceIndicator_SecondaryPCObjective; "Secondary PC Objective"."Outcome Perfomance Indicator")
                {
                }
                column(UnitofMeasure_SecondaryPCObjective; "Secondary PC Objective"."Unit of Measure")
                {
                }
                column(DesiredPerfomanceDirection_SecondaryPCObjective; "Secondary PC Objective"."Desired Perfomance Direction")
                {
                }
                column(KPIType_SecondaryPCObjective; "Secondary PC Objective"."KPI Type")
                {
                }
                column(ImportedAnnualTargetQty_SecondaryPCObjective; "Secondary PC Objective"."Imported Annual Target Qty")
                {
                }
                column(Q1TargetQty_SecondaryPCObjective; "Secondary PC Objective"."Q1 Target Qty")
                {
                }
                column(Q1SelfReviewQty_SecondaryPCObjective; "Secondary PC Objective"."Q1 Self-Review Qty")
                {
                }
                column(Q1ManagerReviewQty_SecondaryPCObjective; "Secondary PC Objective"."Q1 ManagerReview Qty")
                {
                }
                column(Q1ActualQty_SecondaryPCObjective; "Secondary PC Objective"."Q1 Actual Qty")
                {
                }
                column(Q2TargetQty_SecondaryPCObjective; "Secondary PC Objective"."Q2 Target Qty")
                {
                }
                column(Q2SelfReviewQty_SecondaryPCObjective; "Secondary PC Objective"."Q2 Self-Review Qty")
                {
                }
                column(Q2ManagerReviewQty_SecondaryPCObjective; "Secondary PC Objective"."Q2 ManagerReview Qty")
                {
                }
                column(Q2ActualQty_SecondaryPCObjective; "Secondary PC Objective"."Q2 Actual Qty")
                {
                }
                column(Q3TargetQty_SecondaryPCObjective; "Secondary PC Objective"."Q3 Target Qty")
                {
                }
                column(Q3SelfReviewQty_SecondaryPCObjective; "Secondary PC Objective"."Q3 Self-Review Qty")
                {
                }
                column(Q3ManagerReviewQty_SecondaryPCObjective; "Secondary PC Objective"."Q3 ManagerReview Qty")
                {
                }
                column(Q3ActualQty_SecondaryPCObjective; "Secondary PC Objective"."Q3 Actual Qty")
                {
                }
                column(Q4TargetQty_SecondaryPCObjective; "Secondary PC Objective"."Q4 Target Qty")
                {
                }
                column(Q4SelfReviewQty_SecondaryPCObjective; "Secondary PC Objective"."Q4 Self-Review Qty")
                {
                }
                column(Q4ManagerReviewQty_SecondaryPCObjective; "Secondary PC Objective"."Q4 ManagerReview Qty")
                {
                }
                column(Q4ActualQty_SecondaryPCObjective; "Secondary PC Objective"."Q4 Actual Qty")
                {
                }
                column(GlobalDimension1Code_SecondaryPCObjective; "Secondary PC Objective"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_SecondaryPCObjective; "Secondary PC Objective"."Global Dimension 2 Code")
                {
                }
                column(PlanningDateFilter_SecondaryPCObjective; "Secondary PC Objective"."Planning Date Filter")
                {
                }
                column(GoalTemplateID_SecondaryPCObjective; "Secondary PC Objective"."Goal Template ID")
                {
                }
                column(EntryNo_SecondaryPCObjective; "Secondary PC Objective".EntryNo)
                {
                }
                column(IndividualAchievedTargets_SecondaryPCObjective; "Secondary PC Objective"."Individual Achieved Targets")
                {
                }
                column(FunctionalAchievedTargets_SecondaryPCObjective; "Secondary PC Objective"."Functional Achieved Targets")
                {
                }
                column(CEOAchievedTargets_SecondaryPCObjective; "Secondary PC Objective"."CEO Achieved Targets")
                {
                }
                column(BoardAchievedTargets_SecondaryPCObjective; "Secondary PC Objective"."Board Achieved Targets")
                {
                }
                column(AnnualWorkplanAchievedTarget_SecondaryPCObjective; "Secondary PC Objective"."AnnualWorkplan Achieved Target")
                {
                }
                column(AssignedWeight_SecondaryPCObjective; "Secondary PC Objective"."Assigned Weight (%)")
                {
                }
                column(PlogAchievedTargets_SecondaryPCObjective; "Secondary PC Objective"."Plog Achieved Targets")
                {
                }
                column(Datefilter_SecondaryPCObjective; "Secondary PC Objective"."Date filter")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE('%1',SecondaryPCObjective."Initiative No.")
                end;
            }
            dataitem("Company Information"; "Company Information")
            {
                column(ReportForNavId_75; 75)
                {
                }
                column(Name_CompanyInformation; "Company Information".Name)
                {
                }
                column(Name2_CompanyInformation; "Company Information"."Name 2")
                {
                }
                column(Address_CompanyInformation; "Company Information".Address)
                {
                }
                column(Address2_CompanyInformation; "Company Information"."Address 2")
                {
                }
                column(City_CompanyInformation; "Company Information".City)
                {
                }
                column(Picture_CompanyInformation; "Company Information".Picture)
                {
                }
                column(PostCode_CompanyInformation; "Company Information"."Post Code")
                {
                }
                column(County_CompanyInformation; "Company Information".County)
                {
                }
                column(CountryName; CountryName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*Country.RESET;
                    Country.SETRANGE(Code, "Company Information"."Country/Region Code");
                    IF Country.FINDSET THEN
                      CountryName:=Country.Name;*/


                    if Country.Get("Company Information"."Country/Region Code") then
                        CountryName := Country.Name;

                end;
            }

            trigger OnPreDataItem()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Country: Record "Country/Region";
        CountryName: Code[100];
        CompInfo: Record "Company Information";
        AchievedTargets: Decimal;
        SecondaryPCObjective: Record "Secondary PC Objective";


    procedure FnGetAchievedTargets(PCNumber: Code[50]; ActivityID: Code[50]) AchievedT: Decimal
    var
        PCObjective: Record "PC Objective";
    begin
        AchievedT := 0;
        PCObjective.Reset;
        PCObjective.SetRange("Workplan No.", PCNumber);
        PCObjective.SetRange("Initiative No.", ActivityID);
        if PCObjective.Find('-') then begin
            PCObjective.CalcFields("Individual Achieved Targets", "Functional Achieved Targets", "CEO Achieved Targets", "Board Achieved Targets",
                                  "Directors Achieved Targets", "Department Achieved Target");

            if PCObjective."Individual Achieved Targets" > 0 then
                AchievedT := PCObjective."Individual Achieved Targets";

            if PCObjective."Functional Achieved Targets" > 0 then
                AchievedT := PCObjective."Functional Achieved Targets";

            if PCObjective."CEO Achieved Targets" > 0 then
                AchievedT := PCObjective."CEO Achieved Targets";

            if PCObjective."Board Achieved Targets" > 0 then
                AchievedT := PCObjective."Board Achieved Targets";

            if PCObjective."Directors Achieved Targets" > 0 then
                AchievedT := PCObjective."Directors Achieved Targets";

            if PCObjective."Department Achieved Target" > 0 then
                AchievedT := PCObjective."Department Achieved Target";

        end;
        exit;
    end;
}

