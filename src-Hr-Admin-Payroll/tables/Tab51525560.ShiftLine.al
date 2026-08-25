table 51525560 "Shift Line"
{

    DataClassification = CustomerContent;

    fields
    {
        field(1; "Shift No."; Code[20]) { }
        field(2; "Line No."; Integer) { }
        field(3; "Employee No."; Code[20]) { TableRelation = Employee; }

        field(4; "Employee Name"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Employee No.")));
        }
        field(5; "Shift Type"; Code[20])
        {
            TableRelation = "Shift Setup".Code;
            trigger OnValidate()
            var
                ShiftSetupRec: Record "Shift Setup";
            begin
                if ShiftSetupRec.Get(Rec."Shift Type") then begin
                    Rec."Shift Start Time" := ShiftSetupRec."Start Time";
                    Rec."Shift End Time" := ShiftSetupRec."End Time";
                end else begin
                    Rec."Shift Start Time" := 0T;
                    Rec."Shift End Time" := 0T;
                end;
            end;

        }
        field(6; "Task Assigned"; Text[100]) { }
        field(7; "Meal Order"; Code[100])
        {
            TableRelation = "Meal Order".Code;
            trigger OnValidate()
            var
                MealOrderRec: Record "Meal Order";
            begin
                if MealOrderRec.Get("Meal Order") then begin
                    "Meal Order Description" := MealOrderRec."Meal Orders";
                    Rec."Task Assigned" := MealOrderRec."task assignments ";
                end else begin
                    "Meal Order Description" := '';
                    Rec."Task Assigned" := '';
                end;
            end;
        }
        field(8; "Night Shift"; Boolean) { }
        field(9; "Is Public Holiday"; Boolean)
        {
            Editable = true;
        }
        field(10; "Leave Allocated"; Boolean) { }
        field(11; "Shift Date"; Date)
        {
            trigger OnValidate()
            begin
                HandlePublicHoliday();
            end;
        }
        field(12; "Meal Order Description"; Text[300])
        {
        }
        field(13; "Shift Start Time"; Time) { }
        field(14; "Shift End Time"; Time) { }
        // Monday
        field(15; "Mon Shift"; Code[20])
        {
            TableRelation = "Shift Setup".Code;
            trigger OnValidate()
            var
                ShiftSetupRec: Record "Shift Setup";
            begin
                if ShiftSetupRec.Get("Mon Shift") then begin
                    "Mon Start Time" := ShiftSetupRec."Start Time";
                    "Mon End Time" := ShiftSetupRec."End Time";
                end else begin
                    "Mon Start Time" := 0T;
                    "Mon End Time" := 0T;
                end;
            end;
        }
        field(16; "Mon Start Time"; Time) { }
        field(17; "Mon End Time"; Time) { }

        // Tuesday
        field(18; "Tue Shift"; Code[20])
        {
            TableRelation = "Shift Setup".Code;
            trigger OnValidate()
            var
                ShiftSetupRec: Record "Shift Setup";
            begin
                if ShiftSetupRec.Get("Tue Shift") then begin
                    "Tue Start Time" := ShiftSetupRec."Start Time";
                    "Tue End Time" := ShiftSetupRec."End Time";
                end else begin
                    "Tue Start Time" := 0T;
                    "Tue End Time" := 0T;
                end;
            end;
        }
        field(19; "Tue Start Time"; Time) { }
        field(20; "Tue End Time"; Time) { }

        // Wednesday
        field(21; "Wed Shift"; Code[20])
        {
            TableRelation = "Shift Setup".Code;
            trigger OnValidate()
            var
                ShiftSetupRec: Record "Shift Setup";
            begin
                if ShiftSetupRec.Get("Wed Shift") then begin
                    "Wed Start Time" := ShiftSetupRec."Start Time";
                    "Wed End Time" := ShiftSetupRec."End Time";
                end else begin
                    "Wed Start Time" := 0T;
                    "Wed End Time" := 0T;
                end;
            end;
        }
        field(22; "Wed Start Time"; Time) { }
        field(23; "Wed End Time"; Time) { }

        // Thursday
        field(24; "Thu Shift"; Code[20])
        {
            TableRelation = "Shift Setup".Code;
            trigger OnValidate()
            var
                ShiftSetupRec: Record "Shift Setup";
            begin
                if ShiftSetupRec.Get("Thu Shift") then begin
                    "Thu Start Time" := ShiftSetupRec."Start Time";
                    "Thu End Time" := ShiftSetupRec."End Time";
                end else begin
                    "Thu Start Time" := 0T;
                    "Thu End Time" := 0T;
                end;
            end;
        }
        field(25; "Thu Start Time"; Time) { }
        field(26; "Thu End Time"; Time) { }

        // Friday
        field(27; "Fri Shift"; Code[20])
        {
            TableRelation = "Shift Setup".Code;
            trigger OnValidate()
            var
                ShiftSetupRec: Record "Shift Setup";
            begin
                if ShiftSetupRec.Get("Fri Shift") then begin
                    "Fri Start Time" := ShiftSetupRec."Start Time";
                    "Fri End Time" := ShiftSetupRec."End Time";
                end else begin
                    "Fri Start Time" := 0T;
                    "Fri End Time" := 0T;
                end;
            end;
        }
        field(28; "Fri Start Time"; Time) { }
        field(29; "Fri End Time"; Time) { }

        // Saturday
        field(30; "Sat Shift"; Code[20])
        {
            TableRelation = "Shift Setup".Code;
            trigger OnValidate()
            var
                ShiftSetupRec: Record "Shift Setup";
            begin
                if ShiftSetupRec.Get("Sat Shift") then begin
                    "Sat Start Time" := ShiftSetupRec."Start Time";
                    "Sat End Time" := ShiftSetupRec."End Time";
                end else begin
                    "Sat Start Time" := 0T;
                    "Sat End Time" := 0T;
                end;
            end;
        }
        field(31; "Sat Start Time"; Time) { }
        field(32; "Sat End Time"; Time) { }

        // Sunday
        field(33; "Sun Shift"; Code[20])
        {
            TableRelation = "Shift Setup".Code;
            trigger OnValidate()
            var
                ShiftSetupRec: Record "Shift Setup";
            begin
                if ShiftSetupRec.Get("Sun Shift") then begin
                    "Sun Start Time" := ShiftSetupRec."Start Time";
                    "Sun End Time" := ShiftSetupRec."End Time";
                end else begin
                    "Sun Start Time" := 0T;
                    "Sun End Time" := 0T;
                end;
            end;
        }
        field(34; "Sun Start Time"; Time) { }
        field(35; "Sun End Time"; Time) { }
    }


    keys
    {
        key(PK; "Shift No.", "Line No.") { Clustered = true; }
    }

    local procedure ValidateNightShift(EmployeeNo: Code[20]; ShiftDate: Date)
    var
        ShiftLine: Record "Shift Line";
        WeekStart: Date;
        WeekEnd: Date;
    begin
        WeekStart := CalcDate('<-CW>', ShiftDate);
        WeekEnd := CalcDate('<+6D>', WeekStart);

        ShiftLine.SetRange("Employee No.", EmployeeNo);
        ShiftLine.SetRange("Night Shift", true);
        ShiftLine.SetRange("Shift Date", WeekStart, WeekEnd);

        if ShiftLine.Count >= 3 then
            Error(
              'Employee %1 cannot be assigned more than 3 night shifts in a week.',
              EmployeeNo
            );
    end;

    trigger OnInsert()
    begin
        HandlePublicHoliday();
    end;

    trigger OnModify()
    begin
    end;



    local procedure HandlePublicHoliday()
    begin
        if IsPublicHoliday("Employee No.", "Shift Date") then begin
            "Is Public Holiday" := true;
            "Leave Allocated" := true;
        end else begin
            "Is Public Holiday" := false;
            "Leave Allocated" := false;
        end;
    end;

    local procedure IsPublicHoliday(EmployeeNo: Code[20]; ShiftDate: Date): Boolean
    var
        CalendarMgmt: Codeunit "Calendar Management";
        CustomCalChange: Record "Customized Calendar Change" temporary;
        CompanyInfo: Record "Company Information";
        BaseCalEntry: Record "Base Calendar Change";
        SourceVariant: Variant;
    begin
        if ShiftDate = 0D then
            exit(false);
        if CompanyInfo.Get() then begin
            if CompanyInfo."Base Calendar Code" <> '' then begin
                SourceVariant := CompanyInfo;
                CalendarMgmt.SetSource(SourceVariant, CustomCalChange);
                if CalendarMgmt.IsNonworkingDay(ShiftDate, CustomCalChange) then
                    exit(true);
            end;
        end;
        BaseCalEntry.Reset();
        BaseCalEntry.SetRange("Base Calendar Code", 'RWANDAIR');
        BaseCalEntry.SetRange(Date, ShiftDate);
        BaseCalEntry.SetRange(Nonworking, true);
        if BaseCalEntry.FindFirst() then
            exit(true);
        if Date2DWY(ShiftDate, 1) in [6, 7] then begin
            BaseCalEntry.Reset();
            BaseCalEntry.SetRange("Base Calendar Code", 'RWANDAIR');
            BaseCalEntry.SetRange(Day, Date2DWY(ShiftDate, 1));
            BaseCalEntry.SetRange(Nonworking, true);
            if BaseCalEntry.FindFirst() then
                exit(true);
        end;
        exit(false);
    end;
}

