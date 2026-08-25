#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211777 "Workplan Cost Elements"
{
    PageType = List;
    SourceTable = "Workplan Cost Elements";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub Activity No"; Rec."Sub Activity No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Sub Activity Name"; Rec."Sub Activity Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Initiative No."; Rec."Initiative No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cost Element No';
                }
                field("Cost Elements"; Rec."Cost Elements")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                }
                field("Job No"; Rec."Job No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Financial Budget';
                }
                field("Vote id"; Rec."Vote id")
                {
                    ApplicationArea = Basic;
                }
                field("Vote Desription"; Rec."Vote Desription")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Plan Category"; Rec."Plan Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'Plan Category';
                }
                field("Plan Item No"; Rec."Plan Item No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Item No';
                }
                field("Plan Item Description"; Rec."Plan Item Description")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Funding Level"; Rec."Funding Level")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

