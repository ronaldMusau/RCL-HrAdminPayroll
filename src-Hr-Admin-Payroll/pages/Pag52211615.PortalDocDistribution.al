page 52211615 "Portal Doc Distribution"
{
    ApplicationArea = All;
    Caption = 'Document Distribution';
    PageType = List;
    SourceTable = "Portal Doc Distribution";
    Editable = false;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Code"; Rec."Document Code") { ApplicationArea = All; }
                field("Document Name"; Rec."Document Name") { ApplicationArea = All; }
                field("Send To"; Rec."Send To") { ApplicationArea = All; }
                field("Employee No."; Rec."Employee No.") { ApplicationArea = All; }
                field(EmployeeName; GetEmployeeName()) { ApplicationArea = All; Caption = 'Employee Name'; }
                field("Department Code"; Rec."Department Code") { ApplicationArea = All; }
                field("File Name"; Rec."File Name") { ApplicationArea = All; }
                field("Sent Date"; Rec."Sent Date") { ApplicationArea = All; }
                field("Sent By"; Rec."Sent By") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(FilterByDocument)
            {
                ApplicationArea = All;
                Caption = 'Filter by Document';
                Image = Filter;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.SetRange("Document Code", Rec."Document Code");
                    CurrPage.Update(false);
                end;
            }
            action(ClearFilter)
            {
                ApplicationArea = All;
                Caption = 'Show All';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.SetRange("Document Code");
                    CurrPage.Update(false);
                end;
            }
            action(DeleteDistribution)
            {
                ApplicationArea = All;
                Caption = 'Revoke Access';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                trigger OnAction()
                begin
                    if Confirm('Revoke access for %1 to this document?', false, Rec."Employee No.") then
                        Rec.Delete();
                end;
            }
        }
    }

    local procedure GetEmployeeName(): Text
    var
        Employee: Record Employee;
    begin
        if Employee.Get(Rec."Employee No.") then
            exit(Employee.FullName());
        exit('');
    end;
}
