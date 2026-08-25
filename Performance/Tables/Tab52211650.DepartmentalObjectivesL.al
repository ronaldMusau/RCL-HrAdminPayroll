table 52211741 "Departmental Objectives L"
{
    Caption = 'Departmental Objectives Lines';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Departmental Objectives L";
    LookupPageId = "Departmental Objectives L";

    fields
    {
        field(1; "Document No."; Code[50])
        {
            Caption = 'Document No.';
        }
        field(2; "No."; Code[100])
        {
            Caption = 'No.';
        }
        field(3; Description; Text[1028])
        {
            Caption = 'Description';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        //field(5; "Primary Directorate"; Code[50])
        //{
        //    Caption = 'Primary Directorate';
        //    TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Directorate));
        //}
        field(6; "Primary Department"; Code[50])
        {
            Caption = 'Primary Department';
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        field(7; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
        }
        field(8; Target; Decimal)
        {
            Caption = 'Target';
        }
        field(9; "Year Reporting Code"; Code[30])
        {
            TableRelation = "Annual Reporting Codes";
        }
        field(10; "Appraisal Period"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Periods";
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
    begin
        DeptObjectives.Reset();
        DeptObjectives.SetRange("Document No.", REC."Document No.");
        IF DeptObjectives.FindLast() then begin
            "Line No." := DeptObjectives."Line No." + 1;
        end;
    end;

    var
        DeptObjectives: Record "Departmental Objectives L";
}