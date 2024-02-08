// page 60153 FBM_ListValueType
// {
//     Caption = 'Types for Values List';
//     PageType = List;

//     SourceTable = FBM_ListValues;

//     layout
//     {
//         area(Content)
//         {
//             repeater(Group)
//             {
//                 field(Type; rec.Type)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Ord; rec.Ord)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Value; rec.Value)
//                 {
//                     ApplicationArea = All;
//                 }

//             }
//         }

//     }

//     trigger
//     OnOpenPage()
//     var
//         lv: record FBM_ListValues;
//     begin
//         //lv.SETRANGE(IsDefault, true);
//         lv.DeleteAll();
//         lv.Reset();
//         lv.SETRANGE(IsDefault, true);
//         IF lv.COUNT = 0 then begin
//             lv.Init();
//             lv.ord := 1;
//             lv.type := 'TYPE';
//             lv.value := 'LEVEL';
//             lv.IsDefault := true;
//             lv.Insert();
//             lv.Init();
//             lv.ord := 2;
//             lv.type := 'TYPE';
//             lv.value := 'TYPE';
//             lv.IsDefault := true;
//             lv.Insert();

//             lv.Init();
//             lv.ord := 3;
//             lv.type := 'TYPE';
//             lv.value := 'COMMENTTYPE';
//             lv.IsDefault := true;
//             lv.Insert();
//             lv.Init();
//             lv.ord := 1;
//             lv.type := 'LEVEL';
//             lv.value := 'SUBGROUP';
//             lv.IsDefault := true;
//             lv.Insert();
//             lv.Init();
//             lv.ord := 2;
//             lv.type := 'LEVEL';
//             lv.value := 'SITE';
//             lv.IsDefault := true;
//             lv.Insert();
//             lv.Init();
//             lv.ord := 3;
//             lv.type := 'LEVEL';
//             lv.value := 'CUSTOMER';
//             lv.IsDefault := true;
//             lv.Insert();
//             lv.Init();
//             lv.ord := 1;
//             lv.type := 'COMMENTTYPE';
//             lv.value := 'AGREEMENT';
//             lv.IsDefault := true;
//             lv.Insert();
//             lv.Init();
//             lv.ord := 2;
//             lv.type := 'COMMENTTYPE';
//             lv.value := 'NEXT STEPS';
//             lv.IsDefault := true;
//             lv.Insert();
//             lv.Init();
//             lv.ord := 3;
//             lv.type := 'COMMENTTYPE';
//             lv.value := 'VISIT';
//             lv.IsDefault := true;
//             lv.Insert();
//         end;
//         rec.SetRange(type, 'TYPE');
//     end;

//     trigger
//     OnInsertrecord(Belowxlv: Boolean): Boolean
//     begin
//         rec.TYPE := 'TYPE';
//     end;
// }