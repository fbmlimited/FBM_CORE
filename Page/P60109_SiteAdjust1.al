page 60109 FBM_SiteAdjustCode_CO
{
    Caption = 'Site Adjust - code';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_CustOpSite;


    layout
    {
        area(Content)
        {
            group(header)
            {
                field(maxcode; maxcode)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            repeater(Group)
            {

                field("Site Code"; rec."Site Code")
                {
                    ApplicationArea = All;
                    trigger
                    OnValidate()
                    begin
                        getmaxsite();

                    end;

                    // trigger
                    // OnLookup(var Text: Text): Boolean
                    // var
                    //     tsite: record FBM_CustomerSite_C temporary;
                    //     tcos: Record FBM_CustOpSite temporary;
                    // begin
                    //     companies.FindFirst();
                    //     repeat
                    //         site.Reset();
                    //         site.ChangeCompany(companies.Name);
                    //         site.SetRange("Site Name", rec."Site Name");
                    //         if site.FindFirst() then begin
                    //             tsite.TransferFields(site, true);
                    //             tsite.Insert();
                    //         end;
                    //         cos.Reset();
                    //         cos.ChangeCompany(companies.Name);
                    //         cos.setrange("Customer No.", site."Customer No.");
                    //         cos.SetRange("Site Code", site."Site Code");
                    //         cos.SetFilter("Site Code 2", '<>%1', '');
                    //         if cos.FindFirst() then begin
                    //             tcos.TransferFields(cos, true);
                    //             tcos.Insert();
                    //         end;
                    //     until companies.Next() = 0;
                    //     IF PAGE.RUNMODAL(50034, tsite) = ACTION::LookupOK THEN BEGIN
                    //         tcos.Reset();
                    //         tcos.SetRange("Customer No.", tsite."Customer No.");
                    //         tcos.SetRange("Site Code", tsite."Site Code");
                    //         tcos.SetFilter("Site Code 2", '<>%1', '');
                    //         if tcos.FindFirst() then
                    //             Text := tcos."Site Code 2";
                    //         EXIT(TRUE);
                    //     end;
                    //     clear(tsite);
                    //     Clear(tcos);
                    // end;

                }

            }
        }

    }


    trigger
    OnOpenPage()
    begin
        // rec.SetRange("Site Code 2", '');
        // getmaxsite();
    end;

    trigger
    OnAfterGetRecord()
    var

    begin

        // rec.CalcFields("Site Name");
        // rec.CalcFields("Site Address");

    end;

    var
        sitename: Text;
        siteaddress: Text;
        maxcode: Text;
        cos: record FBM_CustOpSite;
        site: record FBM_CustomerSite_C;
        companies: record Company;
        compinfo: record "Company Information";

    procedure getmaxsite()


    begin
        companies.FindFirst();
        repeat
            compinfo.ChangeCompany(companies.Name);
            cos.ChangeCompany(companies.Name);
            compinfo.get;
            if compinfo.FBM_EnSiteWS then begin
                cos.SetCurrentKey("Site Code");
                if cos.FindLast() then
                    if maxcode < cos."Site Code" then
                        maxcode := cos."Site Code";



            end;

        until companies.Next() = 0;
        CurrPage.Update();


    end;
}