pageextension 60107 FBM_CustomerCardExt_CO extends "Customer Card"
{


    layout
    {

        addbefore(Name)
        {
            field("No. 2_CO"; rec.FBM_GrCode)
            {
                ApplicationArea = All;
                Editable = issup;
            }
        }
        addafter(Name)
        {
            field("FBM_Name 3"; Rec."FBM_Name3")
            {
                ApplicationArea = all;
                Enabled = hascode;
            }

            field("Customer Since_CO"; rec."FBM_Customer Since")
            {
                ApplicationArea = All;
            }
        }
        addbefore("VAT Registration No.")
        {
            field("Separate Halls Inv._CO"; rec."FBM_Separate Halls Inv.")
            {
                ApplicationArea = All;
                Caption = 'Separate Halls Inv.';
            }
            field("Payment Bank Code_CO"; rec."FBM_Payment Bank Code")
            {
                Caption = 'Payment Bank Account';
                ApplicationArea = all;
            }
            field("Payment Bank Code2"; rec."FBM_Payment Bank Code2")
            {
                Caption = 'Payment Bank Account 2';
                ApplicationArea = all;
            }
        }
        addlast(General)
        {
            field(FBM_Acronym; Rec.FBM_Acronym)
            {
                ApplicationArea = All;

            }
        }
        addafter("VAT Registration No.")
        {
            field("Group Customer_CO"; rec.FBM_Group)
            {
                ApplicationArea = All;
            }
            field("SubGroup Customer_CO"; rec.FBM_SubGroup)
            {
                ApplicationArea = All;
            }
        }


        modify(Name)
        {
            Enabled = not hascode;

        }
        modify("Name 2")
        {
            Enabled = not hascode;
            Visible = true;

        }
        modify(Address)
        {
            Enabled = not hascode;

        }
        modify("Address 2")
        {
            Enabled = not hascode;

        }
        modify(County)
        {
            Enabled = not hascode;

        }
        modify("Country/Region Code")
        {
            Enabled = not hascode;

        }
        modify("Post Code")
        {
            Enabled = not hascode;


        }
        modify(City)
        {
            Enabled = not hascode;

        }
        modify("VAT Registration No.")
        {
            Enabled = not hascode;

        }

    }





    actions
    {
#if not JYM
        addlast(navigation)
        {
            group("Customer Sites_CO")
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
#endif
        addlast(processing)
        {


            action(Notes)
            {
                ApplicationArea = All;
                Image = Notes;

                trigger OnAction()
                var
                    pnote: page FBM_NotesCustList_CO;
                begin
                    pnote.passpar(rec."No.");
                    pnote.Run();
                    clear(pnote);
                end;
            }
        }

    }



    var


        CustomerSiteP: Page FBM_CustomerSite_CO;
        CustomerSite: Record FBM_CustomerSite_C;
        Operators: Record "Dimension Value";
        OperatorsP: Page "Dimension Values";
        //OperatorsXML: XmlPort "Import Operators";
        // CurrentCFS: Page "Current Customer FA per Site";
        // FAMH: Record "FA Movement History";
        companyinfo: Record "Company Information";
        ShowSites: boolean;
        issup: boolean;
        hascode: Boolean;



    trigger OnOpenPage()
    var
        uper: Codeunit "User Permissions";
    begin

        if companyinfo.Get() then begin
            if companyinfo.FBM_CustIsOp then
                ShowSites := true
            else
                ShowSites := false;

        end;
        issup := uper.IsSuper(UserSecurityId())

    end;

    trigger
    OnAfterGetRecord()
    begin
        hascode := rec.FBM_GrCode <> '';
    end;
}
