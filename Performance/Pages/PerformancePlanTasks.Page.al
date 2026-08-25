
Page 52211690 "Performance Plan Tasks"
{
    //  CardPageID = "Performance Plan Task";
    PageType = ListPart;
    SourceTable = "Performance Plan Task";
    PopulateAllFields = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Performance Mgt Plan ID"; Rec."Performance Mgt Plan ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Task Code"; Rec."Task Code")
                {
                    ApplicationArea = Basic;
                }
                field("Task Category"; Rec."Task Category")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Review Periods"; Rec."Review Periods")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if ReviewPeriod.Get(Rec."Review Periods") then begin
                            Rec."Performance Cycle Start Date" := ReviewPeriod."Starting Date";
                            Rec."Performance Cycle End Date" := ReviewPeriod."End Date";
                            Rec."Processing Start Date" := ReviewPeriod."Starting Date";
                            Rec."Processing Due Date" := ReviewPeriod."End Date";
                        end;
                    end;
                }
                field("Performance Cycle Start Date"; Rec."Performance Cycle Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Cycle End Date"; Rec."Performance Cycle End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Processing Start Date"; Rec."Processing Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Processing Due Date"; Rec."Processing Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Published?"; Rec."Published?")
                {
                    ApplicationArea = Basic;
                }
                field("Closed?"; Rec."Closed")
                {
                    ApplicationArea = Basic;
                }
                field("Published By"; Rec."Published By")
                {
                    ApplicationArea = Basic;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = Basic;
                }
                field("No of Evaluations/Appeals"; Rec."No of Evaluations/Appeals")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Line Functions")
            {
                action("Publish Task")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        Rec."Published?" := true;
                        Rec."Published By" := UserId;
                        Message('Task Published Successfully');
                    end;
                }
                action("Generate Appraisals")
                {
                    ApplicationArea = Basic;
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec."Task Category" = Rec."task category"::"Performance Review" then begin
                            PerformanceManagementPlan.Reset;
                            PerformanceManagementPlan.SetRange(No, Rec."Performance Mgt Plan ID");
                            if PerformanceManagementPlan.FindFirst then begin
                                StrategicPlanning.FnGenerateBatchAppraisals(Rec, PerformanceManagementPlan."Strategy Plan ID");
                            end;
                        end;
                    end;
                }
                action("Close Task")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        Rec.TestField("Published?", true);
                        Rec."Closed" := true;
                        Rec."Closed By" := UserId;
                        Message('Task Closed Successfully');
                    end;
                }
            }
        }
    }

    var
        ReviewPeriod: Record "Review Periods";
        StrategicPlanning: Codeunit "Strategic Planning";
        PerformanceManagementPlan: Record "Performance Management Plan";
}



