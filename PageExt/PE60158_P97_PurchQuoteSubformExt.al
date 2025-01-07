pageextension 60158 FBM_PurchQuoteSubExt_CO extends "Purchase Quote Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
#if MAIN
        modify("IDPIRPF IRPF Group")
        {
            Visible = ises;
        }
        modify("IDPIRPF IRPF")
        {
            Visible = ises;
        }
        modify("IDPIRPF IRPF Amount")
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
    trigger OnOpenPage()

    begin

        if compinfo.Get() then begin


            ises := compinfo."Country/Region Code" = 'ES';
        end;


    end;

    var

        compinfo: record "Company Information";

        ises: Boolean;

}
