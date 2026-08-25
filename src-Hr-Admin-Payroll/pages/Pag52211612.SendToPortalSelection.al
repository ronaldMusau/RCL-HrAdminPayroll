page 52211612 "Send To Portal Selection"
{
    ApplicationArea = All;
    Caption = 'Send Document to Portal';
    PageType = Card;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Step1)
            {
                Caption = 'Step 1: Choose Recipients';
                Visible = Step1Visible;
                group(SendToGroup)
                {
                    Caption = '';
                    field(SendTo; SendTo)
                    {
                        ApplicationArea = All;
                        Caption = 'Send To';
                        OptionCaption = 'All Employees,By Department,Individual Employees';
                        trigger OnValidate()
                        begin
                            UpdateStepVisibility();
                        end;
                    }
                }
                group(AllEmployeesGroup)
                {
                    Caption = 'Confirmation';
                    Visible = SendTo = SendTo::"All Employees";
                    field(AllEmpMsg; AllEmpMsg)
                    {
                        ApplicationArea = All;
                        Caption = '';
                        Editable = false;
                        MultiLine = true;
                    }
                }
            }
            group(Step2Dept)
            {
                Caption = 'Step 2: Select Departments';
                Visible = DeptStepVisible;
                part(DeptList; "Portal Doc Dept Selection")
                {
                    ApplicationArea = All;
                    Caption = 'Select Departments';
                }
            }
            group(Step2Emp)
            {
                Caption = 'Step 2: Select Employees';
                Visible = EmpStepVisible;
                part(EmpList; "Portal Doc Emp Selection")
                {
                    ApplicationArea = All;
                    Caption = 'Select Employees';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ActionSend)
            {
                ApplicationArea = All;
                Caption = 'Send';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    SendDocuments();
                end;
            }
        }
    }

    var
        SendTo: Option "All Employees","By Department","Individual Employees";
        DocumentCode: Code[20];
        DocumentName: Text[250];
        Step1Visible: Boolean;
        DeptStepVisible: Boolean;
        EmpStepVisible: Boolean;
        AllEmpMsg: Text;
        DocAttachmentID: Integer;
        DocFileName: Text[250];
        DocFileExtension: Text[20];

    trigger OnOpenPage()
    begin
        Step1Visible := true;
        DeptStepVisible := false;
        EmpStepVisible := false;
        AllEmpMsg := 'This document will be sent to ALL employees in the system. Click Send to confirm.';
    end;

    procedure SetDocument(DocCode: Code[20]; DocName: Text[250]; AttachID: Integer; FileName: Text[250]; FileExt: Text[20])
    begin
        DocumentCode := DocCode;
        DocumentName := DocName;
        DocAttachmentID := AttachID;
        DocFileName := FileName;
        DocFileExtension := FileExt;
    end;

    local procedure UpdateStepVisibility()
    begin
        DeptStepVisible := SendTo = SendTo::"By Department";
        EmpStepVisible := SendTo = SendTo::"Individual Employees";
    end;

    local procedure SendDocuments()
    var
        PortalDocDist: Record "Portal Doc Distribution";
        Employee: Record Employee;
        TempDeptSel: Record "Portal Doc Dept Selection" temporary;
        TempEmpSel: Record "Portal Doc Emp Selection" temporary;
    begin
        case SendTo of
            SendTo::"All Employees":
                begin
                    Employee.Reset();
                    if Employee.FindSet() then
                        repeat
                            InsertDistribution(Employee."No.", '', PortalDocDist."Send To"::"All Employees");
                        until Employee.Next() = 0;
                    Message('Document sent to all %1 employees successfully.', Employee.Count);
                end;
            SendTo::"By Department":
                begin
                    CurrPage.DeptList.Page.GetSelected(TempDeptSel);
                    if TempDeptSel.IsEmpty then
                        Error('Please select at least one department.');
                    TempDeptSel.Reset();
                    if TempDeptSel.FindSet() then
                        repeat
                            Employee.Reset();
                            Employee.SetRange("Responsibility Center", TempDeptSel."Department Code");
                            if Employee.FindSet() then
                                repeat
                                    InsertDistribution(Employee."No.", TempDeptSel."Department Code", PortalDocDist."Send To"::"By Department");
                                until Employee.Next() = 0;
                        until TempDeptSel.Next() = 0;
                    Message('Document sent to selected departments successfully.');
                end;
            SendTo::"Individual Employees":
                begin
                    CurrPage.EmpList.Page.GetSelected(TempEmpSel);
                    if TempEmpSel.IsEmpty then
                        Error('Please select at least one employee.');
                    TempEmpSel.Reset();
                    if TempEmpSel.FindSet() then
                        repeat
                            InsertDistribution(TempEmpSel."Employee No.", '', PortalDocDist."Send To"::"Individual Employee");
                        until TempEmpSel.Next() = 0;
                    Message('Document sent to selected employees successfully.');
                end;
        end;
        CurrPage.Close();
    end;

    local procedure InsertDistribution(EmpNo: Code[20]; DeptCode: Code[20]; SendToOption: Option)
    var
        PortalDocDist: Record "Portal Doc Distribution";
    begin
        // Check if already sent to avoid duplicates
        PortalDocDist.Reset();
        PortalDocDist.SetRange("Document Code", DocumentCode);
        PortalDocDist.SetRange("Employee No.", EmpNo);
        if not PortalDocDist.IsEmpty then
            exit;

        PortalDocDist.Init();
        PortalDocDist."Document Code" := DocumentCode;
        PortalDocDist."Document Name" := DocumentName;
        PortalDocDist."Send To" := SendToOption;
        PortalDocDist."Department Code" := DeptCode;
        PortalDocDist."Employee No." := EmpNo;
        PortalDocDist."Sent Date" := CurrentDateTime;
        PortalDocDist."Sent By" := UserId();
        PortalDocDist."File Name" := DocFileName;
        PortalDocDist."File Extension" := DocFileExtension;
        PortalDocDist."Attachment ID" := DocAttachmentID;
        PortalDocDist.Insert();
    end;
}
