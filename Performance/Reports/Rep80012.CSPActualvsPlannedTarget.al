#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Report 52211647 "CSP Actual vs Planned Target"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Performance/Layouts/CSP Actual vs Planned Target.rdlc';

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

                trigger OnAfterGetRecord()
                begin
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
}

