page 51525321 "Open Job Adverts"
{
    ApplicationArea = All;
    CardPageID = "Recruitment Request";
    Editable = true;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE(Status = CONST(Released));//, Advertise = const(true));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Job ID"; Rec."Job ID")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Description; Rec.Description)
                {
                }
                /*field("Global Dimension 1 Code"; Rec. "Global Dimension 1 Code")
                {
                }*/
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field("Sub Responsibility Center"; Rec."Sub Responsibility Center")
                {
                }
                field("Reason for Recruitment"; Rec."Reason for Recruitment")
                {
                }
                field("Requested By"; Rec."Requested By")
                {
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                }
                /*field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                }*/
                field(Status; Rec.Status)
                {
                }
                field(Positions; Rec.Positions)
                { }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    Caption = 'Advertisement Type';
                }
                // field(isInternship; Rec. isInternship)
                // {
                // }
                // field(FnCheckIfJobIsClosed; FnCheckIfJobIsClosed)
                // {
                //     Caption = 'Closed';
                // }
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."End Date" < Today then begin
            Rec.Closed := true;
            Rec.Modify();
        end else begin
            if Rec.Closed and (Rec.Status = Rec.Status::Released) then begin
                Rec.Closed := false;
                Rec.Modify();
            end;
        end;
    end;

    trigger OnOpenPage()
    begin
        Rec.Setfilter("Start Date", '<=%1', TODAY);
        Rec.Setfilter("End Date", '>=%1', TODAY);
        Rec.SetRange(Closed, false);
        Rec.SetRange(Status, Rec.Status::Released);
    end;

    procedure FnCheckIfJobIsClosed(): Boolean
    begin
        if Rec."End Date" < Today then
            exit(true)
        else
            exit(false);
    end;
}