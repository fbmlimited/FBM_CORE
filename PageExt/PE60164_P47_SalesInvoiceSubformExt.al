pageextension 60164 FBM_SalesInvSubExt_CO extends "Sales Invoice Subform"
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
        modify("IDPIRPF Total IRPF Amount")
        {
            Visible = ises;
        }
        modify("IDPIRPF TotalAmountWithVATWithoutIRPF")
        {
            Visible = ises;
        }
#endif
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
    var
        uper: Codeunit "User Permissions";
    begin

        if compinfo.Get() then begin

            showsite := compinfo.FBM_CustIsOp;
            ises := compinfo."Country/Region Code" = 'ES';

        end;


    end;

    var

        compinfo: record "Company Information";
        showsite: Boolean;
        ises: Boolean;
}
