#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Query 52211638 "PerfomanceEvaluation"
{

    elements
    {
        dataitem(Perfomance_Evaluation; "Performance Evaluation")
        {
            column(No; No)
            {
            }
            column(Performance_Mgt_Plan_ID; "Performance Mgt Plan ID")
            {
            }
            column(Performance_Task_ID; "Performance Task ID")
            {
            }
            column(Employee_No; "Employee No.")
            {
            }
            column(Employee_Name; "Employee Name")
            {
            }
            column(Current_Designation; "Current Designation")
            {
            }
            column(Current_Grade; "Current Grade")
            {
            }
            column(Supervisor_Staff_No; "Immediate Supervisor No.")
            {
            }
            column(Supervisor_Name; "Immediate Supervisor Name")
            {
            }
            column(Strategy_Plan_ID; "Strategy Plan ID")
            {
            }
            column(Description; Description)
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(Evaluation_Start_Date; "Evaluation Start Date")
            {
            }
            column(Evaluation_End_Date; "Evaluation End Date")
            {
            }
            column(Appraisal_Template_ID; "Appraisal Template ID")
            {
            }
            column(Evaluation_Type; "Evaluation Type")
            {
            }
            column(Personal_Scorecard_ID; "Personal Scorecard ID")
            {
            }
            column(Competency_Template_ID; "Competency Template ID")
            {
            }
            column(General_Assessment_Template_ID; "General Assessment Template ID")
            {
            }
            // column("360_Degree_Assessment_Temp_ID";"360-Degree Assessment Temp ID")
            // {
            // }
            column(Objective_Outcome_Weight; "Objective & Outcome Weight %")
            {
            }
            column(Competency_Weight; "Competency Weight %")
            {
            }
            column(Total_Weight; "Total Weight %")
            {
            }
            column(Performance_Rating_Scale; "Performance Rating Scale")
            {
            }
            column(Proficiency_Rating_Scale; "Proficiency Rating Scale")
            {
            }
            column(Department; Department)
            {
            }
            // column(Department; Division)
            // {
            // }
            column(Annual_Reporting_Code; "Annual Reporting Code")
            {
            }
            column(Approval_Status; "Approval Status")
            {
            }
            column(Blocked; "Blocked?")
            {
            }
            column(Created_By; "Created By")
            {
            }
            column(Created_On; "Created On")
            {
            }
            column(Last_Evaluation_Date; "Last Evaluation Date")
            {
            }
            column(Document_Type; "Document Type")
            {
            }
            column(Appealed_Performance_Eval_id; "Appealed Performance Eval id")
            {
            }
            column(No_Series; "No. Series")
            {
            }
            column(Document_Status; "Document Status")
            {
            }
            column(Closed; Closed)
            {
            }
            column(Closed_By; "Closed By")
            {
            }
            column(Closed_On; "Closed On")
            {
            }
            column(Review_Period; "Review Period")
            {
            }
            column(Total_Final_Weighted_Score; "Total Final Weighted Score")
            {
            }
            column(Total_Proficiency_Score; "Total Proficiency Score")
            {
            }
            column(Total_Raw_Score; "Total Raw Score")
            {
            }
            dataitem(Corporate_Strategic_Plans; "Corporate Strategic Plans")
            {
                DataItemLink = Code = Perfomance_Evaluation."Strategy Plan ID";
                column(CspDescription; Description)
                {
                }
                dataitem(Performance_Management_Plan; "Performance Management Plan")
                {
                    DataItemLink = No = Perfomance_Evaluation."Performance Mgt Plan ID";
                    column(pmpDescription; Description)
                    {
                    }
                }
            }
        }
    }
}

