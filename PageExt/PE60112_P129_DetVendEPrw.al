pageextension 60112 FBM_DetVendEntPrwExt_CO extends "Detailed Vend. Entries Preview"
{
    layout
    {
        addafter("Vendor No.")
        {
            field(VendName; VendName)
            {
                Caption = 'Vendor Name';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    var
        VendName: Text[150];
        Vendor: Record Vendor;

    trigger OnAfterGetRecord()
    begin
        Vendor.reset;
        if Vendor.Get(Rec."Vendor No.") then
            VendName := Vendor.Name
        else
            VendName := '';
    end;
}
