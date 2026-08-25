report 51525388 "Leave Accrual"
{
    ApplicationArea = All;
    Caption = 'Leave Accrual';
    UsageCategory = Administration;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = const(1));

            trigger OnPreDataItem()
            begin
                if Codeunit.Run(Codeunit::"Accrue Leave Monthly") then //surpress errors
                    CurrReport.Break(); //job done
                CurrReport.Break(); //either way
            end;
        }
    }
}
