page 52211703 "Strategic Goals"
{
    ApplicationArea = All;
    Caption = 'Strategic Goals';
    PageType = List;
    SourceTable = "Strategic Goals";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Strategic Plan ID"; Rec."Strategic Plan ID")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Strategic Plan ID field.', Comment = '%';
                }
                field("Theme ID"; Rec."Theme ID")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Theme ID field.', Comment = '%';
                }
                field("Goal ID"; Rec."Goal ID")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Goal ID field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
