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
        addlast(Reporting)
        {
            field(FBM_EmailAR; Rec.FBM_EmailAR)
            {
                ApplicationArea = all;
            }
        }
        addafter(General)
        {
            group("Exchange Rate")
            {
                Visible = issuper;


                field(FBM_ExchRateFluctuation;
                Rec.FBM_ExchRateFluctuation)
                {
                    ApplicationArea = all;
                    Visible = visph;

                }
                field(FBM_ExchRateFluctuationPHPMin; Rec.FBM_ExchRatePHPMin)
                {
                    ApplicationArea = all;
                    Visible = visph;

                }
                field(FBM_ExchRateFluctuationPHPMax; Rec.FBM_ExchRatePHPMax)
                {
                    ApplicationArea = all;
                    Visible = visph;

                }
                field(FBM_CheckMinMaMax; Rec.FBM_CheckMinMaMax)
                {
                    ApplicationArea = all;
                    Visible = visph;

                }
                field(FBM_PropExchRate; Rec.FBM_PropExchRate)
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


        issuper := uper.IsSuper(UserSecurityId());
    end;

    var
        cinfo: record "Company Information";
        visph: Boolean;
        uper: codeunit "User Permissions";

        issuper: boolean;



}
