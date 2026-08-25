report 51525383 "Shift Roster"
{
    ApplicationArea = All;
    Caption = 'Shift Roster';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep51525383.ShiftRoster.rdlc';
    dataset
    {
        dataitem(ShiftHeader; "Shift Header")
        {
            RequestFilterFields = "No.";
            column(Department; Department)
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(No; "No.")
            {
            }
            column(ShiftDepartment; "Shift Department")
            {
            }
            column(ShiftEndDate; "Shift End Date")
            {
            }
            column(ShiftStartDate; "Shift Start Date")
            {
            }
            column(SupervisorUserID; "Supervisor User ID")
            {
            }
            dataitem(Shift; Integer)
            {
                column(RowNo; Number)
                {
                }
                column(EmployeeName; ShiftDetails[Number, 1])
                {
                }
                column(PublicHoliday; ShiftDetails[Number, 2])
                {
                }
                column(Monday; ShiftDetails[Number, 3])
                {
                }
                column(Tuesday; ShiftDetails[Number, 4])
                {
                }
                column(Wednesday; ShiftDetails[Number, 5])
                {
                }
                column(Thursday; ShiftDetails[Number, 6])
                {
                }
                column(Friday; ShiftDetails[Number, 7])
                {
                }
                column(Saturday; ShiftDetails[Number, 8])
                {
                }
                column(Sunday; ShiftDetails[Number, 9])
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, EmployeeCounter);
                end;
            }
            trigger OnAfterGetRecord()
            var
                i: Integer;
                CurrentEmployeeNo: Code[20];
            begin
                Clear(EmployeeNos);
                EmployeeCounter := 0;
                ShiftLineRec.Reset();
                ShiftLineRec.SetRange("Shift No.", ShiftHeader."No.");
                if ShiftLineRec.FindSet() then
                    repeat
                        if not EmployeeNos.Contains(ShiftLineRec."Employee No.") then begin
                            EmployeeNos.Add(ShiftLineRec."Employee No.");
                        end;
                    until ShiftLineRec.Next() = 0;
                EmployeeCounter := EmployeeNos.Count();
                // Populate ShiftDetails array with Employee Names and Shift Types
                for i := 1 to EmployeeNos.Count() do begin
                    CurrentEmployeeNo := EmployeeNos.Get(i);
                    if EmployeeRec.Get(CurrentEmployeeNo) then
                        ShiftDetails[i, 1] := EmployeeRec."First Name"
                    else
                        ShiftDetails[i, 1] := '';

                    // Initialize Public Holiday count
                    ShiftDetails[i, 2] := '0';

                    // Initialize all days with "OFF"
                    for DayColumn := 3 to 9 do
                        ShiftDetails[i, DayColumn] := 'OFF';

                    // Get all shift lines for this employee and place by day of week
                    PHCount := 0;
                    ShiftLineRec.Reset();
                    ShiftLineRec.SetRange("Shift No.", ShiftHeader."No.");
                    ShiftLineRec.SetRange("Employee No.", CurrentEmployeeNo);
                    if ShiftLineRec.FindSet() then begin
                        repeat
                            // Count public holidays
                            if ShiftLineRec."Is Public Holiday" then
                                PHCount += 1;

                            DayOfWeek := Date2DWY(ShiftLineRec."Shift Date", 1);
                            // DayOfWeek: 1=Monday, 2=Tuesday, ..., 7=Sunday
                            // Map to columns 3-9 (col 1=name, col 2=PH)
                            DayColumn := DayOfWeek + 2;
                            if (DayColumn >= 3) and (DayColumn <= 9) then begin
                                // Store description from Shift Setup which contains the shift type and time info
                                if ShiftSetupRec.Get(ShiftLineRec."Shift Type") then
                                    ShiftDetails[i, DayColumn] := ShiftSetupRec.Description
                                else
                                    ShiftDetails[i, DayColumn] := ShiftLineRec."Shift Type";
                            end;
                        until ShiftLineRec.Next() = 0;
                    end;

                    // Store Public Holiday count
                    ShiftDetails[i, 2] := Format(PHCount);

                end;

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        EmployeeCounter: Integer;
        EmployeeNos: List of [Code[20]];
        ShiftLineRec: Record "Shift Line";
        ShiftDetails: array[10000, 9] of Text[100];
        EmployeeRec: Record Employee;
        DayOfWeek: Integer;
        DayColumn: Integer;
        ShiftSetupRec: Record "Shift Setup";
        PHCount: Integer;



    trigger OnPreReport()
    begin

    end;
}
