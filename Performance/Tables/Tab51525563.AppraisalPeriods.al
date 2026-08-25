// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AW0006 // ForNAV settings
// Table 52211653 "Appraisal Periods"
// {
//     DrillDownPageID = "Appraisal Periods";
//     LookupPageID = "Appraisal Periods";

//     fields
//     {
//         field(1; Period; Code[30])
//         {
//             NotBlank = true;
//         }
//         field(2; "Start Date"; Date)
//         {
//             Caption = 'Start Dtae';
//         }
//         field(3; "End Date"; Date)
//         {
//             Caption = 'End Date';
//         }
//         field(4; "Financial Year"; Code[30])
//         {
//             Caption = 'Financial Year';
//             TableRelation = "G/L Budget Name";
//         }
//         field(5; Comments; Text[250])
//         {
//         }
//         field(6; "Strategic Plan"; Code[50])
//         {
//             TableRelation = "Corporate Strategic Plans";
//         }
//     }

//     keys
//     {
//         key(Key1; Period)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

