#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211717 "Strategic Int Planning Lines"
{
    DrillDownPageID = "Strategic Int Planning Lines";
    LookupPageID = "Strategic Int Planning Lines";

    fields
    {
        field(1; "Strategic Plan ID"; Code[50])
        {

            TableRelation = "Corporate Strategic Plans".Code;
        }
        field(2; "Theme ID"; Code[50])
        {

            TableRelation = "Strategic Theme"."Theme ID" where("Strategic Plan ID" = field("Strategic Plan ID"));
        }
        field(3; "Objective ID"; Code[50])
        {

            TableRelation = "Strategic Objective"."Objective ID" where("Theme ID" = field("Theme ID"),
                                                                        "Strategic Plan ID" = field("Strategic Plan ID"));
        }
        field(4; "Strategy ID"; Code[50])
        {

            TableRelation = Strategy."Strategy ID" where("Objective ID" = field("Objective ID"),
                                                          "Theme ID" = field("Theme ID"),
                                                          "Objective ID" = field("Objective ID"),
                                                          "Strategic Plan ID" = field("Strategic Plan ID"));
        }
        field(5; "Code"; Code[50])
        {

        }
        field(18; "Annual Reporting Codes"; Code[30])
        {

            TableRelation = "CSP Planned Years"."Annual Year Code" where("CSP Code" = field("Strategic Plan ID"));
            trigger OnValidate()
            var
                Years: Record "CSP Planned Years";
            begin
                Years.Reset();
                Years.SetRange("CSP Code", Rec."Strategic Plan ID");
                Years.SetRange("Annual Year Code", Rec."Annual Reporting Codes");
                if Years.FindFirst() then begin
                    Years.TestField("Year Order");
                    Order := Years."Year Order";
                end;
            end;
        }
        field(19; "Target Qty"; Decimal)
        {

        }
        field(20; "Target Budget"; Decimal)
        {

        }
        field(21; "Primary Department"; Code[50])
        {

            // TableRelation = "Responsibility Center" where ("Operating Unit Type"=const(Directorate));
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        field(22; Description; Text[255])
        {

        }
        //field(23; "Primary Division"; Code[50])
        //{
        //
        //// TableRelation = "Responsibility Center" where ("Direct Reports To"=field("Primary Directorate"));
        //TableRelation = "Responsibility Center";
        //}
        field(24; Order; Integer)
        {

        }
    }

    keys
    {
        key(Key1; "Strategic Plan ID", "Theme ID", "Objective ID", "Strategy ID", "Code", "Primary Department", "Annual Reporting Codes")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

