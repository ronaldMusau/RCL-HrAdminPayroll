page 51525403 "Training Request"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Training Request";
    PromotedActionCategories = 'New,Process,Report,Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = EnableEditing;
                field("Request No."; Rec."Request No.")
                {
                    Editable = false;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                }
                field(Directorate; Rec.Directorate)
                {
                    Visible = false;
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    Visible = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Training Master Plan No."; Rec."Training Master Plan No.")
                {
                    ApplicationArea = All;
                    Caption = 'Annual Training Plan';
                    Editable = EnableEditing;
                }
                field(AvailableBudget; AvailableBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Available Budget';
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Requested By';
                    Editable = false;
                    trigger OnValidate()
                    var
                        Emp: Record Employee;
                    begin
                        if Rec."Employee No" <> '' then begin
                            if Emp.Get(Rec."Employee No") then begin
                                Rec."Department Code" := Emp."Global Dimension 2 Code";
                                Rec.Validate("Department Code");
                            end;
                        end else begin
                            Rec."Department Code" := '';
                            Rec."Department Name" := '';
                        end;
                    end;
                }
                field("Tuition Fee"; Rec."Tuition Fee")
                {
                    Editable = false;
                }
                field("Perdiem Per Day"; Rec."Perdiem Per Day")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    Caption = 'Total Per Diem';
                    Editable = false;
                }
                field("Air Ticket"; Rec."Air Ticket")
                {
                    Editable = false;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                }
                field("No. of Approvals"; Rec."No. of Approvals")
                {
                    Editable = false;
                    Visible = false;
                }
            }
            part(Control46; "Training Participants")
            {
                SubPageLink = "Training Request" = FIELD("Request No.");
                Editable = EnableEditing;
            }
        }
        area(factboxes)
        {
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Training Request"),
                              "No." = field("Request No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval Request")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                var
                    CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                    Variant: Variant;
                begin
                    /*GLSetup.RESET;
                    GLSetup.GET;
                    HRSetup.RESET;
                    HRSetup.GET;
                    HRSetup.TESTFIELD("FY Deadline-Training Proposals");
                    IF GLSetup."Current Budget"<>"Budget Name" THEN BEGIN
                      // ERROR('You can only Request Trainings For FY '+GLSetup."Current Budget"+'.Your Training is For FY '+"Budget Name");
                    END;
                    IF "Request Date">HRSetup."FY Deadline-Training Proposals" THEN BEGIN
                        //ERROR('You are requesting training after the Deadline!');
                    END;
                    
                    TESTFIELD("Request Date");
                    TESTFIELD("Tuition Fee");
                    TESTFIELD("Local Destination");
                    //TESTFIELD("Per Diem");
                    TESTFIELD("Planned Start Date");
                    TESTFIELD("Planned End Date");
                    IF "International Travel" THEN BEGIN
                         TESTFIELD("International Destination");
                         TESTFIELD("Exchange Rate");
                    END;
                    */
                    /*
                    //enable
                    IF ApprovalsMgmt.CheckTrainingApprovalPossible(Rec) THEN
                       ApprovalsMgmt.OnSendTrainingDocForApproval(Rec);
                    */

                    Rec.CalcFields("Total Cost");
                    if Rec."Total Cost" = 0 then
                        Error('Training Request %1 has no costs entered. Please add participant costs before sending for approval.',
                              Rec."Request No.");
                    if Rec."Training Master Plan No." = '' then
                        Error('Please select an Annual Training Plan before sending for approval.');
                    Variant := Rec;
                    if CustomApprovalsHR.CheckApprovalsWorkflowEnabled(Variant) then
                        CustomApprovalsHR.OnSendDocForApproval(Variant);
                end;
            }
            action("Cancel Approval Request.")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = true;
                Enabled = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                var
                    CustomApprovalsHR: Codeunit "Custom Approvals Mgmt HR";
                    Variant: Variant;
                begin

                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error('Only requests pending approval can be canceled');
                    Variant := Rec;
                    CustomApprovalsHR.OnCancelDocApprovalRequest(Variant);
                    Rec.Get(Rec."Request No.");
                    if Rec.Status = Rec.Status::"Pending Approval" then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                end;
            }
            action(Reopen)
            {
                ApplicationArea = All;
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected);

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Released then
                        Error('The document must be released to reopen.');
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    CurrPage.Update(false);
                end;
            }
            action(Revise)
            {
                Image = RefreshText;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = seerevise;

                trigger OnAction()
                begin
                    ans := Confirm('Revising will Send an E-mail to the Training Need Requestor For Changes to the Training Need.\You will be required to Put Comments on the Document.\Are you sure you want to Revise?');
                    if Format(ans) = 'Yes' then begin
                        // approvalsmgmt.GetApprovalCommentERC(Rec,3,"Request No.");
                    end;
                end;
            }
            action("DMS Link")
            {
                Image = Web;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin

                    /*GLSetup.Get;
                    link := GLSetup."DMS Imprest Link" + "Request No.";
                    HyperLink(link);*/
                end;
            }
            action(Attachments)
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;
                trigger OnAction()
                var
                    DocAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocAttachmentDetails.OpenForRecRef(RecRef);
                    DocAttachmentDetails.RunModal();
                end;
            }
            action("Approval Entries")
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            action("Create Tuition Invoice")
            {
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = seeInvoice;

                trigger OnAction()
                begin
                    if Rec."Tuition Invoice Created" = true then begin
                        Error('Purchase Invoice Already Created For This Training!');
                    end;

                    purchaseHdr.Reset;
                    //purchaseHdr.SetFilter("Training Code", "Request No.");
                    if purchaseHdr.FindSet then begin
                        Error('This Training has already been used in Creating Purchase Invoice No: ' + purchaseHdr."No.");
                    end;

                    //GLSetup.Reset;

                    purchaseHdr.Reset;
                    purchaseHdr."No." := '';
                    purchaseHdr."Document Type" := purchaseHdr."Document Type"::Invoice;
                    purchaseHdr."Buy-from Vendor No." := Rec."Training Institution Code";
                    purchaseHdr.Validate("Buy-from Vendor No.");
                    purchaseHdr."Document Date" := Today;
                    purchaseHdr."Posting Date" := Today;
                    purchaseHdr.Validate("Document Date");
                    purchaseHdr."Prices Including VAT" := true;
                    //purchaseHdr."From Training Tuition" := true;
                    //purchaseHdr."Training Code" := "Request No.";
                    purchaseHdr.Insert;

                    purchaseline.Reset;
                    purchaseline.Init;
                    purchaseline."Document Type" := purchaseline."Document Type"::Invoice;
                    purchaseline."Document No." := purchaseHdr."No.";
                    purchaseline.Validate("Document No.");
                    purchaseline.Type := purchaseline.Type::"G/L Account";
                    purchaseline."No." := Rec."GL Account";
                    purchaseline.Validate("No.");
                    purchaseline.Quantity := 1;
                    purchaseline.Validate(Quantity);
                    purchaseline."Direct Unit Cost" := Rec."Tuition Fee";
                    purchaseline.Validate("Direct Unit Cost");
                    purchaseline.Insert;

                    Rec."Tuition Invoice Created" := true;
                    Rec.Modify;
                    PAGE.Run(51, purchaseHdr);
                end;
            }
            group(Approval)
            {
                Caption = 'Approval';
                Image = Alerts;
                Enabled = EnableEditing;
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Close;
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Close();
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                        //CurrPage.CLOSE;
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total Cost", "Per Diem", "Air Ticket", "Tuition Fee");
        if IsNewRecord then begin
            IsNewRecord := false;
            Rec."Department Code" := '';
            Rec."Department Name" := '';
            if Rec.Modify() then;
        end;
        if Rec."Training Master Plan No." <> '' then begin
            if AnnualPlan.Get(Rec."Training Master Plan No.") then begin
                AnnualPlan.CalcFields("Courses Budget", "Total Used");
                AvailableBudget := (AnnualPlan."Courses Budget" + AnnualPlan."Extra Budget") - AnnualPlan."Total Used";
            end;
        end else
            AvailableBudget := 0;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExistForCurrUser2 := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    trigger OnModifyRecord(): Boolean
    begin

        /*
        IF Status=Status::Released THEN BEGIN
                     Usersetup.RESET;
                      Usersetup.SETFILTER("User ID",USERID);
                      IF Usersetup.FINDSET THEN BEGIN
                         emprec.RESET;
                         IF emprec.GET(Usersetup."Employee No.") THEN BEGIN
                            GLSetup.RESET;
                            GLSetup.GET;
                            GLSetup.TESTFIELD("HR Department");//MESSAGE('%1\%2\%3',emprec."Global Dimension 1 Code",emprec."No.",Usersetup."User ID");
                            IF GLSetup."HR Department"<>emprec."Global Dimension 1 Code" THEN BEGIN
                               ERROR('You cannot Modify an Approved Training Need!');
                            END;
                         END;
                      END;
        END;
        */

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Currency := 'USD';
        IsNewRecord := true;
        Emp.Reset();
        Emp.SetRange("User ID", UserId);
        if Emp.FindFirst() then begin
            Rec."Employee No" := Emp."No.";
            Rec."Department Code" := Emp."Global Dimension 2 Code";
            Rec.Validate("Department Code");
        end;
    end;

    trigger OnOpenPage()
    var
        TrainingMasterRec: Record "Training Master Plan Header";
    begin
        //CurrPage.Editable(true);
        EnableEditing := true;
        if TrainingMasterRec.IsAReadOnlyUser() then
            EnableEditing := false;//CurrPage.Editable(false);
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExistForCurrUser2 := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        seerevise := false;


        /*Usersetup.Reset;
        Usersetup.SetFilter("User ID", UserId);
        if Usersetup.FindSet then begin
            emprec.Reset;
            if emprec.Get(Usersetup."Employee No.") then begin
                GLSetup.Reset;
                GLSetup.Get;
                //GLSetup.TestField("HR Department");//MESSAGE('%1\%2\%3',emprec."Global Dimension 1 Code",emprec."No.",Usersetup."User ID");
                if GLSetup."HR Department" = emprec."Global Dimension 1 Code" then begin
                    HRSee := true;
                end;
            end;
        end;*/

        editablebd := true;
        if Rec.Status = Rec.Status::Released then begin //The Document is Released, now just visible to HR Guys info
            editablebd := false;
            /*Usersetup.Reset;
            Usersetup.SetFilter("User ID", UserId);
            if Usersetup.FindSet then begin
                emprec.Reset;
                if emprec.Get(Usersetup."Employee No.") then begin
                    GLSetup.Reset;
                    GLSetup.Get;
                    //GLSetup.TestField("HR Department");//MESSAGE('%1\%2\%3',emprec."Global Dimension 1 Code",emprec."No.",Usersetup."User ID");
                    if GLSetup."HR Department" = emprec."Global Dimension 1 Code" then begin
                        OpenApprovalEntriesExistForCurrUser2 := false;
                        seerevise := true;
                    end;
                end;
            end;*/
        end;
        if Rec.Status = Rec.Status::Released then begin
            if Rec."Ready For Imprest" = true then begin
                seerevise := false;
                seeInvoice := true;
            end;
        end;

    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        approvalentry: Record "Approval Entry";
        OpenApprovalEntriesExistForCurrUser2: Boolean;
        i: Integer;
        approvalentries: Record "Approval Entry";
        CUST: Record Customer;
        Internationalsee: Boolean;
        Localsee: Boolean;
        //dotnetvalue: DotNet Interaction;
        commentmsg: Text;
        commentline: Record "Approval Comment Line";
        //GLSetup: Record "Cash Management Setup";
        link: Text;
        HRSee: Boolean;
        Usersetup: Record "User Setup";
        emprec: Record Employee;
        editablebd: Boolean;
        ans: Boolean;
        seerevise: Boolean;
        purchaseHdr: Record "Purchase Header";
        purchaseline: Record "Purchase Line";
        seeInvoice: Boolean;
        HRSetup: Record "Human Resources Setup";
        EnableEditing: Boolean;
        AvailableBudget: Decimal;
        AnnualPlan: Record "Annual Training Plan";
        IsNewRecord: Boolean;
        Emp: Record Employee;
}

