pageextension 60155 FBM_PurchInvSubExt_CO extends "Purch. Invoice Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Deferral Code")
        {
            Visible = true;
        }
        modify("Location Code")
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
