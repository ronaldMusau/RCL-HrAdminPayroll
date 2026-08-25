#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211793 "Training Courses Setup"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Training Courses Setup";
    UsageCategory = Tasks;
    PopulateAllFields = true;

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
                field("Course ID"; Rec."Course ID")
                {
                    ApplicationArea = All;
                }
                field(Descritpion; Rec.Descritpion)
                {
                    ApplicationArea = Basic;
                }
                field(Domain; Rec.Domain)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Institution field.', Comment = '%';
                }
                field("No. of Staff Trained"; Rec."No. of Staff Trained")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Spent"; Rec."Budget Spent")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Name of Course"; Rec."Name of Course")
                {
                    ToolTip = 'Specifies the value of the Name of Course field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Needs To be Addressed")
            {
                ApplicationArea = Basic;
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Training Courses Needs";
                RunPageLink = "Course Code" = field(Code);
            }
        }
    }
}

