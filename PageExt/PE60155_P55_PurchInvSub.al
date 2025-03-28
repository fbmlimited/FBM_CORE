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
        addlast(Control15)
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
#if MAIN
        modify("IDPIRPF IRPF")
        {
            Visible = false;
        }
        modify("IDPIRPF IRPF Amount")
        {
            Visible = false;
        }
        modify("IDPIRPF IRPF Group")
        {
            Visible = false;
        }
        modify("IDPIRPF Total IRPF Amount")
        {
            Visible = false;
        }
#endif

    }


}
