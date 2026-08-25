#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211676 "Strategy Framework"
{
    PageType = List;
    SourceTable = "Strategy Framework";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Framework Perspectives")
            {
                ApplicationArea = Basic;
                Image = CreateBins;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Strategy Framework Perspective";
                RunPageLink = "Strategy Framework" = field(Code);
            }
            action("Corporate Strategic Plan")
            {
                ApplicationArea = Basic;
                Image = Planning;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Corporate Strategic Plans";
                RunPageLink = "Strategy Framework" = field(Code);
            }
        }
    }
}

