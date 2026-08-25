#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211719 "CSP Planned Years"
{

    fields
    {
        field(1; "CSP Code"; Code[30])
        {

        }
        field(2; "Annual Year Code"; Code[50])
        {

            TableRelation = "Annual Reporting Codes".Code;
        }
        field(3; "Year Order"; Integer)
        {
            Caption = 'Order';
            trigger OnValidate()
            var
                PlannedYears: Record "CSP Planned Years";
            begin
                PlannedYears.Reset();
                PlannedYears.SetRange("CSP Code", Rec."CSP Code");
                PlannedYears.SetRange("Year Order", Rec."Year Order");
                if PlannedYears.FindFirst() then
                    Error('Order already applied to %1', PlannedYears."Annual Year Code");
            end;
        }
        field(4; "Current Plan Year"; boolean)
        {

        }
    }

    keys
    {
        key(Key1; "CSP Code", "Annual Year Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

