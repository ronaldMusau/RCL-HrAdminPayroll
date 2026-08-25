table 51525559 "Shift Header"
{

    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20]) { Editable = false; }
        field(2; "Shift Start Date"; Date)
        {
            trigger OnValidate()
            begin
                "Week No." := Date2DWY(Rec."Shift Start Date", 2);
                "Year" := Date2DWY(Rec."Shift Start Date", 3);
            end;
        }
        field(10; "Shift End Date"; Date) { }
        field(3; "Shift Type"; Enum "Shift Type") { }
        field(4; "Supervisor User ID"; Code[50]) { }
        field(5; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Rejected,Released';
            OptionMembers = Open,"Pending Approval",Rejected,Released;
            trigger OnValidate()
            var
                ShiftLine: Record "Shift Line";
                Employee: Record Employee;
                TempBlob: Codeunit "Temp Blob";
                EmailMessage: Codeunit "Email Message";
                Email: Codeunit Email;
                RecRef: RecordRef;
                OutStr: OutStream;
                InStr: InStream;
                Recipients: Text;
                Subject: Text;
                Body: Text;
                AttachmentName: Text;
                EmployeeList: List of [Code[20]];
                EmployeeNo: Code[20];
            begin
                if "Approval Status" = "Approval Status"::Released then begin
                    // Get unique list of employees from shift lines
                    ShiftLine.Reset();
                    ShiftLine.SetRange("Shift No.", "No.");
                    if ShiftLine.FindSet() then begin
                        repeat
                            if not EmployeeList.Contains(ShiftLine."Employee No.") then
                                EmployeeList.Add(ShiftLine."Employee No.");
                        until ShiftLine.Next() = 0;
                    end;

                    // Generate the shift roster report as PDF
                    if EmployeeList.Count() > 0 then begin
                        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                        RecRef.GetTable(Rec);
                        Rec.SetRange("No.", Rec."No.");
                        Report.SaveAs(Report::"Shift Roster", '', ReportFormat::Pdf, OutStr, RecRef);
                        TempBlob.CreateInStream(InStr);

                        // Send email to each employee
                        foreach EmployeeNo in EmployeeList do begin
                            if Employee.Get(EmployeeNo) then begin
                                if Employee."Company E-Mail" <> '' then begin
                                    Clear(EmailMessage);

                                    Recipients := Employee."Company E-Mail";
                                    Subject := StrSubstNo('Shift Roster - %1 to %2', "Shift Start Date", "Shift End Date");
                                    Body := StrSubstNo('Dear %1,<br><br>Please find attached your approved shift roster for the period %2 to %3.<br><br>Kind Regards,<br>HR Department',
                                        Employee."First Name",
                                        "Shift Start Date",
                                        "Shift End Date");
                                    AttachmentName := StrSubstNo('Shift_Roster_%1.pdf', "No.");

                                    EmailMessage.Create(Recipients, Subject, Body, true);

                                    // Reset the stream for each email
                                    TempBlob.CreateInStream(InStr);
                                    EmailMessage.AddAttachment(AttachmentName, 'application/pdf', InStr);

                                    if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                                        Message('Shift roster sent successfully to %1', Employee."Full Name")
                                    else
                                        Message('Failed to send shift roster to %1', Employee."Full Name");
                                end else
                                    Message('Employee %1 does not have an email address', Employee."Full Name");
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(6; Posted; Boolean) { }
        field(7; "Document Date"; Date)
        {

        }
        field(8; "Created by"; Text[100])
        {
            Editable = false;

        }
        field(9; Department; code[200])
        {
            Editable = false;

        }
        field(11; "Shift Department"; Code[100])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(12; "Week No."; Integer) { }
        field(13; "Year"; Integer) { }


    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    trigger OnInsert()
    var
        empl: Record Employee;
    begin
        if "No." = '' then
            HumanResSetup.Get;
        HumanResSetup.TestField("Shift Nos");
        "No." := NoSeriesMgmt.GetNextNo(HumanResSetup."Shift Nos");


        "Supervisor User ID" := UserId;
        "Approval Status" := "Approval Status"::Open;

        empl.Reset();
        empl.SetRange("User ID", UserId);
        if (empl.FindFirst) then begin
            //"Requestor User ID" := empl."No.";
            "Department" := empl."Responsibility Center";
            "Created by" := empl."First Name" + empl."Middle Name" + empl."Last Name";
        end;

        if "Shift Start Date" <> 0D then begin
            "Week No." := Date2DWY("Shift Start Date", 2);
            "Year" := Date2DWY("Shift Start Date", 3);
        end;
    end;


    var
        NoSeriesMgmt: Codeunit "No. Series";
        HumanResSetup: Record "Human Resources Setup";
}
