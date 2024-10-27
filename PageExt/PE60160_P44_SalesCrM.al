pageextension 60160 SalesCreditMemoExt extends "Sales Credit Memo"
{
    layout
    {
#if MAIN
        modify("IDPIRPF IRPF Group")
        {
            visible = ises;
        }
#endif
        moveafter("External Document No."; "Shortcut Dimension 1 Code")
        moveafter("External Document No."; "Shortcut Dimension 2 Code")
        addafter("Shortcut Dimension 1 Code")
        {
            field("Posting Description63167"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
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
                            if page.RunModal(60167, CustSite) = Action::LookupOK then Rec.Validate(fbm_site, CustSite."Site Code");
                        end
                    end
                    else begin
                        CustSite.SetFilter(CustSite."Customer No.", rec."Sell-to Customer No.");
                        CustSite.SetRange(ActiveRec, true);
                        if CustSite.FindFirst() then begin
                            if page.RunModal(60167, CustSite) = Action::LookupOK then Rec.Validate(fbm_site, CustSite."Site Code");
                        end
                        else begin
                            if page.RunModal(60167, CustSiteFull) = Action::LookupOK then Rec.Validate(fbm_site, CustSiteFull."Site Code");
                        end;
                    end;
                    CurrPage.Update(true);
                end;

                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }

            field("FBM_Contract Code"; rec."FBM_Contract Code")
            {
                ApplicationArea = All;
            }
            field(FBM_Segment2; Rec.FBM_Segment2)
            {
                ApplicationArea = All;
            }

            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                ApplicationArea = all;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                ApplicationArea = all;
            }


        }
        addlast(General)
        {
            field(Currency2; rec.FBM_Currency2)
            {
                ApplicationArea = all;

            }
            field(LocalCurrAmt; rec.FBM_LocalCurrAmt)
            {
                ApplicationArea = all;

            }

            field(LCY; glsetup."LCY Code")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
    }
    trigger
       OnOpenPage()
    begin
        compinfo.Get();
        showsite := compinfo.FBM_CustIsOp;
        glsetup.Get();
        ises := compinfo."Country/Region Code" = 'ES';

    end;




    var

        compinfo: record "Company Information";
        showsite: Boolean;
        glsetup: record "General Ledger Setup";
        ises: Boolean;
}
