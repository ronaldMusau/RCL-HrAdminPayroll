#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211677 "Annual Strategy Workplan"
{
    //DrillDownPageID = "Annual Strategy Workplans";
    //LookupPageID = "Annual Strategy Workplans";

    fields
    {
        field(1; No; Code[30])
        {


            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SPMSetup.Get;
                    NoSeriesMgt.TestManual(SPMSetup."Functional AWP Nos");
                    "No. Series" := '';
                end;
            end;


        }
        field(2; Description; Code[255])
        {

        }
        field(3; "Strategy Plan ID"; Code[50])
        {

            TableRelation = "Corporate Strategic Plans".Code;

            trigger OnValidate()
            begin
                CSP.Reset;
                CSP.SetRange(Code, "Strategy Plan ID");
                if CSP.FindSet then begin
                    "Strategy Framework" := CSP."Strategy Framework";
                end;
            end;
        }
        field(4; "Year Reporting Code"; Code[50])
        {

            TableRelation = "Annual Reporting Codes".Code where("Current Year" = const(true));

            trigger OnValidate()
            begin
                if AnnualReportingCodes.Get("Year Reporting Code") then begin
                    "Start Date" := AnnualReportingCodes."Reporting Start Date";
                    "End Date" := AnnualReportingCodes."Reporting End Date";
                end;
            end;
        }
        field(5; "Start Date"; Date)
        {

        }
        field(6; "End Date"; Date)
        {

        }
        field(7; "No. Series"; Code[10])
        {
            Caption = 'No. Series';

            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; "Approval Status"; Option)
        {

            OptionCaption = 'Open,Pending Approval,Released';
            OptionMembers = Open,"Pending Approval",Released;
        }
        field(9; "Unit of Measure"; Text[100])
        {

        }
        field(10; "Current AWP"; Boolean)
        {

        }
        field(38; "Strategy Framework"; Code[100])
        {

            TableRelation = "Strategy Framework";
        }
        field(39; "No. of CEOs PCs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("Staff Performance Contract"),
                                                                    "Score Card Type" = filter(CEOs),
                                                                    "Annual Workplan" = field(No)));
            FieldClass = FlowField;
        }
        field(40; "No. of Department Pcs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("Staff Performance Contract"),
                                                                    "Score Card Type" = filter(Departmental),
                                                                    "Annual Workplan" = field(No)));
            FieldClass = FlowField;
        }
        field(41; "No. of Staff PCs"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = filter("Staff Performance Contract"),
                                                                    "Score Card Type" = filter(Staff),
                                                                    "Annual Workplan" = field(No)));
            FieldClass = FlowField;
        }
        field(42; "Annual Strategy Type"; Option)
        {

            OptionCaption = 'Organizational,Functional,Functional PC,Organizational PC';
            OptionMembers = Organizational,Functional,"Functional PC","Organizational PC";
            DataClassification = ToBeClassified;
        }
        field(43; "Annual Workplan"; Code[30])
        {
            TableRelation = "Annual Strategy Workplan".No where("Annual Strategy Type" = filter(Organizational));
        }
        field(44; Department; Code[30])
        {

            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));

            trigger OnValidate()
            begin
                AnnualStrategyWorkplan.Reset;
                AnnualStrategyWorkplan.SetRange("Annual Strategy Type", AnnualStrategyWorkplan."annual strategy type"::"Functional PC");
                AnnualStrategyWorkplan.SetRange(Department, Department);
                AnnualStrategyWorkplan.SetRange("Strategy Plan ID", "Strategy Plan ID");
                AnnualStrategyWorkplan.SetRange("Year Reporting Code", "Year Reporting Code");
                AnnualStrategyWorkplan.SetRange("Approval Status", AnnualStrategyWorkplan."approval status"::Open);
                if AnnualStrategyWorkplan.FindSet then begin
                    Error('You have already an ongoing Departmental Workplan No %1 for Department %2, Please proceed and Edit it',
                    AnnualStrategyWorkplan.No, AnnualStrategyWorkplan."Department Name");
                end;

                // ResponsibilityCenter.Reset;
                // ResponsibilityCenter.SetRange(Code, Department);
                // if ResponsibilityCenter.Find('-') then begin
                //     "Primary Department" := ResponsibilityCenter."Direct Reports To";
                // end;
            end;
        }
        field(45; "Department Name"; Text[250])
        {

        }
        field(46; Posted; Boolean)
        {

        }
        field(47; "Total Assigned Weight(%)"; Decimal)
        {
            CalcFormula = sum("Strategy Workplan Lines"."Departmental Activity Weight" where(No = field(No)));
            FieldClass = FlowField;
        }
        field(48; "Total  Departments Count"; Integer)
        {
            CalcFormula = count("Responsibility Center" where("Operating Unit Type" = filter(Department)));
            FieldClass = FlowField;
        }
        field(49; "Total Weight(%)"; Decimal)
        {

        }
        field(50; "Primary Department"; Code[50])
        {

            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
            trigger OnValidate()
            var
                ResponsibilityCenter: Record "Responsibility Center";
            begin
                AnnualStrategyWorkplan.Reset;
                AnnualStrategyWorkplan.SetRange("Annual Strategy Type", AnnualStrategyWorkplan."annual strategy type"::"Functional PC");
                AnnualStrategyWorkplan.SetRange(Department, Department);
                AnnualStrategyWorkplan.SetRange("Strategy Plan ID", "Strategy Plan ID");
                AnnualStrategyWorkplan.SetRange("Year Reporting Code", "Year Reporting Code");
                AnnualStrategyWorkplan.SetRange("Approval Status", AnnualStrategyWorkplan."approval status"::Open);
                if AnnualStrategyWorkplan.FindSet then begin
                    Error('You have already an ongoing Departmental Workplan No %1 for Department %2, Please proceed and Edit it',
                    AnnualStrategyWorkplan.No, AnnualStrategyWorkplan."Department Name");
                end;

                ResponsibilityCenter.Reset();
                ResponsibilityCenter.SetRange(Code, "Primary Department");
                if ResponsibilityCenter.find('-') then begin
                    "Department Name" := ResponsibilityCenter.Name;
                end;
            end;
        }
        field(51; "Created By"; Code[50])
        {

        }
        field(52; "Created at"; Date)
        {

        }
        field(53; "Functional Procurment Plan No"; Code[30])
        {

            // TableRelation = "Procurement Plan".Code;////where(Department = field(Department),
            //  "Plan Type" = const(Functional),
            //  "Revision Voucher" = const(false));
        }
        field(54; "Division Filter"; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center".Code;
        }
        field(55; "Department Filter"; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center".Code;
        }
        field(56; "Total Budget"; Decimal)
        {
            CalcFormula = sum("Strategy Workplan Lines"."Imported Annual Budget Est." where(No = field(No)));
            // CalcFormula = sum("Strategy Workplan Lines"."Total Subactivity budget" where(No = field(No),
            //                                                                          "Primary Department" = field("Department Filter")));
            FieldClass = FlowField;
            // CalcFormula = sum("Strategy Workplan Lines"."Total Subactivity budget" where(No = field(No),
            //                                                                          "Primary Department" = field("Division Filter"),
            //                                                                              "Primary Division" = field("Department Filter")));

        }
        field(57; "Organiztional PC"; Code[30])
        {

            TableRelation = "Annual Strategy Workplan".No where("Annual Strategy Type" = const("Organizational PC"));
        }
        field(58; "Total Assigned PC Weight(%)"; Decimal)
        {
            CalcFormula = sum("Board Activities"."WT(%)" where("AWP No" = field(No)));
            FieldClass = FlowField;
        }
        field(59; Archived; Boolean)
        {

        }
        field(60; "Archived On"; Date)
        {

        }
        field(61; "Archived By"; Code[50])
        {

        }
        field(62; "Workplan No"; Code[30])
        {

            TableRelation = "Annual Strategy Workplan".No where("Annual Strategy Type" = const(Organizational),
                                                                 "Strategy Plan ID" = field("Strategy Plan ID"),
                                                                 "Year Reporting Code" = field("Year Reporting Code"));
        }
        field(63; "Approved Budget"; Decimal)
        {

        }
        field(64; "Planning Budget Type"; Option)
        {
            OptionMembers = Supplementary,Original;
        }
        field(65; "Current Performance Contract"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //field(66; "Primary Division"; Code[50])
        //{
        //
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Division/Section"));
        //}
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Annual Strategy Type" = "Annual Strategy Type"::"Organizational PC" THEN
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("Organizational PC Nos");
                No := NoSeriesMgt.GetNextNo(SPMSetup."Organizational PC Nos", 0D, true);
            end;
        IF Rec."Annual Strategy Type" = Rec."annual strategy type"::"Functional PC" THEN
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("Functional Nos");
                No := NoSeriesMgt.GetNextNo(SPMSetup."Functional Nos", 0D, true);
            end;
        //  IF Rec."Annual Strategy Type" = Rec."annual strategy type"::"Functional" THEN

        if No = '' then begin
            SPMSetup.Get;
            SPMSetup.TestField("Corp Strategic Plan Nos");
            No := NoSeriesMgt.GetNextNo(SPMSetup."Functional AWP Nos", 0D, true);
        end;
    end;

    var
        SPMSetup: Record "SPM General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        AnnualReportingCodes: Record "Annual Reporting Codes";
        CSP: Record "Corporate Strategic Plans";
        AnnualStrategyWorkplan: Record "Annual Strategy Workplan";
        ResponsibilityCenter: Record "Responsibility Center";
}

