#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 52211782 "Planning &Strategy Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control10; "Headline RC Business Manager")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control9; "Planning & Strategy Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }
            part(Control2; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("User Task List")
            {
                ApplicationArea = Basic;
                Caption = 'Assign Tasks';
                RunObject = Page "User Task List";
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, performance cycle, and performance contracts.';
        }
        area(sections)
        {
            group("Performance Cycle Setup")
            {
                Caption = 'Performance Cycle Setup';
                Image = PlanningWorksheet;
                action("Performance Management Plans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Performance Management Plans';
                    ToolTip = 'Configure the performance cycle plan, phases, and timeline for the fiscal year.';
                    RunObject = Page "Performance Management Plans";
                }
                // action("Performance Plan Tasks")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Performance Plan Tasks';
                //     ToolTip = 'Manage tasks and deadlines for each phase of the performance cycle.';
                //     RunObject = Page "Performance Plan Tasks";
                // }
                action("Upcoming Performance Tasks")
                {
                    ApplicationArea = Basic;
                    Caption = 'Upcoming Performance Tasks';
                    ToolTip = 'View tasks due in the current or next cycle phase to keep the cycle on track.';
                    RunObject = Page "Upcoming Performance Tasks";
                }
                action("Appraisal Periods")
                {
                    ApplicationArea = Basic;
                    Caption = 'Appraisal Periods';
                    ToolTip = 'Define the mid-year (December) and annual review (May) windows for the performance cycle.';
                    RunObject = Page "Appraisal Periods";
                }
                action("Annual Reporting Codes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Annual Reporting Codes';
                    ToolTip = 'Manage fiscal year reporting codes used across the performance cycle.';
                    RunObject = Page "Annual Reporting Codes";
                }
                // action("Functional Calendars")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Corporate Performance Calendar';
                //     ToolTip = 'Manage the corporate PPM calendar — Cycle Start (July), Objective Setting (August), Mid-Year Check-in (December), Annual Review (May), Calibration (June), Cycle End (June).';
                //     RunObject = Page "Functional calendars";
                // }
            }

            group("Objectives and KPIs Setup")
            {
                Caption = 'Objectives & KPIs Setup';
                Image = Planning;
                action("Corporate Strategic Plans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Corporate Strategic Plans';
                    ToolTip = 'Manage the multi-year corporate strategic plan — the source from which all objectives cascade downward.';
                    RunObject = Page "Corporate Strategic Plans";
                }
                action("Annual Strategy Workplans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Corporate Annual Workplans';
                    ToolTip = 'Draft and approve the organisational-level annual workplan (CEO/CHRAO level) that initiates the cascade.';
                    RunObject = Page "Annual Strategy Workplans";
                }
                action("Approved Annual Strategy Workplans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Corporate Annual Workplans';
                    ToolTip = 'Manage approved organisational-level annual workplans (CEO level) that initiate the cascade.';
                    RunObject = Page "Approved Annual Strategy Work";
                }
                // action("Strategic Objectives")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Strategic Objectives';
                //     ToolTip = 'Define strategic objectives linked to the corporate plan for cascading to departments and individuals.';
                //     RunObject = Page "Strategic Objectives";
                // }
                // action("Strategic Goals")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Strategic Goals';
                //     ToolTip = 'Maintain strategic goals per theme, forming the basis of departmental and individual targets.';
                //     RunObject = Page "Strategic Goals";
                // }
                action("Functional Annual Workplans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Departmental Annual Workplans';
                    ToolTip = 'Draft and approve departmental annual workplans cascaded from the corporate plan (Department Head level).';
                    RunObject = Page "Functional Annual Workplans";
                }
                action("Approved Functional Annual Workplans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Departmental Annual Workplans';
                    ToolTip = 'Manage approved departmental annual workplans cascaded from the corporate plan (Department Head level).';
                    RunObject = Page "Approved Functional Annual Wrk";
                    RunPageLink = "Approval Status" = filter(Released);
                }
                // action("Functional/Operational PCs")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'AWP Cascading Templates';
                //     ToolTip = 'Manage cascading templates used to push Objectives & KPIs from workplans to lower organisational levels.';
                //     RunObject = Page "Functional/Operational PCs";
                // }
                action("CEOs Perfomance Contracts")
                {
                    ApplicationArea = Basic;
                    Caption = 'CEOs Annual Workplans';
                    ToolTip = 'Manage Objectives & KPIs assigned at CEOs level.';
                    RunObject = Page "HODs Perfomance Contracts";
                }
                action("Approved CEOs Perfomance Contracts")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved CEOs Annual Workplans';
                    ToolTip = 'Manage approved Objectives & KPIs assigned at CEOs level.';
                    RunObject = Page "App HODs Perfomance Contracts";
                }
                action("Departments\Centers PCs ")
                {
                    ApplicationArea = Basic;
                    Caption = 'HOD Annual Workplans';
                    ToolTip = 'Manage Objectives & KPIs assigned at Head of Department level.';
                    RunObject = Page "Departments\Centers PCs";
                }
                action("Approved Departments\Centers PCs ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved HOD Annual Workplans';
                    ToolTip = 'Manage approved Objectives & KPIs assigned at Head of Department level.';
                    RunObject = Page "Appr. Departments\Centers PCs";
                }
                action("Individual Scorecards")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff Annual Workplans';
                    ToolTip = 'Manage individual Objectives & KPIs — each with description, weight, and timeline. Total weight must equal 100%.';
                    RunObject = Page "Staff Performance Contracts";
                }
                action("Approved Individual Scorecards")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Staff Annual Workplans';
                    ToolTip = 'Manage approved individual Objectives & KPIs — each with description, weight, and timeline. Total weight must equal 100%.';
                    RunObject = Page "App Staff Performance Contract";
                }
                // action("Goal Templates")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Goal Templates';
                //     ToolTip = 'Manage reusable Objectives & KPI templates for bulk assignment to positions, sections, or individual employees.';
                //     RunObject = Page "Goal Templates";
                // }
            }

            group("EmployeeInitiatedKPIs")
            {
                Caption = 'Employee-Initiated KPIs';
                Image = Employee;
                action("EmployeeKPISubmissions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee KPI Submissions';
                    ToolTip = 'Employee bottom-up flow: employees set their own Objectives & KPIs with description, weight (must total 100%), and timeline, then submit to their manager for approval.';
                    RunObject = Page "Employee KPI Self-Setup List";
                }
                action("PendingKPIApprovals")
                {
                    ApplicationArea = Basic;
                    Caption = 'KPI Submissions Pending Manager Approval';
                    ToolTip = 'Shows all employee-initiated KPI scorecards awaiting manager review. Managers can Approve or Return for revision from here.';
                    RunObject = Page "Employee KPI Self-Setup List";
                    RunPageView = where("Approval Status" = filter("Pending Approval"));
                }
            }
            // group("Performance Contracting")
            // {
            //     Caption = 'Performance Contracts';
            //     Image = Agreement;
            //     action("Organizational PCs")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Organisational Performance Contracts';
            //         ToolTip = 'Draft and approve organisational-level performance contracts.';
            //         RunObject = Page "Organizational PCs";
            //     }
            //     action("Functional PCs ")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Departmental Performance Contracts';
            //         ToolTip = 'Draft and approve departmental performance contracts.';
            //         RunObject = Page "Functional PCs";
            //     }
            //     action("HOD  Perfomance Contracts")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'HOD Performance Contracts';
            //         ToolTip = 'Manage Head of Department performance contracts.';
            //         RunObject = Page "HOD  Perfomance Contracts";
            //     }
            //     action("All Performance Contracts")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'All Performance Contracts';
            //         ToolTip = 'View all performance contracts across all organisational levels.';
            //         RunObject = Page "All Performance Contracts";
            //     }
            // }
            group("Performance Tracking")
            {
                Caption = 'Performance Tracking & Check-Ins';
                Image = Entries;

                action("PerformanceCheckIns")
                {
                    ApplicationArea = Basic;
                    Caption = 'Performance Check-Ins';
                    ToolTip = 'Manage mid-year check-ins: staff answers 4 questions and submits; manager section unlocks and the manager answers the same 4 questions from their perspective before approving.';
                    RunObject = Page "SPM Performance Check Ins";
                }
                action("Performance Diary Logs")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff Performance Diary Logs';
                    ToolTip = 'Record monthly KPI progress percentages and one-on-one check-in documentation per employee (staff submits, manager approves).';
                    RunObject = Page "Performance Diary Logs";
                }
                action("Approved Performance Diary Logs")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Staff Performance Diary Logs';
                    ToolTip = 'Record monthly KPI progress percentages and one-on-one check-in documentation per employee (staff submits, manager approves).';
                    RunObject = Page "Appr. Performance Diary Logs";
                }
                action("Posted Performance Diary Logs")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Staff Performance Diary Logs';
                    ToolTip = 'Record monthly KPI progress percentages and one-on-one check-in documentation per employee (staff submits, manager approves).';
                    RunObject = Page "Posted Performance Diary Logs";
                }

                // action("Performance Diary Entries")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Performance Diary Entries';
                //     ToolTip = 'View individual check-in entries including the 4 check-in questions, supporting evidence, and development action updates.';
                //     RunObject = Page "Performance Diary Entries";
                // }
                // action("Department Performance Logs")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Department Performance Logs';
                //     ToolTip = 'Monitor KPI progress and check-in completion rates at departmental level.';
                //     RunObject = Page "Department Performance Logs";
                // }
                // action("Depart Performance Cont Logs")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Department PC Monitoring Logs';
                //     ToolTip = 'Review performance contract monitoring logs per department.';
                //     RunObject = Page "Depart Performance Cont Logs";
                // }
            }

            group("Appraisal and Evaluation")
            {
                Caption = 'Performance Evaluation & Appraisal';
                Image = Approval;
                // action("Staff Performance Appraisal List")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Staff Performance Appraisals';
                //     ToolTip = 'Manage staff self-assessments, manager evaluations, and final weighted scores (60% KPIs + 40% Values). Includes digital acknowledgment capture.';
                //     RunObject = Page "Staff Performance Contracts";
                // }
                // action("Standard Perform Appraisal")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Standard Performance Appraisals';
                //     ToolTip = 'Manage standard appraisal documents — Objectives & KPIs tab, Values tab (7 core values), Development Actions tab, and Check-In tab.';
                //     RunObject = Page "Standard Perform Appraisal";
                // }
                action("Self-Supervisor Appraisals")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Self-Supervisor Appraisals';
                    RunObject = Page "Self-Supervisor Appraisals";
                }
                action("Self Supervisor Appraisals Under Evaluation")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Self Supervisor Appraisals Under Evaluation';
                    RunObject = Page "Self-Supervisor Appraisals-E";
                }
                action("Self Supervisor Appraisals Under Pending Confirmation")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Self Supervisor Appraisals Under Pending Confirmation';
                    RunObject = Page "Self Supervisor Appraisals-PC";
                }
                action("Submitted Self-Supervisor Appraisals")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Submitted Self-Supervisor Appraisals';
                    RunObject = Page "Self-Supervisor Appraisals-Sub";
                }
                action("Closed Self-Supervisor Appraisals")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Closed Self-Supervisor Appraisals';
                    RunObject = Page "SelfSupervisorAppraisal-Closed";
                }
                action("Perfomance Evaluation Temps")
                {
                    ApplicationArea = Basic;
                    Caption = 'Evaluation Templates';
                    ToolTip = 'Configure evaluation templates covering Objectives & KPIs, Values assessment, Development Actions, and Check-In tabs.';
                    RunObject = Page "Perfomance Evaluation Temps";
                }
                action("Performance Evaluation Weight")
                {
                    ApplicationArea = Basic;
                    Caption = 'Evaluation Weighting Setup';
                    ToolTip = 'Configure the weighting split: Objectives & KPIs = 60%, Values = 40% as defined in the BRD.';
                    RunObject = Page "Performance Evaluation Weight";
                }
                action("Competency Performance Temps")
                {
                    ApplicationArea = Basic;
                    Caption = 'Competency Evaluation Templates';
                    ToolTip = 'Manage competency evaluation templates used in the appraisal process.';
                    RunObject = Page "Competency Performance Temps";
                }
            }


            group("Performance Improvement")
            {
                Caption = 'Performance Improvement Plans';
                Image = TaskList;
                action("Performance Improvement Plans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Active Performance Improvement Plans';
                    ToolTip = 'View and manage all PIPs with milestone tracking, colour-coded status (On Track / At Risk / Overdue / Completed), and escalation alerts.';
                    RunObject = Page "Performance Improvement Plans";
                }
                action("PIP Templates")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIP Templates';
                    ToolTip = 'Manage configurable PIP templates with 3-5 milestones, success criteria, evidence requirements, and resource allocation fields.';
                    RunObject = Page "PIP Templates";
                }
                action("PIP Verdict Codes")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIP Outcome Codes';
                    ToolTip = 'Define PIP outcomes: Successful Improvement (exits PIP), Partial Improvement (extend up to 3 months), or Unsuccessful (escalate per HR policy).';
                    RunObject = Page "PIP Verdict Codes";
                }
                action("Evaluation PIP Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIP Categories';
                    ToolTip = 'Manage categories used to classify PIP improvement actions and areas.';
                    RunObject = Page "Evaluation PIP Category";
                }
            }

            group("Performance Appeals")
            {
                Caption = 'Performance Appeals';
                Image = Warning;
                action("Perfomance Appeals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Performance Appeals';
                    ToolTip = 'Manage employee appeals against final performance ratings issued after the annual review. Handled by the Performance Management Team.';
                    RunObject = Page "Perfomance Appeals";
                }
            }

            group("Setup and Configuration")
            {
                Caption = 'Setup & Administration';
                Image = Setup;
                action("Strategy General Setup")
                {
                    ApplicationArea = Basic;
                    Caption = 'SPM General Setup';
                    ToolTip = 'Configure number series, notification settings, PIP escalation timelines, and global PPM parameters.';
                    RunObject = Page "Strategy General Setup";
                }
                action("Core Values")
                {
                    ApplicationArea = Basic;
                    Caption = 'Core Values';
                    ToolTip = 'Maintain the 7 RwandAir core values (40% weighting): People & Empathy, Sustainable Innovation, Teamwork, Transparency, Integrity & Accountability, Safety & Compliance, Excellence.';
                    RunObject = Page "Core Values";
                }
                action("Competencies")
                {
                    ApplicationArea = Basic;
                    Caption = 'Competencies';
                    ToolTip = 'Manage competency definitions and proficiency scale assignments used in evaluations.';
                    RunObject = Page "Competencies";
                }
                action("Competency Proficiency Scales")
                {
                    ApplicationArea = Basic;
                    Caption = 'Competency Proficiency Scales';
                    ToolTip = 'Define proficiency levels and scoring for each competency.';
                    RunObject = Page "Competency Proficiency Scales";
                }
                action("Perfomance Rating Scales")
                {
                    ApplicationArea = Basic;
                    Caption = 'Performance Rating Scales';
                    ToolTip = 'Configure the 4-point BRD rating scale: 1=Developing Impact (0-60%), 2=Expected Impact (61-99%), 3=Significant Impact (100-120%), 4=Transformational Impact (121%+).';
                    RunObject = Page "Perfomance Rating Scales";
                }
                action("Policy Guidelines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Policies & Guidelines';
                    ToolTip = 'Maintain HR policies and performance management guidelines accessible to all system users.';
                    RunObject = Page "Policy & Guideline";
                }
                action("Performance Plan Guidelines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Performance Plan Guidelines';
                    ToolTip = 'Manage guidelines published to employees for each performance plan phase.';
                    RunObject = Page "Performance Plan Guidelines";
                }
            }
        }
    }
}

profile PlanningAndStrategyRoleCenter
{
    Caption = 'Planning and Strategy Role Center';
    RoleCenter = "Planning &Strategy Role Center";
}
