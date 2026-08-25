#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Report 52211648 "Individual PC-Sub Indicators"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Performance/Layouts/Individual PC-Sub Indicators.rdlc';

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
            dataitem("Company Information"; "Company Information")
            {
                column(ReportForNavId_124; 124)
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
            dataitem("PC Job Description"; "PC Job Description")
            {
                DataItemLink = "Workplan No." = field(No);
                column(ReportForNavId_71; 71)
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
                column(StartDate_PCJobDescription; "PC Job Description"."Start Date")
                {
                }
                column(DueDate_PCJobDescription; "PC Job Description"."Due Date")
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
                dataitem("Sub JD Objective"; "Sub JD Objective")
                {
                    DataItemLink = "Workplan No." = field("Workplan No."), "Line Number" = field("Line Number");
                    column(ReportForNavId_72; 72)
                    {
                    }
                    column(WorkplanNo_SubJDObjective; "Sub JD Objective"."Workplan No.")
                    {
                    }
                    column(LineNumber_SubJDObjective; "Sub JD Objective"."Line Number")
                    {
                    }
                    column(Description_SubJDObjective; "Sub JD Objective".Description)
                    {
                    }
                    column(GoalID_SubJDObjective; "Sub JD Objective"."Goal ID")
                    {
                    }
                    column(InitiativeType_SubJDObjective; "Sub JD Objective"."Initiative Type")
                    {
                    }
                    column(TaskType_SubJDObjective; "Sub JD Objective"."Task Type")
                    {
                    }
                    column(Indentation_SubJDObjective; "Sub JD Objective".Indentation)
                    {
                    }
                    column(Totaling_SubJDObjective; "Sub JD Objective".Totaling)
                    {
                    }
                    column(Progress_SubJDObjective; "Sub JD Objective".Progress)
                    {
                    }
                    column(Complete_SubJDObjective; "Sub JD Objective"."%Complete")
                    {
                    }
                    column(PriorityLevel_SubJDObjective; "Sub JD Objective"."Priority Level")
                    {
                    }
                    column(StrategyPlanID_SubJDObjective; "Sub JD Objective"."Strategy Plan ID")
                    {
                    }
                    column(YearReportingCode_SubJDObjective; "Sub JD Objective"."Year Reporting Code")
                    {
                    }
                    column(StartDate_SubJDObjective; "Sub JD Objective"."Start Date")
                    {
                    }
                    column(DueDate_SubJDObjective; "Sub JD Objective"."Due Date")
                    {
                    }
                    column(OverallOwner_SubJDObjective; "Sub JD Objective"."Overall Owner")
                    {
                    }
                    column(OutcomePerfomanceIndicator_SubJDObjective; "Sub JD Objective"."Outcome Perfomance Indicator")
                    {
                    }
                    column(UnitofMeasure_SubJDObjective; "Sub JD Objective"."Unit of Measure")
                    {
                    }
                    column(DesiredPerfomanceDirection_SubJDObjective; "Sub JD Objective"."Desired Perfomance Direction")
                    {
                    }
                    column(KPIType_SubJDObjective; "Sub JD Objective"."KPI Type")
                    {
                    }
                    column(ImportedAnnualTargetQty_SubJDObjective; "Sub JD Objective"."Imported Annual Target Qty")
                    {
                    }
                    column(Q1TargetQty_SubJDObjective; "Sub JD Objective"."Q1 Target Qty")
                    {
                    }
                    column(Q1SelfReviewQty_SubJDObjective; "Sub JD Objective"."Q1 Self-Review Qty")
                    {
                    }
                    column(Q1ManagerReviewQty_SubJDObjective; "Sub JD Objective"."Q1 ManagerReview Qty")
                    {
                    }
                    column(Q1ActualQty_SubJDObjective; "Sub JD Objective"."Q1 Actual Qty")
                    {
                    }
                    column(Q2TargetQty_SubJDObjective; "Sub JD Objective"."Q2 Target Qty")
                    {
                    }
                    column(Q2SelfReviewQty_SubJDObjective; "Sub JD Objective"."Q2 Self-Review Qty")
                    {
                    }
                    column(Q2ManagerReviewQty_SubJDObjective; "Sub JD Objective"."Q2 ManagerReview Qty")
                    {
                    }
                    column(Q2ActualQty_SubJDObjective; "Sub JD Objective"."Q2 Actual Qty")
                    {
                    }
                    column(Q3TargetQty_SubJDObjective; "Sub JD Objective"."Q3 Target Qty")
                    {
                    }
                    column(Q3SelfReviewQty_SubJDObjective; "Sub JD Objective"."Q3 Self-Review Qty")
                    {
                    }
                    column(Q3ManagerReviewQty_SubJDObjective; "Sub JD Objective"."Q3 ManagerReview Qty")
                    {
                    }
                    column(Q3ActualQty_SubJDObjective; "Sub JD Objective"."Q3 Actual Qty")
                    {
                    }
                    column(Q4TargetQty_SubJDObjective; "Sub JD Objective"."Q4 Target Qty")
                    {
                    }
                    column(Q4SelfReviewQty_SubJDObjective; "Sub JD Objective"."Q4 Self-Review Qty")
                    {
                    }
                    column(Q4ManagerReviewQty_SubJDObjective; "Sub JD Objective"."Q4 ManagerReview Qty")
                    {
                    }
                    column(Q4ActualQty_SubJDObjective; "Sub JD Objective"."Q4 Actual Qty")
                    {
                    }
                    column(GlobalDimension1Code_SubJDObjective; "Sub JD Objective"."Global Dimension 1 Code")
                    {
                    }
                    column(GlobalDimension2Code_SubJDObjective; "Sub JD Objective"."Global Dimension 2 Code")
                    {
                    }
                    column(PlanningDateFilter_SubJDObjective; "Sub JD Objective"."Planning Date Filter")
                    {
                    }
                    column(GoalTemplateID_SubJDObjective; "Sub JD Objective"."Goal Template ID")
                    {
                    }
                    column(SubInitiativeNo_SubJDObjective; "Sub JD Objective"."Sub Initiative No.")
                    {
                    }
                    column(SubTargets_SubJDObjective; "Sub JD Objective"."Sub Targets")
                    {
                    }
                    column(EntryNumber_SubJDObjective; "Sub JD Objective"."Entry Number")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        PCJobDescription.Reset;
                        PCJobDescription.SetRange("Line Number", "Sub JD Objective"."Line Number");
                        if PCJobDescription.FindFirst then begin
                            JobDescription := PCJobDescription.Description;
                        end;
                    end;
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
                column(AnnualWorkplanAchievedTarget_PCObjective; "PC Objective"."Individual Achieved Targets")
                {
                }
                dataitem("Sub PC Objective"; "Sub PC Objective")
                {
                    DataItemLink = "Workplan No." = field("Workplan No."), "Initiative No." = field("Initiative No.");
                    column(ReportForNavId_63; 63)
                    {
                    }
                    column(InitiativeNo_SubPCObjective; "Sub PC Objective"."Initiative No.")
                    {
                    }
                    column(SubInitiativeNo_SubPCObjective; "Sub PC Objective"."Sub Initiative No.")
                    {
                    }
                    column(ObjectiveName; ObjectiveName)
                    {
                    }
                    column(ObjectiveInitiative_SubPCObjective; "Sub PC Objective"."Objective/Initiative")
                    {
                    }
                    column(SubTargets_SubPCObjective; "Sub PC Objective"."Imported Annual Target Qty")
                    {
                    }
                    column(StartDate_SubPCObjective; "Sub PC Objective"."Start Date")
                    {
                    }
                    column(OutcomePerfomanceIndicator_SubPCObjective; "Sub PC Objective"."Outcome Perfomance Indicator")
                    {
                    }
                    column(DueDate_SubPCObjective; "Sub PC Objective"."Due Date")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        PCObjective.Reset;
                        PCObjective.SetRange("Initiative No.", "Sub PC Objective"."Initiative No.");
                        if PCObjective.FindFirst then begin
                            ObjectiveName := PCObjective."Objective/Initiative";
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    "PC Objective".CalcFields("PC Objective"."Individual Achieved Targets");
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
        ObjectiveName: Text[200];
        PCObjective: Record "PC Objective";
        PCJobDescription: Record "PC Job Description";
        JobDescription: Text;
}

