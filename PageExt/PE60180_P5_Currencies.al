pageextension 60180 FBM_CurrenciesExt_CO extends Currencies
{
    actions
    {
        addlast(processing)
        {
            action("PHP/USD")
            {
                Visible = visph;
                Image = ExchangeRateAdjustRegister;
                RunObject = page FBM_ExchRatePHP_CO;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

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