pageextension 60154 FBM_PurchCrMSubExt_CO extends "Purch. Cr. Memo Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
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
        addafter("Location Code")
        {
            field(FBM_Site; Rec.FBM_Site)
            {
                ApplicationArea = all;
            }
        }
        addlast(Control1)
        {
            field(FBM_IsFreight; Rec.FBM_IsFreight)
            {
                ApplicationArea = all;
            }
            field(FBM_IsWht; Rec.FBM_IsWht)
            {
                ApplicationArea = all;
            }

        }
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
