#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211743 "Review Period"
{
    PageType = Card;
    SourceTable = "Review Periods";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Annual Reporting Code"; Rec."Annual Reporting Code")
                {
                    ApplicationArea = Basic;
                }
                field("Review Type"; Rec."Review Type")
                {
                    ApplicationArea = Basic;
                }
                field("No of Quarters"; Rec."No of Quarters")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = Basic;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ApplicationArea = Basic;
                }
                field("Closed Time"; Rec."Closed Time")
                {
                    ApplicationArea = Basic;
                }
                field("Genererated Appraisal"; Rec."Genererated Appraisal")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Quartely Review Periods")
            {
                ApplicationArea = Basic;
                Image = PeriodEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Quartely Review Periods";
                RunPageLink = "Year Code" = field("Annual Reporting Code"),
                              "Review Period Code" = field(Code);
            }
        }
    }
}

