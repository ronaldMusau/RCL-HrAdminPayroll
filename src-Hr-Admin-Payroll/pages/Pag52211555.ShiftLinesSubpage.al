page 52211555 "Shift Lines Subpage"

{
    PageType = ListPart;
    SourceTable = "Shift Line";
    ApplicationArea = All;
    Caption = 'Shift Employees';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.") { }
                field("Employee Name"; Rec."Employee Name") { }

                // Monday
                field("Mon Shift"; Rec."Mon Shift") { }
                field("Mon Start Time"; Rec."Mon Start Time") { }
                field("Mon End Time"; Rec."Mon End Time") { }

                // Tuesday
                field("Tue Shift"; Rec."Tue Shift") { }
                field("Tue Start Time"; Rec."Tue Start Time") { }
                field("Tue End Time"; Rec."Tue End Time") { }

                // Wednesday
                field("Wed Shift"; Rec."Wed Shift") { }
                field("Wed Start Time"; Rec."Wed Start Time") { }
                field("Wed End Time"; Rec."Wed End Time") { }

                // Thursday
                field("Thu Shift"; Rec."Thu Shift") { }
                field("Thu Start Time"; Rec."Thu Start Time") { }
                field("Thu End Time"; Rec."Thu End Time") { }

                // Friday
                field("Fri Shift"; Rec."Fri Shift") { }
                field("Fri Start Time"; Rec."Fri Start Time") { }
                field("Fri End Time"; Rec."Fri End Time") { }

                // Saturday
                field("Sat Shift"; Rec."Sat Shift") { }
                field("Sat Start Time"; Rec."Sat Start Time") { }
                field("Sat End Time"; Rec."Sat End Time") { }

                // Sunday
                field("Sun Shift"; Rec."Sun Shift") { }
                field("Sun Start Time"; Rec."Sun Start Time") { }
                field("Sun End Time"; Rec."Sun End Time") { }
                // field("Employee No."; Rec."Employee No.")
                // {
                //     ApplicationArea = All;
                // }
                // field("Employee Name"; Rec."Employee Name")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Shift Type"; Rec."Shift Type")
                // {
                //     ApplicationArea = All;
                // }
                // field("Meal Order"; Rec."Meal Order")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Meal Order Description"; Rec."Meal Order Description")
                // {
                //     Visible = false;

                // }
                // field("Task Assigned"; Rec."Task Assigned")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Shift Date"; Rec."Shift Date")
                // {
                //     ToolTip = 'Specifies the value of the Shift Date field.', Comment = '%';
                // }
                // field("Shift Start Time"; Rec."Shift Start Time")
                // {

                // }
                // field("Shift End Time"; Rec."Shift End Time")
                // {

                // }

                // field("Is Public Holiday"; Rec."Is Public Holiday")
                // {
                //     ApplicationArea = All;
                //     Editable = true;
                // }
                // field("Leave Allocated"; Rec."Leave Allocated")
                // {
                //     ApplicationArea = All;
                //     Editable = true;
                // }
            }
        }
    }
}
