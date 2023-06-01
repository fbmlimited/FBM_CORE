pageextension 60140 FBM_PurchOrdListExt_CO extends "Purchase Order List"
{
    layout
    {
    }
    actions
    {
        addlast(navigation)
        {

            action("Search Serial No.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Search Serial No.';
                Image = "BarCode";
                RunObject = Page "FBM_Search Serial No._CO";
            }

            action("Vendor Order Detailes")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor  Order Detailes';
                Image = "Report";
                RunObject = Report "FBM_Vendor Order Detailes_CO";
            }


        }
    }
    var
}