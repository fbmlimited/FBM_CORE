pageextension 60110 FBM_CustPGExt_CO extends "Customer Posting Groups"
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