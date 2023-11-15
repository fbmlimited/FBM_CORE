pageextension 60184 FBM_ItemCardExt_CO extends "Item Card"
{
    layout
    {
        addfirst(Replenishment)
        {
            field(FBM_MinStock; Rec.FBM_MinStock)
            {
                ApplicationArea = all;
            }
        }
        addafter(Inventory)
        {
            field(FBM_Inventory_New; Rec.FBM_Inventory_New)
            {
                ApplicationArea = all;
            }
            field(FBM_Inventory_Used; Rec.FBM_Inventory_Used)
            {
                ApplicationArea = all;
            }
        }
    }
}