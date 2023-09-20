pageextension 60133 FBM_PostSCrMSubExt_CO extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Variant Code")
        {


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
        compinfo.Get();
        showsite := compinfo.FBM_CustIsOp;

    end;


    var

        compinfo: record "Company Information";
        showsite: Boolean;
}
