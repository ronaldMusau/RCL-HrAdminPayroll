codeunit 51525318 "Training Expiry Notifications"
{
    trigger OnRun()
    begin
        SendExpiryNotifications();
    end;

    procedure SendExpiryNotifications()
    var
        TrainingSchedLine: Record "Training Schedule Lines";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        HREmployee: Record Employee;
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        NotifyDate: Date;
        HREmail: Text;
        EmpEmail: Text;
        Subject: Text;
        Body: Text;
    begin
        // Get HR email from HR Setup
        HREmail := '';
        if HRSetup.Get() then begin
            if HRSetup."HR Head" <> '' then begin
            if HREmployee.Get(HRSetup."HR Head") then
                HREmail := HREmployee."Company E-Mail";
        end;
        end;

        // Loop through all schedule lines with a certificate expiry date
        TrainingSchedLine.Reset();
        TrainingSchedLine.SetFilter("Certificate Expiry Date", '>%1', 0D);
        TrainingSchedLine.SetRange("Notification Sent", false);
        if TrainingSchedLine.FindSet() then
            repeat
                // Check if today is within Notification Days of expiry
                if TrainingSchedLine."Notification Days" > 0 then
                    NotifyDate := CalcDate('-' + Format(TrainingSchedLine."Notification Days") + 'D',
                                          TrainingSchedLine."Certificate Expiry Date")
                else
                    NotifyDate := CalcDate('-30D', TrainingSchedLine."Certificate Expiry Date");

                if Today >= NotifyDate then begin
                    // Get employee email
                    EmpEmail := '';
                    if Employee.Get(TrainingSchedLine."Emp No.") then
                        EmpEmail := Employee."Company E-Mail";

                    Subject := 'Training Certificate Expiry Reminder - ' +
                               TrainingSchedLine."Training Title" + ' - ' +
                               TrainingSchedLine."Employee Name";

                    Body := 'Dear ' + TrainingSchedLine."Employee Name" + ',' + '<br/><br/>' +
                            'This is a reminder that your training certificate for <b>' +
                            TrainingSchedLine."Training Title" + '</b>';

                    if TrainingSchedLine."Permit Type" <> TrainingSchedLine."Permit Type"::" " then
                        Body := Body + ' (' + Format(TrainingSchedLine."Permit Type") + ')';

                    Body := Body + ' is due for renewal on <b>' +
                            Format(TrainingSchedLine."Certificate Expiry Date", 0, '<Day,2>/<Month,2>/<Year4>') +
                            '</b>.<br/><br/>' +
                            'Please take the necessary steps to renew before the expiry date.<br/><br/>' +
                            'Regards,<br/>HR Department';

                    // Send to employee
                    if EmpEmail <> '' then begin
                        EmailMsg.Create(EmpEmail, Subject, Body, true);
                        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then;
                    end;

                    // Send to HR
                    if HREmail <> '' then begin
                        EmailMsg.Create(HREmail, Subject, Body, true);
                        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then;
                    end;

                    // Mark as notified
                    TrainingSchedLine."Notification Sent" := true;
                    TrainingSchedLine.Modify();
                end;
            until TrainingSchedLine.Next() = 0;
    end;
}


