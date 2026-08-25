#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Table 52211733 "Workplan Cost Elements"
{

    fields
    {
        field(1; "Workplan No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Initiative No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Activity Id"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                StrategyWorkplanLines.Reset;
                StrategyWorkplanLines.SetRange(No, "Workplan No.");
                StrategyWorkplanLines.SetRange("Activity ID", "Activity Id");
                if StrategyWorkplanLines.Find('-') then begin
                    "Activity Description" := StrategyWorkplanLines.Description;
                    "Primary Department" := StrategyWorkplanLines."Primary Department";
                    // "Primary Department" := StrategyWorkplanLines."Primary Division";
                end;
            end;
        }
        field(4; "Cost Elements"; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                SubActivityBudget := 0;
                TotalCostElements := 0;
                SubWorkplanActivity.Reset;
                SubWorkplanActivity.SetRange("Workplan No.", "Workplan No.");
                SubWorkplanActivity.SetRange("Activity Id", "Activity Id");
                SubWorkplanActivity.SetRange("Sub Initiative No.", "Sub Activity No");
                if SubWorkplanActivity.FindFirst then begin
                    SubActivityBudget := SubWorkplanActivity."Total Budget";
                end;

                WorkplanCostElements.Reset;
                WorkplanCostElements.SetRange("Workplan No.", "Workplan No.");
                WorkplanCostElements.SetRange("Activity Id", "Activity Id");
                WorkplanCostElements.SetRange("Sub Activity No", "Sub Activity No");
                if WorkplanCostElements.FindFirst then begin
                    repeat
                        TotalCostElements := TotalCostElements + Amount;
                    until WorkplanCostElements.Next = 0;
                end;



                //IF TotalCostElements> SubActivityBudget THEN
                //  ERROR('Your Workplan Cost Elements of Amount %1 are more than Sub Activity Budget of %2',TotalCostElements,SubActivityBudget);
            end;
        }
        field(6; "Job No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job."No.";// where (Budget=filter(Yes));
        }
        field(7; "Vote id"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No"));

            trigger OnValidate()
            begin
                JobTask.Reset;
                JobTask.SetRange("Job No.", "Job No");
                JobTask.SetRange("Job Task No.", "Vote id");
                if JobTask.Find('-') then begin
                    "Vote Desription" := JobTask.Description;
                end;
            end;
        }
        field(8; "Vote Desription"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Procurment Plan No"; Code[30])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Procurement Plan".Code where("Plan Type" = const(Consolidated),
            //    "Revision Voucher" = const(false));
        }
        field(10; "Plan Item No"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Item."No." where("Procurement Category" = field("Plan Category"));

            trigger OnValidate()
            begin
                /*ProcurementPlanEntry.RESET;
                ProcurementPlanEntry.SETRANGE("Entry No.","Plan Item No");
                IF ProcurementPlanEntry.FIND('-') THEN BEGIN
                   "Plan Item Description":=ProcurementPlanEntry.Description;
                    "Unit Cost":=ProcurementPlanEntry."Unit Cost";
                END;*/
                if "Vote id" = '' then begin
                    Error('Error! Kindly key in the Vote ID');

                end;
                Item.Reset;
                Item.SetRange("No.", "Plan Item No");
                if Item.FindFirst then begin
                    if Item."Last Direct Cost" <= 0 then begin

                        "Unit Cost" := Item."Unit Cost";
                    end else begin
                        "Unit Cost" := Item."Last Direct Cost";
                    end;
                    "Plan Item Description" := Item.Description;
                end;

            end;
        }
        field(11; "Plan Category"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Procurement Category".Code where(Blocked = const(false));

            trigger OnValidate()
            begin
                if "Vote id" = '' then begin
                    Error('Error! Kindly key in the Vote ID');

                end;
            end;
        }
        field(12; "Activity Description"; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Plan Item Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Sub Activity No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub Workplan Activity"."Sub Initiative No." where("Workplan No." = field("Workplan No."),
                                                                                "Initiative No." = field("Initiative No."));

            trigger OnValidate()
            begin
                TotalCostElements := 0;
                SubWorkplanActivity.Reset;
                SubWorkplanActivity.SetRange("Workplan No.", "Workplan No.");
                SubWorkplanActivity.SetRange("Activity Id", "Activity Id");
                SubWorkplanActivity.SetRange("Sub Initiative No.", "Sub Activity No");
                if SubWorkplanActivity.FindFirst then begin
                    "Sub Activity Name" := SubWorkplanActivity."Objective/Initiative";
                end;
            end;
        }
        field(15; "Sub Activity Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Plan Item No" <> '' then begin
                    Error('ERROR!, You are not allowed to change the Unit cost for the procurable items, Contact Supply Chain Management');
                end;
            end;
        }
        field(17; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount := "Unit Cost" * Quantity;
                Validate(Amount);
            end;
        }
        field(18; "Functional Procurment Plan No"; Code[30])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Procurement Plan".Code;
        }
        // field(19; "Primary Directorate"; Code[50])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Directorate));
        // }
        field(20; "Primary Department"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center" where("Operating Unit Type" = filter(Department));
        }
        field(21; "Funding Level"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fully,Partially,Not Funded,No Funds Needed';
            OptionMembers = " ",Fully,Partially,"Not Funded","No Funds Needed";
        }
        field(32; Comments; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Workplan Ele Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Prevously Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Prevously Requested Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                // IF "Plan Item No"<>'' THEN BEGIN
                //  ERROR('ERROR!, You are not allowed to change the Unit cost for the procurable items, Contact Supply Chain Management');
                //  END;
            end;
        }
        field(36; "Prevously RequestedQuantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Amount := "Unit Cost" * Quantity;
                VALIDATE(Amount);
            end;
        }
        field(37; "Planning Budget Type"; Option)
        {
            OptionMembers = Original,Supplementary;
        }

    }

    keys
    {
        key(Key1; "Workplan No.", "Activity Id", "Initiative No.", "Sub Activity No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        JobTask: Record "Job Task";
        // ProcurementPlanEntry: Record "Procurement Plan Entry";
        StrategyWorkplanLines: Record "Strategy Workplan Lines";
        SubWorkplanActivity: Record "Sub Workplan Activity";
        SubActivityBudget: Decimal;
        WorkplanCostElements: Record "Workplan Cost Elements";
        TotalCostElements: Decimal;
        Item: Record Item;
}

