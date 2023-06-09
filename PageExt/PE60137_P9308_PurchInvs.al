pageextension 60137 FBM_PurchInvsExt_CO extends "Purchase Invoices"
{
    layout
    {
        addafter(Amount)
        {
            field("Shortcut Dimension 1 Code45814"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Shortcut Dimension 2 Code60954"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
