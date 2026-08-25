pageextension 52211588 "Travel Request Card Ext" extends "Travelling Request"
{
    layout
    {
        addlast(FactBoxes)
        {
            part(ApprovalEntries; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(51525906), "Document No." = field("Request No.");
            }
        }
        modify("For Official Use Only")
        {
            Visible = false;
        }
        modify("Vehicle Allocated")
        {
            Visible = false;
        }
        modify("Vehicle Description")
        {
            Visible = false;
        }
        modify(Driver)
        {
            Visible = false;
        }
        modify("Driver Name")
        {
            Visible = false;
        }
        modify(Taxi)
        {
            Visible = false;
        }
        modify("Outsourced Vehicle Reg No.")
        {
            Visible = false;
        }
        modify("Number of Passengers")
        {
            Visible = false;
        }
        modify("Return Distance Travelled")
        {
            Visible = false;
        }
        modify("Estimated Mileage/Mantain-Cost")
        {
            Visible = false;
        }
        addafter("Accommodation Required")
        {
            field("COO Approval"; Rec."COO Approval")
            {
            }
            field("COO Approver Name"; Rec."COO Approver Name")
            {
                Editable = Rec."COO Approval" = true;
            }
            field("CEO Approval"; Rec."CEO Approval")
            {
            }
            field("CEO Approver Name"; Rec."CEO Approver Name")
            {
                Editable = Rec."CEO Approval" = true;
            }
        }

    }
    actions
    {
        addafter("Post Doc")
        {
            action(HRPrintTravelReport)
            {
                ApplicationArea = All;
                Caption = 'Print Travel Request Report';
                Image = Print;
                trigger OnAction()
                var
                    TravelReq: Record "Travelling Request";
                begin
                    TravelReq.SetRange("Request No.", Rec."Request No.");
                    Report.RunModal(Report::"HR Travelling Request Report", true, true, TravelReq);
                end;
            }
        }
        addlast(Promoted)
        {
            group(ReportGroup)
            {
                Caption = 'Report';
                actionref(HRMyReportRef; HRPrintTravelReport) { }
            }
        }
    }
}