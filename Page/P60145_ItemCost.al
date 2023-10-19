page 60145 FBM_ItemCost_CO
{
    Caption = 'Item Cost';
    PageType = CardPart;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Item Journal Line";

    layout
    {
        area(Content)
        {
            Group("Item")
            {
                field("Item Cost"; Format(round(Rec.CalcItemCost(''), 0.000001), 0, '<Precision,6:6><Standard Format,2>'))

                {
                    ApplicationArea = All;
                }
                field("Item Cost by Loc"; Format(round(Rec.CalcItemCost(rec."Location Code"), 0.000001), 0, '<Precision,6:6><Standard Format,2>'))

                {
                    ApplicationArea = All;
                }

            }
        }

    }

    trigger
    OnOpenPage()
    begin

    end;
}