page 60101 "FBM_CustomerSite_CO"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FBM_CustomerSite_C;
    caption = 'Customer/Site';


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
                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                csite.SetFilter(status, '<>%1', csite.status::"STOP OPERATION");// don't count the ceased ones
                                if csite.IsEmpty then
                                    site.Mark(true)
                                else
                                    site.mark(false);
                            until site.Next() = 0;

                        site.setrange(Company1);
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

                            end;
                        end;
                    end;
                }
            }
            repeater(GroupName)
            {
                field(SiteGrCode; Rec.SiteGrCode)
                {
                    ApplicationArea = All;
                    Caption = 'Site Gr. Code';
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
                    Editable = issuper;
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
        }
    }
    trigger
    OnOpenPage()
    begin
        issuper := uper.IsSuper(UserSecurityId())
    end;

    trigger
    OnAfterGetRecord()
    begin
        compinfo.get;
        EnableSpin := compinfo.FBM_EnSpin;
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
}

