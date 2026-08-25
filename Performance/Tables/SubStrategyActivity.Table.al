#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211730 "Sub_Strategy_Activity"
{
    // DrillDownPageID = "Sub Intiative Entries";
    // LookupPageID = "Sub Intiative Entries";

    fields
    {
        field(1; "Strategic Plan ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Corporate Strategic Plans".Code;
        }
        field(2; "Theme ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Strategic Theme"."Theme ID";
        }
        field(3; "Objective ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Strategic Objective"."Objective ID";
        }
        field(4; "Strategy ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Strategy."Strategy ID";
        }
        field(5; "Activity ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Initiative".Code;

            trigger OnValidate()
            begin
                if StrategicInitiative.Get("Activity ID") then begin
                    "Strategic Plan ID" := StrategySub_ActivityEntry."Strategic Plan ID";
                    "Theme ID" := StrategySub_ActivityEntry."Theme ID";
                    "Objective ID" := StrategySub_ActivityEntry."Objective ID";
                    "Strategy ID" := StrategySub_ActivityEntry."Strategy ID";
                end;
            end;
        }
        field(6; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(7; "Entry Description"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Planned,Actual';
            OptionMembers = Planned,Actual;
        }
        field(9; "Year Reporting Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Reporting Codes".Code;
        }
        field(10; "Quarter Reporting Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Quarterly Reporting Periods" where("Year Code" = field("Year Reporting Code"));
        }
        field(11; "Planning Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Primary Department"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        //field(13; "Primary Division"; Code[100])
        //{
        //DataClassification = ToBeClassified;
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        //}
        field(14; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Cost Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "External Document No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Strategic Plan,Perfomance Contract';
            OptionMembers = "Strategic Plan","Perfomance Contract";
        }
        field(18; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(19; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Plog,Appraisal';
            OptionMembers = Plog,Appraisal;
        }
        field(21; "User ID"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Region Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Performance Contract ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Annual Workplan"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Board PC ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "CEO PC ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Functional PC ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Unit of Measure"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(29; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Reversed Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "CEOs PC ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"),
                                                                   "Score Card Type" = filter(Departmental | CEOs),
                                                                   "Approval Status" = const(Released));
        }
        field(33; "Department/Center PC ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Contract Header".No where("Document Type" = const("Staff Performance Contract"),
                                                                   "Score Card Type" = const(Departmental));
        }
        field(34; "Sub Initiative No."; Code[255])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Strategic Plan ID", "Entry No", "Sub Initiative No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        StrategicInitiative: Record "Strategic Initiative";
        StrategySub_ActivityEntry: Record "Strategy Sub_Activity Entry";
}

