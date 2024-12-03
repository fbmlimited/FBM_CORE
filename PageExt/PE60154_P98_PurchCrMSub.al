pageextension 60154 FBM_PurchCrMSubExt_CO extends "Purch. Cr. Memo Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
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
