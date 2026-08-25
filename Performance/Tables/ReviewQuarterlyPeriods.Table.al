#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211716 "Review Quarterly Periods"
{
    DrillDownPageID = "Quarterly Reporting Periods";
    LookupPageID = "Quarterly Reporting Periods";

    fields
    {
        field(1; "Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Quarterly Reporting Periods".Code where("Year Code" = field("Year Code"));

            trigger OnValidate()
            begin
                QuarterlyReportingPeriods.Reset;
                QuarterlyReportingPeriods.SetRange(Code, Code);
                if QuarterlyReportingPeriods.Find('-') then begin
                    Description := QuarterlyReportingPeriods.Description;
                    "Reporting Start Date" := QuarterlyReportingPeriods."Reporting Start Date";
                    "Reporting End Date" := QuarterlyReportingPeriods."Reporting End Date";
                    "Current Year?" := QuarterlyReportingPeriods."Current Year?";
                end;
            end;
        }
        field(2; "Year Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes";
        }
        field(3; Description; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Reporting Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Reporting End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Current Year?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Review Period Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Review Periods";
        }
    }

    keys
    {
        key(Key1; "Code", "Year Code", "Review Period Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        QuarterlyReportingPeriods: Record "Quarterly Reporting Periods";
}

