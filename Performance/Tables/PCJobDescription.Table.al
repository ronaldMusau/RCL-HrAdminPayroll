#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211718 "PC Job Description"
{

    fields
    {
        field(1; "Workplan No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No;
        }
        field(2; "Line Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Progress; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Not started,In progress,Completed';
            OptionMembers = "Not started","In progress",Completed;
        }
        field(10; "%Complete"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Priority Level"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Urgent,Important,Medium,Low';
            OptionMembers = Urgent,Important,Medium,Low;
        }
        field(13; "Year Reporting Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes";
        }
        field(14; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Primary Department"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        //field(17; "Primary Division"; Code[100])
        //{
        //DataClassification = ToBeClassified;
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter("Division/Section"));
        //
        //trigger OnValidate()
        //begin
        //if ResponsibilityCenter.Get("Primary Division") then begin
        //"Primary Department" := ResponsibilityCenter."Direct Reports To";
        //end;
        //end;
        //}
        field(18; "Overall Owner"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Outcome Perfomance Indicator"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Indicator".KPI;

            trigger OnValidate()
            begin
                PerformanceIndicator.Reset;
                PerformanceIndicator.SetRange(KPI, "Outcome Perfomance Indicator");
                if PerformanceIndicator.FindSet then begin
                    "Key Performance Indicator" := PerformanceIndicator.Description;
                    "Unit of Measure" := PerformanceIndicator."Unit of Measure";
                end;
            end;
        }
        field(20; "Unit of Measure"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(21; "Desired Perfomance Direction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Increasing KPI,Decreasing KPI,Not Applicable';
            OptionMembers = "Increasing KPI","Decreasing KPI","Not Applicable";
        }
        field(22; "KPI Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Lagging,Leading,Not Applicable';
            OptionMembers = Lagging,Leading,"Not Applicable";
        }
        field(23; "Imported Annual Target Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Global Dimension 1 Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Global Dimension 2 Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(44; "Individual Achieved Targets"; Decimal)
        {
            CalcFormula = sum("Performance Diary Entry".Quantity where("Personal Scorecard ID" = field("Workplan No."),
                                                                        "Line Number" = field("Line Number"),
                                                                        "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(50; "Assigned Weight (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Plog Achieved Targets"; Decimal)
        {
            FieldClass = Normal;
        }
        field(52; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(53; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(54; "Key Performance Indicator"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Workplan No.", "Line Number", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PerformanceIndicator: Record "Performance Indicator";
        ResponsibilityCenter: Record "Responsibility Center";
}

