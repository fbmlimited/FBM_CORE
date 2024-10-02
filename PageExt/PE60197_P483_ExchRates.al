pageextension 60197 FBM_ExchRatesExt_CO extends "Currency Exchange Rates"
{
    layout
    {

    }
    actions
    {
        addlast(processing)
        {
            action("PHP/USD")
            {
                Visible = visph;
                Image = ExchangeRateAdjustRegister;
                RunObject = page FBM_ExchRatePHP_CO;
                RunPageOnRec = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;

            }

        }

    }
    trigger
   OnOpenPage()
    begin
        cinfo.get();
        if cinfo."Country/Region Code" = 'PH' then
            visph := true;


    end;

    var
        cinfo: record "Company Information";
        visph: Boolean;
}

