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
            field(FBM_EmailTransfer; Rec.FBM_EmailTransfer)
            {
                ApplicationArea = all;


            }
            field(FBM_OrionEmail; Rec.FBM_OrionEmail)
            {
                ApplicationArea = all;


            }
            field(FBM_SendAlertEmail; Rec.FBM_SendAlertEmail)
            {
                ApplicationArea = all;


            }


        }

    }
}