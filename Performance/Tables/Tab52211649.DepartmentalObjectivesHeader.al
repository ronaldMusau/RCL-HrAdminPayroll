table 52211740 "Departmental Objectives Header"
{
    Caption = 'Departmental Objectives Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[50])
        {
            Caption = 'Document No.';
        }
        field(2; Description; Text[600])
        {
            Caption = 'Description';
        }
        field(3; "Year Reporting Code"; Code[50])
        {
            Caption = 'Year Reporting Code';
            TableRelation = "Annual Reporting Codes".Code where("Current Year" = const(true));

            trigger OnValidate()
            begin
                if AnnualReportingCodes.Get("Year Reporting Code") then begin
                    "Start Date" := AnnualReportingCodes."Reporting Start Date";
                    "End Date" := AnnualReportingCodes."Reporting End Date";
                end;
            end;
        }
        //field(4; "Primary Directorate"; Code[50])
        //{
        //    Caption = 'Primary Directorate';
        //    TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Directorate));
        //}
        field(5; "Primary Department"; Code[50])
        {
            Caption = 'Primary Department';
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
            Editable = false;
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
            Editable = false;
        }
        field(8; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            OptionMembers = Open,Approved,"Pending Approval",Rejected,"Closed";
        }
        field(9; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(10; "Last Modified Date"; Date)
        {
            Caption = 'Last Modified Date';
            Editable = false;
        }
        field(11; "Last Modified DateTime"; DateTime)
        {
            Caption = 'Last Modified DateTime';
            Editable = false;
        }
        field(12; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(13; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
        }
        field(14; "Appraisal Period"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Periods";
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        SetModified();
    end;

    trigger OnRename()
    begin
        SetModified();
    end;

    trigger OnModify()
    begin
        SetModified();
    end;

    var
        AnnualReportingCodes: Record "Annual Reporting Codes";

    local procedure SetModified()
    begin
        Rec."Last Modified Date" := Today;
        Rec."Last Modified DateTime" := CurrentDateTime;
    end;
}