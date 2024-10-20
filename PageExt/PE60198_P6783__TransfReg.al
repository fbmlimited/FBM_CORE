pageextension 60198 FBM_TransfREgExt_CO extends "Posted Direct Transfers"
{
    layout
    {
        addafter("No.")
        {
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = all;

            }

        }

    }
}