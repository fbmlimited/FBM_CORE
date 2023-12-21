pageextension 60155 FBM_PurchInvSubExt_CO extends "Purch. Invoice Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Deferral Code")
        {
            Visible = true;
        }
        modify("Location Code")
        {
            Visible = true;
        }
        addafter("Location Code")
        {
            field(FBM_Site; Rec.FBM_Site)
            {
                ApplicationArea = all;
            }
            field(FBM_Pedimento1; Rec.FBM_Pedimento1)
            {
                ApplicationArea = all;
                Visible = isped;
            }
            field(FBM_Pedimento2; Rec.FBM_Pedimento2)
            {
                ApplicationArea = all;
                Visible = isped;
            }
            field(FBM_Pedimento3; Rec.FBM_Pedimento3)
            {
                ApplicationArea = all;
                Visible = isped;
            }
            field(FBM_Pedimento4; Rec.FBM_Pedimento4)
            {
                ApplicationArea = all;
                Visible = isped;
            }
            field(FBM_Pedimento; Rec.FBM_Pedimento)
            {
                ApplicationArea = all;
                Visible = isped;
            }
        }

    }
    trigger
    OnOpenPage()
    begin
        purchsetup.get;
        isped := purchsetup.FBM_Use_Pedimento;

    end;

    var
        purchsetup: record "Purchases & Payables Setup";
        isped: Boolean;
}
