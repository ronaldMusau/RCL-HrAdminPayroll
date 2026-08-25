#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211679 "SPM General Setup"
{

    fields
    {
        field(1; "Primary key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Corp Strategic Plan Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "Work Plan Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(4; "PM Plans Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(5; "PET Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6; "PWork Plans"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7; "Corporate PC No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Functional PC No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(9; "Individual Scorecard Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(10; "PC Target Revision Voucher Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(11; "Daily Performance Diary Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12; "Performance Evaluation Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(13; "Performance Appeals No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(14; "Enable Performance Appeals"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Performance Improv Review Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(16; "Review Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Review Description"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "policy  Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(19; "PLog Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(20; "Appraisal Based On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Direct Input,Plog Input';
            OptionMembers = " ","Direct Input","Plog Input";
        }
        field(21; "Allow Loading of  CSP"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Allow Loading of JD"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Workplan Revision No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(24; "Functional Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(25; "Organizational PC Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(26; "Functional AWP Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(27; "Budget Consolidation Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(28; "Monitoring Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(29; "Functional Annual Workplan Nos"; code[30])
        {

        }
        field(30; "Current Rev Annual Workplan"; code[30])
        {

        }
        field(31; "Current Annual Workplan"; code[30])
        {

        }
        field(32; "Current Reporting Period"; code[30])
        {
            TableRelation = "Annual Reporting Codes".Code;
            trigger OnValidate()
            var
                QuarterlyReportingPeriods: Record "Quarterly Reporting Periods";
            begin
                QuarterlyReportingPeriods.Reset();
                QuarterlyReportingPeriods.SetRange(Code, "Current Reporting Period");
                if QuarterlyReportingPeriods.FindFirst() then begin
                    "Current Quarter Start Date" := QuarterlyReportingPeriods."Reporting Start Date";
                    "Current Quarter End Date" := QuarterlyReportingPeriods."Reporting End Date";
                end;
            end;

        }
        field(33; "Current Reporting Quarter"; code[30])
        {
            TableRelation = "Quarterly Reporting Periods".Code WHERE("Year Code" = FIELD("Current Reporting Period"));
        }
        field(34; "Notification Due Period"; DateFormula)
        {

        }
        field(35; "Current Quarter Start Date"; Date)
        {

        }
        field(36; "Current Quarter End Date"; Date)
        {

        }
        field(37; "Notification At the Begging Q"; DateFormula)
        {

        }
        field(39; "Notification Due of PC"; DateFormula)
        {

        }
        field(40; "Planning and Strategy Email"; code[50])
        {

        }
        field(41; "HOD Planning & Strategy"; code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(42; "Calibration Start Date"; Date)
        {
            Caption = 'Calibration Window Start Date';
            DataClassification = ToBeClassified;
        }
        field(43; "Calibration End Date"; Date)
        {
            Caption = 'Calibration Window End Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Calibration End Date" <> 0D) and ("Calibration Start Date" <> 0D) then
                    if "Calibration End Date" < "Calibration Start Date" then
                        Error('Calibration End Date cannot be before Calibration Start Date.');
            end;
        }
        field(44; "Check-In Nos"; Code[30])
        {
            Caption = 'Check-In Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }



    }

    keys
    {
        key(Key1; "Primary key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

