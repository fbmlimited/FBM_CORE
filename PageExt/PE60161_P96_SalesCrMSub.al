pageextension 60161 FBM_SalesCrMSubExt_CO extends "Sales Cr. Memo Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        addafter("VAT Prod. Posting Group")
        {


            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                Visible = showsite;
                ApplicationArea = all;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                Visible = showsite;
                ApplicationArea = all;
            }

        }
#if MAIN
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
        addafter("Quantity")
        {

            field(FBM_Site; Rec.FBM_Site)
            {
                Visible = showsite;

                ApplicationArea = all;
            }

        }

    }
    trigger OnOpenPage()

    begin

        if compinfo.Get() then begin

            showsite := compinfo.FBM_CustIsOp;
            ises := compinfo."Country/Region Code" = 'ES';
        end;


    end;

    var
        compinfo: RECORD "Company Information";
        showsite: Boolean;
        ises: Boolean;
}
