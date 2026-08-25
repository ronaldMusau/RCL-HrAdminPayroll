#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211819 "Employee KPI Self-Setup List"
{
    ApplicationArea = Basic;
    Caption = 'My KPI Submissions';
    PageType = List;
    CardPageId = "Employee KPI Self-Setup";
    SourceTable = "Perfomance Contract Header";
    SourceTableView = where("Document Type" = const("Staff Performance Contract"),
                            "Target Setting Type" = const("Employee-Initiated"));
    PromotedActionCategories = 'New,Process,Report';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the scorecard number.';
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the performance cycle year.';
                }
                field("Responsible Employee No."; Rec."Responsible Employee No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee name.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the department.';
                }
                field("Total Assigned Weight(%)"; Rec."Total Assigned Weight(%)")
                {
                    ApplicationArea = Basic;
                    Caption = 'KPI Weight (%)';
                    StyleExpr = WeightStyle;
                    ToolTip = 'Specifies the total assigned KPI weight. Must equal 100% before submission.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StatusStyle;
                    ToolTip = 'Specifies the current approval status.';
                }
                field("Employee Submitted On"; Rec."Employee Submitted On")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies when the employee submitted for manager review.';
                }
                field("Manager Acknowledged By"; Rec."Manager Acknowledged By")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the manager who approved.';
                }
                field("Manager Acknowledged On"; Rec."Manager Acknowledged On")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies when the manager approved.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(NewKPISetup)
            {
                ApplicationArea = Basic;
                Caption = 'New';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = page "Employee KPI Self-Setup";
                RunPageMode = Create;
                ToolTip = 'Create a new employee-initiated KPI scorecard.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total Assigned Weight(%)");

        if Rec."Total Assigned Weight(%)" = 100 then
            WeightStyle := 'Favorable'
        else if Rec."Total Assigned Weight(%)" > 100 then
            WeightStyle := 'Unfavorable'
        else
            WeightStyle := 'Attention';

        case Rec."Approval Status" of
            Rec."approval status"::Open:
                StatusStyle := 'Ambiguous';
            Rec."approval status"::"Pending Approval":
                StatusStyle := 'Attention';
            Rec."approval status"::Released:
                StatusStyle := 'Favorable';
            Rec."approval status"::Rejected:
                StatusStyle := 'Unfavorable';
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."document type"::"Staff Performance Contract";
        Rec."Target Setting Type" := Rec."target setting type"::"Employee-Initiated";
        exit(true);
    end;

    var
        WeightStyle: Text;
        StatusStyle: Text;
}
