pageextension 60146 FBM_VendorCardExt_CO extends "Vendor Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Default Bank Account"; rec."FBM_Default Bank Account")
            {
                ApplicationArea = All;
            }


        }
        addlast(General)
        {
            field("Print Name on Check"; Rec."FBM_Print Name on Check")
            {
                ApplicationArea = All;
            }

        }
    }

}