#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211733 "Improvement Plan Line"
{
    PageType = ListPart;
    Caption = 'Milestones';
    SourceTable = "Improvement Plan Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the milestone line number.';
                }
                field("Expectation to be met"; Rec."Expectation to be met")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Describes the expectation or improvement action required for this milestone.';
                }
                field("Success Criteria"; Rec."Success Criteria")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Describes the criteria that must be met for this milestone to be considered successful.';
                }
                field("Achievement Due Date"; Rec."Achievement Due Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the target date by which this milestone must be achieved.';
                }
                field("Milestone Status"; Rec."Milestone Status")
                {
                    ApplicationArea = Basic;
                    StyleExpr = MilestoneStyle;
                    ToolTip = 'Specifies the current status of this milestone: Not Started, In Progress, Completed, or Overdue.';
                }
                field("Completed On"; Rec."Completed On")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the date this milestone was completed. Setting this date automatically marks the milestone as Completed.';
                }
                field("Outcome Perfomance Indicator"; Rec."Outcome Perfomance Indicator")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the KPI or performance indicator used to measure achievement of this milestone.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the unit of measure for the target.';
                }
                field("Desired Perfomance Direction"; Rec."Desired Perfomance Direction")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies whether the KPI should increase or decrease to indicate improvement.';
                }
                field("Target Qty"; Rec."Target Qty")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the target quantity for this milestone.';
                }
                field("Achievement Qty"; Rec."Achievement Qty")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the actual quantity achieved against the target.';
                }
                field("Final Performance Rating"; Rec."Final Performance Rating")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the final rating for this milestone.';
                }
                field("Performance Deficiency ID"; Rec."Performance Deficiency ID")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the performance deficiency this milestone addresses.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies whether this line belongs to a PIP or PIP Review.';
                }
            }
        }
    }

    actions
    {
    }

    var
        MilestoneStyle: Text;

    trigger OnAfterGetRecord()
    begin
        if Rec.IsOverdue() then
            Rec."Milestone Status" := Rec."milestone status"::Overdue;

        case Rec."Milestone Status" of
            Rec."milestone status"::"Not Started":
                MilestoneStyle := 'Ambiguous';
            Rec."milestone status"::"In Progress":
                MilestoneStyle := 'Attention';
            Rec."milestone status"::Completed:
                MilestoneStyle := 'Favorable';
            Rec."milestone status"::Overdue:
                MilestoneStyle := 'Unfavorable';
        end;
    end;
}
