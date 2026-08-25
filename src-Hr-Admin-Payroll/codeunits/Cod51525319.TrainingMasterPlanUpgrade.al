codeunit 51525319 "Training Master Plan Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerDatabase()
    begin
    end;

    trigger OnUpgradePerCompany()
    begin
        // Upgrade logic removed - no longer needed
    end;
}
