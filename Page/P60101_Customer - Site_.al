page 60101 "FBM_CustomerSite_CO"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FBM_CustomerSite_Ctmp;
    caption = 'Customer/Site';
    RefreshOnActivate = true;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            group(Selection)
            {

                field(selsite; selsite)
                {
                    caption = 'Select New Site';
                    ApplicationArea = all;
                    trigger
                    OnLookup(var Text: Text): Boolean
                    var
                        compinfo: record "Company Information";
                        csite: record FBM_CustomerSite_C;
                        maxnum: Integer;
                    begin
                        clear(site);
                        compinfo.get;
                        site.SetRange(Company1, compinfo."Custom System Indicator Text");
                        site.SetRange(ActiveRec, true);


                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                csite.SetFilter(status, '<>%1', csite.status::"STOP OPERATION");// don't count the ceased ones
                                csite.SetRange(ActiveRec, true);
                                if csite.IsEmpty then
                                    site.Mark(true)
                                else
                                    site.mark(false);
                            until site.Next() = 0;

                        site.setrange(Company1);
                        site.SetRange(ActiveRec, true);
                        site.SetRange(Company2, compinfo."Custom System Indicator Text");
                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                if csite.IsEmpty then
                                    site.Mark(true)
                                else
                                    site.mark(false);
                            until site.Next() = 0;
                        site.SetRange(Company2);
                        site.SetRange(ActiveRec, true);
                        site.SetRange(Company3, compinfo."Custom System Indicator Text");
                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                if csite.IsEmpty then
                                    site.Mark(true)
                                else
                                    site.mark(false);
                            until site.Next() = 0;
                        site.setrange(Company1);
                        site.SetRange(Company2);
                        site.SetRange(Company3);
                        site.SetRange(ActiveRec, true);
                        site.MarkedOnly(true);

                        if page.RunModal(page::FBM_SiteLookup_CO, site) = action::LookupOK then begin
                            selsite := site."Site Code";
                            if rec.SiteGrCode = '' then begin
                                rec.SiteGrCode := site."Site Code";
                                csite.Reset();
                                csite.setrange("Customer No.", rec."Customer No.");
                                if csite.FindLast() then
                                    if strpos(csite."Site Code", '-') > 0 then
                                        evaluate(maxnum, copystr(csite."Site Code", strpos(csite."Site Code", '-') + 1))
                                    else
                                        maxnum := 0
                                else
                                    maxnum := 0;
                                //rec.Rename(rec."Customer No.", rec."Customer No." + '-' + PADSTR('', 4 - strlen(FORMAT(MAXNUM + 1)), '0') + FORMAT(MAXNUM + 1));
                                rec."Site Code" := rec."Customer No." + '-' + PADSTR('', 4 - strlen(FORMAT(MAXNUM + 1)), '0') + FORMAT(MAXNUM + 1);
                                csite.Init();
                                csite."Site Code" := rec."Site Code";
                                csite."Customer No." := pcust;
                                csite.Version := 1;
                                csite.ActiveRec := true;
                                csite.SiteGrCode := rec.SiteGrCode;
                                csite.Typerec := prec;
                                if prec = prec::Landbase then
                                    csite.TypeSite := rec.TypeSite::Site;
                                csite.Insert(true);
                            end;
                        end;
                    end;
                }
            }
            repeater(GroupName)
            {
                field(Typerec; Rec.Typerec)
                {
                    ApplicationArea = All;

                    enabled = false;
                }
                field(TypeSite; Rec.TypeSite)
                {
                    ApplicationArea = All;

                    enabled = isonline;
                    trigger
                    OnValidate()
                    begin
                        if rec.Typerec = rec.Typerec::Online then
                            if rec.TypeSite = rec.TypeSite::Site then
                                error('Site is used  only for Landbase');
                    end;
                }
                field(SiteGrCode; Rec.SiteGrCode)
                {
                    ApplicationArea = All;
                    Caption = 'Site Gr. Code';
                    enabled = existrec;
                }
                field("Site Code"; rec."Site Code")
                {
                    ApplicationArea = All;
                    Caption = 'Site Code';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = ismaster;
                    trigger
                                       OnValidate()
                    var

                        pcsite: page FBM_CustomerSite_CO;
                        csite: record FBM_CustomerSite_C;
                    begin
                        // commit;
                        // csite.setrange("Customer No.", rec."Customer No.");
                        // pcsite.SetTableView(csite);
                        // //CurrPage.Close();
                        // pcsite.Run();
                        // pcsite.Close();
                        // CurrPage.Close();
                        //clear(pcsite);
                        // error('');

                    end;
                }
                field("Site Name"; rec."Site Name_FF")
                {
                    ApplicationArea = All;
                    Caption = 'Site Name';
                }
                field(Address; rec.Address_FF)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; rec."Address 2_FF")
                {
                    ApplicationArea = All;
                }
                field(City; rec.City_FF)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; rec."Post Code_FF")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; rec."Country/Region Code_FF")
                {
                    ApplicationArea = All;
                }


                field(Contact; rec.Contact)
                {
                    ApplicationArea = all;

                }
                field("Contract Code"; rec."Contract Code")
                {
                    ApplicationArea = all;
                }

                field("Contract Code2"; rec."Contract Code2")
                {
                    ApplicationArea = all;
                    visible = EnableSpin;
                }
                field("Vat Number"; Rec."Vat Number")
                {
                    ApplicationArea = all;
                }

            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(sol)
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;

                caption = 'Change Request';

                trigger OnAction()
                var
                    req: record FBM_CustSiteReq;
                    reqpage: page FBM_SiteChangeReq_DD;
                begin
                    reqpage.passpar(rec.SiteGrCode, true);
                    req.Init();
                    req.ReqType := req.ReqType::Edit;
                    req.CustSiteCode := rec.SiteGrCode;
                    req.Rectype := 'SITE';
                    req.Insert();
                    commit;
                    reqpage.SetTableView(req);
                    reqpage.Runmodal();
                    clear(reqpage);
                end;
            }
            action(History)
            {
                ApplicationArea = All;
                Image = History;

                caption = 'History';

                trigger OnAction()
                var

                    hpage: page FBM_CustSiteHist_CO;
                begin
                    hpage.passpar(rec."Customer No.", rec."Site Code");


                    hpage.Run();
                    clear(hpage);
                end;
            }
            action(SetType)
            {
                ApplicationArea = All;
                Image = History;

                caption = 'Set Type Landbase';

                trigger OnAction()
                var

                    csite: record FBM_CustomerSite_C;
                begin
                    csite.FindFirst();
                    repeat
                        //csite.Rename(csite."Customer No.", csite."Site Code", csite.Version, true);
                        csite.Typerec := csite.Typerec::Landbase;
                        csite.TypeSite := csite.TypeSite::Site;
                        csite.Modify();
                    until csite.Next() = 0
                end;
            }
        }
    }
    trigger
                    OnModifyRecord(): Boolean
    var
        csite: record FBM_CustomerSite_C;
    begin

        commit;
        csite.SetRange("Customer No.", rec."Customer No.");
        csite.SetRange("Site Code", rec."Site Code");


        if csite.FindLast() then begin
            if rec.SiteGrCode <> xrec.SiteGrCode then
                csite.validate(SiteGrCode, rec.SiteGrCode);
            if rec.Status <> xrec.Status then
                csite.validate(Status, rec.Status);
            if rec.Contact <> xrec.Contact then
                csite.validate(Contact, rec.Contact);
            if rec."Contract Code" <> xrec."Contract Code" then
                csite.validate("Contract Code", rec."Contract Code");
            if rec."Contract Code2" <> xrec."Contract Code2" then
                csite.validate("Contract Code2", rec."Contract Code2");
            if rec."Vat Number" <> xrec."Vat Number" then
                csite.validate("Vat Number", rec."Vat Number");
            csite.SetRange("Customer No.", rec."Customer No.");
            csite.SetRange("Site Code", rec."Site Code");


            if csite.FindLast() then begin
                csite.SiteGrCode := rec.SiteGrCode;
                csite.Status := rec.Status;
                csite.Contact := rec.Contact;
                csite."Contract Code" := rec."Contract Code";
                csite."Contract Code2" := rec."Contract Code2";
                csite."Vat Number" := rec."Vat Number";
                csite.Typerec := rec.Typerec;
                csite.TypeSite := rec.TypeSite;
                csite.Modify(true);
            end;
        end;
    end;

    trigger
    OnDeleteRecord(): Boolean
    var
        csite: record FBM_CustomerSite_C;
    begin
        csite.SetRange("Customer No.", xrec."Customer No.");
        csite.SetRange("Site Code", xrec."Site Code");
        csite.SetRange(ActiveRec, true);
        if csite.FindFirst() then
            csite.delete;
    end;

    trigger
    OnOpenPage()
    var
        csite: record FBM_CustomerSite_C;
        usetup: record "User Setup";
    begin
        if usetup.get(UserId) then
            ismaster := usetup.FBM_EditMaster;
        issuper := uper.IsSuper(UserSecurityId());
        //rec.SetRange(ActiveRec, true);
        csite.setrange(ActiveRec, true);
        csite.SetRange(Typerec, prec);
        if psite <> psite::" " then
            csite.SetRange(TypeSite, psite);
        if csite.findfirst then
            repeat
                rec.TransferFields(csite, true);
                if rec.Insert() then begin
                end;
            until csite.Next() = 0;
        rec.SetRange("Customer No.", pcust);
    end;

    trigger
    OnAfterGetCurrRecord()
    begin
        compinfo.get;
        EnableSpin := compinfo.FBM_EnSpin;
        existrec := (rec."Site Code" <> '') and (rec.SiteGrCode <> '');
        isonline := rec.Typerec = rec.Typerec::Online;



    end;

    trigger
    OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec.Typerec := prec;
        if prec = prec::Landbase then
            rec.TypeSite := rec.TypeSite::Site;



    end;




    var
        DimensionValue: Record "Dimension Value";
        FASetup: Record "FA Setup";
        EnableSpin: Boolean;
        compinfo: record "Company Information";
        selsite: code[20];
        site: record FBM_Site;
        uper: codeunit "User Permissions";
        issuper: boolean;
        pcust: code[20];
        existrec: Boolean;
        prec: enum FBM_TypeRec_DD;
        psite: enum FBM_TypeSite_DD;
        isonline: Boolean;
        ismaster: Boolean;

    procedure passpar(cust: code[20]; rectype: enum FBM_TypeRec_DD; sitetype: enum FBM_TypeSite_DD)
    begin
        pcust := cust;
        prec := rectype;
        psite := sitetype;

    end;
}

