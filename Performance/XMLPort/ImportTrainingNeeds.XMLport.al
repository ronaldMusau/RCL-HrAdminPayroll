#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
XmlPort 52211623 "Import Training Needs"
{
    Direction = Import;
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(TrainingNeeds)
        {
            tableelement("Training Needs Lines"; "Training Needs Lines")
            {
                XmlName = 'TrainingNeed';
                fieldelement(No; "Training Needs Lines".Description)
                {
                }
                fieldelement(Description; "Training Needs Lines".Source)
                {
                }
                fieldelement(Quantity; "Training Needs Lines".Comments)
                {
                }
            }
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

    trigger OnPreXmlPort()
    begin
        LineNo := 10000;
        "Training Needs Lines"."Training Header No." := ReqNo;
    end;

    var
        ReqNo: Code[10];
        LineNo: Integer;


    procedure GetRec(var Header: Record "Training Courses Needs")
    begin
        //  ReqNo:=Header."Entry No.";
    end;
}

