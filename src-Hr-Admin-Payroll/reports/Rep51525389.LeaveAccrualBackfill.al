report 51525389 "Leave Accrual Backfill"
{
    ApplicationArea = All;
    Caption = 'Leave Accrual Backfill';
    UsageCategory = Administration;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemInteger; Integer)
        {
            DataItemTableView = where(Number = const(1));

            trigger OnPreDataItem()
            var
                AccrueLeave: Codeunit "Accrue Leave Monthly";
            begin
                if PostingDateField = 0D then
                    Error('Please enter a posting date.');
                AccrueLeave.RunForDate(PostingDateField);
                CurrReport.Break();
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
                    field(PostingDateField; PostingDateField)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                        ToolTip = 'Enter any date in the month to accrue (e.g. 04/15/2026 for April)';
                    }
                }
            }
        }
    }

    var
        PostingDateField: Date;
}
