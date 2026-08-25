#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211681 "Performance Management Plan"
{
    DrillDownPageID = "Performance Management Plans";
    LookupPageID = "Performance Management Plans";

    fields
    {
        field(1; No; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SPMSetup.Get;
                    NoSeriesMgt.TestManual(SPMSetup."PM Plans Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Strategy Plan ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans".Code;
        }
        field(4; "Annual Reporting Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes".Code where("Current Year" = const(true));

            trigger OnValidate()
            begin
                if AnnualReportingCodes.Get("Annual Reporting Code") then begin
                    "Start Date" := AnnualReportingCodes."Reporting Start Date";
                    "End Date" := AnnualReportingCodes."Reporting End Date";
                end;
            end;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "HR Performance Template"; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Evaluation Template".Code;
        }
        field(8; "Performance Contract  Template"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Executive Summary"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Evaluation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Standard Appraisal/Supervisor Score Only,Self-Appraisal with Supervisor Score,360-Degree/Group Appraisal';
            OptionMembers = "Standard Appraisal/Supervisor Score Only","Self-Appraisal with Supervisor Score","360-Degree/Group Appraisal";
        }
        field(13; Type; option)
        {
            optionMembers = "Functional","Corporate","Plan";
            optionCaption = 'Functional,Corporate,Plan';

        }
        field(14; "Approval Status"; Option)
        {
            OptionMembers = Open,"Pending Approval",Released;
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
            SPMSetup.TestField("Work Plan Nos");
            No := NoSeriesMgt.GetNextNo(SPMSetup."PM Plans Nos", 0D, true);
        end;
    end;

    var
        SPMSetup: Record "SPM General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        AnnualReportingCodes: Record "Annual Reporting Codes";
}

