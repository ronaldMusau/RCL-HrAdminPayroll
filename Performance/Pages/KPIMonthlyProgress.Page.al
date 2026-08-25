#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211804 "SPM KPI Monthly Progress"
{
    ApplicationArea = Basic;
    AutoSplitKey = true;
    Caption = 'KPI Monthly Progress';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "SPM KPI Monthly Progress";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Initiative No."; Rec."Initiative No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the KPI / initiative number.';
                }
                field("Objective Description"; Rec."Objective Description")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the objective or KPI description.';
                }
                field("Progress Month"; Rec."Progress Month")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the month for this progress update (first day of the month).';
                }
                field("Progress %"; Rec."Progress %")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the completion percentage for this KPI in the given month.';
                }
                field("Evidence Description"; Rec."Evidence Description")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies evidence or supporting notes for the progress reported.';
                }
                field("Comments"; Rec."Comments")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Additional comments about this KPI progress entry.';
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the annual reporting period.';
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies who last updated this progress entry.';
                }
                field("Updated On"; Rec."Updated On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies when this progress entry was last updated.';
                }
            }
        }
    }
}
