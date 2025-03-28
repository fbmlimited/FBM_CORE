// page 60157 FBM_NotesCustList_CO
// {
//     Caption = 'Customer Notes';
//     PageType = List;
//     UsageCategory = Lists;
//     ApplicationArea = All;
//     SourceTable = FBM_Notes;
//     CardPageId = FBM_NotesCust_DD;
//     Editable = false;
//     layout
//     {
//         area(Content)
//         {
//             repeater(Group)
//             {
//                 field(EntryNo; Rec.EntryNo)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(IsActive; Rec.IsActive)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(SavedAt; Rec.SavedAt)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(User; Rec.User)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Level; Rec.Level)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(LevelValue; Rec.LevelValue)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(pnote; pnote)
//                 {
//                     ApplicationArea = All;
//                 }

//             }
//         }

//     }
//     trigger
//     OnOpenPage()
//     begin
//         ssetup.Get();
//         rec.SetRange(Customer, ssetup.FBM_Custtmp);

//     end;

//     trigger
//     OnAfterGetRecord()
//     begin
//         rec.CalcFields(NoteBlob);
//         rec.NoteBlob.CreateInStream(InStream, TEXTENCODING::UTF8);
//         pnote := copystr(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator), 1, 20);

//     end;

//     var

//         ssetup: Record "Sales & Receivables Setup";
//         pnote: text[20];
//         TypeHelper: Codeunit "Type Helper";
//         InStream: InStream;

//     procedure passpar(pcust: code[20])
//     begin
//         ssetup.Get();

//         ssetup.FBM_Custtmp := pcust;
//         ssetup.Modify();
//     end;
// }