#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211696 "Aligned Business Goals"
{
    PageType = List;
    SourceTable = "PC Goal Hub";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Goal ID"; Rec."Goal ID")
                {
                    ApplicationArea = Basic;
                }
                field("Goal Description"; Rec."Goal Description")
                {
                    ApplicationArea = Basic;
                }
                field("Aligned-To Strategic Plan ID"; Rec."Aligned-To Strategic Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Aligned-To PC ID"; Rec."Aligned-To PC ID")
                {
                    ApplicationArea = Basic;
                }
                field("Aligned-To PC Goal ID"; Rec."Aligned-To PC Goal ID")
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

