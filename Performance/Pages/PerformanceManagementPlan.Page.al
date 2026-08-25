#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211825 "Performance Management Plan"
{
    PageType = Card;
    SourceTable = "Performance Management Plan";

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
                field(Description; Rec.Description)
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
                field("Evaluation Type"; Rec."Evaluation Type")
                {
                    ApplicationArea = Basic;
                }
                field("HR Performance Template"; Rec."HR Performance Template")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Contract  Template"; Rec."Performance Contract  Template")
                {
                    ApplicationArea = Basic;
                }
                field("Executive Summary"; Rec."Executive Summary")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control13; "Performance Plan Tasks")
            {
                SubPageLink = "Performance Mgt Plan ID" = field(No);
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Performance Appraisals")
            {
                ApplicationArea = Basic;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Standard Perfomance Appraisal";
                RunPageLink = "Performance Mgt Plan ID" = field(No),
                              "Document Type" = const("Performance Appraisal");
            }
            action("Performance Appeals")
            {
                ApplicationArea = Basic;
                Image = AddContacts;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Standard Perfomance Appraisal";
                RunPageLink = "Performance Mgt Plan ID" = field(No),
                              "Document Type" = const("Performance Appeal");
            }
            action(PIPs)
            {
                ApplicationArea = Basic;
                Image = Addresses;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Performance Improvement Plans";
            }
            action("Performance Mgmt Policies")
            {
                ApplicationArea = Basic;
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Performance Plan Guidelines";
                RunPageLink = "Performance Mgt Plan ID" = field(No);
            }
            action("Review Periods")
            {
                ApplicationArea = Basic;
                Image = Replan;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Review Periods";
            }
        }
    }
}

