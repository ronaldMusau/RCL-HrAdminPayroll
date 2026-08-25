report 52211585 "HR Travelling Request Report"
{
    Caption = 'HR Travelling Request Report';
    ApplicationArea = All;
    UsageCategory = None;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep52211585.TravellingRequestReport.rdlc';
    dataset
    {
        dataitem(CompanyInformation; "Company Information")
        {
            column(Logo; Picture)
            {
            }
            column(CompanyName; Name)
            {
            }
            column(CompanyAddress; Address)
            {
            }
            column(CompanyPhone; "Phone No.")
            {
            }

            dataitem(TravellingRequest; "Travelling Request")
            {
                RequestFilterFields = "Request No.";

                column(RequestNo; "Request No.")
                {
                }
                column(RequestID; "Request ID")
                {
                }
                column(RequestDate; "Request Date")
                {
                }
                column(ReasonforTravel; "Reason for Travel")
                {
                }
                column(Employee_No_; "Employee No.")
                {

                }

                column(EmployeeName; "Employee Name")
                {
                }
                column(EmpJobTitle; EmpJobTitle)
                {
                }
                column(DriverName; "Driver Name")
                {
                }
                column(ModeofTravel; "Mode of Travel")
                {
                }
                column(LocalDestination; "Local Destination")
                {
                }
                column(Origin; Origin)
                {
                }
                column(TripStartDate; "Trip Planned Start Date")
                {
                }
                column(TripEndDate; "Trip Planned End Date")
                {
                }
                column(International_Destination; "International Destination")
                {

                }
                column(COO_Approval; "COO Approval")
                {
                }
                column(COO_Approver_Name; "COO Approver Name")
                {
                }
                column(CEO_Approval; "CEO Approval")
                {
                }
                column(CEO_Approver_Name; "CEO Approver Name")
                {
                }

                dataitem("Travelling Employees"; "Travelling Employees")
                {
                    DataItemLink = "Request No." = FIELD("Request No.");
                    column(Employee_Name; "Employee Name")
                    {
                    }
                    column(Department_Name; "Department Name")
                    {
                    }
                    column(International; International)
                    {
                    }
                    column(Locals; Locals)
                    {
                    }
                }
                dataitem(ApprovalEntry; "Approval Entry")
                {
                    DataItemLink = "Document No." = FIELD("Request No.");
                    DataItemTableView = WHERE(Status = CONST(Approved), "Table ID" = CONST(51525906));
                    column(ApproverID; "Approver ID")
                    {
                    }
                    column(ApproverName; "Approver Name")
                    {
                    }
                    column(ApprovalDate; "Date-Time Sent for Approval")
                    {
                    }
                    column(LastModifiedDateTime; "Last Date-Time Modified")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if ApprovalEntry."Approver ID" = ApprovalEntry."Sender ID" then
                            CurrReport.Skip();
                        if ApprovalEntry."Approver Name" = '' then begin
                            if Emp.Get(ApprovalEntry."Approver ID") then
                                ApprovalEntry."Approver Name" := Emp."Full Name"
                            else begin
                                Emp.Reset();
                                Emp.SetRange("User ID", ApprovalEntry."Approver ID");
                                if Emp.FindFirst() then
                                    ApprovalEntry."Approver Name" := Emp."Full Name";
                            end;
                        end;

                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    Emp.Reset();
                    Emp.SetRange("No.", "Employee No.");
                    if Emp.FindFirst() then begin
                        EmpJobTitle := Emp."Job Title";
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                // HRSetup.Get();
                // COOName := HRSetup."COO Approval";
                // CEOName := HRSetup."CEO Approval";
            end;

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

    var
        Emp: Record Employee;
        EmpJobTitle: Text;
        HRSetup: Record "Human Resources Setup";
        COOName: Text;
        CEOName: Text;
}
