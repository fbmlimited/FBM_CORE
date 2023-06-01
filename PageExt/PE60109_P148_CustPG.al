pageextension 60109 FBM_CustPGCardExt_CO extends "Customer Posting Group Card"
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