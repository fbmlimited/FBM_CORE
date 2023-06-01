pageextension 60173 FBM_VendPGsExt_CO extends "Vendor Posting Groups"
{
    layout
    {
        addlast(Control1)
        {
            field(BudgetAccount; rec.FBM_BudgetAccount)
            {
                ApplicationArea = all;
            }
        }

    }
}