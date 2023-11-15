pageextension 60187 FBM_ItemLEPreviewExt_CO extends "Item Ledger Entries Preview"
{
    layout
    {
        addlast(Control1)
        {
            field(FBM_Site; Rec.FBM_Site)
            {
                ApplicationArea = all;

            }

        }

    }
}