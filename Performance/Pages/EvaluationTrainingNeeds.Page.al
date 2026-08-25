#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211764 "Evaluation Training Needs"
{
    PageType = ListPart;
    SourceTable = "Evaluation Training needs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Course; Rec.Course)
                {
                    ApplicationArea = Basic;
                }
                field("Training Need Number"; Rec."Training Need Number")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Training Need Category"; Rec."Training Need Category")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Training Duration"; Rec."Training Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisee's Comments"; Rec."Appraisee's Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor's Comments"; Rec."Supervisor's Comments")
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

