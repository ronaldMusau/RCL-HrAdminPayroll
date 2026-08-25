codeunit 51525322 "Medical Expiry Notifications"
{
    trigger OnRun()
    var
        MedicalHistory: Record "Medical History";
        Employee: Record Employee;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        ToList: List of [Text];
        Subject: Text[250];
        Body: Text;
    begin
        MedicalHistory.Reset();
        MedicalHistory.SetRange(Notified, false);
        if MedicalHistory.FindSet(true) then
            repeat
                if (MedicalHistory."Expiry Date" <> 0D) and
                   (MedicalHistory."Expiry Date" <= Today + MedicalHistory."Notification Days") then begin
                    if Employee.Get(MedicalHistory."Employee No") then
                        if Employee."Company E-Mail" <> '' then begin
                            Clear(ToList);
                            ToList.Add(Employee."Company E-Mail");
                            Subject := CopyStr(
                                'Medical Certificate Expiry: ' + MedicalHistory."Certificate Type",
                                1, 250);
                            Body := 'Dear ' + Employee."First Name" + ',<br/>' +
                                    'Your medical certificate <b>' + MedicalHistory."Certificate No." +
                                    '</b> (' + MedicalHistory."Certificate Type" + ') expires on ' +
                                    Format(MedicalHistory."Expiry Date") + '.<br/>' +
                                    'Please arrange for renewal.';
                            EmailMessage.Create(ToList, Subject, Body, true);
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                        end;
                    MedicalHistory.Notified := true;
                    MedicalHistory.Modify(true);
                end;
            until MedicalHistory.Next() = 0;
    end;
}
