#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211759 "Board SUb Activities"
{
    PageType = ListPart;
    SourceTable = "Board Sub Activities";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub-Initiative"; Rec."Objective/Initiative")
                {
                    ApplicationArea = Basic;
                }
                field("Sub-Indicator"; Rec."Outcome Perfomance Indicator")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Target; Rec."Imported Annual Target Qty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Target';
                }
                field("Completion Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Achieved Targets"; Rec."Achieved Targets")
                {

                }
                //  field("Sub Activity Budget"; REC."Sub Activity Budget")
                //  {
                //      ApplicationArea = Basic;
                //      Visible = false;
                //  }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

