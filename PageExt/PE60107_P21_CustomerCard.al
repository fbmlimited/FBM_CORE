pageextension 60107 FBM_CustomerCardExt_CO extends "Customer Card"
{
    Editable = false;
    layout
    {

        addbefore(Name)
        {
            field("No. 2"; rec.FBM_GrCode)
            {
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            field("FBM_Name 3"; Rec."FBM_Name 3")
            {
                ApplicationArea = all;
            }

            field("Customer Since"; rec."FBM_Customer Since")
            {
                ApplicationArea = All;
            }
        }
        addbefore("VAT Registration No.")
        {
            field("Separate Halls Inv."; rec."FBM_Separate Halls Inv.")
            {
                ApplicationArea = All;
                Caption = 'Separate Halls Inv.';
            }
            field("Payment Bank Code"; rec."FBM_Payment Bank Code")
            {
                Caption = 'Payment Bank Account';
            }
            field("Payment Bank Code2"; rec."FBM_Payment Bank Code2")
            {
                Caption = 'Payment Bank Account 2';
            }
        }
        addafter("VAT Registration No.")
        {
            field("Group Customer"; rec.FBM_Group)
            {
                ApplicationArea = All;
            }
            field("SubGroup Customer"; rec.FBM_SubGroup)
            {
                ApplicationArea = All;
            }
        }

        modify("IDPIRPF IRPF Group")
        {
            Visible = isvisES;

        }
        modify("WHT Business Posting Group PHL")
        {
            Visible = isvisPH;

        }
    }





    actions
    {
        addlast(navigation)
        {
            group("Customer Sites")
            {
                Image = Warehouse;

                action(Sites)
                {
                    ApplicationArea = All;
                    Image = Warehouse;
                    Visible = ShowSites;

                    trigger OnAction()
                    begin
                        Clear(CustomerSite);
                        Clear(CustomerSiteP);
                        CustomerSite.SetFilter("Customer No.", Rec."No.");
                        CustomerSiteP.SetTableView(CustomerSite);
                        CustomerSiteP.RunModal();
                    end;
                }
            }
        }
    }



    var
        isvisES: Boolean;
        isvisPH: Boolean;
        compinfo: record "Company Information";

        CustomerSiteP: Page FBM_CustomerSite_CO;
        CustomerSite: Record FBM_CustomerSite_C;
        Operators: Record "Dimension Value";
        OperatorsP: Page "Dimension Values";
        //OperatorsXML: XmlPort "Import Operators";
        // CurrentCFS: Page "Current Customer FA per Site";
        // FAMH: Record "FA Movement History";
        companyinfo: Record "Company Information";
        ShowSites: boolean;



    trigger OnOpenPage()
    begin
        if companyinfo.Get() then begin
            if companyinfo.FBM_CustIsOp then
                ShowSites := true
            else
                ShowSites := false;
            compinfo.get;
            isvisES := compinfo."Country/Region Code" = 'ES';
            isvisPH := compinfo."Country/Region Code" = 'PH';
        end;
    end;
}
