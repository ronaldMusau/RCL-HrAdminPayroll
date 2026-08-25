page 52211613 "Portal Doc Dept Selection"
{
    ApplicationArea = All;
    Caption = 'Select Departments';
    PageType = ListPart;
    SourceTable = "Responsibility Center";
    Editable = true;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Search';
                ShowCaption = false;
                field(SearchDept; SearchDept)
                {
                    ApplicationArea = All;
                    Caption = 'Search by Department';
                    trigger OnValidate()
                    begin
                        if SearchDept <> '' then
                            Rec.SetFilter(Name, '@*' + SearchDept + '*')
                        else
                            Rec.SetRange(Name);
                        CurrPage.Update(false);
                    end;
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
                            if not TempDeptSel.Get(Rec.Code) then begin
                                TempDeptSel.Init();
                                TempDeptSel."Department Code" := Rec.Code;
                                TempDeptSel."Department Name" := Rec.Name;
                                TempDeptSel.Selected := true;
                                TempDeptSel.Insert();
                            end;
                        end else begin
                            if TempDeptSel.Get(Rec.Code) then
                                TempDeptSel.Delete();
                        end;
                    end;
                }
                field("Code"; Rec.Code) { ApplicationArea = All; Editable = false; }
                field(Name; Rec.Name) { ApplicationArea = All; Editable = false; }
            }
        }
    }

    var
        TempDeptSel: Record "Portal Doc Dept Selection" temporary;
        Selected: Boolean;
        SearchDept: Text;

    procedure GetSelected(var TempDept: Record "Portal Doc Dept Selection" temporary)
    begin
        TempDept.Copy(TempDeptSel, true);
    end;
}
