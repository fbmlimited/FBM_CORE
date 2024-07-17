pageextension 60123 FBM_GLSetupExt_CO extends "General Ledger Setup"
{
    layout
    {
        // modify("Shortcut Dimension 3 Code")
        // {
        //     Editable = false;
        // }
        // modify("Shortcut Dimension 6 Code")
        // {
        //     Editable = false;
        // }

        addlast(General)
        {
            field(FBM_ExchRateFluctuation; Rec.FBM_ExchRateFluctuation)
            {
                ApplicationArea = all;
                Visible = issuper;
            }
        }
    }
    trigger
    OnOpenPage()
    begin
        cinfo.get();
        visph := (cinfo."Country/Region Code" = 'PH');

        issuper := uper.IsSuper(UserSecurityId())

    end;

    var
        cinfo: record "Company Information";
        visph: Boolean;
        uper: codeunit "User Permissions";
        issuper: boolean;


}
