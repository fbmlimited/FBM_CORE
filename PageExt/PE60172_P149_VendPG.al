pageextension 60172 FBM_VendPGExt_CO extends "Vendor Posting Group Card"
{
    layout
    {
        addlast(General)
        {
            field(BudgetAccount; rec.FBM_BudgetAccount)
            {
                ApplicationArea = all;
            }
        }

    }
}