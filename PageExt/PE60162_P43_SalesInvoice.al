pageextension 60162 FBM_SalesInvExt_CO extends "Sales Invoice"
{
    layout
    {
#if MAIN
        modify("IDPIRPF IRPF Group")
        {
            visible = ises;
        }
#endif

        modify("Sell-to Contact")
        {
            Importance = Additional;
        }

        moveafter(Status; "Shortcut Dimension 1 Code")
        moveafter(Status; "Shortcut Dimension 2 Code")
        addafter("Shortcut Dimension 1 Code")
        {
            field("Posting Description63167"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
        }

        addafter("External Document No.")
        {
            field("Posting No._CO"; rec."Posting No.")
            {
                ApplicationArea = All;
            }
            field(Site_CO; rec.FBM_Site)
            {
                Visible = showsite;
                ApplicationArea = All;
                Importance = Additional;
                trigger OnLookup(var Text: Text): Boolean
                var
                    CustSite: Record FBM_CustomerSite_C;
                    CustSiteFull: Record FBM_CustomerSite_C;
                    FASetup: Record "FA Setup";
                    companyinfo: record "Company Information";
                    CustmoerSiteP: Page FBM_CustomerSite_CO;
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
                            if page.RunModal(60167, CustSite) = Action::LookupOK then begin

                                Rec.Validate(fbm_Site, CustSite."Site Code");

                            end;
                            /*if CustmoerSiteP.RunModal = Action::LookupOK then
                               Rec.Validate(fbm_site, CustSite."Site Code");*/
                        end
                    end
                    else begin
                        CustSite.SetFilter(CustSite."Customer No.", rec."Sell-to Customer No.");
                        CustSite.SetRange(ActiveRec, true);
                        if CustSite.FindFirst() then begin
                            if page.RunModal(60167, CustSite) = Action::LookupOK then Rec.Validate(fbm_Site, CustSite."Site Code");
                        end
                        else begin
                            if page.RunModal(60167, CustSiteFull) = Action::LookupOK then Rec.Validate(fbm_Site, CustSiteFull."Site Code");
                        end;
                    end;
                    CurrPage.Update(true);
                end;

                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }

            field("Contract Code_CO"; rec."FBM_Contract Code")
            {
                ApplicationArea = All;
                Editable = false;
                Importance = Additional;
            }
            field(Segment_CO; rec.FBM_Segment2)
            {
                ApplicationArea = All;
            }

            field("Period Start_CO"; rec."FBM_Period Start")
            {
                Visible = showsite;
                ApplicationArea = all;
            }
            field("Period End_CO"; rec."FBM_Period End")
            {
                Visible = showsite;
                ApplicationArea = all;
            }

            field(signature_pic; rec.FBM_Signature_pic)
            {
                ApplicationArea = all;
            }


            field("Billing Statement_CO"; rec."FBM_Billing Statement")
            {
                ApplicationArea = all;
                //Importance = Additional;
                Visible = isph;


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
        addafter("Currency Code")
        {
            field("Customer Payment Bank Code"; rec."FBM_Cust Payment Bank Code_FF")
            {
                ApplicationArea = all;
                Editable = false;
                Importance = Additional;
            }

            field("Customer Payment Bank Code2"; rec."FBM_Cust Payment Bank Code2_FF")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
        modify("Company Bank Account Code")
        {

            Visible = false;
        }
        addlast(factboxes)
        {

            part(signature; FBM_Factbox_SI_CO)
            {

                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
        }




    }


    trigger
    OnOpenPage()
    begin
        compinfo.Get();
        showsite := compinfo.FBM_CustIsOp;
        ises := compinfo."Country/Region Code" = 'ES';
        isph := compinfo."Country/Region Code" = 'PH';

    end;




    var
        glsetup: record "General Ledger Setup";

        usersetup: record "User Setup";
        compinfo: record "Company Information";
        showsite: Boolean;
        ises: Boolean;
        cinfo: record "Company Information";
        isph: Boolean;

}
