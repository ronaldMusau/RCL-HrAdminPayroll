#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211705 "Performance Diary Log"
{

    fields
    {
        field(1; No; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SPMSetup.Get;
                    NoSeriesMgt.TestManual(SPMSetup."PLog Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Journal Batch"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Per Diary Journal Batch".Code;
        }
        field(3; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." where(Status = const(Active));

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    "Employee Names" := Employee.FullName;
                    // "Directorate Code" := Employee."Directorate Code";
                    "Department Code" := Employee."Responsibility Center";
                    // "Division Code" := Employee.Division;
                end;

                Description := 'Performance Log_' + "Employee No." + '_' + '(' + FORMAT("Document Date") + ')';
            end;
        }
        field(4; "Incidence Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Performance Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Positive Performance,Negative Performance';
            OptionMembers = "Positive Performance","Negative Performance";
        }
        field(6; "Diary Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Self-Log,Supervisor-Log';
            OptionMembers = "Self-Log","Supervisor-Log";
        }
        field(7; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Personal Scorecard ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No where("Responsible Employee No." = field("Employee No."),
                                                                   "Approval Status" = const(Released));

            trigger OnValidate()
            begin
                IndividualScorecard.Reset;
                IndividualScorecard.SetRange(No, "Personal Scorecard ID");
                IndividualScorecard.SetRange("Document Type", IndividualScorecard."document type"::"Staff Performance Contract");
                // IndividualScorecard.SetRange("Approval Status", IndividualScorecard."approval status"::Released);
                if IndividualScorecard.Find('-') then begin
                    "Goal ID" := IndividualScorecard."Goal Template ID";
                    "CSP ID" := IndividualScorecard."Strategy Plan ID";
                    "AWP ID" := IndividualScorecard."Annual Workplan";
                    "Functional PC" := IndividualScorecard."Functional WorkPlan";
                    "CEOs PC ID" := IndividualScorecard."CEOs PC ID";
                    "Department/Center PC ID" := IndividualScorecard."Department/Center PC ID";
                    "Year Reporting Code" := IndividualScorecard."Annual Reporting Code";

                    Validate("Year Reporting Code");
                end;

                FunctionalWorkplan.RESET;
                FunctionalWorkplan.SETRANGE(No, "Functional PC");
                FunctionalWorkplan.SETRANGE("Document Type", FunctionalWorkplan."Document Type"::"Functional/Operational PC");
                FunctionalWorkplan.SETRANGE("Approval Status", FunctionalWorkplan."Approval Status"::Released);
                IF FunctionalWorkplan.FIND('-') THEN BEGIN
                    "AWP ID" := FunctionalWorkplan."Annual Workplan";
                    Annual_Workplan := "AWP ID";
                END;

                CEOPC.Reset;
                CEOPC.SetRange("Annual Workplan", "AWP ID");
                CEOPC.SetRange("Document Type", CEOPC."document type"::"CEO/Corporate PC");
                CEOPC.SetRange("Approval Status", CEOPC."approval status"::Released);
                if CEOPC.Find('-') then begin
                    "CEO PC ID" := CEOPC.No;
                end;


                BoardPC.Reset;
                BoardPC.SetRange("Annual Workplan", "AWP ID");
                BoardPC.SetRange("Document Type", BoardPC."document type"::"Board/Executive PC");
                BoardPC.SetRange("Approval Status", BoardPC."approval status"::Released);
                if BoardPC.Find('-') then begin
                    "Board PC ID" := BoardPC.No;
                    "CSP ID" := BoardPC."Strategy Plan ID";
                    "Organizational No" := BoardPC."Organizational PC";
                end;

            end;
        }
        field(9; "Goal ID"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Goal Template".Code;
        }
        field(10; "Objective ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Objective"."Objective ID";
        }
        field(11; "Disciplinary Case ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Department Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        // field(13; "Division Code"; Code[100])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Division/Section"));
        // }
        field(14; "Employee Names"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Description:='Performance Log_'+"Employee No."+'_'+'('+FORMAT("Document Date")+')';
            end;
        }
        field(16; "Region ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Activity Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Activity End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "CSP ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "AWP ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Board PC ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "CEO PC ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Functional PC"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "No. Series"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Created On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Created Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Released,Pending Approval,Rejected';
            OptionMembers = Open,Released,"Pending Approval",Rejected;
        }
        field(29; "Year Reporting Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes".Code where("Current Year" = const(true));

            trigger OnValidate()
            begin
                if AnnualReportingCodes.Get("Year Reporting Code") then begin
                    "Activity Start Date" := AnnualReportingCodes."Reporting Start Date";
                    "Activity End Date" := AnnualReportingCodes."Reporting End Date";
                end;
            end;
        }
        field(30; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Posted By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Posted On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Remaining Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "CEOs PC ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"),
                                                                   "Score Card Type" = filter(Departmental | CEOs),
                                                                   "Approval Status" = const(Released));
        }
        field(35; "Department/Center PC ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"),
                                                                   "Score Card Type" = const(Departmental));
        }
        field(36; "Reporting Quater Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Quarterly Reporting Periods".Code WHERE("Year Code" = FIELD("Year Reporting Code"));

        }
        field(37; "Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Plog Type"; Option)
        {
            OptionMembers = PC,AWP;
        }
        field(39; "HOD Scorecard ID"; code[100])
        {

        }
        field(40; "Organizational No"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Are Objectives On Track?"; Boolean)
        {
            Caption = 'Are Objectives On Track against Plan?';
        }
        field(42; "Received Ongoing Feedback"; Boolean)
        {
            Caption = 'Did you receive ongoing feedback from your line manager?';
        }
        field(43; "Development Actions On Track"; Boolean)
        {
            Caption = 'Are your development actions on track against plan?';
        }
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
        if No = '' then begin
            SPMSetup.Get;
            SPMSetup.TestField("PLog Nos");
            No := NoSeriesMgt.GetNextNo(SPMSetup."PLog Nos", 0D, true);
        end;

        "Document Date" := Today;
        "Created By" := UserId;
        "Created On" := Today;
        "Created Time" := Time;
    end;

    var
        Employee: Record Employee;
        SPMSetup: Record "SPM General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        IndividualScorecard: Record "Perfomance Contract Header";
        BoardPC: Record "Perfomance Contract Header";
        CEOPC: Record "Perfomance Contract Header";
        Annual_Workplan: Code[50];
        FunctionalWorkplan: Record "Perfomance Contract Header";
        AnnualReportingCodes: Record "Annual Reporting Codes";
}

