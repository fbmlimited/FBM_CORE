pageextension 60192 FBM_PostedPInvSubExt_CO extends "Posted Purch. Invoice Subform"
{
    layout
    {
#if MAIN
        modify("IDPIRPF Total IRPF Amount")
        {
            Visible = ises;

        }
        modify("IDPIRPF IRPF Group")
        {
            Visible = ises;

        }
        modify("IDPIRPF IRPF Amount")
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