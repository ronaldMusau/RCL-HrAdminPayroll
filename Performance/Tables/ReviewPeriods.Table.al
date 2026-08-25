#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211712 "Review Periods"
{
    DrillDownPageID = "Review Periods";
    LookupPageID = "Review Periods";

    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Review Type" = "review type"::" " then
                    Error('First Select Review Type Category');

                TestField("Annual Reporting Code");

                if not ("Starting Date" >= "Reporting Start Date") and ("Starting Date" <= "Reporting End Date") then
                    Error('Starting Date should be within annual reporting dates');

                SPMsetup.Get;
                "End Date" := CalcDate(SPMsetup."Review Duration", "Starting Date");
                Description := SPMsetup."Review Description";
            end;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Closed By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Closed Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Closed Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Genererated Appraisal"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Annual Reporting Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes".Code where("Current Year" = const(true));

            trigger OnValidate()
            begin
                if AnnualReportingCodes.Get("Annual Reporting Code") then begin
                    "Reporting Start Date" := AnnualReportingCodes."Reporting Start Date";
                    "Reporting End Date" := AnnualReportingCodes."Reporting End Date";
                end;
            end;
        }
        field(11; "Review Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Quartely,Semi-Quartely,Annually';
            OptionMembers = " ",Quartely,"Semi-Quartely",Annually;

            trigger OnValidate()
            begin
                if "Review Type" = "review type"::Quartely then begin
                    "No of Quarters" := 1;
                end;

                if "Review Type" = "review type"::"Semi-Quartely" then begin
                    "No of Quarters" := 2;
                end;
                if "Review Type" = "review type"::Annually then begin
                    "No of Quarters" := 4;
                end;
            end;
        }
        field(12; "No of Quarters"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Reporting Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Reporting End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SPMsetup: Record "SPM General Setup";
        AnnualReportingCodes: Record "Annual Reporting Codes";
}

