pageextension 60133 FBM_PostSCrMSubExt_CO extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Variant Code")
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
    }
    trigger OnOpenPage()
    begin
        compinfo.Get();
        showsite := compinfo.FBM_CustIsOp;
        ;
        ises := compinfo."Country/Region Code" = 'ES';
    end;


    var

        compinfo: record "Company Information";
        showsite: Boolean;
        ises: Boolean;
}
