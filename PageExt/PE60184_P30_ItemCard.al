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
    actions
    {

        addlast(ItemAvailabilityBy)
        {
            action(ItemsBySite)
            {

                AccessByPermission = TableData FBM_Customer = R;
                ApplicationArea = Location;
                Caption = 'Items b&y Site';
                Image = ItemAvailbyLoc;
                ToolTip = 'Show a list of items grouped by location.';

                trigger OnAction()
                begin
                    PAGE.Run(PAGE::FBM_ItemsBySite_CO, Rec);
                end;
            }
        }
    }

}