pageextension 60130 FBM_PostPurchInvsExt_CO extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Posting Description"; rec."Posting Description")
            {
                ApplicationArea = all;
            }
        }
    }
}