#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Report 52211646 "Performance Log"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Performance/Layouts/Performance Log.rdlc';

    dataset
    {
        dataitem("Performance Diary Log"; "Performance Diary Log")
        {
            RequestFilterFields = No;
            column(ReportForNavId_1; 1)
            {
            }
            column(No_PerformanceDiaryLog; "Performance Diary Log".No)
            {
            }
            column(EmployeeNo_PerformanceDiaryLog; "Performance Diary Log"."Employee No.")
            {
            }
            column(IncidenceDate_PerformanceDiaryLog; "Performance Diary Log"."Incidence Date")
            {
            }
            column(PerformanceEntryType_PerformanceDiaryLog; "Performance Diary Log"."Performance Entry Type")
            {
            }
            column(DiarySource_PerformanceDiaryLog; "Performance Diary Log"."Diary Source")
            {
            }
            column(Description_PerformanceDiaryLog; "Performance Diary Log".Description)
            {
            }
            column(PersonalScorecardID_PerformanceDiaryLog; "Performance Diary Log"."Personal Scorecard ID")
            {
            }
            column(GoalID_PerformanceDiaryLog; "Performance Diary Log"."Goal ID")
            {
            }
            column(ObjectiveID_PerformanceDiaryLog; "Performance Diary Log"."Objective ID")
            {
            }
            column(DisciplinaryCaseID_PerformanceDiaryLog; "Performance Diary Log"."Disciplinary Case ID")
            {
            }
            column(DirectorateCode_PerformanceDiaryLog; "Performance Diary Log"."Department Code")
            {
            }
            column(EmployeeNames_PerformanceDiaryLog; "Performance Diary Log"."Employee Names")
            {
            }
            column(DocumentDate_PerformanceDiaryLog; "Performance Diary Log"."Document Date")
            {
            }
            column(RegionID_PerformanceDiaryLog; "Performance Diary Log"."Region ID")
            {
            }
            column(ActivityStartDate_PerformanceDiaryLog; "Performance Diary Log"."Activity Start Date")
            {
            }
            column(ActivityEndDate_PerformanceDiaryLog; "Performance Diary Log"."Activity End Date")
            {
            }
            column(CSPID_PerformanceDiaryLog; "Performance Diary Log"."CSP ID")
            {
            }
            column(AWPID_PerformanceDiaryLog; "Performance Diary Log"."AWP ID")
            {
            }
            column(BoardPCID_PerformanceDiaryLog; "Performance Diary Log"."Board PC ID")
            {
            }
            column(CEOPCID_PerformanceDiaryLog; "Performance Diary Log"."CEO PC ID")
            {
            }
            column(FunctionalPC_PerformanceDiaryLog; "Performance Diary Log"."Functional PC")
            {
            }
            column(CreatedBy_PerformanceDiaryLog; "Performance Diary Log"."Created By")
            {
            }
            column(CreatedOn_PerformanceDiaryLog; "Performance Diary Log"."Created On")
            {
            }
            column(CreatedTime_PerformanceDiaryLog; "Performance Diary Log"."Created Time")
            {
            }
            column(ApprovalStatus_PerformanceDiaryLog; "Performance Diary Log"."Approval Status")
            {
            }
            column(YearReportingCode_PerformanceDiaryLog; "Performance Diary Log"."Year Reporting Code")
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
            dataitem("Plog Lines"; "Plog Lines")
            {
                DataItemLink = "PLog No." = field(No);
                column(ReportForNavId_17; 17)
                {
                }
                column(PLogNo_PlogLines; "Plog Lines"."PLog No.")
                {
                }
                column(InitiativeNo_PlogLines; "Plog Lines"."Initiative No.")
                {
                }
                column(Description_PlogLines; "Plog Lines"."Sub Intiative No")
                {
                }
                column(GoalID_PlogLines; "Plog Lines".Description)
                {
                }
                column(StrategyPlanID_PlogLines; "Plog Lines"."Strategy Plan ID")
                {
                }
                column(YearReportingCode_PlogLines; "Plog Lines"."Year Reporting Code")
                {
                }
                column(PlannedDate_PlogLines; "Plog Lines"."Planned Date")
                {
                }
                column(AchievedDate_PlogLines; "Plog Lines"."Achieved Date")
                {
                }
                column(PrimaryDirectorate_PlogLines; "Plog Lines"."Primary Department")
                {
                }
                column(UnitofMeasure_PlogLines; "Plog Lines"."Unit of Measure")
                {
                }
                column(TargetQty_PlogLines; "Plog Lines"."Target Qty")
                {
                }
                column(AchievedTarget_PlogLines; "Plog Lines"."Achieved Target")
                {
                }
                column(AWPID_PlogLines; "Plog Lines"."AWP ID")
                {
                }
                column(BoardPCID_PlogLines; "Plog Lines"."Board PC ID")
                {
                }
                column(CEOPCID_PlogLines; "Plog Lines"."CEO PC ID")
                {
                }
                column(FunctionalPC_PlogLines; "Plog Lines"."Functional PC")
                {
                }
                column(EmployeeNo_PlogLines; "Plog Lines"."Employee No.")
                {
                }
                column(PersonalScorecardID_PlogLines; "Plog Lines"."Personal Scorecard ID")
                {
                }
                column(Comments_PlogLines; "Plog Lines".Comments)
                {
                }
                column(KeyPerformanceIndicator_PlogLines; "Plog Lines"."Key Performance Indicator")
                {
                }
                column(DueDate_PlogLines; "Plog Lines"."Due Date")
                {
                }
                column(Variance; Variance)
                {

                }
                column(variance1; variance1)
                {

                }

                dataitem("Sub Plog Lines"; "Sub Plog Lines")
                {
                    DataItemLink = "PLog No." = field("PLog No."), "Initiative No." = field("Initiative No.");
                    column(ReportForNavId_50; 50)
                    {
                    }
                    column(SubActivityNo_SubPlogLines; "Sub Plog Lines"."Sub Activity No.")
                    {
                    }
                    column(Description_SubPlogLines; "Sub Plog Lines".Description)
                    {
                    }
                    column(TargetQty_SubPlogLines; "Sub Plog Lines"."Target Qty")
                    {
                    }
                    column(AchievedTarget_SubPlogLines; "Sub Plog Lines"."Achieved Target")
                    {
                    }
                    column(Weight_SubPlogLines; "Sub Plog Lines"."Weight %")
                    {
                    }
                    column(DueDate_SubPlogLines; "Sub Plog Lines"."Due Date")
                    {
                    }
                }
            }

            trigger OnPreDataItem()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                variance1 := "Plog Lines"."Target Qty" - "Plog Lines"."Achieved Target";

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
        variance1: Decimal;
}

