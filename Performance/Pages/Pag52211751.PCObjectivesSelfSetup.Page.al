#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211818 "PC Objectives Self Setup"
{
    ApplicationArea = Basic;
    Caption = 'Objectives & KPIs';
    PageType = ListPart;
    SourceTable = "PC Objective";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Objective/Initiative"; Rec."Objective/Initiative")
                {
                    ApplicationArea = Basic;
                    Caption = 'Objective / KPI Title';
                    ToolTip = 'Describe the objective or KPI in clear terms.';
                }
                field("Key Performance Indicator"; Rec."Key Performance Indicator")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    ToolTip = 'Provide more detail on how this KPI will be measured and what constitutes success.';
                }
                field("Assigned Weight (%)"; Rec."Assigned Weight (%)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Weight (%)';
                    ToolTip = 'Specifies the weighting of this KPI. All KPI weights must total 100%.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Target Completion Date';
                    ToolTip = 'Specifies the date by which this KPI should be achieved.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the unit in which the KPI is measured (e.g. %, RWF, count).';
                }
                field("Desired Perfomance Direction"; Rec."Desired Perfomance Direction")
                {
                    ApplicationArea = Basic;
                    Caption = 'KPI Direction';
                    ToolTip = 'Specifies whether a higher or lower value indicates better performance.';
                }
                field("Imported Annual Target Qty"; Rec."Imported Annual Target Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Annual Target';
                    ToolTip = 'Specifies the annual target quantity for this KPI.';
                }
                field("Priority Level"; Rec."Priority Level")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the priority of this objective.';
                }
                field(Progress; Rec.Progress)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the current progress status of this objective.';
                }
                field("%Complete"; Rec."%Complete")
                {
                    ApplicationArea = Basic;
                    Caption = '% Complete';
                    ToolTip = 'Specifies the current completion percentage for this objective.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Initiative Type" := Rec."Initiative Type"::"Employee-Defined";
    end;
}
