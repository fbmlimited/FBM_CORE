pageextension 60174 FBM_BankAccLEPrw extends "Bank Acc. Ledg. Entr. Preview"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field(BankName; BankName)
            {
                Caption = 'Bank Name';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    var
        BankName: Text[150];

        BankAccount: Record "Bank Account";

    trigger OnAfterGetRecord()
    begin
        BankAccount.reset;
        if BankAccount.Get(Rec."Bank Account No.") then
            BankName := BankAccount.Name
        else
            BankName := '';
    end;

}
