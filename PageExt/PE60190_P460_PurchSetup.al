pageextension 60190 FBM_PurchSetupExt_CO extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {


            field(FBM_PurchPhone; Rec.FBM_PurchPhone)
            {
                ApplicationArea = all;

            }

        }

    }
}