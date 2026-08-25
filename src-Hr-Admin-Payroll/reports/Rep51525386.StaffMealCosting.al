report 51525386 "Staff Meal Costing"
{
    Caption = 'Staff Meal Costing';
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep51525386.StaffMealCosting.rdlc';

    dataset
    {
        dataitem(Meals; Item)
        {
            RequestFilterFields = "No.";

            column(ReportTitle; ReportTitle)
            {
            }
            column(MonthLabel; MonthLabel)
            {
            }
            column(MealCode_Meals; "No.")
            {
            }
            column(Description_Meals; Description)
            {
            }
            column(UnitPrice_Meals; "Unit Price")
            {
            }
            column(BaseUnitofMeasure_Meals; "Base Unit of Measure")
            {
            }

            dataitem(Days; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 .. 31));

                column(DayNo_Days; DayNo)
                {
                }
                column(DayDate_Days; CurrentDayDate)
                {
                }
                column(DayCaption_Days; CurrentDayCaption)
                {
                }
                column(Qty_Days; QtyValue)
                {
                }
                column(Amt_Days; AmtValue)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DayNo := Days.Number;
                    CurrentDayDate := MonthStartDate + (DayNo - 1);

                    if CurrentDayDate > MonthEndDate then
                        CurrReport.Skip();

                    CurrentDayCaption := UpperCase(Format(CurrentDayDate, 0, '<Weekday Text,3>')) + ' ' + Format(CurrentDayDate, 0, '<Day,2>');
                    QtyValue := GetTotal(TotalsByItemDateQty, BuildKey(Meals."No.", CurrentDayDate));
                    AmtValue := GetTotal(TotalsByItemDateAmt, BuildKey(Meals."No.", CurrentDayDate));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if not ItemHasTransactions(Meals."No.") then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                BuildDateFilteredTotals();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ReportMonthDateField; ReportMonthDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Date';
                    }
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
        RequisitionHeader: Record "Meal Requisition Header";
        Line: Record "Meal Requisition Line";
        TotalsByItemDateQty: Dictionary of [Text, Decimal];
        TotalsByItemDateAmt: Dictionary of [Text, Decimal];
        MealCodesWithTransactions: Dictionary of [Code[20], Boolean];
        ReportMonthDate: Date;
        MonthStartDate: Date;
        MonthEndDate: Date;
        ReportTitle: Text[250];
        MonthLabel: Text[100];
        DayNo: Integer;
        CurrentDayDate: Date;
        CurrentDayCaption: Text[20];
        QtyValue: Decimal;
        AmtValue: Decimal;

    trigger OnInitReport()
    begin
        if ReportMonthDate = 0D then
            ReportMonthDate := Today();
    end;

    trigger OnPreReport()
    begin
        ValidateDate();
        SetMonthRangeFromDate();

        ReportTitle := UpperCase(StrSubstNo('Staff Meals Costing for %1', Format(ReportMonthDate, 0, '<Month Text> <Year4>')));
        MonthLabel := Format(ReportMonthDate, 0, '<Month Text> <Year4>');
    end;

    local procedure BuildDateFilteredTotals()
    var
        RunningQty: Decimal;
        RunningAmt: Decimal;
        KeyText: Text;
    begin
        Clear(TotalsByItemDateQty);
        Clear(TotalsByItemDateAmt);
        Clear(MealCodesWithTransactions);

        RequisitionHeader.Reset();
        RequisitionHeader.SetRange("Request Date", MonthStartDate, MonthEndDate);

        if RequisitionHeader.FindSet() then
            repeat
                Line.Reset();
                Line.SetRange("Requisition No", RequisitionHeader."Requisition No");
                if Line.FindSet() then
                    repeat
                        KeyText := BuildKey(Line."Meal Code", RequisitionHeader."Request Date");

                        RunningQty := GetTotal(TotalsByItemDateQty, KeyText) + Line.Quantity;
                        TotalsByItemDateQty.Set(KeyText, RunningQty);

                        RunningAmt := GetTotal(TotalsByItemDateAmt, KeyText) + Line.Amount;
                        TotalsByItemDateAmt.Set(KeyText, RunningAmt);

                        if not MealCodesWithTransactions.ContainsKey(Line."Meal Code") then
                            MealCodesWithTransactions.Add(Line."Meal Code", true);
                    until Line.Next() = 0;
            until RequisitionHeader.Next() = 0;
    end;

    local procedure ValidateDate()
    begin
        if ReportMonthDate = 0D then
            Error('Date is required.');
    end;

    local procedure SetMonthRangeFromDate()
    begin
        MonthStartDate := DMY2Date(1, Date2DMY(ReportMonthDate, 2), Date2DMY(ReportMonthDate, 3));
        MonthEndDate := CalcDate('<CM>', MonthStartDate);
    end;

    local procedure BuildKey(MealCode: Code[20]; EntryDate: Date): Text
    begin
        exit(Format(MealCode) + '|' + Format(EntryDate, 0, '<Year4><Month,2><Day,2>'));
    end;

    local procedure GetTotal(var AmountDictionary: Dictionary of [Text, Decimal]; KeyText: Text): Decimal
    var
        Value: Decimal;
    begin
        if AmountDictionary.Get(KeyText, Value) then
            exit(Value);

        exit(0);
    end;

    local procedure ItemHasTransactions(MealCode: Code[20]): Boolean
    var
        HasRows: Boolean;
    begin
        if MealCodesWithTransactions.Get(MealCode, HasRows) then
            exit(HasRows);

        exit(false);
    end;
}
