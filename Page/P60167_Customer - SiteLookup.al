page 60167 "FBM_CustomerSiteLook_CO"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FBM_CustomerSite_C;
    caption = 'Customer/Site';
    RefreshOnActivate = true;
    SourceTableTemporary = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {

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


        }
    }

    trigger
    OnOpenPage()
    var
        csite: record FBM_CustomerSite_C;
        usetup: record "User Setup";
    begin
        rec.SetRange(ActiveRec, true);
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


}

