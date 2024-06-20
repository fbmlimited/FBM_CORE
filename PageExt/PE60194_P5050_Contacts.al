pageextension 60194 FBM_ContactsExt_CO extends "Contact Card"
{
    layout
    {
        addafter("No.")
        {
            field(FBM_Role; Rec.FBM_Role)
            {
                ApplicationArea = all;
                enabled = showrole;
                trigger
                OnValidate()
                begin
                    showrole := (rec.FBM_RoleTXT = '');
                end;


            }
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
        modify(Control31)
        {
            Visible = false;


        }
        modify(Control41)
        {
            Visible = false;


        }
        modify(ContactIntEntriesSubform)
        {
            Visible = false;


        }
        modify("Profile Questionnaire")
        {
            Visible = false;


        }
        modify("Foreign Trade")
        {
            Visible = false;


        }
        modify(Control37)
        {
            Visible = false;


        }
        modify("Correspondence Type")
        {
            Visible = false;


        }
        modify("Language Code")
        {
            Visible = false;


        }
        modify("Salesperson Code")
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