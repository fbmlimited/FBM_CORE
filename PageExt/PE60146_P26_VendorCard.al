pageextension 60146 FBM_VendorCardExt_CO extends "Vendor Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Default Bank Account"; rec."FBM_Default Bank Account")
            {
                ApplicationArea = All;
            }


        }
        addlast(General)
        {
            field("Print Name on Check"; Rec."FBM_Print Name on Check")
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
    trigger OnOpenPage()
    var

    begin
        if compinfo.Get() then begin

            isvisES := compinfo."Country/Region Code" = 'ES';
            isvisPH := compinfo."Country/Region Code" = 'PH';
        end;


    end;

    var
        isvisES: Boolean;
        isvisPH: Boolean;
        compinfo: record "Company Information";
}