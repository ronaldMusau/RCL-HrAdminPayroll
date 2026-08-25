#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211775 "Sub Workplan Activity"
{
    Caption = 'Sub Workplan Activities';
    PageType = List;
    SourceTable = "Sub Workplan Activity";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub-Intiative No"; Rec."Sub Initiative No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sub-Activity No';
                }
                field("Sub-Initiative"; Rec."Objective/Initiative")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sub-Activity';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field(Target; Rec."Imported Annual Target Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Target';
                }
                field("Total Budget"; Rec."Total Budget")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                // field("Total Autocalculated Amount"; Rec."Total Autocalculated Amount")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Expense Amount"; Rec."Expense Amount")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Completion Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = Basic;
                }
                field("Q1 Target Qty"; Rec."Q1 Target Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q1 Target';
                }
                field("Q2 Target Qty"; Rec."Q2 Target Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q2 Target';
                }
                field("Q3 Target Qty"; Rec."Q3 Target Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q3 Target';
                }
                field("Q4 Target Qty"; Rec."Q4 Target Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q4 Target';
                }
                field("Elements Count"; Rec."Elements Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // group("Line Functions ")
            // {
            //     Caption = 'Annual Workplan Sub-Activities';
            //     Image = AnalysisView;
            //     action("Workplan Cost Items")
            //     {
            //         ApplicationArea = Basic;
            //         Image = Notes;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;
            //         RunObject = Page "Workplan Cost Elements";
            //         RunPageLink = "Workplan No." = field("Workplan No."),
            //                       "Activity Id" = field("Activity Id"),
            //                       "Sub Activity No" = field("Sub Initiative No.");
            //     }
            //     action("Update Total SubActivity Budget")
            //     {
            //         ApplicationArea = Basic;
            //         Image = UpdateUnitCost;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;

            //         trigger OnAction()
            //         begin
            //             WorkplanCostElements.Reset;
            //             WorkplanCostElements.SetRange("Workplan No.", Rec."Workplan No.");
            //             WorkplanCostElements.SetRange("Activity Id", Rec."Activity Id");
            //             WorkplanCostElements.SetRange("Sub Activity No", Rec."Sub Initiative No.");
            //             WorkplanCostElements.CalcSums(Amount);
            //             Rec."Total Budget" := WorkplanCostElements.Amount;
            //             Rec.Modify;

            //             Message('Total Sub Activity Budget Updated successfully');
            //         end;
            //     }
            //}
        }
    }

    var
        // WorkplanCostElements: Record "Workplan Cost Elements";
}

#pragma implicitwith restore

