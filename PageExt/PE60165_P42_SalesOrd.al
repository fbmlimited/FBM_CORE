pageextension 60165 FBM_SalesOrdExt_CO extends "Sales Order"
{
    layout
    {
        addafter("External Document No.")
        {
            field(FBM_Site; Rec.FBM_Site)
            {
                Visible = showsite;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    CustSite: Record FBM_CustomerSite_C;
                    CustSiteFull: Record FBM_CustomerSite_C;
                    FASetup: Record "FA Setup";
                    companyinfo: record "Company Information";
                begin
                    CustSite.Reset();
                    FASetup.Get();
                    CustSiteFull.Reset();
                    companyinfo.Reset();
                    companyinfo.Get();
                    if companyinfo.FBM_CustIsOp then begin
                        CustSite.SetFilter(CustSite."Customer No.", rec."Sell-to Customer No.");
                        CustSite.SetRange(ActiveRec, true);
                        if CustSite.FindFirst() then begin
                            if page.RunModal(60101, CustSite) = Action::LookupOK then Rec.Validate(fbm_Site, CustSite."Site Code");
                        end
                    end
                    else begin
                        CustSite.SetFilter(CustSite."Customer No.", rec."Sell-to Customer No.");
                        CustSite.SetRange(ActiveRec, true);
                        if CustSite.FindFirst() then begin
                            if page.RunModal(60101, CustSite) = Action::LookupOK then Rec.Validate(fbm_Site, CustSite."Site Code");
                        end
                        else begin
                            if page.RunModal(60101, CustSiteFull) = Action::LookupOK then Rec.Validate(fbm_Site, CustSiteFull."Site Code");
                        end;
                    end;
                    CurrPage.Update(true);
                end;

                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }

            field("FBM_Contract Code"; Rec."FBM_Contract Code")
            {
                ApplicationArea = All;
            }

            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                Visible = showsite;
                ApplicationArea = all;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                Visible = showsite;
                ApplicationArea = all;
            }

        }
        addlast(General)
        {
            field(FBM_PO_Customer; Rec.FBM_PO_Customer)
            {
                ApplicationArea = All;
                enabled = povis;

            }
        }
        modify("Bill-to Name")
        {
            trigger
            OnAfterValidate()
            begin
                if cust.get(rec."Bill-to Customer No.") then
                    if cust.FBM_Acronym <> '' then
                        povis := true
                    else
                        povis := false;
            end;
        }
    }
    var
        POvis: Boolean;
        cust: record Customer;

    trigger
        OnOpenPage()
    begin
        compinfo.Get();
        showsite := compinfo.FBM_CustIsOp;
        if cust.get(rec."Bill-to Customer No.") then
            if cust.FBM_Acronym <> '' then
                povis := true;

    end;




    var

        compinfo: record "Company Information";
        showsite: Boolean;
}
