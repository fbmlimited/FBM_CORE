pageextension 60178 FBM_ChartOfAccExt_CO extends "Chart of Accounts"
{
    layout
    {
        addafter(Balance)
        {
            field("FBM_Periods Required"; Rec."FBM_Periods Required")
            {
            }
        }
    }
    actions
    {
    }
}
