pageextension 60123 FBM_GLSetupExt_CO extends "General Ledger Setup"
{
    layout
    {
        modify("Shortcut Dimension 3 Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 6 Code")
        {
            Editable = false;
        }

    }
    trigger
    OnOpenPage()
    begin
        cinfo.get();
        visph := (cinfo."Country/Region Code" = 'PH')

    end;

    var
        cinfo: record "Company Information";
        visph: Boolean;


}
