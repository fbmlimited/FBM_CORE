pageextension 60113 FBM_DetCustLEPrwExt_CO extends "Det. Cust. Ledg. Entr. Preview"
{
    layout
    {
        addafter("Customer No.")
        {
            field(CustName; CustName)
            {
                Caption = 'Customer Name';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    var
        CustName: Text[150];
        Customer: Record Customer;

    trigger OnAfterGetRecord()
    begin
        Customer.reset;
        if Customer.Get(Rec."Customer No.") then
            CustName := Customer.Name
        else
            CustName := '';
    end;
}
