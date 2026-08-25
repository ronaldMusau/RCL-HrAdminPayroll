page 52211614 "Portal Doc Emp Selection"
{
    ApplicationArea = All;
    Caption = 'Select Employees';
    PageType = ListPart;
    SourceTable = Employee;
    Editable = true;

    layout
    {
        area(content)
        {
            group(SearchGroup)
            {
                Caption = 'Filter Employees';
                ShowCaption = true;
                grid(FilterGrid)
                {
                    GridLayout = Rows;
                    group(Row1)
                    {
                        ShowCaption = false;
                        field(SearchName; SearchName)
                        {
                            ApplicationArea = All;
                            Caption = 'Name contains';
                            trigger OnValidate()
                            begin
                                ApplyFilters();
                            end;
                        }
                        field(ClearName; '✕')
                        {
                            ApplicationArea = All;
                            Caption = '';
                            Width = 1;
                            Editable = false;
                            trigger OnDrillDown()
                            begin
                                SearchName := '';
                                ApplyFilters();
                            end;
                        }
                    }
                    group(Row2)
                    {
                        ShowCaption = false;
                        field(SearchDept; SearchDept)
                        {
                            ApplicationArea = All;
                            Caption = 'Department';
                            TableRelation = "Responsibility Center";
                            trigger OnValidate()
                            begin
                                ApplyFilters();
                            end;
                        }
                        field(ClearDept; '✕')
                        {
                            ApplicationArea = All;
                            Caption = '';
                            Width = 1;
                            Editable = false;
                            trigger OnDrillDown()
                            begin
                                SearchDept := '';
                                ApplyFilters();
                            end;
                        }
                    }
                    group(Row3)
                    {
                        ShowCaption = false;
                        field(SearchEmpNo; SearchEmpNo)
                        {
                            ApplicationArea = All;
                            Caption = 'Employee No.';
                            trigger OnValidate()
                            begin
                                ApplyFilters();
                            end;
                        }
                        field(ClearEmpNo; '✕')
                        {
                            ApplicationArea = All;
                            Caption = '';
                            Width = 1;
                            Editable = false;
                            trigger OnDrillDown()
                            begin
                                SearchEmpNo := '';
                                ApplyFilters();
                            end;
                        }
                    }
                }
            }
            repeater(Group)
            {
                field(Selected; Selected)
                {
                    ApplicationArea = All;
                    Caption = 'Selected';
                    trigger OnValidate()
                    begin
                        if Selected then begin
                            if not TempEmpSel.Get(Rec."No.") then begin
                                TempEmpSel.Init();
                                TempEmpSel."Employee No." := Rec."No.";
                                TempEmpSel."Employee Name" := Rec.FullName();
                                TempEmpSel."Department Code" := Rec."Responsibility Center";
                                TempEmpSel.Selected := true;
                                TempEmpSel.Insert();
                            end;
                        end else begin
                            if TempEmpSel.Get(Rec."No.") then
                                TempEmpSel.Delete();
                        end;
                    end;
                }
                field("No."; Rec."No.") { ApplicationArea = All; Editable = false; }
                field(FullName; Rec.FullName()) { ApplicationArea = All; Caption = 'Name'; Editable = false; }
                field("Responsibility Center"; Rec."Responsibility Center") { ApplicationArea = All; Editable = false; Caption = 'Department'; }
                field("Job Title"; Rec."Job Title") { ApplicationArea = All; Editable = false; }
            }
        }
    }

    var
        TempEmpSel: Record "Portal Doc Emp Selection" temporary;
        Selected: Boolean;
        SearchName: Text;
        SearchDept: Code[20];
        SearchEmpNo: Code[20];

    trigger OnOpenPage()
    begin
        // Clear all filters when page opens fresh
        Rec.SetRange("No.");
        Rec.SetRange("Full Name");
        Rec.SetRange("Responsibility Center");
        SearchName := '';
        SearchDept := '';
        SearchEmpNo := '';
    end;

    local procedure ApplyFilters()
    begin
        Rec.SetRange("No.");
        Rec.SetRange("Full Name");
        Rec.SetRange("Responsibility Center");

        if SearchName <> '' then
            Rec.SetFilter("Full Name", '@*' + SearchName + '*');
        if SearchDept <> '' then
            Rec.SetRange("Responsibility Center", SearchDept);
        if SearchEmpNo <> '' then
            Rec.SetFilter("No.", '@*' + SearchEmpNo + '*');

        CurrPage.Update(false);
    end;

    procedure GetSelected(var TempEmp: Record "Portal Doc Emp Selection" temporary)
    begin
        TempEmp.Copy(TempEmpSel, true);
    end;
}
