pageextension 60167 FBM_SalesQuoteSubExt_CO extends "Sales Quote Subform"
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
        
    }
    trigger OnOpenPage()
    
    begin

        if compinfo.Get() then begin
            
            showsite:=compinfo.FBM_CustIsOp;
        end;


    end;

    var
        
        compinfo: record "Company Information";
        showsite: Boolean;
}
