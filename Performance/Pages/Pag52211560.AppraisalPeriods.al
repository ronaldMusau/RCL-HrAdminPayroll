page 52211655 "Appraisal Periods"
{
    ApplicationArea = All;
    Caption = 'Appraisal Periods';
    PageType = List;
    SourceTable = "Appraisal Periods";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = Basic;
                }
                field("Strategic Plan"; Rec."Strategic Plan")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
        }
    }
}
