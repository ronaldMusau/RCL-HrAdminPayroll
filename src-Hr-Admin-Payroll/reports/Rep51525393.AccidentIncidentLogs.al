report 51525393 "Accident / Incident Logs"
{
    ApplicationArea = All;
    Caption = 'Accident / Incident Log Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\AccidentIncidentLogs.rdlc';
    dataset
    {
        dataitem(AccidentIncidentLogsManag; "Accident / Incident Logs Manag")
        {

            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyCounty; CompanyInfo.County) { }
            column(CompanyPostCode; CompanyInfo."Post Code") { }
            column(CompanyCountryRegionCode; CompanyInfo."Country/Region Code") { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyPicture; CompanyInfo.Picture) { }


            column(DocumentNumber; "Document Number") { }
            column(ReportingParty; "Reporting Party ") { }
            column(ReportingPartyName; "Reporting Party Name") { }
            column(LocationOfIncident; "Location of Incident") { }
            column(DateOfIncident; "Date of Incident") { }
            column(TimeOfIncident; "Time of Incident") { }
            column(IncidentDescription; "Incident Description") { }
            column(CorrectiveActionTaken; "Corrective Action Taken") { }
            column(FollowUpOrInvestigations; "Follow-up or investigations") { }
            column(ApprovalStatus; Format("Approval Status")) { }

            dataitem(AccidentIncidentLogsLine; "Accident / Incident Logs Line")
            {
                DataItemLink = "Doc. No." = FIELD("Document Number");
                DataItemTableView = sorting("Doc. No.", "Line No.");

                column(LineDocNo; "Doc. No.") { }
                column(LineNo; "Line No.") { }
                column(PersonInvolved; "Person Involved") { }
                column(Department; Department) { }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Filter Options';

                    field(DateFrom; DateFrom)
                    {
                        ApplicationArea = All;
                        Caption = 'Date From';
                        ToolTip = 'Filter incidents from this date.';
                    }
                    field(DateTo; DateTo)
                    {
                        ApplicationArea = All;
                        Caption = 'Date To';
                        ToolTip = 'Filter incidents up to this date.';
                    }
                    field(FilterApprovalStatus; FilterApprovalStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Approval Status';
                        ToolTip = 'Filter by approval status.';
                        OptionCaption = ' ,Open,Pending Approval,Approved,Rejected';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            DateTo := Today();
            DateFrom := CalcDate('<-1Y>', Today());
        end;
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        if DateFrom <> 0D then
            AccidentIncidentLogsManag.SetFilter("Date of Incident", '>=%1', DateFrom);
        if DateTo <> 0D then
            AccidentIncidentLogsManag.SetFilter("Date of Incident", '<=%1', DateTo);
        if FilterApprovalStatus > 0 then
            AccidentIncidentLogsManag.SetRange("Approval Status", FilterApprovalStatus - 1);
    end;

    var
        CompanyInfo: Record "Company Information";
        DateFrom: Date;
        DateTo: Date;
        FilterApprovalStatus: Option " ",Open,"Pending Approval",Approved,Rejected;
}
