report 52211586 "HR Travel Authorisation"
{
    Caption = 'HR Travel Authorisation';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep52211586.TravelAuthorisation.rdlc';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {

            column(Address_CompanyInformation; Address)
            {
            }
            column(PhoneNo_CompanyInformation; "Phone No.")
            {
            }
            column(PhoneNo2_CompanyInformation; "Phone No. 2")
            {
            }
            column(Logo; Picture)
            {
            }
        }
        dataitem(TravellingEmployees; "Travelling Employees")
        {
            RequestFilterFields = "Employee No.";
            column(Name; "Employee Name")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(CountryofOrigin; "Desitination From")
            {
            }
            column(Destination; "Destination To")
            {
            }
            column(Title; Title)
            {
            }
            column(PurposeOfTravel; PurposeOfTravel)
            {
            }
            column(TravelAuthorizer; TravelAuthorizer)
            {
            }
            column(AuthorizerTitle; AuthorizerTitle)
            {
            }

            trigger OnAfterGetRecord()
            var
                TravelRequest: Record "Travelling Request";
                UserSetup: Record "User Setup";
                HRSetup: Record "Human Resources Setup";
                AuthorizerEmp: Record Employee;
            begin
                Emp.Get(TravellingEmployees."Employee No.");
                Title := Emp."Job Title";

                // Get travel request details
                if TravelRequest.Get(TravellingEmployees."Request No.") then begin
                    PurposeOfTravel := TravelRequest."Reason for Travel";
                end;

                // Get Travel Authorizer from HR Setup
                if HRSetup.Get() then begin
                    if HRSetup."Travel Authorizer" <> '' then begin
                        if AuthorizerEmp.Get(HRSetup."Travel Authorizer") then begin
                            TravelAuthorizer := AuthorizerEmp."First Name" + ' ' + AuthorizerEmp."Middle Name" + ' ' + AuthorizerEmp."Last Name";
                            AuthorizerTitle := AuthorizerEmp."Job Title";
                        end;
                    end;
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
        Emp: Record Employee;
        Title: Text[100];
        PurposeOfTravel: Text[250];
        TravelAuthorizer: Text[250];
        AuthorizerTitle: Text[100];
}
