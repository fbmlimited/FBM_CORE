pageextension 60179 FBM_PurchSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Local Functionalities PHL")
        {
            field(FBM_Enable_CompMsg; Rec.FBM_Enable_CompMsg)
            {
                ApplicationArea = all;
            }
        }
    }
}