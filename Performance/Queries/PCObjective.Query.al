#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Query 52211630 "PCObjective"
{

    elements
    {
        dataitem(PC_Objective; "PC Objective")
        {
            column(Workplan_No; "Workplan No.")
            {
            }
            column(Initiative_No; "Initiative No.")
            {
            }
            column(Objective_Initiative; "Objective/Initiative")
            {
            }
            column(Goal_ID; "Goal ID")
            {
            }
            column(Initiative_Type; "Initiative Type")
            {
            }
            column(Task_Type; "Task Type")
            {
            }
            column(Indentation; Indentation)
            {
            }
            column(Totaling; Totaling)
            {
            }
            column(Progress; Progress)
            {
            }
            column(Complete; "%Complete")
            {
            }
            column(Priority_Level; "Priority Level")
            {
            }
            column(Strategy_Plan_ID; "Strategy Plan ID")
            {
            }
            column(Year_Reporting_Code; "Year Reporting Code")
            {
            }
            column(Start_Date; "Start Date")
            {
            }
            column(Due_Date; "Due Date")
            {
            }
            column(Primary_Department; "Primary Department")
            {
            }
            // column(Primary_Department; "Primary Division")
            // {
            // }
            column(Overall_Owner; "Overall Owner")
            {
            }
            column(Outcome_Perfomance_Indicator; "Outcome Perfomance Indicator")
            {
            }
            column(Unit_of_Measure; "Unit of Measure")
            {
            }
            column(Desired_Perfomance_Direction; "Desired Perfomance Direction")
            {
            }
            column(KPI_Type; "KPI Type")
            {
            }
            column(Imported_Annual_Target_Qty; "Imported Annual Target Qty")
            {
            }
            column(Q1_Target_Qty; "Q1 Target Qty")
            {
            }
            column(Q1_Self_Review_Qty; "Q1 Self-Review Qty")
            {
            }
            column(Q1_ManagerReview_Qty; "Q1 ManagerReview Qty")
            {
            }
            column(Q1_Actual_Qty; "Q1 Actual Qty")
            {
            }
            column(Q2_Target_Qty; "Q2 Target Qty")
            {
            }
            column(Q2_Self_Review_Qty; "Q2 Self-Review Qty")
            {
            }
            column(Q2_ManagerReview_Qty; "Q2 ManagerReview Qty")
            {
            }
            column(Q2_Actual_Qty; "Q2 Actual Qty")
            {
            }
            column(Q3_Target_Qty; "Q3 Target Qty")
            {
            }
            column(Q3_Self_Review_Qty; "Q3 Self-Review Qty")
            {
            }
            column(Q3_ManagerReview_Qty; "Q3 ManagerReview Qty")
            {
            }
            column(Q3_Actual_Qty; "Q3 Actual Qty")
            {
            }
            column(Q4_Target_Qty; "Q4 Target Qty")
            {
            }
            column(Q4_Self_Review_Qty; "Q4 Self-Review Qty")
            {
            }
            column(Q4_ManagerReview_Qty; "Q4 ManagerReview Qty")
            {
            }
            column(Q4_Actual_Qty; "Q4 Actual Qty")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }
            column(Goal_Template_ID; "Goal Template ID")
            {
            }
            column(Individual_Achieved_Targets; "Individual Achieved Targets")
            {
            }
            column(Functional_Achieved_Targets; "Functional Achieved Targets")
            {
            }
            column(CEO_Achieved_Targets; "CEO Achieved Targets")
            {
            }
            column(Board_Achieved_Targets; "Board Achieved Targets")
            {
            }
            column(AnnualWorkplan_Achieved_Target; "AnnualWorkplan Achieved Target")
            {
            }
            column(EntryNo; EntryNo)
            {
            }
            column(Assigned_Weight; "Assigned Weight (%)")
            {
            }
            column(Plog_Achieved_Targets; "Plog Achieved Targets")
            {
            }
            column(Framework_Perspective; "Framework Perspective")
            {
            }
            column(Strategy_Framework; "Strategy Framework")
            {
            }
            column(Previous_Annual_Target_Qty; "Previous Annual Target Qty")
            {
            }
            column(Additional_Comments; "Additional Comments")
            {
            }
            column(Activity_Type; "Activity Type")
            {
            }
            column(Directors_Achieved_Targets; "Directors Achieved Targets")
            {
            }
            column(Department_Achieved_Target; "Department Achieved Target")
            {
            }
            column(Key_Performance_Indicator; "Key Performance Indicator")
            {
            }
            column(Primary_Directorate_Name; "Primary Department Name")
            {
            }
            //column(Primary_Department_Name; "Primary Division Name")
            //{
            //}
            column(Principals_Achieved_Targets; "Principals Achieved Targets")
            {
            }
            column(Seniors_Achieved_Targets; "Seniors Achieved Targets")
            {
            }
            dataitem(Responsibility_Center; "Responsibility Center")
            {
                DataItemLink = Code = PC_Objective."Primary Department";
                column(primarydirectoratename; Name)
                {
                }
            }
        }
    }
}

