pageextension 60195 FBM_ContactListExt_CO extends "Contact List"
{
    layout
    {
        addafter("No.")
        {

            field(FBM_RoleTXT; Rec.FBM_RoleTXT)
            {
                ApplicationArea = all;

                trigger
                               OnValidate()
                begin
                    showrole := (rec.FBM_RoleTXT = '');
                end;
            }


        }






        modify("Language Code")
        {
            Visible = false;


        }
        modify("Salesperson Code")
        {
            Visible = false;


        }
        modify("Territory Code")
        {
            Visible = false;


        }
    }
    var
        showrole: Boolean;

    trigger
     OnOpenPage()
    begin
        showrole := (rec.FBM_RoleTXT = '');
    end;

    trigger
    OnAfterGetRecord()
    begin
        showrole := (rec.FBM_RoleTXT = '');
    end;
}