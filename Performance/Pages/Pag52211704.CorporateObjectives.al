page 52211704 "Corporate Objectives"
{
    ApplicationArea = All;
    Caption = 'Corporate Objectives';
    PageType = List;
    SourceTable = "Corporate Objectives";
    UsageCategory = Lists;
    Editable = true;
    DeleteAllowed = true;
    InsertAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
