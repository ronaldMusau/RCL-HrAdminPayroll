report 51525381 "Shift Report"
{
    Caption = 'Shift Report';
    ApplicationArea = All;
    UsageCategory = None;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\layouts\ShiftReport.rdlc';
    dataset
    {
        dataitem(ShiftHeader; "Shift Header")
        {
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(No; "No.")
            {
            }
            column(ShiftDepartment; "Shift Department")
            {
            }
            column(ShiftStartDate; "Shift Start Date")
            {
            }
            column(ShiftEndDate; "Shift End Date")
            {
            }
            column(WeekNo; "Week No.")
            {
            }
            column(Year; "Year")
            {
            }
            column(ShiftType; "Shift Type")
            {
            }
            column(Department; Department)
            {
            }
            column(Createdby; "Created by")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(SupervisorUserID; "Supervisor User ID")
            {
            }
            column(ApprovalStatus; "Approval Status")
            {
            }

            dataitem("Shift Line"; "Shift Line")
            {
                DataItemLink = "Shift No." = FIELD("No.");

                column(Employee_No_; "Employee No.")
                {
                }
                column(Employee_Name; "Employee Name")
                {
                }
                column(Shift_Type; "Shift Type")
                {
                }
                column(Shift_Date; "Shift Date")
                {
                }
                column(Shift_Start_Time; "Shift Start Time")
                {
                }
                column(Shift_End_Time; "Shift End Time")
                {
                }
                column(Task_Assigned; "Task Assigned")
                {
                }
                column(Meal_Order; "Meal Order")
                {
                }
                column(Meal_Order_Description; "Meal Order Description")
                {
                }
                column(Is_Public_Holiday; "Is Public Holiday")
                {
                }
                column(Leave_Allocated; "Leave Allocated")
                {
                }
                // Monday
                column(Mon_Shift; "Mon Shift") { }
                column(Mon_Start_Time; "Mon Start Time") { }
                column(Mon_End_Time; "Mon End Time") { }

                // Tuesday
                column(Tue_Shift; "Tue Shift") { }
                column(Tue_Start_Time; "Tue Start Time") { }
                column(Tue_End_Time; "Tue End Time") { }

                // Wednesday
                column(Wed_Shift; "Wed Shift") { }
                column(Wed_Start_Time; "Wed Start Time") { }
                column(Wed_End_Time; "Wed End Time") { }

                // Thursday
                column(Thu_Shift; "Thu Shift") { }
                column(Thu_Start_Time; "Thu Start Time") { }
                column(Thu_End_Time; "Thu End Time") { }

                // Friday
                column(Fri_Shift; "Fri Shift") { }
                column(Fri_Start_Time; "Fri Start Time") { }
                column(Fri_End_Time; "Fri End Time") { }

                // Saturday
                column(Sat_Shift; "Sat Shift") { }
                column(Sat_Start_Time; "Sat Start Time") { }
                column(Sat_End_Time; "Sat End Time") { }

                // Sunday
                column(Sun_Shift; "Sun Shift") { }
                column(Sun_Start_Time; "Sun Start Time") { }
                column(Sun_End_Time; "Sun End Time") { }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
