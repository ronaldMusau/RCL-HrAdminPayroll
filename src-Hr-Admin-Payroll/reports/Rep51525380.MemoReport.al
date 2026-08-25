report 51525380 "Memo Report"
{
    Caption = 'Memo Report';
    ApplicationArea = All;
    UsageCategory = None;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\layouts\MemoReport.rdlc';
    dataset
    {
        dataitem(MemoHeader; "Memo Header")
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
            column(No; "No.")
            {
            }
            column(RequestorUserID; "Requestor User ID")
            {
            }
            column(RequestorName; "Requestor Name")
            {
            }
            column(DepartmentCode; "Department Code")
            {
            }
            column(ActivityDate; "Activity Date")
            {
            }
            column(StartTime; "Start Time")
            {
            }
            column(EndTime; "End Time")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(Venue; Venue)
            {
            }
            column(CreatedDate; "Created Date")
            {
            }
            column(Purpose; Purpose)
            {
            }

            dataitem("Memo Lines"; "Memo Lines")
            {
                DataItemLink = "Doc No" = FIELD("No.");

                column(Start_Date; "Start Date")
                {
                }
                column(End_Date; "End Date")
                {
                }
                column(Activity_Description; "Activity Description")
                {
                }
            }

            dataitem(MemoAttenders; "Memo Attenders")
            {
                DataItemLink = "Doc No" = field("No.");

                column(AttenderEmployeeNo; "Employee No")
                {
                }
                column(AttenderEmployeeName; "Employee Name")
                {
                }
            }

            dataitem(ApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = WHERE(Status = CONST(Approved), "Table ID" = CONST(51525558));

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
                SenderID := MemoHeader."Requestor User ID";
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
