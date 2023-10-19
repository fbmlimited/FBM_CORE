page 60144 FBM_ExchRatePHP_CO
{
    Caption = 'Exchange Rate PHP/USD';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Currency Exchange Rate";
    DeleteAllowed = false;
    SourceTableView = where("Currency Code" = const('USD'));

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
                        IF stdate <> 0D then
                            rateen := true;
                        setfil();
                        if rec.IsEmpty then begin
                            rec.Init();
                            rec."Starting Date" := stdate;
                            rec."Currency Code" := 'USD';
                            rec.Insert();
                        end;
                    end;
                }
                field(exrateC; exrate)
                {
                    Enabled = rateen;

                    caption = 'PHP/USD Rate';
                    ApplicationArea = All;
                    trigger
                    OnValidate()
                    var
                        exchrate: record "Currency Exchange Rate";
                        lastrate: Decimal;
                        glsetup: record "General Ledger Setup";

                    begin
                        glsetup.get;
                        IF stdate = 0D THEN
                            error('Missing date.');
                        exchrate.SetRange("Currency Code", 'USD');
                        exchrate.SetFilter("Starting Date", '<=%1', stdate);
                        IF exchrate.FindLast() then begin
                            lastrate := exchrate."Relational Exch. Rate Amount";
                            if (abs((exrate - lastrate) / lastrate) * 100) > glsetup.FBM_ExchRateFluctuation then
                                error('The Fluctuation exceeds the limit. Contact the system Administrator');
                        end;
                        if rec."Relational Exch. Rate Amount" <> 0 then begin
                            if Confirm('There is already a value set. Do you really want to change %1 with %2?', false, rec."Relational Exch. Rate Amount", exrate) then begin
                                if not confirm('Are you sure?', false) then
                                    exit;
                            end
                            else
                                exit;
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
                    Editable = false;
                }
                field("Relational Exch. Rate Amount"; Rec."Relational Exch. Rate Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }


    var
        stdate: date;
        exrate: Decimal;
        rateen: Boolean;


    local procedure setfil()
    begin
        rec.setrange("Starting Date", stdate);
        rec.setrange("Currency Code", 'USD');
        rec.FindFirst();
    end;

    local procedure append()
    begin
        rec.validate("Relational Exch. Rate Amount", exrate);
        rec.Validate("Relational Adjmt Exch Rate Amt", exrate);
        rec.validate("Exchange Rate Amount", 1);
        rec.validate("Adjustment Exch. Rate Amount", 1);
        rec.validate("Fix Exchange Rate Amount", rec."Fix Exchange Rate Amount"::Currency);
    end;
}

