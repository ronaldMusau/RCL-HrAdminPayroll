#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211707 "Performance Improvement Plan"
{

    fields
    {
        field(1; No; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document Type" = "document type"::PIP then begin
                    if No <> xRec.No then begin
                        SPMSetup.Get;
                        NoSeriesMgt.TestManual(SPMSetup."Performance Improv Review Nos");
                        "No. Series" := '';
                    end;
                end;

                if "Document Type" = "document type"::"PIP Review" then begin
                    if No <> xRec.No then begin
                        SPMSetup.Get;
                        NoSeriesMgt.TestManual(SPMSetup."Performance Improv Review Nos");
                        "No. Series" := '';
                    end;
                end;
            end;
        }
        field(2; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'PIP,PIP Review';
            OptionMembers = PIP,"PIP Review";
        }
        field(3; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Primary Evaluation ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Original PIP"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Improvement Plan".No where("Document Type" = const(PIP));
        }
        field(6; Description; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "PIP Template ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "PIP Template"."Template ID";
        }
        field(8; "PIP Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "PIP End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Employee Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Designation; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Grade; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Immediate Supervisor No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Immediate Supervisor Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Personal Scorecard ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"));
        }
        field(17; "Strategy Plan ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans".Code;
        }
        // field(18; Directorate; Code[30])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Responsibility Center".Code where("Operating Unit Type" = filter(Directorate));
        // }
        field(19; Department; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code where("Operating Unit Type" = filter(Department));
        }
        field(20; "Annual Reporting Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes";
        }
        field(21; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
        }
        field(22; "Blocked?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Created By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Created On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Last Review Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Performance Review Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Interim PIP Review,Final PIP Review';
            OptionMembers = "Interim PIP Review","Final PIP Review";
        }
        field(27; "Final PIP Outcome"; Option)
        {
            Caption = 'Final PIP Outcome';
            // OptionMembers = "Positive Performance","Negative Performance";
            OptionCaption = ' ,Successful Improvement,Partial Improvement,Unsuccessful';
            OptionMembers = " ","Successful Improvement","Partial Improvement",Unsuccessful;
        }
        field(28; "Final PIP Verdict Code"; Code[100])
        {
            Caption = 'Final PIP Verdict Code';
            DataClassification = ToBeClassified;
            TableRelation = "PIP Verdict Code".Code;
        }
        field(29; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(30; "PIP Progress Status"; Option)
        {
            Caption = 'PIP Progress Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'On Track,At Risk,Overdue,Completed';
            OptionMembers = "On Track","At Risk",Overdue,Completed;
        }
        field(31; "Total Milestones"; Integer)
        {
            Caption = 'Total Milestones';
            FieldClass = FlowField;
            CalcFormula = count("Improvement Plan Line" where("PIP ID" = field(No), "Document Type" = field("Document Type")));
            Editable = false;
        }
        field(32; "Completed Milestones"; Integer)
        {
            Caption = 'Completed Milestones';
            FieldClass = FlowField;
            CalcFormula = count("Improvement Plan Line" where("PIP ID" = field(No), "Document Type" = field("Document Type"), "Milestone Status" = const(Completed)));
            Editable = false;
        }
        field(33; "Extension Months"; Integer)
        {
            Caption = 'Extension Months';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 3;
        }
        field(34; "Escalation Level"; Option)
        {
            Caption = 'Escalation Level';
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Manager Notified,HR Notified,CHRAO Escalated';
            OptionMembers = None,"Manager Notified","HR Notified","CHRAO Escalated";
        }
        field(35; "Last Escalation Date"; Date)
        {
            Caption = 'Last Escalation Date';
            DataClassification = ToBeClassified;
            Editable = false;
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
        if "Document Type" = "document type"::PIP then begin
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("Performance Improv Review Nos");
                No := NoSeriesMgt.GetNextNo(SPMSetup."Performance Improv Review Nos", 0D, true);
            end;
        end;

        if "Document Type" = "document type"::"PIP Review" then begin
            if No = '' then begin
                SPMSetup.Get;
                SPMSetup.TestField("Performance Improv Review Nos");
                No := NoSeriesMgt.GetNextNo(SPMSetup."Performance Improv Review Nos", 0D, true);
            end;
        end;
    end;

    var
        SPMSetup: Record "SPM General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Emp: Record Employee;
        ResponsibityC: Record "Responsibility Center";
}

