pageextension 60176 FBM_BankAccListExt_CO extends "Bank Account List"
{
    layout
    {
        addafter(Name)
        {
            field(Balance; rec.Balance)
            {
                ApplicationArea = all;
            }
            field("Balance (LCY)"; rec."Balance (LCY)")
            {
                ApplicationArea = All;
            }
            field(FBM_IsPayment; Rec.FBM_IsPayment)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Trial Balance")
        {
            action(BankTrialBalance)
            {
                Caption = 'Bank Trial Balance';
                ApplicationArea = All;
                Image = BankAccountStatement;

                trigger OnAction()
                begin
                    BTB.Run();
                end;
            }
        }
    }
    var
        BTB: Report "FBM_Bank Trial Balance_CO";


        usersetup: Record "User Setup";


    trigger OnOpenPage()
    begin
        if usersetup.Get(UserId) then begin
            if usersetup."FBM_Bank Filter" <> '' then
                Rec.SetFilter("No.", usersetup."FBM_Bank Filter");

        end;


    end;
}
