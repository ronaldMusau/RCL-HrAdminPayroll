/// <summary>
/// Table AppraisalDeptObjectives (ID 50024).
/// </summary>
table 52211736 AppraisalDeptObjectives
{
    Caption = 'AppraisalDeptObjectives';
    LookupPageId = "Dep Objectives";
    DrillDownPageId = "Dep Objectives";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Strategy Plan ID"; Code[20])
        {
            Caption = 'Strategy Plan ID';
        }
        field(5; "Activity ID"; Code[20])
        {
            Caption = 'Activity ID';
        }
        field(6; Description; Text[550])
        {
            Caption = 'Description';
        }
        field(7; "Primary Department"; Code[20])
        {
            Caption = 'Primary Department';
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        //field(8; "Primary Division"; Code[20])
        //{
        //Caption = 'Primary Division';
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Division/Section"));
        //}
        // field(9; "Position ID"; Code[20])
        // {
        //     Caption = 'Position ID';
        // }
        field(10; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
        }
        field(11; Target; Decimal)
        {
            Caption = 'Target';
        }
        field(12; "Objective Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Positions,"Strategy Workplan","Board Activities";
        }
        field(13; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Periods";
        }
        field(14; "Annual Reporting Code"; Code[20])
        {
            TableRelation = "Annual Reporting Codes";
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Objectives: Record AppraisalDeptObjectives;
    begin
        Objectives.Reset();
        Objectives.SetRange("Document No.", Rec."Document No.");
        Objectives.SetRange("Objective Type", Rec."Objective Type");
        Objectives.SetRange("Annual Reporting Code", Rec."Annual Reporting Code");
        Objectives.SetRange("Appraisal Period", Rec."Appraisal Period");
        if Objectives.FindLast() then
            "Line No." := Objectives."Line No." + 1;
    end;
}
