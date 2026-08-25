#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211734 "Workplan Expenditure Entry"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Workplan No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Initiative No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Sub Initiative No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Expenditure Document No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Expenditure Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Expenditure Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        //field(8; "Primary Directorate"; Code[100])
        //{
        //    DataClassification = ToBeClassified;
        //    TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Directorate));
        //}
        field(9; "Primary Department"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        field(10; Job; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
        }
        field(11; "Job Task No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field(Job));

            trigger OnValidate()
            begin
                /*TaskRec.RESET;
                TaskRec.SETRANGE("Job No.",Job);
                TaskRec.SETRANGE("Job Task No.","Job Task No");
                IF TaskRec.FIND('-') THEN BEGIN
                  TaskRec.CALCFIELDS("Schedule (Total Cost)","Remaining (Total Cost)","Usage (Total Cost)",TaskRec.Commitments);
                  "Job Task Name":=TaskRec.Description;
                  "Job Task Budget":=TaskRec."Schedule (Total Cost)";
                  "Job Task Remaining Amount":=TaskRec."Schedule (Total Cost)"-(TaskRec."Usage (Total Cost)"+TaskRec.Commitments);
                END;*/

            end;
        }
        field(12; "Expenditure Posting Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Expenditure Posting By"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "CSP No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

