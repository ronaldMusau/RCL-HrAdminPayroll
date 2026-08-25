report 51525384 "Service Certificate"
{
    ApplicationArea = All;
    Caption = 'Service Certificate';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep51525384.ServiceCertificate.rdlc';
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(JobTitle; "Job Title")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(EmploymentDate; "Employment Date")
            {
            }
            column(EmployeeName; Employee."First Name" + ' ' + Employee."Last Name")
            {
            }
            column(Responsibility_Center_Name; "Responsibility Center Name")
            {
            }
            column(HRHead; HRHead)
            {
            }
            column(HRTitle; HRTitle)
            {
            }
            column(COOName; COOName)
            {

            }
            column(CEOName; CEOName)
            {

            }
            column(Address_CompanyInformation; CompanyInfo.Address)
            {
            }
            column(PhoneNo_CompanyInformation; CompanyInfo."Phone No.")
            {
            }
            column(PhoneNo2_CompanyInformation; CompanyInfo."Phone No. 2")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Gender; GenderText)
            {
            }
            // trigger OnPreDataItem()
            // var
            //     CurrentUserEmployee: Record Employee;
            //     CurrentUserId: Text;
            // begin
            //     CurrentUserId := UserId;

            //     // Find employee record for current user
            //     CurrentUserEmployee.Reset();
            //     CurrentUserEmployee.SetRange("User ID", CurrentUserId);
            //     if CurrentUserEmployee.FindFirst() then begin
            //         // Set filter to current user's employee number
            //         SetRange("No.", CurrentUserEmployee."No.");
            //     end else begin
            //         Error('No employee record found for user %1. Please contact your administrator.', CurrentUserId);
            //     end;

            //     CompanyInfo.Get();
            //     CompanyInfo.CalcFields(Picture);
            // end;

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                HRSetupRec.Get();
                if HRSetupRec."HR Head" <> '' then begin
                    if EmployeeRec.Get(HRSetupRec."HR Head") then begin
                        HRHead := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                        HRTitle := EmployeeRec."Job Title";
                    end;
                end;
                case Gender of
                    Gender::Male:
                        GenderText := 'Male';
                    Gender::Female:
                        GenderText := 'Female';
                    else
                        GenderText := 'Unknown';
                end;
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
        HRHead: Text[100];
        HRTitle: Text[100];
        HRSetupRec: Record "Human Resources Setup";
        EmployeeRec: Record Employee;
        CompanyInfo: Record "Company Information";
        COOName: Text;
        CEOName: Text;
        GenderText: Text;
}
