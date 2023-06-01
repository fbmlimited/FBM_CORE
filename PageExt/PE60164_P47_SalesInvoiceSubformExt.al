pageextension 60164 FBM_SalesInvSubExt_CO extends "Sales Invoice Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }

        addafter("VAT Prod. Posting Group")
        {



            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                ApplicationArea = all;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                ApplicationArea = all;
            }





        }

        addafter("Quantity")
        {

            field(FBM_Site; Rec.FBM_Site)
            {

                ApplicationArea = all;
            }

        }
    }
}
