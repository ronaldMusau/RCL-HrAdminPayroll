#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211762 "Evaluation Improvement Plan"
{
    PageType = ListPart;
    SourceTable = "Evaluation PIP";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PIP Number"; Rec."PIP Number")
                {
                    ApplicationArea = Basic;
                }
                field("PIP Category"; Rec."PIP Category")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

