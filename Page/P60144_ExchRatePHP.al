page 60144 FBM_ExchRatePHP_CO
{
    Caption = 'Exchange Rate PHP/USD';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Currency Exchange Rate";
    DeleteAllowed = false;

    layout
    {

        area(Content)
        {
            group("Filter")
            {
                field(stdate; stdate)
                {
                    ApplicationArea = All;
                    trigger
                    OnValidate()
                    begin
                        setfil();
                        if rec.IsEmpty then
                            rec.Init();
                        rec."Starting Date" := stdate;
                        rec."Currency Code" := 'USD';
                        rec.Insert();
                    end;
                }
                field(exchrate; exchrate)
                {
                    ApplicationArea = All;
                    trigger
                    OnValidate()
                    var
                        exchrate: record "Currency Exchange Rate";
                        lastrate: Decimal;

                    begin
                        IF stdate = 0D THEN
                            error('Missing date.');
                        exchrate.SetRange("Currency Code", 'USD');
                        exchrate.SetFilter("Starting Date", '<=%1', stdate);
                        IF exchrate.FindLast() then begin
                            lastrate := exchrate."Relational Exch. Rate Amount";
                            // compare fluctuation
                        end;
                        if rec."Relational Exch. Rate Amount" <> 0 then begin
                            if Confirm('There is already a value set. Do you really want to change %1', false, rec."Relational Exch. Rate Amount") then
                                if not confirm('Are you sure?', false) then exit;
                        end;
                        append();
                    end;
                }

            }
            group("Exchange Rate")
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Relational Exch. Rate Amount"; Rec."Relational Exch. Rate Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        stdate: date;
        exchrate: Decimal;

    local procedure setfil()
    begin
        rec.setrange("Starting Date", stdate);
        rec.setrange("Currency Code", 'USD')
    end;

    local procedure append()
    begin
        rec."Relational Exch. Rate Amount" := exchrate;
        rec."Relational Adjmt Exch Rate Amt" := exchrate;
        rec."Exchange Rate Amount" := 1;
        rec."Adjustment Exch. Rate Amount" := 1;
        rec."Fix Exchange Rate Amount" := rec."Fix Exchange Rate Amount"::Currency;
    end;
}

