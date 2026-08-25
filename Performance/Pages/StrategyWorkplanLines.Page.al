
Page 52211684 "Strategy Workplan Lines"
{
    PageType = ListPart;
    SourceTable = "Strategy Workplan Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Activity ID"; Rec."Activity ID")
                {
                    ApplicationArea = Basic;
                }
                field(Exists; Rec.Exists)
                {
                    ApplicationArea = basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Outcome; Rec.Outcome)
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Framework"; Rec."Strategy Framework")
                {
                    ApplicationArea = Basic;
                }
                field("Framework Perspective"; Rec."Framework Perspective")
                {
                    ApplicationArea = Basic;
                }
                field("Perfomance Indicator"; Rec."Perfomance Indicator")
                {
                    ApplicationArea = Basic;
                    Caption = 'KPI';
                }
                field("Key Performance Indicator"; Rec."Key Performance Indicator")
                {
                    ApplicationArea = Basic;
                    Caption = 'Perfromance Indicator';
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field("Desired Perfomance Direction"; Rec."Desired Perfomance Direction")
                {
                    ApplicationArea = Basic;
                }
                field("Assigned Weight(%)"; Rec."Assigned Weight(%)")
                {
                    ApplicationArea = Basic;
                }
                field("Imported Annual Target Qty"; Rec."Imported Annual Target Qty")
                {
                    ApplicationArea = Basic;
                }
                field("Imported Annual Budget Est."; Rec."Imported Annual Budget Est.")
                {
                    ApplicationArea = Basic;
                }
                field("Primary Department"; Rec."Primary Department")
                {
                    ApplicationArea = Basic;
                    Caption = 'Primary Department';
                }
                field("Primary Department Name"; Rec."Primary Department Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Primary Department Name';
                }
                // field("Primary Division"; Rec."Primary Division")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                // field("Primary Division Name"; Rec."Primary Division Name")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Visible = false;
                // }
                field("Year Reporting Code"; Rec."Year Reporting Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Year Reporting Code field.', Comment = '%';
                }
                field("Q1 Target"; Rec."Q1 Target")
                {
                    ApplicationArea = Basic;
                }
                field("Q1 Budget"; Rec."Q1 Budget")
                {
                    ApplicationArea = Basic;
                }
                field("Q2 Target"; Rec."Q2 Target")
                {
                    ApplicationArea = Basic;
                }
                field("Q2 Budget"; Rec."Q2 Budget")
                {
                    ApplicationArea = Basic;
                }
                field("Q3 Target"; Rec."Q3 Target")
                {
                    ApplicationArea = Basic;
                }
                field("Q3 Budget"; Rec."Q3 Budget")
                {
                    ApplicationArea = Basic;
                }
                field("Q4 Target"; Rec."Q4 Target")
                {
                    ApplicationArea = Basic;
                }
                field("Q4 Budget"; Rec."Q4 Budget")
                {
                    ApplicationArea = Basic;
                }
                field("AnnualWorkplan Achieved Target"; Rec."AnnualWorkplan Achieved Target")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                // field("Achieved Performance Level"; Rec."Achieved Performance Level")
                // {
                //     ApplicationArea = basic;
                // }

                // field("Key Performance Indicator";"Key Performance Indicator")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Performance Indicator';
                //     Editable = false;
                //     Visible = false;

                //     trigger OnValidate()
                //     begin
                //         KeyPerformanceIndicator.Reset;
                //         KeyPerformanceIndicator.SetRange(KPI,"Key Performance Indicator","Key Performance Indicator");
                //         if KeyPerformanceIndicator.FindFirst then begin
                //             "Unit of Measure":=KeyPerformanceIndicator."Unit of Measure";
                //           end;
                //     end;
                // }

                field("Departmental Activity Weight"; Rec."Departmental Activity Weight")
                {
                    ApplicationArea = Basic;
                }
                // field("Total Subactivity budget"; Rec."Total Subactivity budget")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field("Sub Activity Budget Sum"; Rec."Sub Activity Budget Sum")
                // {
                //     ApplicationArea = Basic;
                // }


                field("Annual Target"; Rec."Annual Target")
                {
                    ApplicationArea = Basic;
                }
                // field("Annual Budget"; Rec."Annual Budget")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Allocated Budget';
                // }


            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Line Functions ")
            {
                Caption = 'Annual Workplan Sub-Activities';
                Image = AnalysisView;
                action("Sub-Activities ")
                {
                    ApplicationArea = Basic;
                    Image = Notes;
                    RunObject = Page "Sub Workplan Activity";
                    RunPageLink = "Strategy Plan ID" = field("Strategy Plan ID"),
                                  "Workplan No." = field(No),
                                  "Activity Id" = field("Activity ID");
                }
            }
            action("Update Activity Achievements")
            {
                ApplicationArea = Basic;
                Caption = 'UPDATE';
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to update Activity  Total Assigned Weight?', true) then
                        Error('Activity achievement not update');

                    SubWorkplanActivity.Reset;
                    SubWorkplanActivity.SetRange("Workplan No.", rec.No);
                    SubWorkplanActivity.SetRange("Activity Id", rec."Activity ID");
                    SubWorkplanActivity.CalcSums(Weight);
                    SubWorkplanActivity.CalcSums("Total Budget");

                    if SubWorkplanActivity.Weight = 100 then begin
                        rec."Assigned Weight(%)" := SubWorkplanActivity.Weight;
                        rec."Total Subactivity budget" := SubWorkplanActivity."Total Budget";

                        rec.Modify;
                    end else
                        Error('Total Assigned Weight for sub-sctivities should be equals to 100%');
                end;
            }
        }
    }

    var
        SubWorkplanActivity: Record "Sub Workplan Activity";
    //  KeyPerformanceIndicator: Record ;


}




#pragma implicitwith restore

