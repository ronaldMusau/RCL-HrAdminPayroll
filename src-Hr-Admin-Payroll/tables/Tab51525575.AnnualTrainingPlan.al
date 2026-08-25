table 51525575 "Annual Training Plan"
{
    Caption = 'Training Master Plan';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Title"; Text[250])
        {
            Caption = 'Title';
            NotBlank = true;
        }
        field(3; "Fiscal Year"; Code[10])
        {
            Caption = 'Fiscal Year';
            NotBlank = true;
        }
        field(4; "Extra Budget"; Decimal)
        {
            Caption = 'Extra Budget';
            MinValue = 0;
        }
        field(5; "Courses Budget"; Decimal)
        {
            Caption = 'Courses Budget';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Annual Training Plan Line"."Course Budget" where("Plan No." = field("No.")));
        }
        field(6; "Total Budget"; Decimal)
        {
            Caption = 'Total Budget';
            Editable = false;
        }
        field(7; "Total Committed"; Decimal)
        {
            Caption = 'Total Committed';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Training Request"."Total Cost (LCY)" where("Training Master Plan No." = field("No."), Status = filter("Pending Approval" | Released)));
        }
        field(8; "Total Used"; Decimal)
        {
            Caption = 'Total Used';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Training Request"."Total Cost (LCY)" where("Training Master Plan No." = field("No."), Status = const(Released)));
        }
        field(9; "Balance"; Decimal)
        {
            Caption = 'Balance';
            Editable = false;
        }
        field(10; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            Editable = false;
        }
        field(11; "Description"; Text[2000])
        {
            Caption = 'Description';
        }
        field(12; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(13; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
        key(K2; "Fiscal Year") { }
        key(K3; "Approval Status") { }
    }

    trigger OnInsert()
    var
        AnnualPlan: Record "Annual Training Plan";
    begin
        if "No." = '' then begin
            AnnualPlan.Reset();
            if AnnualPlan.FindLast() then
                "No." := IncStr(AnnualPlan."No.")
            else
                "No." := 'ATP-0001';
        end;
        "Created By" := UserId;
        "Created Date" := Today;
        "Approval Status" := "Approval Status"::Open;
    end;

    trigger OnModify()
    begin
        CalcFields("Courses Budget", "Total Committed", "Total Used");
        "Total Budget" := "Courses Budget" + "Extra Budget";
        "Balance" := "Total Budget" - "Total Used";
    end;
}
