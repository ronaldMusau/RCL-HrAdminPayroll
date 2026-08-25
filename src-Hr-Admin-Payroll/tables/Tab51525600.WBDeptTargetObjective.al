table 52211620 "WB Dept Target Objective"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "WB Departmental Targets".No;
        }
        field(2; "Objective No"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; Objective; Text[250])
        {
            Caption = 'Objective';
            DataClassification = CustomerContent;
        }
        field(4; "Goal Statement"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No", "Objective No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        ObjectiveLines: Record "WB Dept Target Objective";
        NextNo: Integer;
        CurrentNoText: Text;
        CurrentNo: Integer;
    begin
        if "Objective No" = '' then begin
            ObjectiveLines.SetRange("Document No", "Document No");
            if ObjectiveLines.FindSet() then
                repeat
                    CurrentNoText := DelChr(ObjectiveLines."Objective No", '=', DelChr(ObjectiveLines."Objective No", '=', '1234567890'));
                    if Evaluate(CurrentNo, CurrentNoText) and (CurrentNo > NextNo) then
                        NextNo := CurrentNo;
                until ObjectiveLines.Next() = 0;

            NextNo += 1;

            "Objective No" := 'OBJ-' + Format(NextNo);
        end;
    end;

    trigger OnDelete()
    var
        TargetLines: Record "Target Lines";
    begin
        TargetLines.SetRange("Document No", Rec."Document No");
        TargetLines.SetRange("Objective No", Rec."Objective No");
        if not TargetLines.IsEmpty() then
            TargetLines.DeleteAll();
    end;
}
