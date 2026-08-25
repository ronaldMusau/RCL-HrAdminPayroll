page 52211588 "Leave Approval Entries"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Approval Entry";
    Caption = 'Leave Approval Entries';
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Entry No."; Rec."Entry No.")
                { ApplicationArea = All; }
                field("Document No."; Rec."Document No.")
                { ApplicationArea = All; }
                field(Status; Rec.Status)
                { ApplicationArea = All; }
                field("Approver ID"; Rec."Approver ID")
                { ApplicationArea = All; }
                field("Sender ID"; Rec."Sender ID")
                { ApplicationArea = All; }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                { ApplicationArea = All; }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                { ApplicationArea = All; }
                field(Comment; Rec.Comment)
                { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Delegate)
            {
                Caption = 'Delegate';
                ApplicationArea = All;
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    UserSetup: Record "User Setup";
                    NewApproverUserSetup: Record "User Setup";
                begin
                    // Find the open approval entry for this leave
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", DATABASE::"Employee Leave Application");
                    ApprovalEntry.SetRange("Document No.", Rec."Document No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    if not ApprovalEntry.FindFirst() then
                        Error('No open approval request found for this leave application.');

                    // Find the substitute for the current approver
                    if not UserSetup.Get(ApprovalEntry."Approver ID") then
                        Error('Approver %1 not found in User Setup.', ApprovalEntry."Approver ID");

                    if UserSetup.Substitute = '' then
                        Error('No substitute has been set for approver %1. Please configure a substitute in Approval User Setup.',
                            ApprovalEntry."Approver ID");

                    // Verify substitute exists
                    if not NewApproverUserSetup.Get(UserSetup.Substitute) then
                        Error('Substitute user %1 not found in User Setup.', UserSetup.Substitute);

                    // Reassign the approval entry to the substitute
                    ApprovalEntry."Approver ID" := UserSetup.Substitute;
                    ApprovalEntry.Modify(true);

                    Message('Approval request for %1 has been delegated from %2 to %3.',
                        Rec."Document No.",
                        UserSetup."User ID",
                        UserSetup.Substitute);

                    CurrPage.Update(false);
                end;
            }
        }
    }
}
