#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211685 "Perfomance Contract Header"
{
    DrillDownPageID = "All Performance Contracts";
    LookupPageID = "All Performance Contracts";

    fields
    {
        field(1; No; Code[100])
        {


            trigger OnValidate()
            begin
                /*IF No <> xRec.No THEN BEGIN
                   SPMSetup.GET;
                    NoSeriesMgt.TestManual(SPMSetup."PWork Plans");
                    "No. Series" := '';
                END;*/


                if "Document Type" = "document type"::"Board/Executive PC" then begin
                    if No <> xRec.No then begin
                        SPMSetup.Get;
                        NoSeriesMgt.TestManual(SPMSetup."PWork Plans");
                        "No. Series" := '';
                    end;
                end;

                if "Document Type" = "document type"::"CEO/Corporate PC" then begin
                    if No <> xRec.No then begin
                        SPMSetup.Get;
                        NoSeriesMgt.TestManual(SPMSetup."Corporate PC No. Series");
                        "No. Series" := '';
                    end;
                end;

                if "Document Type" = "document type"::"Functional/Operational PC" then begin
                    if No <> xRec.No then begin
                        SPMSetup.Get;
                        NoSeriesMgt.TestManual(SPMSetup."Functional PC No. Series");
                        "No. Series" := '';
                    end;
                end;

                if "Document Type" = "document type"::"Staff Performance Contract" then begin
                    if No <> xRec.No then begin
                        SPMSetup.Get;
                        NoSeriesMgt.TestManual(SPMSetup."Individual Scorecard Nos");
                        "No. Series" := '';
                    end;
                end;
                if "Document Type" = "document type"::"Individual Scorecard PC" then begin
                    if No <> xRec.No then begin
                        SPMSetup.Get;
                        NoSeriesMgt.TestManual(SPMSetup."Individual Scorecard Nos");
                        "No. Series" := '';
                    end;
                end;

            end;
        }
        field(2; "Document Type"; Option)
        {

            OptionCaption = 'Board/Executive PC,CEO/Corporate PC,Functional/Operational PC,Staff Performance Contract,CEO/Corporate Awp,Staff Performance Appraisal PC';
            OptionMembers = "Board/Executive PC","CEO/Corporate PC","Functional/Operational PC","Staff Performance Contract","CEO/Corporate Awp","Individual Scorecard PC";
        }
        field(3; Description; Text[100])
        {

        }
        field(4; "Document Date"; Date)
        {

        }
        field(5; "Objective Setting Due Date"; Date)
        {

        }
        field(6; "Strategy Plan ID"; Code[100])
        {
            TableRelation = "Corporate Strategic Plans".Code;

            trigger OnValidate()
            begin
                CSP.Reset;
                CSP.SetRange(Code, "Strategy Plan ID");
                if CSP.FindSet then begin
                    "Strategy Framework" := CSP."Strategy Framework";
                    "Mission Statement" := CSP."Mission Statement";
                    "Vision Statement" := CSP."Vision Statement";
                end;
            end;
        }
        field(7; "Annual Reporting Code"; Code[100])
        {

            TableRelation = "Annual Reporting Codes".Code where("Current Year" = const(true));

            trigger OnValidate()
            begin
                if AnnualReportingCodes.Get("Annual Reporting Code") then begin
                    "Start Date" := AnnualReportingCodes."Reporting Start Date";
                    "End Date" := AnnualReportingCodes."Reporting End Date";
                end;
            end;
        }
        field(8; "Start Date"; Date)
        {

        }
        field(9; "End Date"; Date)
        {

        }
        field(10; "Responsible Employee No."; Code[100])
        {

            TableRelation = Employee."No." where(Status = filter(Active));

            trigger OnValidate()
            begin
                if (("Document Type" = "document type"::"Staff Performance Contract") and ("Score Card Type" = "score card type"::Departmental)) then begin
                    ResponsibityC.Reset;
                    ResponsibityC.SetRange("Current Head", "Responsible Employee No.");
                    // if not ResponsibityC.FindFirst then begin
                    //     Error('Current Employee Must be a Head of Department');
                    // end;
                end;



                Emp.Reset;
                Emp.SetRange("No.", "Responsible Employee No.");
                if Emp.FindSet then begin
                    "Employee Name" := Emp.FullName;
                    if HQ = true then
                        "Responsibility Center" := Emp."Responsibility Center";
                    // else
                    //     "Responsibility Center" := Emp.Region;

                    "Responsibility Center Name" := Emp."Responsibility Center Name";
                    ResponsibityC.Reset;
                    ResponsibityC.SetRange(Code, "Responsibility Center");
                    if ResponsibityC.FindFirst() then
                        "Responsibility Center Name" := ResponsibityC.Name;
                    Position := Emp.Position;
                    // Position := Emp."Job ID";
                    // "Acting Job ID" := Emp."Acting Job ID";
                    Designation := Emp."Job Title";
                    Department := Emp."Responsibility Center";
                    // "Region Code" := Emp."Global Dimension 1 Code";
                    //HOD := Emp.HOD;
                    Validate("Responsibility Center");
                end;
                // IF Emp.GET("Responsible Employee No.") THEN BEGIN
                //    "Employee Name":=Emp.FullName;
                //    "Responsibility Center":=Emp."Responsibility Center";
                //    "Responsibility Center Name":=Emp."Responsibility Center Name";
                //    Position:=Emp.Position;
                //    MESSAGE('Wow');
                //    //Position:=Emp."Job ID";
                //    //"Acting Job ID":=Emp."Acting Job ID";
                //    Designation:=Emp."Job Title";
                //    Directorate:=Emp."Directorate Code";
                //    HOD:=Emp.HOD;
                //    VALIDATE(Directorate);
                //    VALIDATE("Responsibility Center");
                //  END;
            end;
        }
        field(11; Designation; Code[100])
        {

        }
        field(12; Grade; Code[100])
        {

        }
        field(13; "Employee Name"; Code[255])
        {

        }
        field(14; "Responsibility Center"; Code[100])
        {

            TableRelation = "Responsibility Center".Code where("Operating Unit Type" = filter(Department));

            trigger OnValidate()
            begin
                if ResponsibityC.Get("Responsibility Center") then begin
                    "Responsibility Center Name" := ResponsibityC.Name;
                    // HQ := ResponsibityC.HQ;
                end;
            end;
        }
        field(15; "Responsibility Center Name"; Code[255])
        {

        }
        field(16; "Evaluation Type"; Option)
        {

            OptionCaption = 'Standard Appraisal/Supervisor Score Only,Self-Appraisal with Supervisor Score,360-Degree/Group Appraisal';
            OptionMembers = "Standard Appraisal/Supervisor Score Only","Self-Appraisal with Supervisor Score","360-Degree/Group Appraisal";
        }
        field(17; "Approval Status"; Option)
        {

            OptionCaption = 'Open,Released,Pending Approval,Rejected';
            OptionMembers = Open,Released,"Pending Approval",Rejected;
        }
        field(18; "Blocked"; Boolean)
        {

        }
        field(19; "Created By"; Text[100])
        {

        }
        field(20; "Created On"; Date)
        {

        }
        field(21; "Last Evaluation Date"; Date)
        {

        }
        field(22; "No. Series"; Code[10])
        {

        }
        field(23; "Goal Template ID"; Code[50])
        {

            TableRelation = "Goal Template";
        }
        field(24; "Annual Workplan"; Code[50])
        {

            TableRelation = "Annual Strategy Workplan".No where("Annual Strategy Type" = filter("Organizational PC" | Organizational), "Approval Status" = const(Released));

            trigger OnValidate()
            begin
                if AnnualStrategyWorkplan.Get("Annual Workplan") then begin
                    "Strategy Plan ID" := AnnualStrategyWorkplan."Strategy Plan ID";
                    "Annual Reporting Code" := AnnualStrategyWorkplan."Year Reporting Code";
                    Validate("Annual Reporting Code");
                end;
            end;
        }
        field(25; "CEO WorkPlan"; Code[50])
        {

            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("CEO/Corporate PC"),
                                                                   "Approval Status" = const(Released));

            trigger OnValidate()
            begin
                if PerfomanceContractHeader.Get("Annual Workplan") then begin
                    "Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
                    "Annual Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
                    Validate("Annual Reporting Code");
                end;
            end;
        }
        field(26; "Functional WorkPlan"; Code[50])
        {

            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Functional/Operational PC"),
                                                                   "Approval Status" = const(Released));

            trigger OnValidate()
            begin
                if PerfomanceContractHeader.Get("Functional WorkPlan") then begin
                    "Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
                    "Annual Workplan" := PerfomanceContractHeader."Annual Workplan";
                    "CEO WorkPlan" := PerfomanceContractHeader."CEO WorkPlan";
                    "Annual Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
                    Validate("Annual Reporting Code");
                end;
            end;
        }
        field(27; Status; Option)
        {
            Caption = 'Status';

            Editable = true;
            OptionCaption = ' ,Signed,Canceled,Supervisor Signed';
            OptionMembers = " ",Signed,Canceled,"Supervisor Signed";

            trigger OnValidate()
            var
                ServLedgEntry: Record "Service Ledger Entry";
                ConfirmManagement: Codeunit "Confirm Management";
                AnyServItemInOtherContract: Boolean;
            begin
            end;
        }
        field(28; "Change Status"; Option)
        {
            Caption = 'Change Status';

            Editable = false;
            OptionCaption = 'Open,Locked';
            OptionMembers = Open,Locked;
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(31; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';

            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;
        }
        field(32; Department; Code[30])
        {

            TableRelation = "Responsibility Center".Code where("Operating Unit Type" = filter(Department));

            trigger OnValidate()
            begin
                if ResponsibityC.Get(Department) then begin
                    "Department Name" := ResponsibityC.Name;
                end;
            end;
        }
        field(33; "Department Name"; Code[100])
        {

        }
        field(34; Position; Code[50])
        {
            TableRelation = "Positions Responsibility";
        }
        field(35; "Total Assigned Weight(%)"; Decimal)
        {
            CalcFormula = sum("PC Objective"."Assigned Weight (%)" where("Workplan No." = field(No)));
            FieldClass = FlowField;
        }
        field(36; "Secondary Assigned Weight(%)"; Decimal)
        {
            CalcFormula = sum("Secondary PC Objective"."Assigned Weight (%)" where("Workplan No." = field(No)));
            FieldClass = FlowField;
        }
        field(37; "JD Assigned Weight(%)"; Decimal)
        {
            CalcFormula = sum("PC Job Description"."Assigned Weight (%)" where("Workplan No." = field(No)));
            FieldClass = FlowField;
        }
        field(38; "Strategy Framework"; Code[100])
        {
            TableRelation = "Strategy Framework";
        }
        field(39; "Vision Statement"; Text[255])
        {


        }
        field(40; "Mission Statement"; Text[255])
        {

        }
        field(41; "Score Card Type"; Option)
        {

            OptionCaption = ' ,CEOs,Departmental,Staff, Senior, Principal';
            OptionMembers = " ",CEOs,Departmental,Staff,Senior,Principal;
        }
        field(42; "CEOs PC ID"; Code[20])
        {
            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"),
                                                                   "Score Card Type" = filter(CEOs),
                                                                   "Approval Status" = const(Released));

            trigger OnValidate()
            begin
                PerfomanceContractHeader.Reset;
                PerfomanceContractHeader.SetRange(No, "CEOs PC ID");
                if PerfomanceContractHeader.FindSet then begin
                    "Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
                    "Annual Workplan" := PerfomanceContractHeader."Annual Workplan";
                    "Annual Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
                    "Start Date" := PerfomanceContractHeader."Start Date";
                    "End Date" := PerfomanceContractHeader."End Date";
                    "Functional WorkPlan" := PerfomanceContractHeader."Functional WorkPlan";
                    "CEO WorkPlan" := PerfomanceContractHeader."CEO WorkPlan";
                end;
            end;
        }
        field(43; "Department/Center PC ID"; Code[20])
        {

            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"),
                                                                   "Score Card Type" = const(Departmental),
                                                                   "Approval Status" = filter(Released));
            // HQ = filter(true));

            trigger OnValidate()
            begin
                PerfomanceContractHeader.Reset;
                PerfomanceContractHeader.SetRange(No, "Department/Center PC ID");
                if PerfomanceContractHeader.FindSet then begin
                    "Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
                    "Annual Workplan" := PerfomanceContractHeader."Annual Workplan";
                    "Start Date" := PerfomanceContractHeader."Start Date";
                    "End Date" := PerfomanceContractHeader."End Date";
                    "Annual Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
                    "Functional WorkPlan" := PerfomanceContractHeader."Functional WorkPlan";
                    "CEOs PC ID" := PerfomanceContractHeader."CEOs PC ID";
                    "CEO WorkPlan" := PerfomanceContractHeader."CEO WorkPlan";

                    Validate("Responsibility Center", PerfomanceContractHeader.Department);

                    ResponsibityC.Reset;
                    ResponsibityC.SetRange(Code, "Responsibility Center");
                    if ResponsibityC.FindFirst() then
                        "Responsibility Center Name" := ResponsibityC.Name;
                end;
            end;
        }
        field(44; "Activity Type"; Option)
        {

            OptionMembers = " ",Board,CSP;
        }
        field(45; HOD; Boolean)
        {

        }
        field(46; "Acting Job ID"; Code[30])
        {

        }
        field(47; "No.of CEOs PCs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("CEO/Corporate PC"),
                                                                    No = field("CEO WorkPlan")));
            FieldClass = FlowField;
        }
        field(48; "No. of Directors' PCs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("Staff Performance Contract"),
                                                                    "Score Card Type" = filter(CEOs),
                                                                    No = field("CEOs PC ID")));
            FieldClass = FlowField;
        }
        field(49; "No. of Departments' PCs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("Staff Performance Contract"),
                                                                    "Score Card Type" = filter(Departmental),
                                                                    "CEOs PC ID" = field(No)));
            FieldClass = FlowField;
        }
        field(50; "No. of Staff PCs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("Staff Performance Contract"),
                                                                    "Score Card Type" = filter(Staff),
                                                                    "CEOs PC ID" = field(No)));
            FieldClass = FlowField;
        }
        field(51; "No. of Dpt Staff PCs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("Staff Performance Contract"),
                                                                    "Score Card Type" = filter(Staff),
                                                                    "Department/Center PC ID" = field(No)));
            FieldClass = FlowField;
        }
        field(52; "Principal Officer PC ID"; Code[30])
        {

            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"),
                                                                   "Score Card Type" = filter(Principal),
                                                                   "Approval Status" = const(Released)
                                                                   );
            //HQ = const(true)

            trigger OnValidate()
            begin
                PerfomanceContractHeader.Reset;
                PerfomanceContractHeader.SetRange(No, "Principal Officer PC ID");
                if PerfomanceContractHeader.FindSet then begin
                    "Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
                    "Annual Workplan" := PerfomanceContractHeader."Annual Workplan";
                    "Start Date" := PerfomanceContractHeader."Start Date";
                    "End Date" := PerfomanceContractHeader."End Date";
                    "Annual Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
                    "Functional WorkPlan" := PerfomanceContractHeader."Functional WorkPlan";
                    "CEOs PC ID" := PerfomanceContractHeader."CEOs PC ID";
                    "Department/Center PC ID" := PerfomanceContractHeader."Department/Center PC ID";
                    "CEO WorkPlan" := PerfomanceContractHeader."CEO WorkPlan";
                end;
            end;
        }
        field(53; "Senior Officer PC ID"; Code[30])
        {

            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"),
                                                                   "Score Card Type" = filter(Senior),
                                                                   "Approval Status" = const(Released)
                                                                   );
            //HQ = const(true)

            trigger OnValidate()
            begin
                PerfomanceContractHeader.Reset;
                PerfomanceContractHeader.SetRange(No, "Senior Officer PC ID");
                if PerfomanceContractHeader.FindSet then begin
                    "Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
                    "Annual Workplan" := PerfomanceContractHeader."Annual Workplan";
                    "Start Date" := PerfomanceContractHeader."Start Date";
                    "End Date" := PerfomanceContractHeader."End Date";
                    "Annual Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
                    "Functional WorkPlan" := PerfomanceContractHeader."Functional WorkPlan";
                    "CEOs PC ID" := PerfomanceContractHeader."CEOs PC ID";
                    "Department/Center PC ID" := PerfomanceContractHeader."Department/Center PC ID";
                    "Principal Officer PC ID" := PerfomanceContractHeader."Principal Officer PC ID";
                    "CEO WorkPlan" := PerfomanceContractHeader."CEO WorkPlan";
                end;
            end;
        }
        field(54; "No. of Principal Officers PCs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("Staff Performance Contract"),
                                                                    "Score Card Type" = filter(Principal),
                                                                    "Department/Center PC ID" = field(No)));
            FieldClass = FlowField;
        }
        field(55; "No. of Senior Officers PCs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("Staff Performance Contract"),
                                                                    "Score Card Type" = filter(Senior),
                                                                    "Department/Center PC ID" = field(No)));
            FieldClass = FlowField;
        }
        field(56; HQ; Boolean)
        {

        }
        // field(57; "Regional PC ID"; Code[20])
        // {

        //     TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Appraisal"),
        //                                                            "Score Card Type" = const(Departmental),
        //                                                            "Approval Status" = filter(Released),
        //                                                            HQ = filter(false),
        //                                                            "Region Code" = field("Region Code"));

        //     trigger OnValidate()
        //     begin
        //         PerfomanceContractHeader.Reset;
        //         PerfomanceContractHeader.SetRange(No, "Regional PC ID");
        //         if PerfomanceContractHeader.FindSet then begin
        //             "Strategy Plan ID" := PerfomanceContractHeader."Strategy Plan ID";
        //             "Annual Workplan" := PerfomanceContractHeader."Annual Workplan";
        //             "Start Date" := PerfomanceContractHeader."Start Date";
        //             "End Date" := PerfomanceContractHeader."End Date";
        //             "Annual Reporting Code" := PerfomanceContractHeader."Annual Reporting Code";
        //             "Functional WorkPlan" := PerfomanceContractHeader."Functional WorkPlan";
        //             "CEOs PC ID" := PerfomanceContractHeader."CEOs PC ID";
        //             //MESSAGE('Department %1',PerfomanceContractHeader."Department/Center PC ID");
        //             "Department/Center PC ID" := "Regional PC ID";
        //             "CEO WorkPlan" := PerfomanceContractHeader."CEO WorkPlan";
        //         end;
        //     end;
        // }
        // field(58; "Region Code"; Code[30])
        // {

        //     TableRelation = "Responsibility Center".Code where("Operating Unit Type" = filter(Region));

        //     trigger OnValidate()
        //     begin
        //         if ResponsibityC.Get(Department) then begin
        //             "Department Name" := ResponsibityC.Name;
        //         end;
        //     end;
        // }
        field(59; "Planning Budget Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Original,Supplementary';
            OptionMembers = Original,Supplementary;
        }
        field(60; "Organizational PC"; code[50])
        {
            TableRelation = "Annual Strategy Workplan".No where("Annual Strategy Type" = filter("Organizational PC"), "Approval Status" = filter(Released));
        }
        field(61; "Annual Performance Contract"; code[50])
        {
            TableRelation = "Perfomance Contract Header".No WHERE("Document Type" = CONST("Board/Executive PC"), "Approval Status" = CONST(Released));
        }
        field(62; "Do you have a senior?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Target Setting Type"; Option)
        {
            Caption = 'Target Setting Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Top-Down Cascade,Employee-Initiated';
            OptionMembers = "Top-Down Cascade","Employee-Initiated";
        }
        field(64; "Employee Submitted By"; Code[50])
        {
            Caption = 'Submitted By (Employee)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(65; "Employee Submitted On"; Date)
        {
            Caption = 'Submitted On (Employee)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(66; "Manager Return Reason"; Text[500])
        {
            Caption = 'Manager Return Reason';
            DataClassification = ToBeClassified;
        }
        field(67; "Manager Acknowledged By"; Code[50])
        {
            Caption = 'Approved By (Manager)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(68; "Manager Acknowledged On"; Date)
        {
            Caption = 'Approved On (Manager)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69; "Manager No."; Code[50])
        {
            Caption = 'Manager No.';
            TableRelation = Employee."No." where(Status = filter(Active));
        }
        field(70; "Manager Name"; Text[250])
        {
            Caption = 'Manager Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Search Name" where("No." = field("Manager No.")));
        }

    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
        key(Key2; Department, "Responsibility Center", "Responsible Employee No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; No, Description, "Responsible Employee No.", "Employee Name")
        {
        }
        fieldgroup(Brick; No, Description, "Responsible Employee No.", "Employee Name")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Document Type" = "document type"::"Board/Executive PC" then begin
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("PWork Plans");
                No := NoSeriesMgt.GetNextNo(SPMSetup."PWork Plans", 0D, true);
            end;
        end;

        if "Document Type" = "document type"::"CEO/Corporate PC" then begin
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("PWork Plans");
                No := NoSeriesMgt.GetNextNo(SPMSetup."Corporate PC No. Series", 0D, true);
            end;
        end;

        if "Document Type" = "document type"::"Functional/Operational PC" then begin
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("PWork Plans");
                No := NoSeriesMgt.GetNextNo(SPMSetup."Functional PC No. Series", 0D, true);
            end;
        end;

        if "Document Type" = "document type"::"Staff Performance Contract" then begin
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("PWork Plans");
                No := NoSeriesMgt.GetNextNo(SPMSetup."Individual Scorecard Nos", 0D, true);
            end;
        end;

        if "Document Type" = "document type"::"Individual Scorecard PC" then begin
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("PWork Plans");
                No := NoSeriesMgt.GetNextNo(SPMSetup."Individual Scorecard Nos", 0D, true);
            end;
        end;

        "Created By" := UserId;
        "Created On" := Today;
        "Document Date" := Today;

        companyinfo.get();
        "Vision Statement" := companyinfo.Vision;
        "Mission Statement" := companyinfo.Mission;
    end;


    var
        SPMSetup: Record "SPM General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Emp: Record Employee;
        ResponsibityC: Record "Responsibility Center";
        AnnualStrategyWorkplan: Record "Annual Strategy Workplan";
        AnnualReportingCodes: Record "Annual Reporting Codes";
        PerfomanceContractHeader: Record "Perfomance Contract Header";
        CSP: Record "Corporate Strategic Plans";
        companyinfo: Record "Company Information";

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        /*OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");*/


        //IF "No." <> '' THEN
        //  MODIFY;

        /*IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
          MODIFY;
          IF PurchLinesExist THEN
            UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;*/

    end;


    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        /*OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID",STRSUBSTNO('%1 %2',"Document Type","No."),
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");*/


        /*IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
          MODIFY;
        
        
          IF PurchLinesExist THEN
            UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;*/

    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin

        // Update all lines with changed dimensions.

        /*IF NewParentDimSetID = OldParentDimSetID THEN
          EXIT;
        IF NOT CONFIRM(Text051) THEN
          EXIT;
        
        PurchLine.RESET;
        //PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE(PurchLine.No,"No.");
        PurchLine.LOCKTABLE;
        IF PurchLine.FIND('-') THEN
          REPEAT
            NewDimSetID := DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID",NewParentDimSetID,OldParentDimSetID);
            IF PurchLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
              PurchLine."Dimension Set ID" := NewDimSetID;
              DimMgt.UpdateGlobalDimFromDimSetID(
                PurchLine."Dimension Set ID",PurchLine."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 2 Code");
              PurchLine.MODIFY;
            END;
          UNTIL PurchLine.NEXT = 0;*/

    end;


    procedure PurchLinesExist(): Boolean
    begin
        /*PurchLine.RESET;
        //PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE(PurchLine.No,"No.");
        EXIT(PurchLine.FINDFIRST);*/

    end;

    procedure ValidateKPIWeight()
    var
        TotalWeight: Decimal;
        WeightErr: Label 'Total KPI weight is %1%. It must equal 100% before submitting.';
    begin
        CalcFields("Total Assigned Weight(%)");
        TotalWeight := "Total Assigned Weight(%)";
        if TotalWeight <> 100 then
            Error(WeightErr, TotalWeight);
    end;

    procedure SubmitForManagerApproval()
    begin
        TestField("Responsible Employee No.");
        TestField("Annual Reporting Code");
        if "Target Setting Type" <> "target setting type"::"Employee-Initiated" then
            Error('Only Employee-Initiated scorecards use the employee submission flow.');
        if "Approval Status" <> "approval status"::Open then
            Error('Only Open scorecards can be submitted for manager approval.');

        ValidateKPIWeight();

        "Approval Status" := "approval status"::"Pending Approval";
        "Employee Submitted By" := UserId();
        "Employee Submitted On" := Today;
        "Manager Return Reason" := '';
        Modify(true);
    end;

    procedure ManagerApprove()
    begin
        if "Target Setting Type" <> "target setting type"::"Employee-Initiated" then
            Error('Only Employee-Initiated scorecards use the manager approval flow.');
        if "Approval Status" <> "approval status"::"Pending Approval" then
            Error('Only scorecards Pending Approval can be approved.');

        "Approval Status" := "approval status"::Released;
        "Manager Acknowledged By" := UserId();
        "Manager Acknowledged On" := Today;
        Modify(true);
    end;

    procedure ManagerReturn(ReturnReason: Text[500])
    begin
        if "Target Setting Type" <> "target setting type"::"Employee-Initiated" then
            Error('Only Employee-Initiated scorecards use the manager return flow.');
        if "Approval Status" <> "approval status"::"Pending Approval" then
            Error('Only scorecards Pending Approval can be returned.');
        if ReturnReason = '' then
            Error('Please provide a reason for returning the scorecard.');

        "Approval Status" := "approval status"::Open;
        "Manager Return Reason" := ReturnReason;
        "Employee Submitted By" := '';
        "Employee Submitted On" := 0D;
        Modify(true);
    end;
}

