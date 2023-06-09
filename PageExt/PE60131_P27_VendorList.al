pageextension 60131 FBM_VendorListext_CO extends "Vendor List"
{
    layout
    {
        addafter("Search Name")
        {
            field("Currency Code12915"; Rec."Currency Code")
            {
                ApplicationArea = All;
            }
        }
    }
}