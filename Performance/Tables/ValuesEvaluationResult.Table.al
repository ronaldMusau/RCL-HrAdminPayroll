#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211754 "Values Evaluation Result"
{
    Caption = 'Values Evaluation Result';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Performance Evaluation ID"; Code[100])
        {
            Caption = 'Performance Evaluation ID';
            DataClassification = ToBeClassified;
            TableRelation = "Performance Evaluation".No;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Core Value Code"; Code[30])
        {
            Caption = 'Core Value Code';
            DataClassification = ToBeClassified;
            TableRelation = "Core Values".Code;

            trigger OnValidate()
            var
                CoreValue: Record "Core Values";
            begin
                if CoreValue.Get("Core Value Code") then
                    "Core Value Description" := CoreValue.Description;
            end;
        }
        field(4; "Core Value Description"; Text[200])
        {
            Caption = 'Core Value Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Employee Self Rating"; Option)
        {
            Caption = 'Employee Self Rating';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,1-Developing Impact,2-Expected Impact,3-Significant Impact,4-Transformational Impact';
            OptionMembers = " ","1-Developing Impact","2-Expected Impact","3-Significant Impact","4-Transformational Impact";
        }
        field(6; "Manager Rating"; Option)
        {
            Caption = 'Manager Rating';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,1-Developing Impact,2-Expected Impact,3-Significant Impact,4-Transformational Impact';
            OptionMembers = " ","1-Developing Impact","2-Expected Impact","3-Significant Impact","4-Transformational Impact";
        }
        field(7; "Final Rating"; Option)
        {
            Caption = 'Final Rating';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,1-Developing Impact,2-Expected Impact,3-Significant Impact,4-Transformational Impact';
            OptionMembers = " ","1-Developing Impact","2-Expected Impact","3-Significant Impact","4-Transformational Impact";
        }
        field(8; "Weight %"; Decimal)
        {
            Caption = 'Weight %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(9; "Employee Comments"; Text[500])
        {
            Caption = 'Employee Comments';
            DataClassification = ToBeClassified;
        }
        field(10; "Manager Comments"; Text[500])
        {
            Caption = 'Manager Comments';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Performance Evaluation ID", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        LastLine: Record "Values Evaluation Result";
    begin
        if "Line No." = 0 then begin
            LastLine.Reset();
            LastLine.SetRange("Performance Evaluation ID", "Performance Evaluation ID");
            if LastLine.FindLast() then
                "Line No." := LastLine."Line No." + 10000
            else
                "Line No." := 10000;
        end;
    end;
}
