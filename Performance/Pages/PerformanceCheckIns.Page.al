#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211801 "SPM Performance Check Ins"
{
    ApplicationArea = Basic;
    Caption = 'Performance Check-Ins';
    CardPageId = "SPM Performance Check In Card";
    PageType = List;
    SourceTable = "SPM Performance Check In";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the check-in document number.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee name.';
                }
                field("Check-In Period Description"; Rec."Check-In Period Description")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the check-in period (e.g. August 2025 Monthly Check-In).';
                }
                field("Check-In Date"; Rec."Check-In Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the date of the check-in.';
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the reporting year.';
                }
                field("Q4 Mid-Year Self Rating"; Rec."Q4 Mid-Year Self Rating")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the mid-year self rating.';
                }
                field("Check-In Status"; Rec."Check-In Status")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the status of the check-in.';
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee department.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(NewCheckIn)
            {
                ApplicationArea = Basic;
                Caption = 'New Check-In';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "SPM Performance Check In Card";
                RunPageMode = Create;
                ToolTip = 'Create a new monthly check-in.';
            }
        }
    }
}
