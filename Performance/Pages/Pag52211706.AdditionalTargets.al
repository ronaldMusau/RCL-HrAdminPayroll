page 52211706 "Additional Targets"
{
    ApplicationArea = All;
    Caption = 'Additional Targets';
    PageType = ListPart;
    SourceTable = "Additional Targets";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Additional Target"; Rec."Additional Target")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Additional Target field.', Comment = '%';
                }
                field("Target Qty"; Rec."Target Qty")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Target Qty field.', Comment = '%';
                }
                field("Results Achieved"; Rec."Results Achieved")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Results Achieved field.', Comment = '%';
                }
                field("Perfomance Appraisal"; Rec."Perfomance Appraisal")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Perfomance Appraisal field.', Comment = '%';
                }
                field(Reasons; Rec.Reasons)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Reasons field.', Comment = '%';
                }
            }
        }
    }
}
