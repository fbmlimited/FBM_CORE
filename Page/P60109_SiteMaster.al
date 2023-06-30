page 60109 FBM_SiteMaster_CO
{
    Caption = 'Site Master';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = FBM_Site;


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
            group(general)
            {

                field("Site Code"; rec."Site Code")
                {
                    ApplicationArea = All;

                }
                field("Site Name"; Rec."Site Name")
                {
                    ApplicationArea = All;

                }
                field("Site Name 2"; Rec."Site Name 2")
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;

                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;

                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;

                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;

                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;

                }
                field("Vat Number"; Rec."Vat Number")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field(Company1; Rec.Company1)
                {
                    ApplicationArea = All;

                }
            }
        }


    }

    trigger
                       OnOpenPage()
    begin
        getmaxsite();

    end;

    var
        sitename: Text;
        siteaddress: Text;
        maxcode: Text;
        cos: record FBM_CustOpSite;
        site: record FBM_Site;
        companies: record Company;
        compinfo: record "Company Information";


    procedure getmaxsite()


    begin
        site.SetCurrentKey("Site Code");
        if site.FindLast() then
            maxcode := site."Site Code";
        CurrPage.Update();
    end;
}