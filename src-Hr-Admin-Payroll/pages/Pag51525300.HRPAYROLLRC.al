page 51525300 "HR& PAYROLL R.C"
{
    ApplicationArea = All;
    Caption = 'HR ROLE CENTER';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control8; "Common Headline")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control7; "HR Cues")
            {
            }
            part(Control6; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control4; "New Employees")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control2; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control3; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = R;
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Departmental Contracts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Departmental Contracts';
                RunObject = Page "Departmental Contracts";
                Visible = false;
            }
        }
        area(processing)
        {
            group(Setups)
            {
                Caption = 'Setups';
                action("HR Setups")
                {
                    Image = Setup;
                    RunObject = Page "Human Resources Setup";
                }
            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
                action("Leave Journal")
                {
                    Image = Journal;
                    RunObject = Page "HR Leave Journal Lines";
                }
                group("LeaveReportsMenu")
                {
                    Image = LotInfo;
                    action("Leave Balances")
                    {
                        Image = Balance;
                        RunObject = Report "HR Leave Balances";
                    }
                    action("Leave Liability")
                    {
                        Image = "Report";
                        RunObject = Report "Leave Liability Report";
                    }
                    action("Hr Leave Balances All")
                    {
                        Image = "Report";
                        RunObject = Report "HR Leave Balances All";
                    }
                    action("Staff leave awaiting approval")
                    {
                        Image = "Report";
                        RunObject = Report "Staff Leave Awaiting Approval";
                    }
                    action("Individual leave analysis")
                    {
                        Image = "Report";
                        RunObject = Report "Individual Leave Analysis";
                    }
                }
            }
            group(Action85)
            {
                Caption = 'Company Information';
                action("Company Information")
                {
                    RunObject = Page "Company Information";
                }

            }
            group("Payroll Reports")
            {
                Caption = 'Payroll Reports';
                group("Management Reports")
                {
                    Caption = 'Management Reports';
                    Image = Balance;
                    action("Earnings Report")
                    {
                        RunObject = Report Earnings;
                    }
                    action("Deductions Report")
                    {
                        Caption = 'Deductions Report';
                        RunObject = Report Deductionss;
                    }
                    action("Employer Deductions")
                    {
                        Caption = 'Employer Contributions';
                        RunObject = Report "Employer Contributions";
                    }
                    action("Salary Statistics")
                    {
                        Caption = 'Salary Statistics - Detailed';
                        RunObject = Report "Detailed Payroll Statistics";//"Payroll-Statistics";
                    }
                    action("Salary Statistics - Summarized")
                    {
                        RunObject = Report "Payroll-Statistics Summarized";
                    }
                    action("Payroll Bank Advice")
                    {
                        Caption = 'Bank Pay Report';
                        //RunObject = Report "Payroll Bank Advice";
                        RunObject = Report "Payroll Bank Advice - Simp";
                    }
                    action("Payroll Variance Report")
                    {
                        Caption = 'Payroll Variance Report';
                        RunObject = Report "Payroll Variance Report";
                    }
                    action(Joiners)
                    {
                        RunObject = Report Joiners;
                    }
                    action(Leavers)
                    {
                        RunObject = Report Leavers;
                    }
                    action(Transfers)
                    {
                        RunObject = Report Transfers;
                    }
                    action("Country Payroll Summary Report")
                    {
                        RunObject = Report "Payroll Summary Report";
                    }
                    action("Gender Report")
                    {
                        RunObject = Report "Gender Report";
                    }
                    action("Employee Gross")
                    {
                        Caption = 'Cost Center Report';
                        RunObject = Report "Employee Gross";
                    }
                    action("Departmental Status Report")
                    {
                        Caption = 'Departmental Status Report';
                        RunObject = Report "Departmental Status Report";
                    }
                    action("Maternity Leave Report")
                    {
                        RunObject = Report "Maternity Leave Report";
                    }
                    action("Ten Year Service")
                    {
                        RunObject = Report "Ten Year Service";
                    }
                    /*action("Employees With less than 1/3")
                    {
                        Caption = 'Employees With less than 1/3';
                        RunObject = Report "Employees With less than 1/3";
                    }
                    action("Payroll-Statistics")
                    {
                        Caption = 'Salary Statistics';
                        RunObject = Report "Payroll-Statistics";
                    }*/
                }
                group("Statutory Reports")
                {
                    Caption = 'Statutory Reports';
                    Image = Balance;
                    action("CBHI Annexture")
                    {
                        RunObject = Report "CBHI Annexture";
                    }
                    action("Medical Annexture")
                    {
                        RunObject = Report "Medical Annexture";
                    }
                    action("Maternity Annexture")
                    {
                        RunObject = Report "Maternity Annexture";
                    }
                    action("Pension Monthly Annexture")
                    {
                        RunObject = Report "Pension Monthly Annexture";
                    }
                    action("MMI Report")
                    {
                        RunObject = Report "MMI Report";
                    }
                    action("PAYE Returns")
                    {
                        RunObject = Report "PAYE Returns";
                    }
                    action("New PAYE Annexture")
                    {
                        RunObject = Report "New PAYE Annexture";
                    }
                }
                group("Annual Reports")
                {
                    Caption = 'Annual Reports';
                    Image = Balance;
                    action("P9A Report")
                    {
                        Image = "Report";
                        RunObject = Report "P9A Report";
                        Visible = false;
                    }

                }
            }

        }
        area(sections)
        {
            group(Action81)
            {
                Caption = 'Company Information';
                Image = LotInfo;
                action(Calendar)
                {
                    RunObject = Page "HR Calendar List";
                }
                action("Company Activities")
                {
                    RunObject = Page "Employee Presents";
                }
                action("Rules & Regulations")
                {
                    RunObject = Page "Rules & Regulations";
                }
            }
            group(Establishment)
            {
                Caption = 'Establishment';
                Image = Administration;
                action(Positions)
                {
                    RunObject = Page "Company Job List";
                }
                /*action("Program Positions")
                {
                    RunObject = Page "Department Job Positions";
                }*/
                action("Job Specifications")
                {
                    RunObject = Page "Job Specification List";
                }
                action("Job Responsibilities")
                {
                    RunObject = Page "Job Responsibilties List";
                }
            }

            group(Recruitment)
            {
                Caption = 'Recruitment';
                Image = Worksheets;
                action("Recruitment Needs")
                {
                    RunObject = Page "Recruitment Needs";
                }
                action("Open Job Adverts")
                {
                    RunObject = Page "Open Job Adverts";
                }
                action("Closed Job Adverts")
                {
                    RunObject = Page "Closed Job Adverts";
                }
                action("Applicant Profiles")
                {
                    RunObject = Page "Applicants List";
                }
                action("Job Application Lists")
                {
                    //Caption = '';
                    RunObject = Page "Job Applications List";
                }
                action("Shortlisted Applicants")
                {
                    RunObject = Page "Shortlisted Applicants List";
                }
                action("Failed Shortlisting")
                {
                    RunObject = Page "Failed Shortlisting List";
                }
                action("Passed First Interview")
                {
                    RunObject = Page "Passed First Interview List";
                }
                action("Failed First Interview")
                {
                    RunObject = Page "Failed First Interview List";
                }
                action("Passed Oral Interview")
                {
                    RunObject = Page "Passed Second Interview List";
                }
                action("Failed Oral Interview")
                {
                    RunObject = Page "Failed Second Interview List";
                }
                action("Passed Due Diligence")
                {
                    RunObject = Page "Passed Due Diligence List";
                }
                action("Failed Due Diligence")
                {
                    RunObject = Page "Failed Due Diligence List";
                }

                /*action("Shortlisted Job Applications")
                {
                    RunObject = Page "Short Listed Job Applications";
                }
                action("Post Interview Job Applications")
                {
                    RunObject = Page "Post Interview Job Application";
                }*/
                /*action("Closed Job Adverts")
                {
                    RunObject = Page "Closed Job Applications";
                }*/
                action("Applicant Attachments")
                {
                    RunObject = Page "Applicant Attachments";
                }
            }
            group("Employee Manager")
            {
                Caption = 'Employee Manager';
                Image = HumanResources;

                group("Employee Changes")
                {
                    action("Open Requests")
                    {
                        RunObject = Page "Employee Change Requests";
                        RunPageView = where("Change Approval Status" = const(Open));
                    }
                    action("Pending Approval")
                    {
                        RunObject = Page "Employee Change Requests";
                        RunPageView = where("Change Approval Status" = const("Pending Approval"));
                    }
                    action("Rejected Requests")
                    {
                        RunObject = Page "Employee Change Requests";
                        RunPageView = where("Change Approval Status" = const(Rejected));
                    }
                    action("Approved Changes")
                    {
                        RunObject = Page "Employee Change Requests";
                        RunPageView = where("Change Approval Status" = const(Approved));
                    }
                }
                action("All Employees")
                {
                    RunObject = Page "HR Employee List";
                }
                action("Employee Documents")
                {
                    Caption = 'Employee Documents';
                    Image = Documents;
                    RunObject = Page "Employee Documents List";
                }
                action(" Employee list All data")
                {
                    RunObject = Page "HR Employee list All data";
                }
                action("Active Employees")
                {
                    RunObject = Page "Employee List";
                    RunPageView = where(Status = const(Active));
                }
                action("Inactive Employees")
                {
                    RunObject = Page "Employee List";
                    RunPageView = where(Status = const(Inactive));
                }
                action("Employees On Locum")
                {
                    RunObject = Page "HR Employee List-On Contract";
                }
                action(Interns)
                {
                    RunObject = Page "HR Employee List-Interns";
                }
                action("Employee Transfers")
                {
                    RunObject = Page "Employee Transfer list";
                }
                action("Exit Interviews")
                {
                    RunObject = Page "Job Exit Interview List";
                }
                action("Exit Reasons")
                {
                    RunObject = Page "Job Exit Reason List";
                }

            }
            group("Employee Disciplinary")
            {
                Caption = 'Employee Disciplinary';
                Image = ProductDesign;
                Visible = true;
                action("New Cases")
                {
                    RunObject = Page "Disciplinary Cases";
                }
                action("Ongoing Cases")
                {
                    RunObject = Page "Ongoing Cases";
                }
                action("Committee Disciplinary Cases")
                {
                    RunObject = Page "Comm Disciplinary Cases";
                }
                action("CEO Disciplinary Cases")
                {
                    RunObject = Page "Ceo Disciplinary Cases";
                }
                action("Board Disciplinary Cases")
                {
                    RunObject = Page "Board Disciplinary Cases";
                }
                action("Appealed Cases")
                {
                    RunObject = Page "Appealed Cases";
                }
                action("Closed Cases")
                {
                    RunObject = Page "Closed Cases";
                }
                action("Court Cases")
                {
                    RunObject = Page "Court Cases";
                }
                action("Offense Type Setup")
                {
                    RunObject = Page "Disciplinary Offenses";
                }
                action("Disciplinary Actions")
                {
                    RunObject = Page "Disciplinary Actions";
                }
                action("Discipline Levels")
                {
                    RunObject = Page "Levels of Discipline List";
                }
            }
            group(Payroll)
            {
                Caption = 'Payroll';
                Image = FiledPosted;
                action("Employee List")
                {
                    RunObject = Page "Employee List";
                }
                action("Payrol Processing list")
                {
                    RunObject = Page "Payrol Processing list";
                }
                action("Pay Periods")
                {
                    RunObject = Page "Pay Periods";
                }
                action("Earnings List")
                {
                    RunObject = Page Earnings;
                }
                action("Deductions List")
                {
                    RunObject = Page Deductions;
                }
                action("Bracket Tables")
                {
                    RunObject = Page "Bracket Tables";
                }
                action("Countries")
                {
                    RunObject = Page "Countries/Regions";
                }
                action("Currencies")
                {
                    RunObject = Page "Currencies";
                }
                action("Social Grades")
                {
                    RunObject = Page "Social Grades";
                }
            }
            group("Time and Attendance")
            {
                Caption = 'Time and Attendance';
                action("Time & Attendance")
                {
                    RunObject = Page "Attendance Ledger List";
                    Visible = false;
                }
                action("Attendance Entry List")
                {
                    RunObject = page "Attendance Entry Admin";
                    Caption = 'Time & Attendance';
                }
                group(Reports)
                {
                    action("Attendance Report")
                    {
                        RunObject = report "Attendance Report";
                    }
                }

            }

            group("Leave Manager")
            {
                Caption = 'Leave Manager';
                Image = Ledger;
                action("Employee Leave Balances")
                {
                    RunObject = Page "Employee Leave Balances";
                }
                action("Leave Applications")
                {
                    RunObject = Page "Leave Applications List";
                }
                action("Leave Recalls")
                {
                    RunObject = Page "Leave Recalls List";
                }
                action("Leave Periods")
                {
                    RunObject = Page "HR Leave Period List";
                }
                action("Leave Types")
                {
                    RunObject = Page "Leave Types Setup";
                }
                group("LeaveReportsNav")
                {
                    Caption = 'Reports';
                    action("Employee Leave StatementRC")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee Leave Statement';
                        RunObject = Report "Employee Leave Statement";
                        ToolTip = 'Print leave statement per employee showing allocated, accrued, taken and balance per leave type.';
                    }
                    action("Leave Balance SummaryRC")
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Balance Summary';
                        RunObject = Report "Leave Balance Summary";
                        ToolTip = 'Print summary of leave balances for all employees.';
                    }
                    action("Leave Taken ReportRC")
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Taken Report';
                        RunObject = Report "Leave Taken Report";
                        ToolTip = 'Print detailed list of all approved leave applications taken.';
                    }
                }
            }
            group(Action77)
            {
                Caption = 'Performance Management';
                Image = AnalysisView;
                action("Performance Management Themes")
                {
                    Caption = 'Key Performance Areas';
                    RunObject = Page "Performance Management Themes";
                    Visible = false;
                }
                action("Performance Objectives")
                {
                    RunObject = Page "Performance Objectives";
                    Visible = false;
                }
                action("Departmental Objectives")
                {
                    RunObject = Page "WB Departmental Targets";
                }

                action("Performance Planning")
                {
                    Caption = 'Target Setting';
                    RunObject = Page "Employee Targets";
                    RunPageView = WHERE("Sent to Supervisor" = CONST(false),
                                        "Approved By Supervisor" = CONST(false));
                }
                action("Performance Planning Approval")
                {
                    Caption = 'Targets Pending Approval';
                    RunObject = Page "Supervisor Employee Targets";
                    RunPageView = WHERE("Sent to Supervisor" = CONST(true));
                }
                action("Approved Targets")
                {
                    RunObject = Page "Approved Employee Targets";
                }
                action("Mid Year Appraisal")
                {
                    Caption = 'Mid-Period Review';
                    RunObject = Page "Mid Year Appraisal";
                }
                action("Peer Appraisal Selection")
                {
                    RunObject = Page "Peer Appraisal Selection List";
                    Visible = false;
                }
                action("Peer Review")
                {
                    RunObject = Page "First Peer Review";
                    Visible = false;
                }
                // action(Appraisals)
                // {
                //     Caption = 'Apprissals';
                //     RunObject = Page "Staff Appraisal Lists";
                // }
                action(Appraisals)
                {
                    Caption = 'Appraisals';
                    RunObject = Page "Mid Year Appraisal";

                }
                group(Setups1)
                {
                    Caption = 'Setups';
                    action("Evaluation Scale")
                    {
                        RunObject = Page "Appraisal Remarks";
                    }

                    action("Appraissal Periods")
                    {
                        Caption = 'Appraisal Periods';
                        RunObject = Page "HR Appraisal Period List";
                    }

                }
                action("PIP List")
                {
                    Caption = 'Performance Improvement Plans';
                    RunObject = Page "PIP List";
                }
                action(PIPSetupAction)
                {
                    Caption = 'PIP Setup';
                    RunObject = Page "PIP Setup";
                }
            }
            /*group("Resource Planning  & TimeSheets")
            {
                Caption = 'Resource Planning  & TimeSheets';
                Image = ResourcePlanning;
                Visible = false;
                action("Employee Timesheet list")
                {
                    RunObject = Page "Employee Timesheet list";
                }
                action("Approved Employee Timesheet")
                {
                    RunObject = Page "Approved Employee Timesheet";
                }
            }*/
            group(Training)
            {
                Caption = 'Training';
                Image = FiledPosted;
                action("Course Cards")
                {
                    Caption = 'Course Cards';
                    RunObject = Page "Training Master Plan";
                }
                action("Annual Training Plans")
                {
                    Caption = 'Training Master Plan';
                    RunObject = Page "Annual Training Plan List";
                }
                action("Training Requests")
                {
                    RunObject = Page "Training List";
                }
                action("Pending Training Requests")
                {
                    RunObject = Page "Pending Training Requests";
                }
                action("Approved Training Requests")
                {
                    RunObject = Page "Approved Training Requests";
                }
                action("Training Schedules")
                {
                    RunObject = Page "Training Schedules";
                }
                action("Ongoing Trainings")
                {
                    RunObject = Page "Ongoing Trainings";
                }
                action("Completed Trainings")
                {
                    RunObject = Page "Completed Trainings";
                }
                action("Training Evaluations")
                {
                    Caption = 'Training Evaluations';
                    RunObject = Page "Training Evaluation List";
                }
            }
            group("Shift Management")
            {
                Caption = 'Shift Management';
                action("Shift Lines")
                {
                    RunObject = Page "Shift List";
                    Caption = 'Shift List';
                }
                action("Posted Shift Lines")
                {
                    RunObject = Page "Shift Posted";
                    Caption = 'Posted Shift List';
                }
                action("Shift Meal Orders")
                {
                    RunObject = Page "Meal Order Setup";
                }

            }
            group(SelfService)
            {
                Caption = 'Self Service';
                group(Memo)
                {
                    Caption = 'Memo';
                    action("Memo List")
                    {
                        RunObject = Page "Memo List";
                    }
                    action("Posted Memo List")
                    {
                        RunObject = Page "Posted Memo List";
                    }
                }
                group("Medical Claim")
                {
                    Caption = 'Medical Claims';
                    action("Medical Claims")
                    {
                        RunObject = Page "Claim List";
                    }
                    action("Posted Medical Claims")
                    {
                        RunObject = Page "Posted Claims List";
                    }
                    action(MedicalCertificateTypes)
                    {
                        Caption = 'Medical Certificate Types';
                        ApplicationArea = All;
                        RunObject = Page "Medical Information Setup";
                        Image = Setup;
                    }
                }

                group(Travel)
                {
                    Caption = 'Travel';


                    action("Travelling Request")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Travelling Request';
                        RunObject = Page "Travelling Request Lines";
                    }
                    action("Posted Travelling Request")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Travelling Request';
                        RunObject = Page "Posted Travelling Requests";
                    }
                    action("Employee Travel Request")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Travel Request';
                        RunObject = Page "Employee Travel Request";
                        Visible = false;
                    }

                }
                group("Incidents Logs")
                {
                    action("Accident / Incident Logs")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Accident / Incident Logs';
                        RunObject = Page "Accident / Incident Logs List";
                    }
                }
                group("Compassionate Checks")
                {
                    Caption = 'Compassionate Checks';
                    action("Compassionate Checks List")
                    {
                        Caption = 'New Compassionate Checks';
                        RunObject = Page "Compassionate Checks List";
                        RunPageLink = "Approval Status" = CONST(Open);
                    }
                    action("Pending Compassionate Checks")
                    {
                        Caption = 'Pending Compassionate Checks';
                        RunObject = Page "Compassionate Checks List";
                        RunPageLink = "Approval Status" = CONST("Pending Approval");
                    }
                    action("Approved Compassionate Checks")
                    {
                        Caption = 'Approved Compassionate Checks';
                        RunObject = Page "Compassionate Checks List";
                        RunPageLink = "Approval Status" = CONST(Approved);
                    }
                    action("Compassionate Check Setup")
                    {
                        Caption = 'Compassionate Check Setup';
                        Image = Setup;
                        RunObject = Page "Compassionate Check Setup";
                    }
                }
                group("Staff Advances")
                {
                    action("Loan Product Types")
                    {
                        Caption = 'Staff Advance Products';
                        RunObject = Page "Loan Product Type list";
                    }
                    action("Loan Applications")
                    {
                        Caption = 'Staff Advance Applications';
                        RunObject = Page "Loan Application List";
                    }
                }
                group("Meal Requisition")
                {
                    action("Meal Setup")
                    {
                        Caption = 'Meal Setup';
                        RunObject = Page "Item List";
                    }
                    action("Meal Requisitions")
                    {
                        Caption = 'Meal Requisitions';
                        RunObject = Page "Meal Requisition List";
                        RunPageLink = Status = CONST(Open);
                    }
                    action("Pending Meal Requisitions")
                    {
                        Caption = 'Meal Requisitions Pending Approval';
                        RunObject = Page "Meal Requisition List";
                        RunPageLink = Status = CONST("Pending Approval");
                    }
                    action("Approved Meal Requisitions")
                    {
                        Caption = 'Approved Meal Requisitions';
                        RunObject = Page "Meal Requisition List";
                        RunPageLink = Status = CONST(Approved);
                    }
                }
                action(ServiceCertificate)
                {
                    Caption = 'Service Certificate';
                    RunObject = Report "Service Certificate";
                }
            }






        }
        area(reporting)
        {
            group("Other Reports")
            {
                action(StaffMeals)
                {
                    Caption = 'Staff Meal Costing';
                    RunObject = Report "Staff Meal Costing";
                }
                action(MonthlyMealVariance)
                {
                    Caption = 'Monthly Meal Variance';
                    RunObject = Report "Monthly Meal Variance";
                }
            }
        }
    }
}


