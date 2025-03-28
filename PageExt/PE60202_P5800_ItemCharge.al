pageextension 60202 FBM_ItemChargeExt extends "Item Charges"
{
    layout
    {
        addlast(Control1)
        {
            field(FBM_IsFreight; Rec.FBM_IsFreight)
            {
                ApplicationArea = all;
            }
            field(FBM_IsWht; Rec.FBM_IsWht)
            {
                ApplicationArea = all;
            }
        }

    }
}