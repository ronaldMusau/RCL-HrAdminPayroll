#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211798 "Annual Strategy Workplan Card1"
{
    Caption = 'Corporate Annual Workplan Card';
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "Annual Strategy Workplan";
    PopulateAllFields = true;
    PromotedActionCategories = 'New,Process,Report,Approvals';
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
                field("Current AWP"; Rec."Current AWP")
                {
                    ApplicationArea = Basic;
                }
                field("Year Reporting Code"; Rec."Year Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Workplan No"; Rec."Workplan No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Total Assigned Weight(%)"; Rec."Total Assigned Weight(%)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total  Departments Count"; Rec."Total  Departments Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Weight(%)"; Rec."Total Weight(%)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total Budget"; Rec."Total Budget")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field("Approved Budget"; Rec."Approved Budget")
                // {
                //     ApplicationArea = Basic;
                // }
            }
            part(Control9; "Strategy Workplan Lines")
            {
                SubPageLink = "Strategy Plan ID" = field("Strategy Plan ID"),
                              No = field(No);//,
                                             // "Cross Cutting"=const(No);
                ToolTip = '<>';
            }
            // part(Control27; "Cross Cutting Activites")
            // {
            //     Caption = 'Cross Cutting Activites';
            //     SubPageLink = "Strategy Plan ID" = field("Strategy Plan ID"),
            //                   No = field(No);//,
            //                                  //  "Cross Cutting"=const(Yes);
            //     ToolTip = '<>';
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action("Suggest Activity Lines")
            {
                ApplicationArea = Basic;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    NumCount: Integer;
                begin
                    if not Confirm('Are you sure you want to Suggest Activities', true) then
                        Error('Activities not Suggested');
                    /*StrategicAct.RESET;
                    StrategicAct.SETRANGE("Strategic Plan ID","Strategy Plan ID");
                    IF StrategicAct.FIND('-') THEN BEGIN
                       REPEAT
                         NumCount:=5;
                        // NumCount:=FnGetCount(StrategicAct);
                         WPLines.INIT;
                         WPLines.No:=No;
                         WPLines."Strategy Plan ID":=StrategicAct."Strategic Plan ID";
                         WPLines."Activity ID":=StrategicAct.Code;
                         WPLines."Year Reporting Code":="Year Reporting Code";
                         WPLines.Description:=StrategicAct.Description;
                         WPLines."Primary Directorate":=StrategicAct."Primary Directorate";
                         IF (NumCount>0) THEN
                            WPLines."Imported Annual Target Qty":=StrategicAct."Collective target"/NumCount;
                           WPLines.VALIDATE( WPLines."Imported Annual Target Qty");
                          IF (NumCount>0) THEN
                            WPLines."Imported Annual Budget Est.":=StrategicAct."Collective Budget"/NumCount;
                           WPLines.VALIDATE( WPLines."Imported Annual Budget Est.");
                         WPLines.INSERT(TRUE);
                       UNTIL StrategicAct.NEXT=0;
                      END;*///old

                    //new


                    StrategicIntPlanningLines.Reset;
                    StrategicIntPlanningLines.SetRange("Strategic Plan ID", Rec."Strategy Plan ID");
                    StrategicIntPlanningLines.SetRange("Annual Reporting Codes", Rec."Year Reporting Code");
                    if StrategicIntPlanningLines.FindSet then begin
                        repeat
                            WPLines.Init;
                            WPLines.No := Rec.No;
                            WPLines."Strategy Plan ID" := StrategicIntPlanningLines."Strategic Plan ID";
                            WPLines."Activity ID" := StrategicIntPlanningLines.Code;
                            WPLines."Year Reporting Code" := Rec."Year Reporting Code";
                            WPLines.Validate("Activity ID");
                            //WPLines.Description:=StrategicIntPlanningLines.Description;
                            WPLines."Primary Department" := StrategicIntPlanningLines."Primary Department";
                            //MESSAGE('StrategicIntPlanningLines."Primary Department" is %1',StrategicIntPlanningLines."Primary Department");
                            // WPLines."Primary Division" := StrategicIntPlanningLines."Primary Division";
                            WPLines."Imported Annual Target Qty" := StrategicIntPlanningLines."Target Qty";
                            WPLines.Validate("Imported Annual Target Qty");
                            WPLines."Imported Annual Budget Est." := StrategicIntPlanningLines."Target Budget";
                            WPLines.Validate("Imported Annual Budget Est.");
                            StrategicInt.Reset;
                            StrategicInt.SetRange(Code, WPLines."Activity ID");
                            if StrategicInt.FindSet then begin
                                WPLines."Perfomance Indicator" := StrategicInt."Perfomance Indicator";
                                // WPLines."Key Performance Indicator":=StrategicInt."Date Filter";
                                WPLines."Primary Department Name" := StrategicInt."Primary Department";
                                // WPLines."Primary Division Name" := StrategicInt."Primary Division";
                                WPLines."Unit of Measure" := StrategicInt."Unit of Measure";
                                WPLines."Desired Perfomance Direction" := StrategicInt."Desired Perfomance Direction";
                                WPLines."Strategy Framework" := StrategicInt."Strategy Framework";
                                WPLines."Framework Perspective" := StrategicInt."Framework Perspective";
                                WPLines."Source Of Fund" := StrategicInt."Source Of Fund";
                            end;
                            WPLines.Insert(true);
                        until StrategicIntPlanningLines.Next = 0;
                    end;
                    Message('Work Plan Lines Populated Successfully');

                end;
            }
            separator(Action15)
            {
            }
            action("Export To Excel")
            {
                ApplicationArea = Basic;
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    AnnualWorkPlan.Reset;
                    AnnualWorkPlan.SetRange(No, Rec.No);
                    if AnnualWorkPlan.Find('-') then begin
                        Xmlport.Run(80000, true, false, AnnualWorkPlan);
                    end;
                end;
            }
            separator(Action16)
            {
            }
            action("Import From Excel")
            {
                ApplicationArea = Basic;
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    Xmlport.Run(80001);
                end;
            }
            action("Import From Excel_TobeUsed")
            {
                ApplicationArea = Basic;
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                //RunObject = Report 80000;
                Visible = false;
            }
            separator(Action17)
            {
            }
            action("Post Targets")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    WPlanLines.Reset;
                    WPlanLines.SetRange(No, Rec.No);
                    if WPlanLines.Find('-') then begin
                        repeat
                            //fnPostPlanEntry(WPlanLines);
                            StrategicPlanning.fnPostPlanEntry(WPlanLines);
                        until WPlanLines.Next = 0;
                    end;
                    Message('Targets Posted Successfully');
                end;
            }
            separator(Action41)
            {
            }
            action("Preview Departmental Targets Report")
            {
                ApplicationArea = Basic;
                Caption = 'Preview Annual Targets Report';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.SetRange(No, Rec.No);
                    Report.Run(Report::"Preview targets AWP Report", true, true, Rec)
                end;
            }
            separator(Action39)
            {
            }
            action("Board Activities")
            {
                ApplicationArea = Basic;
                Caption = 'PC Activities';
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = Page "Board Activities";
                RunPageLink = "AWP No" = field(No);
                Visible = false;
            }
            separator(Action37)
            {
            }
            action("Combined Annual Workplan Report")
            {
                ApplicationArea = Basic;
                Caption = 'Preview Consolidated Annual Workplan';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AnnualStrategyWorkplan.Reset;
                    AnnualStrategyWorkplan.SetRange(No, Rec.No);
                    if AnnualStrategyWorkplan.FindFirst then
                        report.run(Report::"PRM Consolidated Workplan Plan", true, true, AnnualStrategyWorkplan);
                end;
            }
            separator(Action34)
            {
            }
            action("Annual Workplan Expenditure")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AnnualStrategyWorkplan.Reset;
                    AnnualStrategyWorkplan.SetRange(No, Rec.No);
                    if AnnualStrategyWorkplan.FindFirst then
                        report.run(Report::"Annual Workplan Expenditure", true, true, AnnualStrategyWorkplan);
                end;
            }
            action("Suggest Funded Activities")
            {
                ApplicationArea = Basic;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                visible = false;

                trigger OnAction()
                var
                    NumCount: Integer;
                begin
                    if not Confirm('Are you sure you want to Suggest Activities', true) then
                        Error('Activities not Suggested');
                    Rec.TestField("Workplan No");
                    AnnualWorkplan2.Reset;
                    AnnualWorkplan2.SetRange(No, Rec."Workplan No");
                    if AnnualWorkplan2.FindSet then begin
                        // StrategicPlanning.FnSuggestAnnuallWorkplan(AnnualWorkplan2,Rec.No);
                    end;
                    Message('Work Plan Lines Populated Successfully');
                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PerformanceApprovals: Codeunit "Performance Approvals";
                        VarVariant: Variant;
                    begin
                        //Rec.CalcFields("Total Budget");
                        // Rec.TestField("Approved Budget");
                        // if Rec."Total Budget" <= 0 then begin
                        //     Error('Error!, Ensure the total budget is greater than 0');

                        // end;

                        // if Rec."Approved Budget" <> Rec."Total Budget" then begin
                        //     Error('Error!, Ensure the Approved Budget is aligned to the total budget');
                        Rec.TestField("Approval Status", Rec."Approval Status"::Open);
                        // Rec.Validate("Approval Status", Rec."Approval Status"::Released);
                        // Rec.Modify;
                        VarVariant := Rec;
                        IF PerformanceApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                            PerformanceApprovals.OnSendDocForApproval(VarVariant);

                    end;
                    //if (Rec."Approval Status" = Rec."approval status"::Open) then
                    // if ApprovalsMgmt.CheckAnnualStrategyApprovalsWorkflowEnabled(Rec) then
                    // ApprovalsMgmt.OnSendAnnualStrategyForApproval(Rec);


                    // if Rec."Approval Status" = Rec."approval status"::"Pending Approval" then
                    //  ApprovalsMgmt.OnCancelAnnualStrategyApprovalRequest(Rec);
                    //end;
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
                        VarVariant: Variant;
                        PerformanceApprovals: Codeunit "Performance Approvals";
                    begin
                        Rec.TestField("Approval Status", Rec."Approval Status"::"Pending Approval");
                        // if Rec."Approval Status" = Rec."approval status"::"Pending Approval" then


                        //   TestField(Status, Status::"Pending Approval");
                        //   TestField("Created By", UserId);

                        Rec.Validate("Approval Status", Rec."Approval Status"::Open);
                        Rec.Modify;

                        // VarVariant := Rec;
                        // PerformanceApprovals.OnCancelDocApprovalRequest(VarVariant);
                        // ApprovalsMgmt.OnCancelAnnualStrategyApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
            // action("Preview funded")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Preview Funded Annual Targets Report';
            //     Image = Print;
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     Visible = false;


            //     trigger OnAction()
            //     begin
            //         Rec.SetRange(No, Rec.No);
            //         // Report.Run(80052, true, true, Rec)
            //     end;
            // }
            // action("Preview unFunded")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Preview Not Funded Annual Targets Report';
            //     Image = Print;
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     visible = false;

            //     trigger OnAction()
            //     begin
            //         Rec.SetRange(No, Rec.No);
            //         // Report.Run(80051, true, true, Rec)
            //     end;
            // }
            action("Update AWP Amounts")
            {
                ApplicationArea = Basic;
                Image = SuggestCapacity;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin

                    WorkplanActiv.Reset;
                    WorkplanActiv.SetRange("Workplan No.", Rec.No);
                    if WorkplanActiv.FindSet then begin
                        repeat
                            WorkplanActiv.CalcFields("Total Autocalculated Amount");
                            WorkplanActiv."Total Budget" := WorkplanActiv."Total Autocalculated Amount";
                            WorkplanActiv.Modify(true);
                        until WorkplanActiv.Next = 0;
                    end;

                    WPlanLines.Reset;
                    WPlanLines.SetRange(No, Rec.No);
                    if WPlanLines.Find('-') then begin
                        repeat
                            WPlanLines.CalcFields("Sub Activity Budget Sum");
                            WPlanLines."Total Subactivity budget" := WPlanLines."Sub Activity Budget Sum";
                            WPlanLines.Modify(true);
                        until WPlanLines.Next = 0;
                    end;
                    Message('Updated Successfully');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total Assigned Weight(%)", "Total  Departments Count");
        if Rec."Total  Departments Count" <> 0 then
            Rec."Total Weight(%)" := (Rec."Total Assigned Weight(%)" / Rec."Total  Departments Count");

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Annual Strategy Type" := Rec."annual strategy type"::Organizational;

        Rec.CalcFields("Total Assigned Weight(%)", "Total  Departments Count");
        if Rec."Total  Departments Count" <> 0 then
            Rec."Total Weight(%)" := (Rec."Total Assigned Weight(%)" / Rec."Total  Departments Count");

    end;

    trigger OnOpenPage()
    begin
        Rec.CalcFields("Total Assigned Weight(%)", "Total  Departments Count");
        if Rec."Total  Departments Count" <> 0 then
            Rec."Total Weight(%)" := (Rec."Total Assigned Weight(%)" / Rec."Total  Departments Count");

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
        AnnualWorkplan2: Record "Annual Strategy Workplan";
        WorkplanActiv: Record "Sub Workplan Activity";


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
        StrategyEntry."Primary Department" := PrimaryDepartment;
        StrategyEntry.Quantity := Quantity;
        StrategyEntry."Cost Amount" := CostAmount;
        StrategyEntry."External Document No" := Extdoc;
        StrategyEntry."Source Type" := SourceType;
        StrategyEntry.Insert(true);
    end;


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

