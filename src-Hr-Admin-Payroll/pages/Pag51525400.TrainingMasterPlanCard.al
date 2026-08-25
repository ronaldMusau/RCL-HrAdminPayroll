page 51525400 "Training Master Plan Card"
{
    ApplicationArea = All;
    Caption = 'Course Card';
    PageType = Card;
    SourceTable = "Training Master Plan Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = EnableEditing;

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Theory/Practical"; Rec."Theory/Practical")
                { }
                field(Category; Rec.Category)
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    MultiLine = true;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Course Abbreviation"; Rec."Course Abbreviation")
                { }
                field("Mandatory/Optional"; Rec."Mandatory/Optional")
                {
                    ToolTip = 'Specifies the value of the Mandatory/Optional field.';
                }
                field(Recurrence; Rec.Recurrence)
                {
                    ToolTip = 'Specifies the value of the Recurrence field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    Caption = 'Frequency (H,D,M,Y)';
                    ToolTip = 'Specify a number then letter H for hours, D-days, M-months, Y-years eg 3M';
                }
                field("Approximate Duration"; Rec."Approximate Duration")
                {
                    Caption = 'Approximate Duration (H,D,M,Y)';
                    ToolTip = 'Specify a number then letter H for hours, D-days, M-months, Y-years eg 3M';
                }
                field("Notification Period Notice"; Rec."Notification Period Notice")
                {
                    ToolTip = 'Specifies the value of the Notification Period Notice field.';
                }
                field(Objectives; Rec.Objectives)
                {
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Legacy Data"; Rec."Legacy Data")
                { }
                field("Training Area"; Rec."Training Area")
                { }
                field("Target Group"; Rec."Target Group")
                { }
                field("No. of Trainees"; Rec."No. of Trainees")
                { }
                field("Proposed Start Date"; Rec."Proposed Start Date")
                { }
                field("Proposed End Date"; Rec."Proposed End Date")
                { }
                field("Proposed Trainer"; Rec."Proposed Trainer")
                { }
                field("Venue/Location"; Rec."Venue/Location")
                { }
                field("Budget/Expense"; Rec."Budget/Expense")
                { }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part("Applicable Departments"; "Training Master Plan Lines")
            {
                Caption = 'Departments';
                SubPageLink = "No." = FIELD("No.");
                UpdatePropagation = Both;
                Editable = EnableEditing;
            }
        }
        area(factboxes)
        {
            part(ApprovalEntries; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(51525341), "Document No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SendApprovalRequest)
            {
                Caption = 'Send Approval Request';
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec."Approval Status" = Rec."Approval Status"::Open;

                trigger OnAction()
                var
                    VarVariant: Variant;
                    CustomApprovals: Codeunit "Custom Approvals Mgmt HR";
                begin
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Request';
                ApplicationArea = All;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec."Approval Status" = Rec."Approval Status"::"Pending Approval";

                trigger OnAction()
                var
                    VarVariant: Variant;
                    CustomApprovals: Codeunit "Custom Approvals Mgmt HR";
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(ReopenDocument)
            {
                Caption = 'Reopen';
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::Released) or
                          (Rec."Approval Status" = Rec."Approval Status"::Rejected);

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to reopen this Training Master Plan? Approval Status will be reset to Open.') then
                        exit;
                    Rec."Approval Status" := Rec."Approval Status"::Open;
                    Rec.Modify(true);
                    EnableEditing := true;
                    CurrPage.Update(false);
                    Message('Training Master Plan %1 has been reopened.', Rec."No.");
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                ApplicationArea = All;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            action("Apply to all Departments")
            {
                Caption = 'Apply to all Departments';
                Promoted = true;
                PromotedCategory = Process;
                Enabled = EnableEditing;

                trigger OnAction()
                var
                    TMALines: Record "Training Master Plan Lines";
                    TMALineInit: Record "Training Master Plan Lines";
                    Depts: Record "Responsibility Center";
                    LineNo: Integer;
                begin
                    if not Confirm('Are you sure this training applies to all departments in the organization?') then exit;
                    LineNo := 0;
                    TMALines.Reset();
                    IF TMALines.FindLast() then
                        LineNo := TMALines."Line No.";
                    Depts.Reset();
                    if Depts.FindSet() then
                        repeat
                            TMALines.Reset();
                            TMALines.SetRange("No.", Rec."No.");
                            TMALines.SetRange("Dept Code", Depts."Code");
                            if not TMALines.FindFirst() then begin
                                LineNo += 1;
                                TMALineInit.Reset();
                                TMALineInit.Init();
                                TMALineInit."Line No." := LineNo;
                                TMALineInit."No." := Rec."No.";
                                TMALineInit."Dept Code" := Depts."Code";
                                TMALineInit.Validate("Dept Code");
                                TMALineInit.Insert()
                            end;
                        until Depts.Next() = 0;
                    Message('Done!');
                end;
            }
            action("Import Legacy Data")
            {
                RunObject = report "Import Legacy Training Data";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableEditing := (Rec."Approval Status" = Rec."Approval Status"::Open) and not Rec.IsAReadOnlyUser();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Approval Status" := Rec."Approval Status"::Open;
        EnableEditing := true;
    end;

    var
        EnableEditing: Boolean;
}
