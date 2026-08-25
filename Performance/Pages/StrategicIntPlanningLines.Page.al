#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211745 "Strategic Int Planning Lines"
{
    PageType = List;
    SourceTable = "Strategic Int Planning Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Annual Reporting Codes"; Rec."Annual Reporting Codes")
                {
                    ApplicationArea = Basic;
                }
                field("Target Budget"; Rec."Target Budget")
                {
                    ApplicationArea = Basic;
                }
                field("Target Qty"; Rec."Target Qty")
                {
                    ApplicationArea = Basic;
                }
                field("Primary Department"; Rec."Primary Department")
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                }
                // field("Primary Division"; Rec."Primary Division")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Allocate Bugdet")
            {
                ApplicationArea = Basic;
                Caption = 'Allocate Bugdet';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = Report "Allocate Budget";
            }
        }
    }
}

#pragma implicitwith restore

