pageextension 60196 FBM_InvSetupExt_CO extends "Inventory Setup"
{
    layout
    {
        addlast(General)
        {
            field(FBM_InvAdjTemplate; Rec.FBM_InvAdjTemplate)
            {
                ApplicationArea = all;


            }
            field(FBM_InvAdjBatch; Rec.FBM_InvAdjBatch)
            {
                ApplicationArea = all;


            }


        }

    }
}