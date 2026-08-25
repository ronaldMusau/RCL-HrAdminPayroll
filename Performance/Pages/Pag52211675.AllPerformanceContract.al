
#pragma implicitwith disable
Page 52211766 "All Performance Contract"
{
    DeleteAllowed = false;
    //  Editable = false;
    //  InsertAllowed = false;
    // ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Perfomance Contract Header";
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Objective Setting Due Date"; Rec."Objective Setting Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Strategy Plan ID"; Rec."Strategy Plan ID")
                {
                    ApplicationArea = Basic;
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Responsible Employee No."; Rec."Responsible Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center Name"; Rec."Responsibility Center Name")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Type"; Rec."Evaluation Type")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field("Blocked?"; Rec."Blocked")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Last Evaluation Date"; Rec."Last Evaluation Date")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Objectives and Intiatives"; "Workplan Initiatives")
            {
                Caption = 'Board PC Activities';
                SubPageLink = "Workplan No." = field(No),
                              "Initiative Type" = const(Board);
                Visible = false;
            }
            part("Core Activities"; "Workplan Initiatives")
            {
                Caption = 'Core Initiatives';
                SubPageLink = "Workplan No." = field(No),
                              "Initiative Type" = filter(Activity | Board);
            }
            part("Added Activities"; "Secondary Workplan Initiatives")
            {
                Caption = 'Additional Initiatives';
                SubPageLink = "Workplan No." = field(No),
                              "Strategy Plan ID" = field("Strategy Plan ID"),
                              "Year Reporting Code" = field("Annual Reporting Code");
            }
            part(Control24; "PC Job Description")
            {
                Caption = 'Job Description';
                SubPageLink = "Workplan No." = field(No);
            }
        }
        area(FactBoxes)
        {
            part("Doc. Attachment List Factbox"; "Doc. Attachment List Factbox")
            {
                Caption = 'Performance Summary';
                SubPageLink = "Table ID" = const(Database::"Perfomance Contract Header"), "No." = field(No);
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

