/// <summary>
/// Page NewAndChangedApprTargets (ID 50029).
/// </summary>
page 52211788 NewAndChangedApprTargets
{
    Caption = 'NewAndChangedApprTargets';
    PageType = ListPart;
    SourceTable = NewAndChangedApprTargets;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Objective/Initiative"; Rec."Objective/Initiative")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target field.';
                }
                field("Target Qty"; Rec."Target Qty")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Target Qty field.', Comment = '%';
                }
                field("Results Achieved"; Rec."Results Achieved")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Results Achieved field.';
                }
                field("Performance Appraisal"; Rec."Performance Appraisal")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Performance Appraisal field.';
                }
                field(Reasons; Rec.Reasons)
                {
                    ApplicationArea = All;
                    // Visible = false;
                    ToolTip = 'Specifies the value of the Reasons field.';
                }
            }
        }
    }
}
