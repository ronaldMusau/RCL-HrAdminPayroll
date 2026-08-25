page 52211586 "PIP List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "PIP Header";
    CardPageId = "PIP Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("PIP No"; Rec."PIP No") { }
                field("Employee No"; Rec."Employee No") { }
                field("Employee Name"; Rec."Employee Name") { }
                field("Appraisal No"; Rec."Appraisal No") { }
                field("Appraisal Period"; Rec."Appraisal Period") { }
                field("Supervisor No"; Rec."Supervisor No") { }
                field("Supervisor Name"; Rec."Supervisor Name") { }
                field("Start Date"; Rec."Start Date") { }
                field("End Date"; Rec."End Date") { }
                field(Status; Rec.Status) { }
            }
        }
    }
}
