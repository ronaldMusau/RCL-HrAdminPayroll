#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
Page 52211803 "Values Evaluation Results"
{
    ApplicationArea = Basic;
    AutoSplitKey = true;
    Caption = 'Core Values Assessment';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Values Evaluation Result";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Core Value Code"; Rec."Core Value Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the core value code.';
                }
                field("Core Value Description"; Rec."Core Value Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the description of the core value.';
                }
                field("Weight %"; Rec."Weight %")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the weight percentage assigned to this core value.';
                }
                field("Employee Self Rating"; Rec."Employee Self Rating")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the employee self-assessment rating for this core value.';
                }
                field("Manager Rating"; Rec."Manager Rating")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the manager rating for this core value.';
                }
                field("Final Rating"; Rec."Final Rating")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the final agreed rating for this core value.';
                }
                field("Employee Comments"; Rec."Employee Comments")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Employee comments on this core value.';
                }
                field("Manager Comments"; Rec."Manager Comments")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Manager comments on this core value.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(LoadCoreValues)
            {
                ApplicationArea = Basic;
                Caption = 'Load Core Values';
                Image = RefreshLines;
                ToolTip = 'Load all core values from the Core Values master into this evaluation.';

                trigger OnAction()
                var
                    CoreValue: Record "Core Values";
                    ValuesResult: Record "Values Evaluation Result";
                    LastLineNo: Integer;
                    EvalID: Code[100];
                begin
                    EvalID := Rec.GetFilter("Performance Evaluation ID");
                    if EvalID = '' then begin
                        Message('Please open this from a Performance Evaluation record.');
                        exit;
                    end;

                    // Remove existing lines for this evaluation
                    ValuesResult.Reset();
                    ValuesResult.SetRange("Performance Evaluation ID", EvalID);
                    ValuesResult.DeleteAll();

                    // Re-load from Core Values master
                    LastLineNo := 0;
                    CoreValue.Reset();
                    if CoreValue.FindSet() then
                        repeat
                            LastLineNo += 10000;
                            ValuesResult.Init();
                            ValuesResult."Performance Evaluation ID" := EvalID;
                            ValuesResult."Line No." := LastLineNo;
                            ValuesResult."Core Value Code" := CoreValue.Code;
                            ValuesResult."Core Value Description" := CoreValue.Description;
                            ValuesResult.Insert(true);
                        until CoreValue.Next() = 0;

                    CurrPage.Update(false);
                end;
            }
        }
    }
}
