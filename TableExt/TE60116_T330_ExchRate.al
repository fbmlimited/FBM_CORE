tableextension 60116 FBM_ExchRateExt_CO extends "Currency Exchange Rate"
{
    trigger

    OnAfterInsert()
    begin
        proprec();
    end;

    trigger
    OnAfterModify()
    begin
        proprec();
    end;

    trigger
    OnDelete()
    begin
        glsetupo.Get();
        if glsetupo.FBM_PropExchRateTo then begin
            compd.FindFirst();
            repeat
                glsetupd.ChangeCompany(compd.Name);
                glsetupd.Get();
                if glsetupd.FBM_PropExchRate = glsetupo.CurrentCompany then begin
                    cecd.ChangeCompany(compd.Name);
                    cecd.SetRange("Starting Date", xrec."Starting Date");
                    cecd.SetRange("Currency Code", xrec."Currency Code");
                    if cecd.FindSet(true) then begin
                        cecd.delete;
                    end;
                end;
            until compd.next = 0;
        end;
    end;

    local procedure
    proprec()

    begin
        glsetupo.Get();
        if glsetupo.FBM_PropExchRateTo then begin
            compd.FindFirst();


            repeat
                glsetupd.ChangeCompany(compd.Name);
                glsetupd.Get();
                if glsetupd.FBM_PropExchRate = glsetupo.CurrentCompany then begin
                    cecd.ChangeCompany(compd.Name);
                    cecd.SetRange("Starting Date", rec."Starting Date");
                    cecd.SetRange("Currency Code", rec."Currency Code");
                    if cecd.FindSet(true) then begin

                        cecd."Adjustment Exch. Rate Amount" := rec."Adjustment Exch. Rate Amount";
                        cecd."Exchange Rate Amount" := rec."Exchange Rate Amount";
                        cecd."Fix Exchange Rate Amount" := rec."Fix Exchange Rate Amount";
                        cecd."Relational Adjmt Exch Rate Amt" := rec."Relational Adjmt Exch Rate Amt";
                        cecd."Relational Currency Code" := rec."Relational Currency Code";
                        cecd."Relational Exch. Rate Amount" := rec."Relational Exch. Rate Amount";
                        cecd.Modify();
                    end
                    else begin
                        cecd.Reset();
                        cecd.Init();
                        cecd.TransferFields(rec, true);
                        cecd.Insert();
                    end;
                end;

            until compd.next = 0;


        end;

    end;

    var

        compo: record Company;
        compd: record Company;
        glsetupo: record "General Ledger Setup";
        glsetupd: record "General Ledger Setup";
        cecd: record "Currency Exchange Rate";


}