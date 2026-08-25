#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211752 "Secondary Workplan Initiatives"
{
    Caption = 'Secondary Workplan Initiatives';
    PageType = ListPart;
    SourceTable = "Secondary PC Objective";
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Primary Department"; Rec."Primary Department")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No"; Rec.EntryNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EntryNo field.', Comment = '%';
                }
                // field("Initiative No."; Rec."Initiative No.")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Objective/Initiative"; Rec."Objective/Initiative")
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outcome Perfomance Indicator"; Rec."Outcome Perfomance Indicator")
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field("Imported Annual Target Qty"; Rec."Imported Annual Target Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Agreed Targets';
                }
                field("Assigned Weight (%)"; Rec."Assigned Weight (%)")
                {
                    ApplicationArea = Basic;
                }
                field(Control7; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Plog Achieved Targets"; Rec."Plog Achieved Targets")
                {
                    ApplicationArea = Basic;
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
                action("Sub Intiatives")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Sub Objectives/Intiatives";
                    RunPageLink = "Workplan No." = field("Workplan No."),
                                  "Initiative No." = field("Initiative No."),
                                  "Goal ID" = field("Goal ID"),
                                  "Strategy Plan ID" = field("Strategy Plan ID");
                }
                // action("Implementation Intiatives")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                // action("Performance Targets")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;

                //     trigger OnAction()
                //     begin
                //         Message('Test');
                //     end;
                // }
                // action("Performance Appraisal Entries")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;

                //     trigger OnAction()
                //     begin
                //         Message('Test');
                //     end;
                // }
                // action(Comments)
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;

                //     trigger OnAction()
                //     begin
                //         Message('Test');
                //     end;
                // }
                // action("Import Objectives")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;

                //     trigger OnAction()
                //     begin
                //         Message('Test');
                //     end;
                // }
            }
        }
    }
}

