#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211742 "Board Activities"
{
    Caption = 'PC Activities';
    PageType = ListPart;
    SourceTable = "Board Activities";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("AWP No"; Rec."AWP No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Board Activity Code"; Rec."Board Activity Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'PC Target Code';

                }
                field("Board Activity Description"; Rec."Board Activity Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'PC Target  Description';
                }
                // field("Primary Directorate"; Rec."Primary Department")
                // {
                //     ApplicationArea = Basic;
                //     Editable = true;
                //
                // }
                // field("Primary Department"; Rec."Primary Division")
                // {
                //     ApplicationArea = Basic;
                //     Editable = true;


                //     trigger OnValidate()
                //     begin
                //         /*BoardActivities.RESET;
                //         BoardActivities.SETCURRENTKEY("Activity Code",Division,Department,"Cross Cutting Item");
                //         BoardActivities.SETRANGE(Division,Division);
                //         BoardActivities.SETRANGE(Department,Department);
                //         BoardActivities.SETASCENDING("Cross Cutting Item",TRUE);
                //         IF NOT BoardActivities.FINDLAST THEN  BEGIN
                //             "Cross Cutting Item":='01';
                //           "Entry No":=Department+'_'+"Cross Cutting Item";
                //         END ELSE BEGIN
                //            "Cross Cutting Item":=INCSTR(BoardActivities."Cross Cutting Item");
                //           "Entry No":=BoardActivities.Department+'_'+"Cross Cutting Item"; */

                //     end;
                // }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Activity Description"; Rec."Activity Description")
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field("WT(%)"; Rec."WT(%)")
                {
                    ApplicationArea = Basic;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Framework"; Rec."Strategy Framework")
                {
                    ApplicationArea = Basic;
                }
                field("Framework Perspective"; Rec."Framework Perspective")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("AnnualWorkplan Achieved Target"; Rec."AnnualWorkplan Achieved Target")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Board Sub-Activities")
            {
                ApplicationArea = Basic;
                Caption = 'PC Sub-Activities';
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Board SUb Activities";
                RunPageLink = "Workplan No." = field("AWP No"),
                              "Initiative No." = field("Board Activity Code"),
                              "Activity Id" = field("Activity Code");
            }
        }
    }

    var
        BoardActivities: Record "Board Activities";
}

#pragma implicitwith restore

