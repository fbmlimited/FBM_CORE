page 60169 FBM_MinStock
{
    Caption = 'Min. Stock Check';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Item;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field(FBM_MinStock; Rec.FBM_MinStock)
                {
                    ApplicationArea = All;
                }


            }
        }

    }
    trigger
    OnOpenPage()
    begin
        rec.SetRange(Type, rec.Type::Inventory);
        rec.FindFirst();
        if Rec.FindSet() then
            repeat
                if rec.Inventory < rec.FBM_MinStock then
                    rec.Mark(true);
            until Rec.Next() = 0;
        rec.MarkedOnly(true);
    end;

}