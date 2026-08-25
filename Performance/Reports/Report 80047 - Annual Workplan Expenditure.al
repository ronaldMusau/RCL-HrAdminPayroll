report 52211650 "Annual Workplan Expenditure"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Performance/Layouts/Annual Workplan Expenditure.rdlc';

    dataset
    {
        dataitem("Annual Strategy Workplan"; "Annual Strategy Workplan")
        {
            RequestFilterFields = No;
            column(No_AnnualStrategyWorkplan; "Annual Strategy Workplan".No)
            {
            }
            column(Description_AnnualStrategyWorkplan; "Annual Strategy Workplan".Description)
            {
            }
            column(StrategyPlanID_AnnualStrategyWorkplan; "Annual Strategy Workplan"."Strategy Plan ID")
            {
            }
            column(YearReportingCode_AnnualStrategyWorkplan; "Annual Strategy Workplan"."Year Reporting Code")
            {
            }
            column(StartDate_AnnualStrategyWorkplan; "Annual Strategy Workplan"."Start Date")
            {
            }
            column(EndDate_AnnualStrategyWorkplan; "Annual Strategy Workplan"."End Date")
            {
            }
            dataitem("Strategy Workplan Lines"; "Strategy Workplan Lines")
            {
                DataItemLink = No = FIELD(No);
                column(ActivityID_StrategyWorkplanLines; "Strategy Workplan Lines"."Activity ID")
                {
                }
                column(Description_StrategyWorkplanLines; "Strategy Workplan Lines".Description)
                {
                }
                column(ImportedAnnualTargetQty_StrategyWorkplanLines; "Strategy Workplan Lines"."Imported Annual Target Qty")
                {
                }
                column(ImportedAnnualBudgetEst_StrategyWorkplanLines; "Strategy Workplan Lines"."Imported Annual Budget Est.")
                {
                }
                column(PrimaryDirectorate_StrategyWorkplanLines; "Strategy Workplan Lines"."Primary Department")
                {
                }
                column(PerfomanceIndicator_StrategyWorkplanLines; "Strategy Workplan Lines"."Perfomance Indicator")
                {
                }
                column(UnitofMeasure_StrategyWorkplanLines; "Strategy Workplan Lines"."Unit of Measure")
                {
                }
                column(KeyPerformanceIndicator_StrategyWorkplanLines; "Strategy Workplan Lines"."Key Performance Indicator")
                {
                }
                column(AssignedWeight_StrategyWorkplanLines; "Strategy Workplan Lines"."Assigned Weight(%)")
                {
                }
                column(AnnualTarget_StrategyWorkplanLines; "Strategy Workplan Lines"."Annual Target")
                {
                }
                column(AnnualBudget_StrategyWorkplanLines; "Strategy Workplan Lines"."Annual Budget")
                {
                }
                dataitem("Sub Workplan Activity"; "Sub Workplan Activity")
                {
                    DataItemLink = "Workplan No." = FIELD(No),
                                   "Activity Id" = FIELD("Activity ID");
                    column(InitiativeNo_SubWorkplanActivity; "Sub Workplan Activity"."Initiative No.")
                    {
                    }
                    column(ObjectiveInitiative_SubWorkplanActivity; "Sub Workplan Activity"."Objective/Initiative")
                    {
                    }
                    column(StartDate_SubWorkplanActivity; "Sub Workplan Activity"."Start Date")
                    {
                    }
                    column(DueDate_SubWorkplanActivity; "Sub Workplan Activity"."Due Date")
                    {
                    }
                    column(OutcomePerfomanceIndicator_SubWorkplanActivity; "Sub Workplan Activity"."Outcome Perfomance Indicator")
                    {
                    }
                    column(UnitofMeasure_SubWorkplanActivity; "Sub Workplan Activity"."Unit of Measure")
                    {
                    }
                    column(DesiredPerfomanceDirection_SubWorkplanActivity; "Sub Workplan Activity"."Desired Perfomance Direction")
                    {
                    }
                    column(ImportedAnnualTargetQty_SubWorkplanActivity; "Sub Workplan Activity"."Imported Annual Target Qty")
                    {
                    }
                    column(TotalBudget_SubWorkplanActivity; "Sub Workplan Activity"."Total Budget")
                    {
                    }
                    column(KPIType_SubWorkplanActivity; "Sub Workplan Activity"."KPI Type")
                    {
                    }
                    column(Q1TargetQty_SubWorkplanActivity; "Sub Workplan Activity"."Q1 Target Qty")
                    {
                    }
                    column(Q2TargetQty_SubWorkplanActivity; "Sub Workplan Activity"."Q2 Target Qty")
                    {
                    }
                    column(Q3TargetQty_SubWorkplanActivity; "Sub Workplan Activity"."Q3 Target Qty")
                    {
                    }
                    column(Q4TargetQty_SubWorkplanActivity; "Sub Workplan Activity"."Q4 Target Qty")
                    {
                    }
                    column(SubInitiativeNo_SubWorkplanActivity; "Sub Workplan Activity"."Sub Initiative No.")
                    {
                    }
                    column(SubTargets_SubWorkplanActivity; "Sub Workplan Activity"."Sub Targets")
                    {
                    }
                    column(ExpenseAmount_SubWorkplanActivity; "Sub Workplan Activity"."Expense Amount")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        "Sub Workplan Activity".CALCFIELDS("Expense Amount");
                    end;
                }
            }
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
}

