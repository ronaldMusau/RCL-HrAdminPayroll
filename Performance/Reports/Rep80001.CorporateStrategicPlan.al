
Report 52211643 "Corporate Strategic Plan"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Performance/Layouts/Corporate Strategic Plan.rdl';

    dataset
    {
        dataitem("Corporate Strategic Plans"; "Corporate Strategic Plans")
        {
            RequestFilterFields = "Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_CorporateStrategicPlans; "Corporate Strategic Plans".Code)
            {
            }
            column(Description_CorporateStrategicPlans; "Corporate Strategic Plans".Description)
            {
            }
            column(PrimaryTheme_CorporateStrategicPlans; "Corporate Strategic Plans"."Primary Theme")
            {
            }
            column(StrategyFramework_CorporateStrategicPlans; "Corporate Strategic Plans"."Strategy Framework")
            {
            }
            column(StartDate_CorporateStrategicPlans; "Corporate Strategic Plans"."Start Date")
            {
            }
            column(EndDate_CorporateStrategicPlans; "Corporate Strategic Plans"."End Date")
            {
            }
            column(DurationYears_CorporateStrategicPlans; "Corporate Strategic Plans"."Duration (Years)")
            {
            }
            column(VisionStatement_CorporateStrategicPlans; "Corporate Strategic Plans"."Vision Statement")
            {
            }
            column(MissionStatement_CorporateStrategicPlans; "Corporate Strategic Plans"."Mission Statement")
            {
            }
            column(ImplementationStatus_CorporateStrategicPlans; "Corporate Strategic Plans"."Implementation Status")
            {
            }
            column(ApprovalStatus_CorporateStrategicPlans; "Corporate Strategic Plans"."Approval Status")
            {
            }
            column(NoSeries_CorporateStrategicPlans; "Corporate Strategic Plans"."No. Series")
            {
            }
            column(CreatedBy_CorporateStrategicPlans; "Corporate Strategic Plans"."Created By")
            {
            }
            column(CreatedDate_CorporateStrategicPlans; "Corporate Strategic Plans"."Created Date")
            {
            }
            column(CreationTime_CorporateStrategicPlans; "Corporate Strategic Plans"."Creation Time")
            {
            }
            column(CompanyInfoName; CompInfo.Name)
            {
            }
            column(CompanyInfoPicture; CompInfo.Picture)
            {
            }
            dataitem("Company Information"; "Company Information")
            {
                column(ReportForNavId_124; 124)
                {
                }
                column(Name_CompanyInformation; "Company Information".Name)
                {
                }
                column(Name2_CompanyInformation; "Company Information"."Name 2")
                {
                }
                column(Address_CompanyInformation; "Company Information".Address)
                {
                }
                column(Address2_CompanyInformation; "Company Information"."Address 2")
                {
                }
                column(City_CompanyInformation; "Company Information".City)
                {
                }
                column(Picture_CompanyInformation; "Company Information".Picture)
                {
                }
                column(PostCode_CompanyInformation; "Company Information"."Post Code")
                {
                }
                column(County_CompanyInformation; "Company Information".County)
                {
                }
                column(CountryName; CountryName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*Country.RESET;
                    Country.SETRANGE(Code, "Company Information"."Country/Region Code");
                    IF Country.FINDSET THEN
                      CountryName:=Country.Name;*/


                    if Country.Get("Company Information"."Country/Region Code") then
                        CountryName := Country.Name;

                end;
            }
            dataitem("Strategic Initiative"; "Strategic Initiative")
            {
                DataItemLink = "Strategic Plan ID" = field(Code);
                column(ReportForNavId_17; 17)
                {
                }
                column(StrategicPlanID_StrategicInitiative; "Strategic Initiative"."Strategic Plan ID")
                {
                }
                column(ThemeID_StrategicInitiative; StrategicThemeDescription)
                {
                }
                column(ObjectiveID_StrategicInitiative; StrategicObjectiveDescription)
                {
                }
                column(StrategyID_StrategicInitiative; StrategyDescription)
                {
                }
                column(Code_StrategicInitiative; "Strategic Initiative".Code)
                {
                }
                column(Description_StrategicInitiative; "Strategic Initiative".Description)
                {
                }
                column(FrameworkPerspective_StrategicInitiative; "Strategic Initiative"."Framework Perspective")
                {
                }
                column(StrategyPlannedTarget_StrategicInitiative; "Strategic Initiative"."Total Posted Planned Target")
                {
                }
                column(PCPlannedTarget_StrategicInitiative; "Strategic Initiative"."PC Planned Target")
                {
                }
                column(AchievedTarget_StrategicInitiative; "Strategic Initiative"."Total Achieved Target")
                {
                }
                column(PlannedBudget_StrategicInitiative; "Strategic Initiative"."Total Posted Planned Budget")
                {
                }
                column(UsageBudget_StrategicInitiative; "Strategic Initiative"."Total Usage Budget")
                {
                }
                column(StrategyFramework_StrategicInitiative; "Strategic Initiative"."Strategy Framework")
                {
                }
                column(Collectivetarget_StrategicInitiative; "Strategic Initiative"."Collective target")
                {
                }
                column(CollectiveBudget_StrategicInitiative; "Strategic Initiative"."Collective Budget")
                {
                }
                column(YearOne; YearOne)
                {
                }
                column(YearOneTarget; YearOneTarget)
                {
                }
                column(YearTwo; YearTwo)
                {
                }
                column(YearTwoTarget; YearTwoTarget)
                {
                }
                column(YearThree; YearThree)
                {
                }
                column(YearThreeTarget; YearThreeTarget)
                {
                }
                column(YearFour; YearFour)
                {
                }
                column(YearFourTarget; YearFourTarget)
                {
                }
                column(YearFive; YearFive)
                {
                }
                column(YearFiveTarget; YearFiveTarget)
                {
                }
                /*  dataitem("Strategic Int Planning Lines";"Strategic Int Planning Lines")
                  {
                      DataItemLinkReference ="Strategic Initiative";
                      DataItemLink = "Strategic Plan ID" = field("Strategic Plan ID"),
                                    "Theme ID" = field("Theme ID"),
                                    "Objective ID" = field("Objective ID"),
                                    "Strategy ID" = field("Strategy ID"),
                                    Code = field(Code),
                                    "Primary Directorate" = field("Primary Directorate");
                                    column(Order;Order)
                                    {

                                    }
                                    column(Annual_Reporting_Codes;"Annual Reporting Codes")
                                    {

                                    }
                                    column(Target_Qty;"Target Qty")
                                    {

                                    }
                  }*/

                trigger OnAfterGetRecord()
                begin
                    YearOne := '';
                    YearOneTarget := 0;
                    YearTwo := '';
                    YearTwoTarget := 0;
                    YearThree := '';
                    YearThreeTarget := 0;
                    YearFour := '';
                    YearFourTarget := 0;
                    YearFive := '';
                    YearFiveTarget := 0;
                    "Strategic Initiative".CalcFields("Total Posted Planned Target", "Total Posted Planned Budget", "Total Achieved Target", "Total Usage Budget");
                    StrategicTheme.Reset;
                    StrategicTheme.SetRange("Theme ID", "Strategic Initiative"."Theme ID");
                    if StrategicTheme.Find('-') then begin
                        StrategicThemeDescription := StrategicTheme.Description;
                    end;

                    StrategicObjective.Reset;
                    StrategicObjective.SetRange("Objective ID", "Strategic Initiative"."Objective ID");
                    if StrategicObjective.Find('-') then begin
                        StrategicObjectiveDescription := StrategicObjective.Description;
                    end;

                    Strategy.Reset;
                    Strategy.SetRange("Strategy ID", "Strategic Initiative"."Strategy ID");
                    if Strategy.Find('-') then begin
                        StrategyDescription := Strategy.Description;
                    end;


                    StrategicIntPlanningLines.Reset;
                    StrategicIntPlanningLines.SetRange("Strategic Plan ID", "Strategic Plan ID");
                    StrategicIntPlanningLines.SetRange("Theme ID", "Theme ID");
                    StrategicIntPlanningLines.SetRange("Objective ID", "Objective ID");
                    StrategicIntPlanningLines.SetRange("Strategy ID", "Strategy ID");
                    // StrategicIntPlanningLines.SetRange("Annual Reporting Codes", 'FY2023/24');
                    StrategicIntPlanningLines.SetRange(Code, Code);
                    StrategicIntPlanningLines.SetRange("Primary Department", "Primary Department");
                    StrategicIntPlanningLines.SetRange(Order, 1);
                    if StrategicIntPlanningLines.FindFirst() then begin
                        // repeat
                        YearOne := StrategicIntPlanningLines."Annual Reporting Codes";
                        YearOneTarget := StrategicIntPlanningLines."Target Qty";
                        //until StrategicIntPlanningLines.Next = 0;
                    end;



                    StrategicIntPlanningLines.Reset;
                    StrategicIntPlanningLines.SetRange("Strategic Plan ID", "Strategic Initiative"."Strategic Plan ID");
                    StrategicIntPlanningLines.SetRange("Theme ID", "Strategic Initiative"."Theme ID");
                    StrategicIntPlanningLines.SetRange("Objective ID", "Strategic Initiative"."Objective ID");
                    StrategicIntPlanningLines.SetRange("Strategy ID", "Strategic Initiative"."Strategy ID");
                    // StrategicIntPlanningLines.SetRange("Annual Reporting Codes", 'FY2024/25');
                    StrategicIntPlanningLines.SetRange(Code, Code);
                    StrategicIntPlanningLines.SetRange("Primary Department", "Primary Department");
                    StrategicIntPlanningLines.SetRange(Order, 2);
                    if StrategicIntPlanningLines.FindFirst() then begin
                        // repeat
                        YearTwo := StrategicIntPlanningLines."Annual Reporting Codes";
                        YearTwoTarget := StrategicIntPlanningLines."Target Qty";
                        // until StrategicIntPlanningLines.Next = 0;
                    end;



                    StrategicIntPlanningLines.Reset;
                    StrategicIntPlanningLines.SetRange("Strategic Plan ID", "Strategic Initiative"."Strategic Plan ID");
                    StrategicIntPlanningLines.SetRange("Theme ID", "Strategic Initiative"."Theme ID");
                    StrategicIntPlanningLines.SetRange("Objective ID", "Strategic Initiative"."Objective ID");
                    StrategicIntPlanningLines.SetRange("Strategy ID", "Strategic Initiative"."Strategy ID");
                    //StrategicIntPlanningLines.SetRange("Annual Reporting Codes", 'FY2025/26');
                    StrategicIntPlanningLines.SetRange(Code, Code);
                    StrategicIntPlanningLines.SetRange("Primary Department", "Primary Department");
                    StrategicIntPlanningLines.SetRange(Order, 3);
                    if StrategicIntPlanningLines.FindFirst() then begin
                        // repeat
                        YearThree := StrategicIntPlanningLines."Annual Reporting Codes";
                        YearThreeTarget := StrategicIntPlanningLines."Target Qty";
                        // until StrategicIntPlanningLines.Next = 0;
                    end;



                    StrategicIntPlanningLines.Reset;
                    StrategicIntPlanningLines.SetRange("Strategic Plan ID", "Strategic Initiative"."Strategic Plan ID");
                    StrategicIntPlanningLines.SetRange("Theme ID", "Strategic Initiative"."Theme ID");
                    StrategicIntPlanningLines.SetRange("Objective ID", "Strategic Initiative"."Objective ID");
                    StrategicIntPlanningLines.SetRange("Strategy ID", "Strategic Initiative"."Strategy ID");
                    // StrategicIntPlanningLines.SetRange("Annual Reporting Codes", 'FY2026/27');
                    StrategicIntPlanningLines.SetRange(Code, Code);
                    StrategicIntPlanningLines.SetRange("Primary Department", "Primary Department");
                    StrategicIntPlanningLines.SetRange(Order, 4);
                    if StrategicIntPlanningLines.FindFirst() then begin
                        ///repeat
                        YearFour := StrategicIntPlanningLines."Annual Reporting Codes";
                        YearFourTarget := StrategicIntPlanningLines."Target Qty";
                        ///until StrategicIntPlanningLines.Next = 0;
                    end;

                    StrategicIntPlanningLines.Reset;
                    StrategicIntPlanningLines.SetRange("Strategic Plan ID", "Strategic Initiative"."Strategic Plan ID");
                    StrategicIntPlanningLines.SetRange("Theme ID", "Strategic Initiative"."Theme ID");
                    StrategicIntPlanningLines.SetRange("Objective ID", "Strategic Initiative"."Objective ID");
                    StrategicIntPlanningLines.SetRange("Strategy ID", "Strategic Initiative"."Strategy ID");
                    // StrategicIntPlanningLines.SetRange("Annual Reporting Codes", 'FY2027/28');
                    StrategicIntPlanningLines.SetRange(Code, Code);
                    StrategicIntPlanningLines.SetRange("Primary Department", "Primary Department");
                    StrategicIntPlanningLines.SetRange(Order, 5);
                    if StrategicIntPlanningLines.FindFirst() then begin
                        //repeat
                        YearFive := StrategicIntPlanningLines."Annual Reporting Codes";
                        YearFiveTarget := StrategicIntPlanningLines."Target Qty";
                        //until StrategicIntPlanningLines.Next = 0;
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin

                CompInfo.Get;
                CompInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Country: Record "Country/Region";
        CountryName: Code[100];
        CompInfo: Record "Company Information";
        StrategicTheme: Record "Strategic Theme";
        StrategicObjective: Record "Strategic Objective";
        Strategy: Record Strategy;
        StrategicThemeDescription: Text;
        StrategicObjectiveDescription: Text;
        StrategyDescription: Text;
        StrategicIntPlanningLines: Record "Strategic Int Planning Lines";
        YearOne: Code[10];
        YearTwo: Code[10];
        YearThree: Code[10];
        YearFour: Code[10];
        YearFive: Code[10];
        YearOneTarget: Decimal;
        YearTwoTarget: Decimal;
        YearThreeTarget: Decimal;
        YearFourTarget: Decimal;
        YearFiveTarget: Decimal;
}

