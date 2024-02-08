page 60157 FBM_NotesCustList_CO
{
    Caption = 'Customer Notes';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_Notes;
    CardPageId = FBM_NotesCust_DD;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                }
                field(SavedAt; Rec.SavedAt)
                {
                    ApplicationArea = All;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                }
                field(LevelValue; Rec.LevelValue)
                {
                    ApplicationArea = All;
                }
                field(Note; copystr(Rec.Note, 1, 20))
                {
                    ApplicationArea = All;
                }

            }
        }

    }
    trigger
    OnOpenPage()
    begin
        ssetup.Get();
        rec.SetRange(Customer, ssetup.FBM_Custtmp);

    end;

    var

        ssetup: Record "Sales & Receivables Setup";

    procedure passpar(pcust: code[20])
    begin
        ssetup.Get();

        ssetup.FBM_Custtmp := pcust;
        ssetup.Modify();
    end;
}