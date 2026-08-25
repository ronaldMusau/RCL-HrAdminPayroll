#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211720 "Plog Lines"
{

    fields
    {
        field(1; "PLog No."; Code[30])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Performance Diary Log".No;
        }
        field(2; "Initiative No."; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Activity Type" = const("Primary Activity")) "PC Objective"."Initiative No." where("Workplan No." = field("Personal Scorecard ID"))
            else if ("Activity Type" = const("Secondary Activity")) "Secondary PC Objective"."Initiative No." where("Workplan No." = field("Personal Scorecard ID"))
            else if ("Activity Type" = const("JD Activity")) "PC Job Description"."Line Number" where("Workplan No." = field("Personal Scorecard ID"));

            trigger OnValidate()
            begin
                if "Activity Type" = "activity type"::"Primary Activity" then begin
                    StrategicInitiative.Reset;
                    StrategicInitiative.SetRange("Strategy Plan ID", "Strategy Plan ID");
                    StrategicInitiative.SetRange("Workplan No.", "Personal Scorecard ID");
                    StrategicInitiative.SetRange("Initiative No.", "Initiative No.");
                    if StrategicInitiative.Find('-') then begin
                        "Sub Intiative No" := StrategicInitiative."Objective/Initiative";
                        "Planned Date" := StrategicInitiative."Start Date";
                        "Target Qty" := StrategicInitiative."Imported Annual Target Qty";
                        "Due Date" := StrategicInitiative."Due Date";
                        "Weight %" := StrategicInitiative."Assigned Weight (%)";
                    end;

                    PerformanceDiaryLog.Reset;
                    PerformanceDiaryLog.SetRange(No, "PLog No.");
                    if PerformanceDiaryLog.FindFirst then begin
                        "Achieved Date" := PerformanceDiaryLog."Document Date";
                        "AWP ID" := PerformanceDiaryLog."AWP ID";
                        "Board PC ID" := PerformanceDiaryLog."Board PC ID";
                        "CEO PC ID" := PerformanceDiaryLog."CEO PC ID";
                        "Functional PC" := PerformanceDiaryLog."Functional PC";
                    end;
                end;

                if "Activity Type" = "activity type"::"Secondary Activity" then begin
                    SecondaryPCObjective.Reset;
                    SecondaryPCObjective.SetRange("Strategy Plan ID", "Strategy Plan ID");
                    SecondaryPCObjective.SetRange("Workplan No.", "Personal Scorecard ID");
                    SecondaryPCObjective.SetRange("Initiative No.", "Initiative No.");
                    if SecondaryPCObjective.Find('-') then begin
                        "Sub Intiative No" := SecondaryPCObjective."Objective/Initiative";
                        "Planned Date" := SecondaryPCObjective."Start Date";
                        "Target Qty" := SecondaryPCObjective."Imported Annual Target Qty";
                        "Due Date" := SecondaryPCObjective."Due Date";
                        "Weight %" := SecondaryPCObjective."Assigned Weight (%)";
                    end;

                    PerformanceDiaryLog.Reset;
                    PerformanceDiaryLog.SetRange(No, "PLog No.");
                    if PerformanceDiaryLog.FindFirst then begin
                        "Achieved Date" := PerformanceDiaryLog."Document Date";
                        "AWP ID" := PerformanceDiaryLog."AWP ID";
                        "Board PC ID" := PerformanceDiaryLog."Board PC ID";
                        "CEO PC ID" := PerformanceDiaryLog."CEO PC ID";
                        "Functional PC" := PerformanceDiaryLog."Functional PC";
                    end;
                end;
            end;
        }
        field(3; "Sub Intiative No"; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Goal ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Strategy Plan ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans";
        }
        field(13; "Year Reporting Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes";
        }
        field(14; "Planned Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Achieved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Primary Department"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        //field(17; "Primary Division"; Code[100])
        //{
        //DataClassification = ToBeClassified;
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Division/Section"));
        //}
        field(20; "Unit of Measure"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(21; "Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Achieved Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF "Achieved Target">"Target Qty" THEN BEGIN
                //  TESTFIELD(Comments);
                //  END;
            end;
        }
        field(23; "AWP ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Board PC ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "CEO PC ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Functional PC"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." where(Status = const(Active));
        }
        field(28; "Personal Scorecard ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No;
        }
        field(29; Comments; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Activity Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Primary Activity,Secondary Activity,JD Activity';
            OptionMembers = "Primary Activity","Secondary Activity","JD Activity";
        }
        field(31; EntryNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(32; "Remaining Targets"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Weight %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Key Performance Indicator"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Q1 Achieved Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Q2 Achieved Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Q3 AchievedTarget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Q4 Achieved Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Achieved Weight(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; Variance; Text[255])
        {

        }
    }

    keys
    {
        key(Key1; "PLog No.", "Initiative No.", "Strategy Plan ID", "Employee No.", "Personal Scorecard ID", "Activity Type", EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        // PerformanceIndicator: Record "Performance Indicator";
        StrategicInitiative: Record "PC Objective";
        PerformanceDiaryLog: Record "Performance Diary Log";
        SecondaryPCObjective: Record "Secondary PC Objective";
}

