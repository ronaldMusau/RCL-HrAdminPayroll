page 52211686 "Functional calendar"
{
    Caption = 'Corporate Calendar';
    PageType = Card;
    SourceTable = "Performance Management Plan";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    Visible = false;
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                }
                // field("Quarterly Reporting code";"Quarterly Reporting code")
                // {
                // }
                field("Start Date"; Rec."Start Date")
                {
                    Visible = false;
                }
                field("End Date"; Rec."End Date")
                {
                    Visible = false;
                }
                field("Evaluation Type"; Rec."Evaluation Type")
                {
                    Visible = false;
                }
                field("HR Performance Template"; Rec."HR Performance Template")
                {
                    Visible = false;
                }
                field("Executive Summary"; Rec."Executive Summary")
                {
                    Visible = false;
                }
                // field(Department;Department)
                // {
                //     Visible = false;
                // }
                field("Approval Status"; Rec."Approval Status")
                {
                }
                field("Performance Contract  Template"; Rec."Performance Contract  Template")
                {
                    Visible = false;
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
            // part(part;80455)
            // {
            //     SubPageLink = "Performance Mgt Plan ID"=FIELD(No);
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    MESSAGE('Sent Successfully');
                end;
            }
            action("Cancel Approval")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    MESSAGE('Cancelled');
                end;
            }
            action("Post To Corporate")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    MESSAGE('Posted');
                end;
            }
            action("Corporate Calender Report")
            {
                Image = "report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PerformanceManagementPlan.RESET;
                    PerformanceManagementPlan.SETRANGE(No, Rec.No);
                    // IF PerformanceManagementPlan.FINDFIRST THEN
                    //     REPORT.RUN(80043, TRUE, TRUE, PerformanceManagementPlan);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Corporate;
    end;

    var
        PerformanceManagementPlan: Record "Performance Management Plan";
}

