page 52211547 "Medical Information Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Medical Information";
    UsageCategory = Administration;
    Caption = 'Medical Certificate Types';

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
