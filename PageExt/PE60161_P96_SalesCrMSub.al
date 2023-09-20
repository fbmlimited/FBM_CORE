pageextension 60161 FBM_SalesCrMSubExt_CO extends "Sales Cr. Memo Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        addafter("VAT Prod. Posting Group")
        {

            field(FBM_Site; Rec.FBM_Site)
            {
                Visible = showsite;
                ApplicationArea = all;
            }
            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                Visible = showsite;
                ApplicationArea = all;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                Visible = showsite;
                ApplicationArea = all;
            }

        }
        modify("IDPIRPF IRPF")
        {

            visible = isvisES;
        }
        modify("IDPIRPF IRPF Amount")
        {

            visible = isvisES;
        }
        modify("IDPIRPF IRPF Group")
        {

            visible = isvisES;
        }
        modify("IDPIRPF Total IRPF Amount")
        {

            visible = isvisES;
        }
        modify("IDPIRPF TotalAmountWithVATWithoutIRPF")
        {

            visible = isvisES;
        }
        modify("VAT Bus. Posting Group PHL")
        {

            visible = isvisPH;
        }
        modify("WHT Product Posting Group PHL")
        {

            visible = isvisPH;
        }
        modify("WHT Business Posting Group PHL")
        {

            visible = isvisPH;
        }
    }
    trigger OnOpenPage()
    var
        uper: Codeunit "User Permissions";
    begin

        if compinfo.Get() then begin
            isvisES := compinfo."Country/Region Code" = 'ES';
            isvisPH := compinfo."Country/Region Code" = 'PH';
            showsite := compinfo.FBM_CustIsOp;
        end;


    end;

    var
        isvisES: Boolean;
        isvisPH: Boolean;
        compinfo: record "Company Information";
        showsite: Boolean;
}
