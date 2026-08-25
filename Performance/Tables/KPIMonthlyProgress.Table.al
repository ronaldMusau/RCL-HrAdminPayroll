#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211755 "SPM KPI Monthly Progress"
{
    Caption = 'KPI Monthly Progress';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Personal Scorecard ID"; Code[100])
        {
            Caption = 'Personal Scorecard ID';
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"));
        }
        field(2; "Initiative No."; Code[30])
        {
            Caption = 'Initiative No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Progress Month"; Date)
        {
            Caption = 'Progress Month';
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Employee No."; Code[50])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(6; "Progress %"; Decimal)
        {
            Caption = 'Progress %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 99999;
        }
        field(7; "Evidence Description"; Text[2048])
        {
            Caption = 'Evidence Description';
            DataClassification = ToBeClassified;
        }
        field(8; "Annual Reporting Code"; Code[50])
        {
            Caption = 'Annual Reporting Code';
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes";
        }
        field(9; "Updated By"; Code[50])
        {
            Caption = 'Updated By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Objective Description"; Text[2048])
        {
            Caption = 'Objective Description';
            DataClassification = ToBeClassified;
        }
        field(12; "Comments"; Text[2048])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Personal Scorecard ID", "Initiative No.", "Progress Month", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        LastLine: Record "SPM KPI Monthly Progress";
    begin
        if "Line No." = 0 then begin
            LastLine.Reset();
            LastLine.SetRange("Personal Scorecard ID", "Personal Scorecard ID");
            LastLine.SetRange("Initiative No.", "Initiative No.");
            LastLine.SetRange("Progress Month", "Progress Month");
            if LastLine.FindLast() then
                "Line No." := LastLine."Line No." + 1
            else
                "Line No." := 1;
        end;

        "Updated By" := UserId();
        "Updated On" := Today;
    end;

    trigger OnModify()
    begin
        "Updated By" := UserId();
        "Updated On" := Today;
    end;
}
