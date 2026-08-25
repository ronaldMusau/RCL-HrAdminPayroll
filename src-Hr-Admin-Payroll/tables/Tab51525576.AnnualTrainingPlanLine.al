table 51525576 "Annual Training Plan Line"
{
    Caption = 'Annual Training Plan Line';
    DataClassification = CustomerContent;
    LookupPageId = "ATP Line Lookup";
    DrillDownPageId = "ATP Line Lookup";

    fields
    {
        field(1; "Plan No."; Code[20])
        {
            Caption = 'Plan No.';
            Editable = false;
            TableRelation = "Annual Training Plan"."No.";
        }
        field(3; "Course No."; Code[30])
        {
            Caption = 'Course No.';
            TableRelation = "Training Master Plan Header"."No." where("Approval Status" = const(Released));
            trigger OnValidate()
            var
                Course: Record "Training Master Plan Header";
            begin
                if "Course No." = '' then begin
                    "Course Title" := '';
                    "Course Budget" := 0;
                    exit;
                end;
                if Course.Get("Course No.") then begin
                    "Course Title" := Course.Title;
                    "Course Budget" := Course."Budget/Expense";
                end;
            end;
        }
        field(4; "Course Title"; Text[250])
        {
            Caption = 'Course Title';
            Editable = false;
        }
        field(5; "Course Budget"; Decimal)
        {
            Caption = 'Course Budget';
            Editable = false;
        }
        field(6; "Date Added"; Date)
        {
            Caption = 'Date Added';
            Editable = false;
        }
        field(7; "Added By"; Code[50])
        {
            Caption = 'Added By';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Plan No.", "Course No.") { Clustered = true; }
    }

    trigger OnInsert()
    var
        ATPlan: Record "Annual Training Plan";
    begin
        "Date Added" := Today;
        "Added By" := UserId;
        if ATPlan.Get("Plan No.") then begin
            ATPlan.CalcFields("Courses Budget");
            ATPlan."Total Budget" := ATPlan."Courses Budget" + ATPlan."Extra Budget";
            ATPlan.Modify(false);
        end;
    end;

    trigger OnModify()
    var
        ATPlan: Record "Annual Training Plan";
    begin
        if ATPlan.Get("Plan No.") then begin
            ATPlan.CalcFields("Courses Budget");
            ATPlan."Total Budget" := ATPlan."Courses Budget" + ATPlan."Extra Budget";
            ATPlan.Modify(false);
        end;
    end;

    trigger OnDelete()
    var
        ATPlan: Record "Annual Training Plan";
    begin
        if ATPlan.Get("Plan No.") then begin
            ATPlan.CalcFields("Courses Budget");
            ATPlan."Total Budget" := ATPlan."Courses Budget" + ATPlan."Extra Budget";
            ATPlan.Modify(false);
        end;
    end;
}

