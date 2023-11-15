pageextension 60157 FBM_PurchOrdSubExt_CO extends "Purchase Order Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Prepayment %")
        {
            Visible = true;
        }
        addafter("Location Code")
        {
            field(FBM_Site; Rec.FBM_Site)
            {
                ApplicationArea = all;
            }
        }


    }

}
