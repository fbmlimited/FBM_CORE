pageextension 60169 FBM_UserSetupExt_CO extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("See LCY in Journals"; rec."FBM_See LCY in Journals")
            {
                ApplicationArea = All;
            }

        }
        addafter("Email")
        {
            field("Item Filter"; rec."FBM_Item Filter")
            {
                ApplicationArea = All;
            }

            field("Bank Filter"; rec."FBM_Bank Filter")
            {
                ApplicationArea = All;
            }
            field("Approve Finance"; rec."FBM_Approve Finance")
            {

            }
            field("Approve AP"; rec."FBM_Approve AP")
            {

            }
        }
    }
    actions
    {
    }
    var
}
