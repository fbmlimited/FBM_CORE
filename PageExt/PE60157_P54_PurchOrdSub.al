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

        compinfo.get;
        ises := compinfo."Country/Region Code" = 'ES';

    end;

    var
        ises: Boolean;
        compinfo: record "Company Information";

}
