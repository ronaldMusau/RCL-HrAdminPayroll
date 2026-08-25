report 52211587 "HR Travel Clearance Form"
{
    Caption = 'HR Travel Clearance Form';
    ApplicationArea = All;
    UsageCategory = None;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep52211587.TravelClearanceForm.rdlc';

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
                column(RequestDate; "Request Date")
                {
                }
                column(EmployeeName; "Employee Name")
                {
                }
                column(EmployeeNo; "Employee No.")
                {
                }
                column(DepartmentName; "Department Name")
                {
                }
                column(JobTitle; JobTitle)
                {
                }
                column(ManagerName; ManagerName)
                {
                }
                column(PurposeOfTravel; "Reason for Travel")
                {
                }
                column(TripStartDate; "Trip Planned Start Date")
                {
                }
                column(TripEndDate; "Trip Planned End Date")
                {
                }
                column(Origin; "Origin")
                {
                }
                column(Destination; EffectiveDestination)
                {
                }
                column(ModeOfTravel; "Mode of Travel")
                {
                }
                column(AccommodationRequired; "Accommodation Required")
                {
                }
                column(TravelStatus; Status)
                {
                }

                dataitem(TravellingEmployees; "Travelling Employees")
                {
                    DataItemLink = "Request No." = field("Request No.");

                    column(EmpRowName; "Employee Name")
                    {
                    }
                    column(EmpRowDept; "Department Name")
                    {
                    }
                    column(EmpRowStartDate; "Start Date")
                    {
                    }
                    column(EmpRowEndDate; "End Date")
                    {
                    }
                }

                dataitem(ApprovalEntry; "Approval Entry")
                {
                    DataItemLink = "Document No." = field("Request No.");
                    DataItemTableView = WHERE(Status = CONST(Approved), "Table ID" = CONST(51525906));

                    column(ClearApproverID; "Approver ID")
                    {
                    }
                    column(ClearApproverName; "Approver Name")
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
                    JobTitle := '';
                    ManagerName := '';
                    EffectiveDestination := '';

                    if Employee.Get("Employee No.") then begin
                        JobTitle := Employee."Job Title";
                        if Employee2.Get(Employee."Manager No.") then
                            ManagerName := Employee2."First Name" + ' ' + Employee2."Middle Name" + ' ' + Employee2."Last Name";
                    end;

                    if "Local Travel" then
                        EffectiveDestination := "Local Destination"
                    else
                        if "International Travel" then
                            EffectiveDestination := "International Destination"
                        else
                            EffectiveDestination := Destination;
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.CalcFields(Picture);
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
        Employee: Record Employee;
        Employee2: Record Employee;
        Emp: Record Employee;
        JobTitle: Text[100];
        ManagerName: Text[150];
        EffectiveDestination: Text[250];
}
