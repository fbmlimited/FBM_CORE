



pageextension 60147 FBMCustomerListExt_CO extends "Customer List"
{
    layout
    {
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
    var
        myInt: Integer;
}



