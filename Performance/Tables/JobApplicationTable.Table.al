#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211744 "Job Application Table"
{

    fields
    {
        field(1; "Application No"; Code[20])
        {
        }
        field(2; "First Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Middle Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Surname; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Salutation; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Miss,Mrs,Mr,Doctor,Professor;
        }
        field(6; "ID/Passport"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Age; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Female,Male,Unknown;
        }
        field(10; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Married,Divorced;
        }
        field(11; "Ethnic Origin"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Ethnic Origin Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Email; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Home Phone No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Work Phone No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Postal Code."; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Postal Code.", County, "Country Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Postal Code.", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(17; "Postal Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Residential Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; City; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Postal Code.", County, "Country Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Postal Code.", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(20; County; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Country Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Postal Code.", County, "Country Code", xRec."Country Code");
            end;
        }
        field(22; "Country Name"; Text[50])
        {
            CalcFormula = lookup("Country/Region".Name where(Code = field("Country Code")));
            FieldClass = FlowField;
        }
        field(23; Citizenship; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Disabled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Disability Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Disability Grade"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Driving Licence"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Highest academic qualification"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Qualification;
        }
        field(29; "Current Job Position"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Current Duties and Responsibil"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(31; Hobbies; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Vacancy Requisition No."; Code[30])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Vacancy  Requisitions Table";

            // trigger OnValidate()
            // begin
            //     VacancyRequisitionsLines.SetRange("Requisition No.", "Vacancy Requisition No.");
            //     if VacancyRequisitionsLines.FindSet then begin
            //         "Job Applied For" := VacancyRequisitionsLines."Job Description";
            //     end
            // end;
        }
        field(33; Shortlisted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Shortlisted On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Shortlisted By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Shortlisting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Oral,Written,Apptitude;
        }
        field(37; Qualified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Qualified By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Quaified On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,Oral,Written,Apptitude,Closed;
        }
        field(41; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(43; Convicted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Job Applied For"; Text[100])
        {
        }
        field(45; "Job Id"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Application Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Submitted,"In-process",Shortlisted,Interview,Succesful;
        }
        field(47; "Names"; Text[1000])
        {
            DataClassification = ToBeClassified;
            // OptionMembers = Submitted,"In-process",Shortlisted,Interview,Succesful;
        }
    }

    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()

    begin
        //GENERATE DOCUMENT NUMBER
        if "Application No" = '' then begin
            HRSetup.Get;
            //  HRSetup.TestField(HRSetup."Job Application Nos");
            // "Application No" := NoSeriesMgt.GetNextNo(HRSetup."Job Application Nos", 0D, true);
        end;
        "Application Date" := Today;

    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit "No. Series";
        userSetup: Record "User Setup";
        mDivision: Code[50];
        mResponsibility: Code[50];
        // VacancyRequisitionsLines: Record "Vacancy Requisition Lines";
        PostCode: Record "Post Code";
}

