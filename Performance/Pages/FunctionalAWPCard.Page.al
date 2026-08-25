#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
#pragma implicitwith disable
Page 52211774 "Functional AWP Card"
{
    Caption = 'Functional AWP Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Annual Strategy Workplan";
    PromotedActionCategories = 'New,Process,Report,Approvals,Print,Release,Navigate';


    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = true;
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
                field("Primary Department"; Rec."Primary Department")
                {
                    ApplicationArea = basic;
                    Caption = 'Primary Department';
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
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Annual Workplan"; Rec."Annual Workplan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Annual Workplan Template';
                }
                // field("Functional Procurment Plan No"; Rec."Functional Procurment Plan No")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Departmental Procurement Plan Template';
                // }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Assigned Weight(%)"; Rec."Total Assigned Weight(%)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Budget"; Rec."Total Budget")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control9; "Strategy Workplan Lines")
            {
                SubPageLink = "Strategy Plan ID" = field("Strategy Plan ID"),
                              No = field(No);
                // "Cross Cutting" = const(No);
                //  ToolTip = '<>';
            }
            // part(Control32; "Cross Cutting Activites")
            // {
            //     Caption = 'Cross Cutting Activites';
            //     SubPageLink = "Strategy Plan ID" = field("Strategy Plan ID"),
            //             No = field(No);//,
            //     //               "Cross Cutting" = const(Yes);
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
                         WPLines."Primary Department":=StrategicAct."Primary Department";
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
                    StrategicIntPlanningLines.SetRange("Primary Department", Rec."Primary Department");
                    // StrategicIntPlanningLines.SetRange("Primary Department", Rec.Department);
                    if StrategicIntPlanningLines.FindSet() then begin
                        repeat
                            WPLines.Init;
                            WPLines.No := Rec.No;
                            WPLines."Strategy Plan ID" := StrategicIntPlanningLines."Strategic Plan ID";
                            WPLines."Activity ID" := StrategicIntPlanningLines.Code;
                            WPLines."Objective ID" := StrategicIntPlanningLines."Objective ID";
                            StrategicInt.Reset;
                            StrategicInt.SetRange(Code, WPLines."Activity ID");
                            if StrategicInt.FindFirst() then begin
                                WPLines."Perfomance Indicator" := StrategicInt."Perfomance Indicator";
                                WPlanLines.Validate("Perfomance Indicator");
                                //WPLines."Key Performance Indicator" := StrategicInt."Key Perfromance Indicator";
                                WPLines."Primary Department" := StrategicInt."Primary Department";
                                //WPLines."Primary Department Name" := StrategicInt."Primary Division Name";
                                WPLines."Unit of Measure" := StrategicInt."Unit of Measure";
                                WPLines."Desired Perfomance Direction" := StrategicInt."Desired Perfomance Direction";
                                WPLines."Strategy Framework" := StrategicInt."Strategy Framework";
                                WPLines."Framework Perspective" := StrategicInt."Framework Perspective";
                                WPLines."Source Of Fund" := StrategicInt."Source Of Fund";
                                WPLines.Outcome := StrategicInt.Outcomes;
                                WPlanLines."Objective ID" := StrategicInt."Objective ID";
                            end;
                            WPLines."Year Reporting Code" := Rec."Year Reporting Code";
                            WPLines.Validate("Activity ID");
                            WPLines.Description := StrategicIntPlanningLines.Description;
                            WPLines."Primary Department" := StrategicIntPlanningLines."Primary Department";
                            WPLines.Validate("Primary Department");
                            // MESSAGE('StrategicIntPlanningLines."Primary Department" is %1',StrategicIntPlanningLines."Primary Department");
                            WPLines."Primary Department" := StrategicIntPlanningLines."Primary Department";
                            WPLines.Validate("Primary Department");
                            WPLines."Imported Annual Target Qty" := StrategicIntPlanningLines."Target Qty";
                            //     WPLines.Validate("Imported Annual Target Qty");
                            WPLines."Imported Annual Budget Est." := StrategicIntPlanningLines."Target Budget";

                        //     WPLines.Validate("Imported Annual Budget Est.");
                        //WPLines.Insert(true);
                        until StrategicIntPlanningLines.Next = 0;


                    end;
                    Message('Work Plan Lines Populated Successfully');

                end;
            }
            action("Suggest Functional lines")
            {
                ApplicationArea = Basic;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

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
                         WPLines."Primary Department":=StrategicAct."Primary Department";
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
                    WPLines.Reset;
                    WPLines.SetRange(No, Rec.No);
                    if WPLines.FindSet then begin
                        WPLines.DeleteAll;
                    end;


                    StrategicIntPlanningLines.Reset;
                    StrategicIntPlanningLines.SetRange("Strategic Plan ID", Rec."Strategy Plan ID");
                    StrategicIntPlanningLines.SetRange("Annual Reporting Codes", Rec."Year Reporting Code");
                    StrategicIntPlanningLines.SETRANGE("Primary Department", Rec."Primary Department");
                    if StrategicIntPlanningLines.FindSet then begin
                        repeat
                            WPLines.Init;
                            WPLines.No := Rec.No;
                            WPLines."Strategy Plan ID" := StrategicIntPlanningLines."Strategic Plan ID";
                            WPLines."Activity ID" := StrategicIntPlanningLines.Code;
                            WPLines.Description := StrategicIntPlanningLines.Description;
                            StrategicInt.Reset;
                            StrategicInt.SetRange(Code, WPLines."Activity ID");
                            if StrategicInt.Find('-') then begin
                                WPLines."Perfomance Indicator" := StrategicInt."Perfomance Indicator";
                                WPLines.Validate("Perfomance Indicator");
                                //WPLines."Key Performance Indicator" := StrategicInt."Key Perfromance Indicator";
                                WPLines."Primary Department" := StrategicInt."Primary Department";
                                WPLines."Primary Department Name" := StrategicInt."Primary Department Name";
                                WPLines."Unit of Measure" := StrategicInt."Unit of Measure";
                                WPLines."Desired Perfomance Direction" := StrategicInt."Desired Perfomance Direction";
                                WPLines."Strategy Framework" := StrategicInt."Strategy Framework";
                                WPLines."Framework Perspective" := StrategicInt."Framework Perspective";
                                WPLines."Source Of Fund" := StrategicInt."Source Of Fund";
                                WPLines.Description := StrategicInt.Description;
                            end;
                            WPLines."Year Reporting Code" := Rec."Year Reporting Code";
                            WPLines.Validate("Activity ID");
                            // WPLines.Description := StrategicIntPlanningLines.Description;
                            WPLines."Primary Department" := StrategicIntPlanningLines."Primary Department";
                            WPLines.Validate("Primary Department");
                            // MESSAGE('StrategicIntPlanningLines."Primary Department" is %1',StrategicIntPlanningLines."Primary Department");
                            WPLines."Primary Department" := StrategicIntPlanningLines."Primary Department";
                            wplines.validate("Primary Department");
                            WPLines."Imported Annual Target Qty" := StrategicIntPlanningLines."Target Qty";
                            WPLines.Validate("Imported Annual Target Qty");
                            WPLines."Imported Annual Budget Est." := StrategicIntPlanningLines."Target Budget";
                            WPLines.Validate("Imported Annual Budget Est.");
                            WPLines.Insert(true);
                        until StrategicIntPlanningLines.Next = 0;

                    end;
                    Message('Work Plan Lines Populated Successfully');
                end;

            }
            separator(Action15)
            {
            }
            action("Update Annual Workplan")
            {
                ApplicationArea = Basic;
                Caption = 'Consolidate Annual Workplan';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Post to Annual Workplan.... Fred
                    // if Rec.Department = 'PRM' then
                    StrategicPlanning.FnUpdateAnnualWorkplan(Rec)
                    //  else
                    //   Error('Only PRM Department is allowed to Consolidate');
                end;
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
                //  RunObject = Report 80000;
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
                Visible = false;

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
            separator(Action19)
            {
            }
            action("Preview Departmental Targets Report")
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(No, Rec.No);
                    Report.Run(Report::"Preview targets AWP Report", true, true, Rec)
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
                Visible = false;
            }
            separator(Action34)
            {
            }
            action("Archive Document")
            {
                ApplicationArea = Basic;
                Image = Archive;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are You sure you want to Archive this Document ?', true) then begin
                        Rec.TestField(Archived, false);
                        Rec.TestField("Approval Status", Rec."approval status"::Open);
                        Rec.Archived := true;
                        Rec."Archived By" := UserId;
                        Rec."Archived On" := Today;
                        Rec.Modify(true);
                        Message('Archived Successfully');

                    end;
                    CurrPage.Close;
                end;
            }
            action("Combined Annual Workplan Report")
            {
                ApplicationArea = Basic;
                Caption = 'Preview AWP Report';
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
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        SubWorkplanActivity: Record "Sub Workplan Activity";
                        // WorkplanCostElements: Record "Workplan Cost Elements";

                        PerformanceApprovals: Codeunit "Performance Approvals";
                        VarVariant: Variant;
                    begin


                        Rec.CalcFields("Total Assigned Weight(%)");
                        // if Rec."Total Assigned Weight(%)" <> 100 then
                        //     Error('Total Assigned weight should be equal to 100%');

                        /*
                        WPlanLines.RESET;
                        WPlanLines.SETRANGE(No,No);
                        IF WPlanLines.FINDFIRST THEN BEGIN
                           REPEAT
                                WPlanLines.TESTFIELD("Primary Department");
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
                        if (Rec."Approval Status" = Rec."approval status"::Open) then
                            VarVariant := Rec;
                        IF PerformanceApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                            PerformanceApprovals.OnSendDocForApproval(VarVariant);
                        //if ApprovalsMgmt.CheckAnnualStrategyApprovalsWorkflowEnabled(Rec) then
                        //  ApprovalsMgmt.OnSendAnnualStrategyForApproval(Rec);
                        //message('Setup');

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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                        VarVariant: Variant;
                        PerformanceApprovals: Codeunit "Performance Approvals";
                    begin
                        Rec.TestField("Approval Status", Rec."Approval Status"::"Pending Approval");
                        Rec.TestField("Created By", UserId);

                        VarVariant := Rec;
                        PerformanceApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;

                    trigger OnAction()
                    var
                        ApprovalsMgt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = not OpenApprovalEntriesExist;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }
    trigger OnInit()
    begin
        Rec."Annual Strategy Type" := Rec."annual strategy type"::Functional;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Annual Strategy Type" := Rec."annual strategy type"::Functional;
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
        //StrategicIntPlanningLines: Record "Strategic Initiative";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        AnnualStrategyWorkplan: Record "Annual Strategy Workplan";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;


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
        StrategyEntry."Primary Department" := PrimaryDepartment;
        StrategyEntry.Quantity := Quantity;
        StrategyEntry."Cost Amount" := CostAmount;
        StrategyEntry."External Document No" := Extdoc;
        StrategyEntry."Source Type" := SourceType;
        StrategyEntry.Insert(true);
    end;


    // // procedure FnInsertEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDepartment: Code[100]; PrimaryDepartment: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract")
    // procedure FnInsertEntry(PlanID: Code[50]; ThemeID: Code[50]; ObjectiveID: Code[50]; StrategyID: Code[50]; Actitvityid: Code[50]; Description: Code[255]; EntryType: Option Planned,Actual; YearCode: Code[50]; QYearCode: Code[50]; PlanningDate: Date; PrimaryDepartment: Code[100]; PrimaryDivision: Code[100]; Quantity: Decimal; CostAmount: Decimal; Extdoc: Code[50]; SourceType: Option "Strategic Plan","Perfomance Contract")
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
    //     StrategyEntry."Primary Division" := PrimaryDepartment;
    //     WPlanLines."Primary Division" := PrimaryDivision;
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

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
    end;
}

#pragma implicitwith restore

