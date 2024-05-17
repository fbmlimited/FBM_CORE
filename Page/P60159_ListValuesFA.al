page 60159 FBM_ListValueFA_CO
{
    Caption = ' Values List for FA Model';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_ListValues;

    layout
    {


        area(Content)
        {
           
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Ord; Rec.Ord)
                {
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                }

            }


        }
    }

    

    trigger
    OnOpenPage()
    begin
        rec.SetRange(type, 'FAMODEL');
    end;

    trigger
    OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        REC.TYPE := 'FAMODEL'
    end;
}