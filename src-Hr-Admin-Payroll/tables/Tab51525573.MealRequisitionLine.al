table 51525573 "Meal Requisition Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Requisition No"; Code[20])
        {
            Caption = 'Requisition No.';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Meal Code"; Code[20])
        {
            Caption = 'Meal Code';
            TableRelation = Item;
            trigger OnValidate()
            var
                MealSetup: Record Item;
            begin
                if "Meal Code" <> '' then
                    if MealSetup.Get("Meal Code") then begin
                        Description := MealSetup.Description;
                        "Unit Price" := MealSetup."Unit Price";
                        Amount := Quantity * "Unit Price";
                    end;
            end;
        }
        field(4; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(5; Quantity; Integer)
        {
            Caption = 'Quantity';
            InitValue = 1;
            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Price";
            end;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            Editable = false;
        }
        field(7; "GL Account"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(Key1; "Requisition No", "Line No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LastLine: Record "Meal Requisition Line";
    begin
        if "Line No" = 0 then begin
            LastLine.Reset();
            LastLine.SetRange("Requisition No", "Requisition No");
            if LastLine.FindLast() then
                "Line No" := LastLine."Line No" + 1
            else
                "Line No" := 1;
        end;
    end;



}
