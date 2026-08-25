#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 52211735 "Planning and Strategy Cues"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(3; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(4; "Current CSP"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Corporate Strategic Plans".Code;
        }
        field(5; "Current Annual Workplan"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Strategy Workplan".No where("Strategy Plan ID" = field("Current CSP"));
        }
        // field(6; "Current Financial Year"; Code[30])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "CSP Planned Years"."Annual Year Code" where("CSP Code" = field("Current CSP"),
        //                                                                   "Current Plan Year" = const(true));
        // }
        field(6; "Current Financial Year"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "CSP Planned Years"."Annual Year Code" where("CSP Code" = field("Current CSP"),
                                                                          "Current Plan Year" = const(true));
        }
        field(7; "Current Quarter"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Quarterly Reporting Periods".Code where("Year Code" = field("Current Financial Year"));
        }
        field(8; "Open Departimental Workplan"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const(Functional),
                                                                  "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(9; "Pending Departimental Workplan"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const(Functional),
                                                                  "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(10; "Approved Dept Workplan"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const(Functional),
                                                                  "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(11; "Open Annual Workplan"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const(Organizational),
                                                                  "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(12; "Pending Annual Workplan"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const(Organizational),
                                                                  "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(13; "Approved Annual Workplan"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const(Organizational),
                                                                  "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(14; "Open CEO Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("CEO/Corporate Awp"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(15; "Pending CEO Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("CEO/Corporate Awp"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(16; "Approved CEO Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("CEO/Corporate Awp"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(17; "Open CEO PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("CEO/Corporate PC"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(18; "Pending CEO PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("CEO/Corporate PC"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(19; "Approved CEO PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("CEO/Corporate PC"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(20; "Open AWP Cascading Template"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Functional/Operational PC"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(21; "Pending AWP Cascading Template"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Functional/Operational PC"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(22; "Approved AWP Cascading Temp"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Functional/Operational PC"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(23; "Open DCS Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Staff Performance Contract"),
                                                                    "Score Card Type" = const(CEOs),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(24; "Pending DCS Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Staff Performance Contract"),
                                                                    "Score Card Type" = const(CEOs),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(25; "Approved DCS Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Staff Performance Contract"),
                                                                    "Score Card Type" = const(CEOs),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(26; "Open HOD Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Staff Performance Contract"),
                                                                    "Score Card Type" = const(Departmental),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Open)));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(27; "Pending HOD Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Staff Performance Contract"),
                                                                    "Score Card Type" = const(Departmental),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(28; "Approved HOD Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Staff Performance Contract"),
                                                                    "Score Card Type" = const(Departmental),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(29; "Open Staff Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Staff Performance Contract"),
                                                                    "Score Card Type" = const(Staff),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(30; "Pending Staff Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Staff Performance Contract"),
                                                                    "Score Card Type" = const(Staff),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(31; "Approved Staff Annual Workplan"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Staff Performance Contract"),
                                                                    "Score Card Type" = const(Staff),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(32; "Open Annual PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Board/Executive PC"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(33; "Pending  Annual PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Board/Executive PC"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(34; "Approved  Annual PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Board/Executive PC"),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(35; "Open DCS PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Individual Scorecard PC"),
                                                                    "Score Card Type" = const(CEOs),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(36; "Pending DCS PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Individual Scorecard PC"),
                                                                    "Score Card Type" = const(CEOs),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(37; "Approved DCS PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Individual Scorecard PC"),
                                                                    "Score Card Type" = const(CEOs),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(38; "Open HOD PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Individual Scorecard PC"),
                                                                    "Score Card Type" = const(Departmental),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Open)));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(39; "Pending PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Individual Scorecard PC"),
                                                                    "Score Card Type" = const(Departmental),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(40; "Approved HOD PC"; Integer)
        {
            CalcFormula = count("Perfomance Contract Header" where("Document Type" = const("Individual Scorecard PC"),
                                                                    "Score Card Type" = const(Departmental),
                                                                    "Strategy Plan ID" = field("Current CSP"),
                                                                    "Annual Workplan" = field("Current Annual Workplan"),
                                                                    "Annual Reporting Code" = field("Current Financial Year"),
                                                                    "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(41; "Open Dept Draft Pc"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const("Functional PC"),
                                                                  "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(42; "Pending Dept Draft Pc"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const("Functional PC"),
                                                                  "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(43; "Approved Dept Draft Pc"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const("Functional PC"),
                                                                  "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(44; "Open Annual Draft Pc"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const("Organizational PC"),
                                                                  "Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(45; "Pending Annual Draft Pc"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const("Organizational PC"),
                                                                  "Approval Status" = const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(46; "Approved Annual Draft Pc"; Integer)
        {
            CalcFormula = count("Annual Strategy Workplan" where("Strategy Plan ID" = field("Current CSP"),
                                                                  "Year Reporting Code" = field("Current Financial Year"),
                                                                  "Annual Strategy Type" = const("Organizational PC"),
                                                                  "Approval Status" = const(Released)));
            FieldClass = FlowField;
        }
        field(47; "Corparate Strategic Plan"; Integer)
        {
            CalcFormula = count("Corporate Strategic Plans" where(Code = filter(<> '')));
            FieldClass = FlowField;
        }
        field(48; "Requests to Approve"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Approver ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
