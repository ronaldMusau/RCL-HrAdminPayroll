#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211753 "SPM Performance Check In"
{
    Caption = 'Performance Check-In';
    DrillDownPageID = "SPM Performance Check Ins";
    LookupPageID = "SPM Performance Check Ins";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[50])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if Emp.Get("Employee No.") then begin
                    "Employee Name" := Emp.FullName();
                    "Department" := Emp."Responsibility Center";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Immediate Supervisor No."; Code[50])
        {
            Caption = 'Immediate Supervisor No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if Emp.Get("Immediate Supervisor No.") then
                    "Immediate Supervisor Name" := Emp.FullName();
            end;
        }
        field(5; "Immediate Supervisor Name"; Text[100])
        {
            Caption = 'Immediate Supervisor Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Department"; Code[50])
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(7; "Check-In Date"; Date)
        {
            Caption = 'Check-In Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Performance Mgt Plan ID"; Code[100])
        {
            Caption = 'Performance Mgt Plan ID';
            DataClassification = ToBeClassified;
            TableRelation = "Performance Management Plan".No;
        }
        field(9; "Personal Scorecard ID"; Code[100])
        {
            Caption = 'Personal Scorecard ID';
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"));
        }
        field(10; "Annual Reporting Code"; Code[50])
        {
            Caption = 'Annual Reporting Code';
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes".Code;
        }
        field(11; "Check-In Period Description"; Text[100])
        {
            Caption = 'Check-In Period Description';
            DataClassification = ToBeClassified;
        }
        field(12; "Q1 Objectives On Track"; Boolean)
        {
            Caption = 'Q1 - Are your objectives on track?';
            DataClassification = ToBeClassified;
        }
        field(13; "Q2 Feedback From Manager"; Option)
        {
            Caption = 'Q2 - Feedback received from Line Manager?';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Regularly,Infrequent,Not At All';
            OptionMembers = " ",Regularly,Infrequent,"Not At All";
        }
        field(14; "Q3 Dev Actions On Track"; Boolean)
        {
            Caption = 'Q3 - Are Development Actions on track?';
            DataClassification = ToBeClassified;
        }
        field(15; "Q4 Mid-Year Self Rating"; Option)
        {
            Caption = 'Q4 - Mid-Year Self Rating';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,1-Development Required,2-Building Understanding,3-Consistently Meeting Expectations,4-Leading Performance';
            OptionMembers = " ","1-Development Required","2-Building Understanding","3-Consistently Meeting Expectations","4-Leading Performance";
        }
        field(16; "Employee Comments"; Text[2048])
        {
            Caption = 'Employee Comments';
            DataClassification = ToBeClassified;
        }
        field(17; "Manager Comments"; Text[2048])
        {
            Caption = 'Manager Comments';
            DataClassification = ToBeClassified;
        }
        field(27; "MQ1 Objectives On Track"; Boolean)
        {
            Caption = 'MQ1 - Are the staff''s objectives on track against plan?';
            DataClassification = ToBeClassified;
        }
        field(28; "MQ2 Feedback Provided"; Option)
        {
            Caption = 'MQ2 - Did you provide ongoing feedback to this staff member?';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Regularly,Infrequent,Not At All';
            OptionMembers = " ",Regularly,Infrequent,"Not At All";
        }
        field(29; "MQ3 Dev Actions On Track"; Boolean)
        {
            Caption = 'MQ3 - Are the staff''s Development Actions on track against plan?';
            DataClassification = ToBeClassified;
        }
        field(30; "MQ4 Mid-Year Manager Rating"; Option)
        {
            Caption = 'MQ4 - Mid-Year Manager Rating';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,1-Development Required,2-Building Understanding,3-Consistently Meeting Expectations,4-Leading Performance';
            OptionMembers = " ","1-Development Required","2-Building Understanding","3-Consistently Meeting Expectations","4-Leading Performance";
        }
        field(31; "Manager Completed By"; Code[50])
        {
            Caption = 'Manager Completed By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Manager Completed On"; Date)
        {
            Caption = 'Manager Completed On';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Check-In Status"; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Submitted,Approved,Rejected';
            OptionMembers = Open,Submitted,Approved,Rejected;
        }
        field(19; "Submitted By"; Code[50])
        {
            Caption = 'Submitted By';
            DataClassification = ToBeClassified;
        }
        field(20; "Submitted On"; Date)
        {
            Caption = 'Submitted On';
            DataClassification = ToBeClassified;
        }
        field(21; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = ToBeClassified;
        }
        field(22; "Approved On"; Date)
        {
            Caption = 'Approved On';
            DataClassification = ToBeClassified;
        }
        field(23; "Rejected Reason"; Text[500])
        {
            Caption = 'Rejected Reason';
            DataClassification = ToBeClassified;
        }
        field(24; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(25; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Annual Reporting Code", "Check-In Status")
        {
        }
    }

    trigger OnInsert()
    var
        SPMSetup: Record "SPM General Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "No." = '' then begin
            SPMSetup.Get();
            if SPMSetup."Check-In Nos" <> '' then begin
                SPMSetup.TestField("Check-In Nos");
                "No." := NoSeriesMgt.GetNextNo(SPMSetup."Check-In Nos", 0D, true);
                "No. Series" := SPMSetup."Check-In Nos";
            end else
                Error('Please set up Check-In Nos in SPM General Setup before creating Check-Ins.');
        end;
        "Created By" := UserId();
        "Created On" := Today;
        "Check-In Date" := Today;
    end;
}
