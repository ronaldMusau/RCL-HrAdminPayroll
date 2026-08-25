report 51525387 "Monthly Meal Variance"
{
    Caption = 'Monthly Meal Variance';
    DefaultLayout = RDLC;
    RDLCLayout = 'src-Hr-Admin-Payroll\reports\Rep51525387.MonthlyMealVariance.rdlc';

    dataset
    {
        dataitem(Lines; Integer)
        {
            DataItemTableView = sorting(Number);

            column(ReportTitle; ReportTitle)
            {
            }
            column(PrevMonthLabel; PrevMonthLabel)
            {
            }
            column(CurrMonthLabel; CurrMonthLabel)
            {
            }
            column(SectionType; SectionType)
            {
            }
            column(LineNo; Lines.Number)
            {
            }
            column(IsYearHeader; IsYearHeader)
            {
            }
            column(IsDetailTotal; IsDetailTotal)
            {
            }
            column(SummaryYear; SummaryYear)
            {
            }
            column(SummaryMonthName; SummaryMonthName)
            {
            }
            column(SummaryAmount; SummaryAmount)
            {
            }
            column(SummaryVariance; SummaryVariance)
            {
            }
            column(DetailLineNo; DetailLineNo)
            {
            }
            column(DetailItemName; DetailItemName)
            {
            }
            column(PrevQty; PrevQty)
            {
            }
            column(PrevAmt; PrevAmt)
            {
            }
            column(CurrQty; CurrQty)
            {
            }
            column(CurrAmt; CurrAmt)
            {
            }
            column(VarQty; VarQty)
            {
            }
            column(VarAmt; VarAmt)
            {
            }

            trigger OnPreDataItem()
            begin
                BuildLines();
                SetRange(Number, 1, TotalLines);
            end;

            trigger OnAfterGetRecord()
            begin
                LoadLine(Lines.Number);
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
    }

    var
        RequisitionHeader: Record "Meal Requisition Header";
        Line: Record "Meal Requisition Line";
        ItemRec: Record Item;

        ReportMonthDate: Date;
        PrevMonthStartDate: Date;
        PrevMonthEndDate: Date;
        CurrMonthStartDate: Date;
        CurrMonthEndDate: Date;
        CurrYear: Integer;
        PrevYear: Integer;

        ReportTitle: Text[100];
        PrevMonthLabel: Text[30];
        CurrMonthLabel: Text[30];

        TotalLines: Integer;

        LineSectionByNo: Dictionary of [Integer, Text];
        LineIsYearHeaderByNo: Dictionary of [Integer, Boolean];
        LineIsDetailTotalByNo: Dictionary of [Integer, Boolean];
        LineSummaryYearByNo: Dictionary of [Integer, Integer];
        LineSummaryMonthByNo: Dictionary of [Integer, Text];
        LineSummaryAmountByNo: Dictionary of [Integer, Decimal];
        LineSummaryVarianceByNo: Dictionary of [Integer, Decimal];
        LineDetailLineNoByNo: Dictionary of [Integer, Integer];
        LineDetailItemNameByNo: Dictionary of [Integer, Text];
        LinePrevQtyByNo: Dictionary of [Integer, Decimal];
        LinePrevAmtByNo: Dictionary of [Integer, Decimal];
        LineCurrQtyByNo: Dictionary of [Integer, Decimal];
        LineCurrAmtByNo: Dictionary of [Integer, Decimal];
        LineVarQtyByNo: Dictionary of [Integer, Decimal];
        LineVarAmtByNo: Dictionary of [Integer, Decimal];

        MonthTotalByKey: Dictionary of [Text, Decimal];
        PrevQtyByItem: Dictionary of [Code[20], Decimal];
        PrevAmtByItem: Dictionary of [Code[20], Decimal];
        CurrQtyByItem: Dictionary of [Code[20], Decimal];
        CurrAmtByItem: Dictionary of [Code[20], Decimal];
        ItemHasActivity: Dictionary of [Code[20], Boolean];

        SectionType: Text[20];
        IsYearHeader: Boolean;
        IsDetailTotal: Boolean;
        SummaryYear: Integer;
        SummaryMonthName: Text[30];
        SummaryAmount: Decimal;
        SummaryVariance: Decimal;
        DetailLineNo: Integer;
        DetailItemName: Text[100];
        PrevQty: Decimal;
        PrevAmt: Decimal;
        CurrQty: Decimal;
        CurrAmt: Decimal;
        VarQty: Decimal;
        VarAmt: Decimal;

    trigger OnInitReport()
    begin
        if ReportMonthDate = 0D then
            ReportMonthDate := Today();
    end;

    local procedure BuildLines()
    var
        MonthNo: Integer;
        AmountValue: Decimal;
        VarianceValue: Decimal;
        DetailSerialNo: Integer;
        ThisPrevQty: Decimal;
        ThisPrevAmt: Decimal;
        ThisCurrQty: Decimal;
        ThisCurrAmt: Decimal;
        TotalPrevQty: Decimal;
        TotalPrevAmt: Decimal;
        TotalCurrQty: Decimal;
        TotalCurrAmt: Decimal;
        TotalVarQty: Decimal;
        TotalVarAmt: Decimal;
    begin
        ValidateDate();
        SetPeriods();
        PrepareLabels();

        ClearLineStores();
        Clear(MonthTotalByKey);
        Clear(PrevQtyByItem);
        Clear(PrevAmtByItem);
        Clear(CurrQtyByItem);
        Clear(CurrAmtByItem);
        Clear(ItemHasActivity);

        BuildMonthlySummaryTotals();
        BuildItemMonthTotals();

        AddSummaryYearHeader(PrevYear);
        for MonthNo := 1 to 12 do begin
            AmountValue := GetMonthTotal(PrevYear, MonthNo);
            if MonthNo = 1 then
                VarianceValue := 0
            else
                VarianceValue := AmountValue - GetMonthTotal(PrevYear, MonthNo - 1);
            AddSummaryMonthLine(PrevYear, MonthNo, AmountValue, VarianceValue);
        end;

        AddSummaryYearHeader(CurrYear);
        for MonthNo := 1 to 12 do begin
            AmountValue := GetMonthTotal(CurrYear, MonthNo);
            if MonthNo = 1 then
                VarianceValue := 0
            else
                VarianceValue := AmountValue - GetMonthTotal(CurrYear, MonthNo - 1);
            AddSummaryMonthLine(CurrYear, MonthNo, AmountValue, VarianceValue);
        end;

        DetailSerialNo := 0;
        ItemRec.Reset();
        ItemRec.SetCurrentKey(Description);
        if ItemRec.FindSet() then
            repeat
                if ItemHasActivity.ContainsKey(ItemRec."No.") then begin
                    ThisPrevQty := GetItemTotal(PrevQtyByItem, ItemRec."No.");
                    ThisPrevAmt := GetItemTotal(PrevAmtByItem, ItemRec."No.");
                    ThisCurrQty := GetItemTotal(CurrQtyByItem, ItemRec."No.");
                    ThisCurrAmt := GetItemTotal(CurrAmtByItem, ItemRec."No.");

                    if (ThisPrevQty <> 0) or (ThisPrevAmt <> 0) or (ThisCurrQty <> 0) or (ThisCurrAmt <> 0) then begin
                        DetailSerialNo += 1;
                        AddDetailLine(
                          DetailSerialNo,
                          ItemRec.Description,
                          ThisPrevQty,
                          ThisPrevAmt,
                          ThisCurrQty,
                          ThisCurrAmt,
                          ThisCurrQty - ThisPrevQty,
                          ThisCurrAmt - ThisPrevAmt,
                          false);

                        TotalPrevQty += ThisPrevQty;
                        TotalPrevAmt += ThisPrevAmt;
                        TotalCurrQty += ThisCurrQty;
                        TotalCurrAmt += ThisCurrAmt;
                    end;
                end;
            until ItemRec.Next() = 0;

        TotalVarQty := TotalCurrQty - TotalPrevQty;
        TotalVarAmt := TotalCurrAmt - TotalPrevAmt;

        AddDetailLine(
          0,
          'Total',
          TotalPrevQty,
          TotalPrevAmt,
          TotalCurrQty,
          TotalCurrAmt,
          TotalVarQty,
          TotalVarAmt,
          true);
    end;

    local procedure LoadLine(LineNo: Integer)
    begin
        ClearLineValues();

        SectionType := GetText(LineSectionByNo, LineNo);
        IsYearHeader := GetBoolean(LineIsYearHeaderByNo, LineNo);
        IsDetailTotal := GetBoolean(LineIsDetailTotalByNo, LineNo);
        SummaryYear := GetInteger(LineSummaryYearByNo, LineNo);
        SummaryMonthName := GetText(LineSummaryMonthByNo, LineNo);
        SummaryAmount := GetDecimal(LineSummaryAmountByNo, LineNo);
        SummaryVariance := GetDecimal(LineSummaryVarianceByNo, LineNo);
        DetailLineNo := GetInteger(LineDetailLineNoByNo, LineNo);
        DetailItemName := GetText(LineDetailItemNameByNo, LineNo);
        PrevQty := GetDecimal(LinePrevQtyByNo, LineNo);
        PrevAmt := GetDecimal(LinePrevAmtByNo, LineNo);
        CurrQty := GetDecimal(LineCurrQtyByNo, LineNo);
        CurrAmt := GetDecimal(LineCurrAmtByNo, LineNo);
        VarQty := GetDecimal(LineVarQtyByNo, LineNo);
        VarAmt := GetDecimal(LineVarAmtByNo, LineNo);
    end;

    local procedure BuildMonthlySummaryTotals()
    var
        YearStartDate: Date;
        YearEndDate: Date;
        KeyText: Text;
        RunningAmount: Decimal;
    begin
        YearStartDate := DMY2Date(1, 1, PrevYear);
        YearEndDate := DMY2Date(31, 12, CurrYear);

        RequisitionHeader.Reset();
        RequisitionHeader.SetRange("Request Date", YearStartDate, YearEndDate);

        if RequisitionHeader.FindSet() then
            repeat
                Line.Reset();
                Line.SetRange("Requisition No", RequisitionHeader."Requisition No");
                if Line.FindSet() then
                    repeat
                        KeyText := BuildMonthKey(Date2DMY(RequisitionHeader."Request Date", 3), Date2DMY(RequisitionHeader."Request Date", 2));
                        RunningAmount := GetMonthTotalByKey(KeyText) + Line.Amount;
                        MonthTotalByKey.Set(KeyText, RunningAmount);
                    until Line.Next() = 0;
            until RequisitionHeader.Next() = 0;
    end;

    local procedure BuildItemMonthTotals()
    var
        IsPrevMonth: Boolean;
        IsCurrMonth: Boolean;
    begin
        RequisitionHeader.Reset();
        RequisitionHeader.SetRange("Request Date", PrevMonthStartDate, CurrMonthEndDate);

        if RequisitionHeader.FindSet() then
            repeat
                IsPrevMonth := IsSameMonth(RequisitionHeader."Request Date", PrevMonthStartDate);
                IsCurrMonth := IsSameMonth(RequisitionHeader."Request Date", CurrMonthStartDate);

                Line.Reset();
                Line.SetRange("Requisition No", RequisitionHeader."Requisition No");
                if Line.FindSet() then
                    repeat
                        if IsPrevMonth then begin
                            PrevQtyByItem.Set(Line."Meal Code", GetItemTotal(PrevQtyByItem, Line."Meal Code") + Line.Quantity);
                            PrevAmtByItem.Set(Line."Meal Code", GetItemTotal(PrevAmtByItem, Line."Meal Code") + Line.Amount);
                            if not ItemHasActivity.ContainsKey(Line."Meal Code") then
                                ItemHasActivity.Add(Line."Meal Code", true);
                        end;

                        if IsCurrMonth then begin
                            CurrQtyByItem.Set(Line."Meal Code", GetItemTotal(CurrQtyByItem, Line."Meal Code") + Line.Quantity);
                            CurrAmtByItem.Set(Line."Meal Code", GetItemTotal(CurrAmtByItem, Line."Meal Code") + Line.Amount);
                            if not ItemHasActivity.ContainsKey(Line."Meal Code") then
                                ItemHasActivity.Add(Line."Meal Code", true);
                        end;
                    until Line.Next() = 0;
            until RequisitionHeader.Next() = 0;
    end;

    local procedure AddSummaryYearHeader(YearValue: Integer)
    begin
        TotalLines += 1;
        SetText(LineSectionByNo, TotalLines, 'SUMMARY');
        SetBoolean(LineIsYearHeaderByNo, TotalLines, true);
        SetInteger(LineSummaryYearByNo, TotalLines, YearValue);
        SetText(LineSummaryMonthByNo, TotalLines, 'Period');
    end;

    local procedure AddSummaryMonthLine(YearValue: Integer; MonthNo: Integer; AmountValue: Decimal; VarianceValue: Decimal)
    begin
        TotalLines += 1;
        SetText(LineSectionByNo, TotalLines, 'SUMMARY');
        SetBoolean(LineIsYearHeaderByNo, TotalLines, false);
        SetInteger(LineSummaryYearByNo, TotalLines, YearValue);
        SetText(LineSummaryMonthByNo, TotalLines, Format(DMY2Date(1, MonthNo, YearValue), 0, '<Month Text>'));
        SetDecimal(LineSummaryAmountByNo, TotalLines, AmountValue);
        SetDecimal(LineSummaryVarianceByNo, TotalLines, VarianceValue);
    end;

    local procedure AddDetailLine(SerialNo: Integer; ItemName: Text; PrevQtyValue: Decimal; PrevAmtValue: Decimal; CurrQtyValue: Decimal; CurrAmtValue: Decimal; VarQtyValue: Decimal; VarAmtValue: Decimal; IsTotal: Boolean)
    begin
        TotalLines += 1;
        SetText(LineSectionByNo, TotalLines, 'DETAIL');
        SetBoolean(LineIsDetailTotalByNo, TotalLines, IsTotal);
        SetInteger(LineDetailLineNoByNo, TotalLines, SerialNo);
        SetText(LineDetailItemNameByNo, TotalLines, ItemName);
        SetDecimal(LinePrevQtyByNo, TotalLines, PrevQtyValue);
        SetDecimal(LinePrevAmtByNo, TotalLines, PrevAmtValue);
        SetDecimal(LineCurrQtyByNo, TotalLines, CurrQtyValue);
        SetDecimal(LineCurrAmtByNo, TotalLines, CurrAmtValue);
        SetDecimal(LineVarQtyByNo, TotalLines, VarQtyValue);
        SetDecimal(LineVarAmtByNo, TotalLines, VarAmtValue);
    end;

    local procedure PrepareLabels()
    begin
        ReportTitle := 'MONTHLY VARIANCE REPORT';
        PrevMonthLabel := Format(PrevMonthStartDate, 0, '<Month Text,3>-<Year,2>');
        CurrMonthLabel := Format(CurrMonthStartDate, 0, '<Month Text,3>-<Year,2>');
    end;

    local procedure SetPeriods()
    begin
        CurrMonthStartDate := DMY2Date(1, Date2DMY(ReportMonthDate, 2), Date2DMY(ReportMonthDate, 3));
        CurrMonthEndDate := CalcDate('<CM>', CurrMonthStartDate);

        PrevMonthEndDate := CurrMonthStartDate - 1;
        PrevMonthStartDate := DMY2Date(1, Date2DMY(PrevMonthEndDate, 2), Date2DMY(PrevMonthEndDate, 3));

        CurrYear := Date2DMY(CurrMonthStartDate, 3);
        PrevYear := CurrYear - 1;
    end;

    local procedure ValidateDate()
    begin
        if ReportMonthDate = 0D then
            Error('Date is required.');
    end;

    local procedure BuildMonthKey(YearNo: Integer; MonthNo: Integer): Text
    begin
        exit(Format(YearNo) + '-' + Format(MonthNo));
    end;

    local procedure GetMonthTotal(YearNo: Integer; MonthNo: Integer): Decimal
    begin
        exit(GetMonthTotalByKey(BuildMonthKey(YearNo, MonthNo)));
    end;

    local procedure GetMonthTotalByKey(KeyText: Text): Decimal
    var
        Value: Decimal;
    begin
        if MonthTotalByKey.Get(KeyText, Value) then
            exit(Value);

        exit(0);
    end;

    local procedure GetItemTotal(var ItemTotals: Dictionary of [Code[20], Decimal]; ItemNo: Code[20]): Decimal
    var
        Value: Decimal;
    begin
        if ItemTotals.Get(ItemNo, Value) then
            exit(Value);

        exit(0);
    end;

    local procedure IsSameMonth(InputDate: Date; ReferenceMonthDate: Date): Boolean
    begin
        exit(
          (Date2DMY(InputDate, 2) = Date2DMY(ReferenceMonthDate, 2)) and
          (Date2DMY(InputDate, 3) = Date2DMY(ReferenceMonthDate, 3)));
    end;

    local procedure ClearLineStores()
    begin
        TotalLines := 0;
        Clear(LineSectionByNo);
        Clear(LineIsYearHeaderByNo);
        Clear(LineIsDetailTotalByNo);
        Clear(LineSummaryYearByNo);
        Clear(LineSummaryMonthByNo);
        Clear(LineSummaryAmountByNo);
        Clear(LineSummaryVarianceByNo);
        Clear(LineDetailLineNoByNo);
        Clear(LineDetailItemNameByNo);
        Clear(LinePrevQtyByNo);
        Clear(LinePrevAmtByNo);
        Clear(LineCurrQtyByNo);
        Clear(LineCurrAmtByNo);
        Clear(LineVarQtyByNo);
        Clear(LineVarAmtByNo);
    end;

    local procedure ClearLineValues()
    begin
        Clear(SectionType);
        Clear(IsYearHeader);
        Clear(IsDetailTotal);
        Clear(SummaryYear);
        Clear(SummaryMonthName);
        Clear(SummaryAmount);
        Clear(SummaryVariance);
        Clear(DetailLineNo);
        Clear(DetailItemName);
        Clear(PrevQty);
        Clear(PrevAmt);
        Clear(CurrQty);
        Clear(CurrAmt);
        Clear(VarQty);
        Clear(VarAmt);
    end;

    local procedure GetText(var DataStore: Dictionary of [Integer, Text]; KeyNo: Integer): Text
    var
        Value: Text;
    begin
        if DataStore.Get(KeyNo, Value) then
            exit(Value);

        exit('');
    end;

    local procedure GetBoolean(var DataStore: Dictionary of [Integer, Boolean]; KeyNo: Integer): Boolean
    var
        Value: Boolean;
    begin
        if DataStore.Get(KeyNo, Value) then
            exit(Value);

        exit(false);
    end;

    local procedure GetInteger(var DataStore: Dictionary of [Integer, Integer]; KeyNo: Integer): Integer
    var
        Value: Integer;
    begin
        if DataStore.Get(KeyNo, Value) then
            exit(Value);

        exit(0);
    end;

    local procedure GetDecimal(var DataStore: Dictionary of [Integer, Decimal]; KeyNo: Integer): Decimal
    var
        Value: Decimal;
    begin
        if DataStore.Get(KeyNo, Value) then
            exit(Value);

        exit(0);
    end;

    local procedure SetText(var DataStore: Dictionary of [Integer, Text]; KeyNo: Integer; Value: Text)
    begin
        if DataStore.ContainsKey(KeyNo) then
            DataStore.Set(KeyNo, Value)
        else
            DataStore.Add(KeyNo, Value);
    end;

    local procedure SetBoolean(var DataStore: Dictionary of [Integer, Boolean]; KeyNo: Integer; Value: Boolean)
    begin
        if DataStore.ContainsKey(KeyNo) then
            DataStore.Set(KeyNo, Value)
        else
            DataStore.Add(KeyNo, Value);
    end;

    local procedure SetInteger(var DataStore: Dictionary of [Integer, Integer]; KeyNo: Integer; Value: Integer)
    begin
        if DataStore.ContainsKey(KeyNo) then
            DataStore.Set(KeyNo, Value)
        else
            DataStore.Add(KeyNo, Value);
    end;

    local procedure SetDecimal(var DataStore: Dictionary of [Integer, Decimal]; KeyNo: Integer; Value: Decimal)
    begin
        if DataStore.ContainsKey(KeyNo) then
            DataStore.Set(KeyNo, Value)
        else
            DataStore.Add(KeyNo, Value);
    end;
}
