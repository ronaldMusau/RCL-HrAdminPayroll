page 52211580 "Emp Document Category List"
{
    ApplicationArea = All;
    Caption = 'Employee Document Categories';
    PageType = List;
    SourceTable = "Emp Document Category";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document category code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document category description shown to employees.';
                }
                field(Required; Rec.Required)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this document is required for all employees.';
                }
                field("Allow Employee Upload"; Rec."Allow Employee Upload")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether employees can upload this document type themselves via the ESS portal.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this category is blocked from use.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(InitDefaults)
            {
                ApplicationArea = All;
                Caption = 'Initialize Default Categories';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Creates a default set of document categories if none exist.';

                trigger OnAction()
                var
                    EmpDocMgmt: Codeunit "Employee Document Mgmt";
                begin
                    EmpDocMgmt.InitializeDefaultCategories();
                    CurrPage.Update(false);
                    Message('Default categories have been created.');
                end;
            }
        }
    }
}
