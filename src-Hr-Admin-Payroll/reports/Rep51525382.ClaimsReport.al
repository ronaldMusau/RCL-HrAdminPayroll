report 51525382 "Claims Report"
{
    Caption = 'Claims Report';
    ApplicationArea = All;
    UsageCategory = None;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\layouts\ClaimsReport.rdlc';
    dataset
    {
        dataitem(MedicalClaimHeader; "Medical Claim Header")
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
            column(ClaimNo; "Claim No")
            {
            }
            column(ClaimDate; "Claim Date")
            {
            }
            column(Claimant; Claimant)
            {
            }
            column(ClaimantName; "Claimant Name")
            {
            }
            column(ClaimantNo; "Claimant No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Department; Department)
            {
            }
            column(ServiceProviderName; "Service Provider Name")
            {
            }
            column(EmployeeNo; "Employee No")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(BankAccountNo; "Bank Account No")
            {
            }
            dataitem("Claim Line"; "Claim Line")
            {
                DataItemLink = "Claim No" = FIELD("Claim No");

                column(Employee_Name; "Employee Name")
                {
                }
                column(Claim_No; "Claim No")
                {
                }
                column(Department1; Department)
                {
                }
                column(Medical_Scheme; "Medical Scheme")
                {
                }
                column(Invoice_Number; "Invoice Number")
                {
                }
                column(AmountLines; Amount)
                {
                }
                column(ClaimType; "Claim Type")
                {
                }
                column(VisitDate; "Visit Date")
                {
                }
                column(PatientName; "Patient Name")
                {
                }
                column(HospitalSpecialist; "Hospital/Specialist")
                {
                }
                column(LineNo; "Line No")
                {
                }
            }

            dataitem(ApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = field("Claim No");
                DataItemTableView = WHERE(Status = CONST(Approved), "Table ID" = CONST(51525438));

                column(ApproverID; "Approver ID")
                {
                }
                column(ApproverName; "Approver Name")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ApprovalEntry."Approver ID" = SenderID then
                        CurrReport.Skip();
                    if ApprovalEntry."Approver Name" = '' then begin
                        Emp.Reset();
                        Emp.SetRange("User ID", ApprovalEntry."Approver ID");
                        if Emp.FindFirst() then
                            ApprovalEntry."Approver Name" := Emp."Full Name";
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SenderID := MedicalClaimHeader."Employee No";
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Emp: Record Employee;
        CompanyInfo: Record "Company Information";
        SenderID: Code[50];
}
