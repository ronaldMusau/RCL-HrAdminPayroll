table 52211654 "Departmental Objectives Lines"
{
    Caption = 'Departmental Objectives Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Appraisal Period"; Code[30])
        {
            Caption = 'Appraisal Period';
            TableRelation = "Appraisal Periods";
            Editable = false;
        }
        field(2; "Department Code"; Code[20])
        {
            Editable = false;
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Department Code");
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Objective; Text[200])
        {
            Caption = 'Objective';
        }
        field(5; Description; Text[2048])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Appraisal Period", "Department Code", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Objectives: Record "Departmental Objectives Lines";
    begin
        Objectives.Reset();
        Objectives.SetRange("Appraisal Period", Rec."Appraisal Period");
        Objectives.SetRange("Department Code", Rec."Department Code");
        if Objectives.FindLast() then
            Rec."Line No." := Objectives."Line No."
        else
            Rec."Line No." := 1;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        // OldDimSetID := "Dimension Set ID";
        // DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        // if "No." <> '' then
        //     //MODIFY;

        //     if OldDimSetID <> "Dimension Set ID" then begin
        //         //MODIFY;
        //         if PurchLinesExist then
        //             UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        //     end;
    end;
}
