table 51525527 "Appraisal Periods"
{
    //DrillDownPageID = "GS Transport Request List";
    //LookupPageID = "GS Transport Request List";

    fields
    {
        field(1; Period; Code[30])
        {
            NotBlank = true;
        }
        field(2; Comments; Text[250])
        {
        }
        field(3; "Start Date"; Date)
        {
        }
        field(4; "End Date"; Date)
        {
        }
        field(5; "Current Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Financial Year"; Code[100])
        {

        }
        field(7; "Strategic Plan"; Code[100])
        {

        }
    }

    keys
    {
        key(Key1; Period)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Period, "Start Date", "End Date")
        {
        }
    }
}