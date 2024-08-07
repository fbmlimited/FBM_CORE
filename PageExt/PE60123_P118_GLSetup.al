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

        addafter(General)
        {
            group("Exchange Rate")
            {
                Visible = issuperPH;

                field(FBM_ExchRateFluctuation; Rec.FBM_ExchRateFluctuation)
                {
                    ApplicationArea = all;

                }
                field(FBM_ExchRateFluctuationPHPMin; Rec.FBM_ExchRatePHPMin)
                {
                    ApplicationArea = all;

                }
                field(FBM_ExchRateFluctuationPHPMax; Rec.FBM_ExchRatePHPMax)
                {
                    ApplicationArea = all;

                }
            }
        }
    }
    trigger
    OnOpenPage()
    begin
        cinfo.get();
        visph := (cinfo."Country/Region Code" = 'PH');

        issuperph := uper.IsSuper(UserSecurityId()) and visph;

    end;

    var
        cinfo: record "Company Information";
        visph: Boolean;
        uper: codeunit "User Permissions";
        issuperPH: boolean;


}
