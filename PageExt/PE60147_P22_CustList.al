



pageextension 60147 FBMCustomerListExt_CO extends "Customer List"
{

    layout
    {
        addafter(Name)
        {
            field(FBM_GrCode; Rec.FBM_GrCode)
            {
                ApplicationArea = all;
            }

        }
        addafter("Phone No.")
        {
            field("Payment Bank Code"; rec."FBM_Payment Bank Code")
            {
                ApplicationArea = all;
            }
            field("Payment Bank Code2"; rec."FBM_Payment Bank Code2")
            {
                ApplicationArea = all;
            }
        }
        addafter("Name")
        {
            field("No. 2"; rec.FBM_GrCode)
            {
                ApplicationArea = all;
            }
            field("VAT Registration No."; rec."VAT Registration No.")
            {
                ApplicationArea = all;
            }
            field("Group Customer"; rec.FBM_Group)
            {
                ApplicationArea = all;
            }
            field("SubGroup Customer"; rec.FBM_SubGroup)
            {
                ApplicationArea = all;
            }
        }



    }
    actions
    {
        addlast(reporting)
        {
            group("Aged Account Monthly")
            {

                Caption = 'Aged Account Monthly';
                Image = "Report";
                action(AgedAccountMonthly)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Aged Account Monthly';
                    Image = CustomerLedger;
                    RunObject = Page "FBM_Aged Accounts by Months_CO";


                }
            }
        }
    }
#if not SAAS
    trigger
    OnOpenPage()
    var
        customer: record Customer;
        custlist2: page "FBM_Customer List_CO";

    begin
        if GuiAllowed then begin
            customer.CopyFilters(rec);

            custlist2.SetTableView(customer);
            custlist2.Run();
            Error('');

        end;

    end;
#endif



}



