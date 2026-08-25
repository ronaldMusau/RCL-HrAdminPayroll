#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211682 "Performance Plan Task"
{
    DrillDownPageId = "Upcoming Performance Tasks";
    LookupPageId = "Upcoming Performance Tasks";
    fields
    {
        field(1; "Performance Mgt Plan ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Management Plan".No;
        }
        field(2; "Task Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Task Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Corporate Target Setting,Functional Target Setting,Individual Target Setting,Performance Review,Performance Appeal';
            OptionMembers = "Corporate Target Setting","Functional Target Setting","Individual Target Setting","Performance Review","Performance Appeal";
        }
        field(4; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Performance Cycle Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Performance Cycle End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Processing Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Processing Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Published?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Published By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Closed By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "No of Evaluations/Appeals"; Integer)
        {
            CalcFormula = count("Performance Evaluation" where("Performance Mgt Plan ID" = field("Performance Mgt Plan ID"),
                                                               "Performance Task ID" = field("Task Code")));
            FieldClass = FlowField;
        }
        field(14; "Review Periods"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Task Category" = const("Performance Review")) "Review Periods".Code where(Closed = const(false));

            trigger OnValidate()
            begin
                ReviewQuarterlyPeriods.Reset;
                ReviewQuarterlyPeriods.SetRange("Review Period Code", "Review Periods");
                if not ReviewQuarterlyPeriods.FindSet then begin
                    repeat
                        Error('Please assign Review Quarterly Periods for Review period %1', "Review Periods");
                    until ReviewQuarterlyPeriods.Next = 0;
                end;
            end;
        }
        field(15; "Calendar Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Global,Departmental';
            OptionMembers = "Global","Departmental";
        }
        field(16; "Event Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Daily,Weekly,Biweekly,Monthly,Annualy';
            OptionMembers = "Daily","Weekly","Biweekly","Monthly","Annualy";
        }
        field(17; "Event Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Event Venue"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Event Agenda"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Task code2"; code[30])
        {

        }
        field(22; "Task Category2"; Text[250])
        {

        }
    }

    keys
    {
        key(Key1; "Performance Mgt Plan ID", "Task Code")
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     fieldgroup(Dropdown; "Task Code","Task Category")
    //     {

    //     }
    // }

    var
        ReviewQuarterlyPeriods: Record "Review Quarterly Periods";
}

