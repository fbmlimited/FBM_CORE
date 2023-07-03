page 60101 "FBM_CustomerSite_CO"
{
    PageType = List;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = FBM_CustomerSite_C;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(Selection)
            {

                field(selsite; selsite)
                {

                    ApplicationArea = all;
                    trigger
                    OnLookup(var Text: Text): Boolean
                    var
                        compinfo: record "Company Information";
                        csite: record FBM_CustomerSite_C;
                    begin
                        compinfo.get;
                        site.SetRange(Company1, compinfo."Custom System Indicator Text");
                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                if csite.IsEmpty then
                                    site.Mark(true);
                            until site.Next() = 0;
                        site.SetRange(Company2, compinfo."Custom System Indicator Text");
                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                if csite.IsEmpty then
                                    site.Mark(true);
                            until site.Next() = 0;
                        site.SetRange(Company3, compinfo."Custom System Indicator Text");
                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                if csite.IsEmpty then
                                    site.Mark(true);
                            until site.Next() = 0;
                        site.setrange(Company1);
                        site.SetRange(Company2);
                        site.SetRange(Company3);
                        site.MarkedOnly(true);

                        if page.RunModal(page::FBM_SiteLookup_CO, site) = action::LookupOK then begin
                            selsite := site."Site Code";

                            rec.SiteGrCode := site."Site Code";
                        end
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


            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
    }
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
}