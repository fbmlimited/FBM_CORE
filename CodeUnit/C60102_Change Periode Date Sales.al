codeunit 60102 "FBM_AdjustExchRate_CO"
{
    trigger
    OnRun()
    begin
        Codeunit.run(1281);
        fixexch();

    end;

    procedure fixexch()
    var
        cexch: record "Currency Exchange Rate";
        cexch2: record "Currency Exchange Rate";
        comp: record Company;
        cinfo: record "company Information";
    begin
        comp.findfirst;
        repeat

            cinfo.changecompany(comp.name);
            cinfo.get();
            cexch.changecompany(comp.name);
            cexch2.changecompany(comp.name);
            cexch.SetRange("Starting Date", DMY2Date(Date2DMY(calcdate('-1D', Today), 1), Date2DMY(calcdate('-1D', Today), 2), Date2DMY(calcdate('-1D', Today), 3)));
            cexch2.SetRange("Starting Date", Today);

            if cexch.FindFirst() then
                repeat
                    cexch2.SetRange("Currency Code", cexch."Currency Code");
                    if not cexch2.FindFirst() then begin
                        cexch2.init;
                        cexch2."Starting Date" := Today;
                        cexch2."Currency Code" := cexch."Currency Code";
                        cexch2."Exchange Rate Amount" := cexch."Exchange Rate Amount";
                        cexch2."Adjustment Exch. Rate Amount" := cexch."Adjustment Exch. Rate Amount";
                        cexch2."Relational Currency Code" := cexch."Relational Currency Code";
                        cexch2."Relational Exch. Rate Amount" := cexch."Relational Exch. Rate Amount";
                        cexch2."Relational Adjmt Exch Rate Amt" := cexch."Relational Adjmt Exch Rate Amt";
                        cexch2."Fix Exchange Rate Amount" := cexch."Fix Exchange Rate Amount";
                        cexch2.Insert();
                    end;

                until cexch.Next() = 0;

        until comp.next = 0;
    end;
}