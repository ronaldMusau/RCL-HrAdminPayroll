#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211706 "Performance Diary Entry"
{

    fields
    {
        field(1; "Line Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Performance Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Positive Performance,Negative Performance';
            OptionMembers = "Positive Performance","Negative Performance";
        }
        field(5; "Diary Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Self-Log,Supervisor-Log';
            OptionMembers = "Self-Log","Supervisor-Log";
        }
        field(6; Description; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Personal Scorecard ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Goal ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Objective ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Disciplinary Case ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Primary Department"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        //field(12; "Primary Division"; Code[100])
        //{
        //DataClassification = ToBeClassified;
        //TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        //}
        field(13; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line Number", "Employee No", "Posting Date", "Personal Scorecard ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

