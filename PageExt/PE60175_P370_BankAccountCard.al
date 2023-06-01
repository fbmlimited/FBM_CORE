pageextension 60175 BankAccountCard extends "Bank Account Card"
{
    layout
    {
        addlast(General)
        {
            field("FBM_Check Layout Code"; Rec."FBM_Check Layout Code")
            {
                ApplicationArea = all;

            }
            field(FBM_Beneficiary; Rec.FBM_Beneficiary)
            {
                ApplicationArea = all;

            }
        }

    }
}