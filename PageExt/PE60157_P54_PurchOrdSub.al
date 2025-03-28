pageextension 60157 FBM_PurchOrdSubExt_CO extends "Purchase Order Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Prepayment %")
        {
            Visible = true;
        }
        addafter("Location Code")
        {
            field(FBM_Site; Rec.FBM_Site)
            {
                ApplicationArea = all;
            }

        }
#if MAIN
        modify("IDPIRPF IRPF")
        {

            Visible = ises;
        }
        modify("IDPIRPF IRPF Amount")
        {

            Visible = ises;
        }
        modify("IDPIRPF IRPF Group")
        {

            Visible = ises;
        }
        modify("IDPIRPF Total IRPF Amount")
        {

            Visible = ises;
        }
        modify("IDPIRPF TotalAmountWithVATWithoutIRPF")
        {

            Visible = ises;
        }
#endif
        addlast(Control1)
        {
            field(FBM_IsFreight; Rec.FBM_IsFreight)
            {
                ApplicationArea = all;
            }
            field(FBM_IsWht; Rec.FBM_IsWht)
            {
                ApplicationArea = all;
            }
        }
        addlast(Control19)
        {
            field(TotProd; TotalPurchaseLine.FBM_TotProd)
            {
                Caption = 'Total Products';
                ApplicationArea = all;
            }
            // field(TotDisc; TotalPurchaseLine.FBM_TotDiscount)
            // {
            //     Caption = 'Total Discount';
            //     ApplicationArea = all;
            // }
            field(TotFreight; TotalPurchaseLine.FBM_TotFreight)
            {
                Caption = 'Total Freight';
                ApplicationArea = all;
            }
            field(TotWht; TotalPurchaseLine.FBM_TotWht)
            {
                Caption = 'Total Withholding';
                ApplicationArea = all;
            }
            field(TotVAT; TotalPurchaseLine.FBM_TotVAT)
            {
                Caption = 'Total VAT';
                ApplicationArea = all;
            }
            field(GrandTot; TotalPurchaseLine.FBM_GrandTot)
            {
                Caption = 'Grand Total';
                ApplicationArea = all;
            }
        }

    }
    trigger
   OnOpenPage()
    begin

        compinfo.get;
        ises := compinfo."Country/Region Code" = 'ES';

    end;

    var
        ises: Boolean;
        compinfo: record "Company Information";

}
