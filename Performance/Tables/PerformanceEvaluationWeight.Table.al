#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211684 "Performance Evaluation Weight"
{

    fields
    {
        field(1; "Per_Evaluation Template ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance Evaluation Template".Code;
        }
        field(2; "Key Evaluation Section"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Objectives & Outcomes,Competency & Company Values';
            OptionMembers = " ","Objectives & Outcomes","Competency & Company Values";
        }
        field(3; "Total Weight (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Per_Evaluation Template ID", "Key Evaluation Section")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

