#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211784 "Organizational Pc"
{
    Caption = 'Organizational Pc';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Annual Strategy Workplan";
    PromotedActionCategories = 'New,Process,Report,Approvals,Activities';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Year Reporting Code"; Rec."Year Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
            part(Control3; "Board Activities")
            {
                SubPageLink = "AWP No" = field(No);
                ToolTip = '<>';
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Annual Workplan")
            {
                ApplicationArea = Basic;
                Caption = 'Consolidate Annual Workplan';
                Image = PostBatch;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Post to Annual Workplan.... Fred
                    // StrategicPlanning.FnUpdateAnnualWorkplan(Rec);
                end;
            }
            separator(Action21)
            {
            }
            action("Board Activities")
            {
                ApplicationArea = Basic;
                Caption = 'PC Activities';
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Board Activities";
                RunPageLink = "AWP No" = field(No);
                Visible = true;
            }
            separator(Action34)
            {
            }
            action("Combined Annual Workplan Report")
            {
                ApplicationArea = Basic;
                Caption = 'Preview Departmental AWP Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AnnualStrategyWorkplan.Reset;
                    AnnualStrategyWorkplan.SetRange(No, Rec.No);
                    if AnnualStrategyWorkplan.FindFirst then
                        Report.Run(Report::"Consolidated Workplan Plan", true, true, AnnualStrategyWorkplan);
                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send for review';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PerformanceApprovals: Codeunit "Performance Approvals";
                        VarVariant: Variant;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        SubWorkplanActivity: record "Sub Workplan Activity";
                        WorkplanCostElements: Record "Workplan Cost Elements";
                    begin


                        Rec.CalcFields("Total Assigned Weight(%)");
                        // if Rec."Total Assigned Weight(%)" <> 100 then
                        //     Error('Total Assigned weight should be equal to 100%');
                        VarVariant := Rec;
                        // if (Rec."Approval Status" = Rec."approval status"::Open) then
                        IF PerformanceApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                            PerformanceApprovals.OnSendDocForApproval(VarVariant);
                        /*
                        WPlanLines.RESET;
                        WPlanLines.SETRANGE(No,No);
                        IF WPlanLines.FINDFIRST THEN BEGIN
                           REPEAT
                                //WPlanLines.TESTFIELD("Primary Directorate");
                                WPlanLines.TESTFIELD("Primary Department");
                        
                                SubWorkplanActivity.RESET;
                                //SubWorkplanActivity.SETRANGE("Strategy Plan ID",WPlanLines."Strategy Plan ID");
                                SubWorkplanActivity.SETRANGE("Workplan No.",WPlanLines.No);
                                SubWorkplanActivity.SETRANGE("Activity Id",WPlanLines."Activity ID");
                                IF SubWorkplanActivity.FINDFIRST THEN BEGIN
                                   REPEAT
                        
                                     WorkplanCostElements.RESET;
                                     WorkplanCostElements.SETRANGE("Workplan No.",SubWorkplanActivity."Workplan No.");
                                     WorkplanCostElements.SETRANGE("Activity Id",SubWorkplanActivity."Activity Id");
                                     WorkplanCostElements.SETRANGE("Sub Activity No",SubWorkplanActivity."Sub Initiative No.");
                                     IF  NOT WorkplanCostElements.FIND('-')  THEN BEGIN
                                       REPEAT
                        
                                         ERROR('All Sub activities must have Workplan Cost Elements. Please enter Workplan Cost Elements for sub activity %1  %2',
                                         SubWorkplanActivity."Sub Initiative No.",SubWorkplanActivity."Objective/Initiative");
                                       UNTIL WorkplanCostElements.NEXT=0;
                                     END;
                                     UNTIL SubWorkplanActivity.NEXT=0;
                                   END;
                          UNTIL WPlanLines.NEXT=0;
                        END;
                        */
                        //  if (Rec."Approval Status" = Rec."approval status"::Open) then
                        // if ApprovalsMgmt.CheckAnnualStrategyApprovalsWorkflowEnabled(Rec) then
                        //    ApprovalsMgmt.OnSendAnnualStrategyForApproval(Rec);

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PerformanceApprovals: Codeunit "Performance Approvals";
                        VarVariant: Variant;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin


                        VarVariant := Rec;
                        if Rec."Approval Status" = Rec."approval status"::"Pending Approval" then
                            PerformanceApprovals.OnCancelDocApprovalRequest(VarVariant);

                        // if Rec."Approval Status" = Rec."approval status"::"Pending Approval" then
                        //  ApprovalsMgmt.OnCancelAnnualStrategyApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Annual Strategy Type" := Rec."annual strategy type"::"Organizational PC";
    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    var
        ExcelBuffer: Record "Excel Buffer";
    begin
    end;

    var
        WPLines: Record "Strategy Workplan Lines";
        StrategicAct: Record "Strategic Initiative";
        ServerFileName: Text;
        SheetName: Text;
        FIleManagement: Codeunit "File Management";
        Text0001: label 'testing';
        ExcelExt: Text;
        AnnualWorkPlan: Record "Strategy Workplan Lines";
        StrategyEntry: Record "Strategy Sub_Activity Entry";
        WPlanLines: Record "Strategy Workplan Lines";
        I: Integer;
        ThemeID: Code[50];
        ObjectiveID: Code[50];
        StrategicInt: Record "Strategic Initiative";
        SourceType: Option "Strategic Plan","Perfomance Contract";
        YearCode: Record "Annual Reporting Codes";
        QYearCode: Record "Quarterly Reporting Periods";
        QCount: Integer;
        Q1: Code[20];
        Q1date: Date;
        Q2: Code[20];
        Q2date: Date;
        Q3: Code[20];
        Q3date: Date;
        Q4: Code[20];
        Q4date: Date;
        StrategicPlanning: Codeunit "Strategic Planning";
        StrategicIntPlanningLines: Record "Strategic Int Planning Lines";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        AnnualStrategyWorkplan: Record "Annual Strategy Workplan";


    procedure fnPostPlanEntry(WPlanLines: Record "Strategy Workplan Lines")
    var
        StrategyEntry: Record "Strategy Sub_Activity Entry";
    begin
        StrategicInt.Reset;
        StrategicInt.SetRange(Code, WPlanLines."Activity ID");
        if StrategicInt.Find('-') then begin
            ThemeID := StrategicInt."Theme ID";
            ObjectiveID := StrategicInt."Objective ID";
        end;

        QYearCode.Reset;
        QYearCode.SetRange("Year Code", WPlanLines."Year Reporting Code");
        if QYearCode.Find('-') then begin
            repeat
                QCount := QCount + 1;
                if (QCount = 1) then begin
                    Q1 := QYearCode.Code;
                    Q1date := QYearCode."Reporting Start Date";
                end;
                if (QCount = 2) then begin
                    Q2 := QYearCode.Code;
                    Q2date := QYearCode."Reporting Start Date";
                end;
                if (QCount = 3) then begin
                    Q3 := QYearCode.Code;
                    Q3date := QYearCode."Reporting Start Date";
                end;
                if (QCount = 4) then begin
                    Q4 := QYearCode.Code;
                    Q4date := QYearCode."Reporting Start Date";
                end;
            until QYearCode.Next = 0;
        end;


        // I:=0;
        for I := 1 to 4 do begin
            if (I = 1) then begin
                FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
                Rec."Year Reporting Code", Q1, Q1date, WPlanLines."Primary Department", WPlanLines."Q1 Target", WPlanLines."Q1 Budget",
                Rec.No, Sourcetype::"Strategic Plan");
            end;
            if (I = 2) then begin
                FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
                Rec."Year Reporting Code", Q2, Q2date, WPlanLines."Primary Department", WPlanLines."Q2 Target", WPlanLines."Q2 Budget",
                Rec.No, Sourcetype::"Strategic Plan");
            end;

            if (I = 3) then begin
                FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
                Rec."Year Reporting Code", Q3, Q3date, WPlanLines."Primary Department", WPlanLines."Q3 Target", WPlanLines."Q3 Budget",
                Rec.No, Sourcetype::"Strategic Plan");

            end;
            if (I = 4) then begin
                FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
                Rec."Year Reporting Code", Q4, Q4date, WPlanLines."Primary Department", WPlanLines."Q4 Target", WPlanLines."Q4 Budget",
                Rec.No, Sourcetype::"Strategic Plan");
            end;


            // if (I = 1) then begin
            //     FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
            //     Rec."Year Reporting Code", Q1, Q1date, WPlanLines."Primary Department", WPlanLines."Primary Division", WPlanLines."Q1 Target", WPlanLines."Q1 Budget",
            //     Rec.No, Sourcetype::"Strategic Plan");
            // end;
            // if (I = 2) then begin
            //     FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
            //     Rec."Year Reporting Code", Q2, Q2date, WPlanLines."Primary Department", WPlanLines."Primary Division", WPlanLines."Q2 Target", WPlanLines."Q2 Budget",
            //     Rec.No, Sourcetype::"Strategic Plan");
            // end;

            // if (I = 3) then begin
            //     FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
            //     Rec."Year Reporting Code", Q3, Q3date, WPlanLines."Primary Department", WPlanLines."Primary Division", WPlanLines."Q3 Target", WPlanLines."Q3 Budget",
            //     Rec.No, Sourcetype::"Strategic Plan");

            // end;
            // if (I = 4) then begin
            //     FnInsertEntry(WPlanLines."Strategy Plan ID", ThemeID, ObjectiveID, WPlanLines."Strategy Plan ID", WPlanLines."Activity ID", WPlanLines.Description, WPlanLines."entry type"::Planned,
            //     Rec."Year Reporting Code", Q4, Q4date, WPlanLines."Primary Department", WPlanLines."Primary Division", WPlanLines."Q4 Target", WPlanLines."Q4 Budget",
            //     Rec.No, Sourcetype::"Strategic Plan");
            // end;
        end;
    end;


    procedure FnInsertEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDepartment: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract")
    var
        StrategyEntry: Record "Strategy Sub_Activity Entry";
    begin

        StrategyEntry.Init;
        StrategyEntry."Strategic Plan ID" := PlanID;
        StrategyEntry."Theme ID" := ThemeID;
        StrategyEntry."Objective ID" := ObjectiveID;
        StrategyEntry."Strategy ID" := StrategyID;
        StrategyEntry."Activity ID" := Actitvityid;
        StrategyEntry."Entry Description" := Description;
        StrategyEntry."Entry Type" := EntryType;
        StrategyEntry."Year Reporting Code" := YearCode;
        StrategyEntry."Quarter Reporting Code" := QYearCode;
        StrategyEntry."Planning Date" := PlanningDate;
        // StrategyEntry."Primary Department" := PrimaryDirectorate;
        StrategyEntry."Primary Department" := PrimaryDepartment;
        StrategyEntry.Quantity := Quantity;
        StrategyEntry."Cost Amount" := CostAmount;
        StrategyEntry."External Document No" := Extdoc;
        StrategyEntry."Source Type" := SourceType;
        StrategyEntry.Insert(true);
    end;

    // procedure FnInsertEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDirectorate: Code[100]; PrimaryDepartment: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract")
    // var
    //     StrategyEntry: Record "Strategy Sub_Activity Entry";
    // begin

    //     StrategyEntry.Init;
    //     StrategyEntry."Strategic Plan ID" := PlanID;
    //     StrategyEntry."Theme ID" := ThemeID;
    //     StrategyEntry."Objective ID" := ObjectiveID;
    //     StrategyEntry."Strategy ID" := StrategyID;
    //     StrategyEntry."Activity ID" := Actitvityid;
    //     StrategyEntry."Entry Description" := Description;
    //     StrategyEntry."Entry Type" := EntryType;
    //     StrategyEntry."Year Reporting Code" := YearCode;
    //     StrategyEntry."Quarter Reporting Code" := QYearCode;
    //     StrategyEntry."Planning Date" := PlanningDate;
    //     StrategyEntry."Primary Department" := PrimaryDirectorate;
    //     StrategyEntry."Primary Division" := PrimaryDepartment;
    //     StrategyEntry.Quantity := Quantity;
    //     StrategyEntry."Cost Amount" := CostAmount;
    //     StrategyEntry."External Document No" := Extdoc;
    //     StrategyEntry."Source Type" := SourceType;
    //     StrategyEntry.Insert(true);
    // end;


    procedure FnGetCount(StrategicInitiative: Record "Strategic Initiative") NumCount: Integer
    var
        StrategicInitiativeYears: Record "Strategic Int Planning Lines";
    begin
        StrategicInitiativeYears.Reset;
        StrategicInitiativeYears.SetRange("Strategic Plan ID", StrategicInitiative."Strategic Plan ID");
        StrategicInitiativeYears.SetRange("Theme ID", StrategicInitiative."Theme ID");
        StrategicInitiativeYears.SetRange("Objective ID", StrategicInitiative."Objective ID");
        StrategicInitiativeYears.SetRange("Strategy ID", StrategicInitiative."Strategy ID");
        StrategicInitiativeYears.SetRange(Code, StrategicInitiative.Code);
        if StrategicInitiativeYears.Find('-') then begin
            NumCount := StrategicInitiativeYears.Count;
        end;
        exit(NumCount);
    end;
}

#pragma implicitwith restore

