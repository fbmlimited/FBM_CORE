pageextension 60157 FBM_PurchOrdSubExt_CO extends "Purchase Order Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Prepayment %")
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
#if MAIN
        modify("IDPIRPF IRPF")
        {

            Visible = ises;
        }
        modify("IDPIRPF IRPF Amount")
        {

            Visible = ises;
        }
        modify("IDPIRPF IRPF Group")
        {

            Visible = ises;
        }
        modify("IDPIRPF Total IRPF Amount")
        {

            Visible = ises;
        }
        modify("IDPIRPF TotalAmountWithVATWithoutIRPF")
        {

            Visible = ises;
        }
#endif


    }
    trigger
   OnOpenPage()
    begin
        purchsetup.get;
        isped := purchsetup.FBM_Use_Pedimento;
        compinfo.get;
        ises := compinfo."Country/Region Code" = 'ES';

    end;

    var
        purchsetup: record "Purchases & Payables Setup";
        isped: Boolean;
        ises: Boolean;
        compinfo: record "Company Information";

}
