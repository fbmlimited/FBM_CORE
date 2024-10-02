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
        cust: record Customer;
        cust2: record Customer;
        comp: record Company;
        cont: record Contact;
        contp: record Contact;

    trigger
     OnOpenPage()
    begin
        showrole := (rec.FBM_RoleTXT = '');
        contp.get(rec."Company No.");
        cust.SetRange("Primary Contact No.", contp."No.");
        if cust.FindFirst() then begin
            comp.FindFirst();


            repeat
                cust2.ChangeCompany(comp.Name);
                cust2.setrange(FBM_GrCode, cust.FBM_GrCode);
                if cust2.FindFirst() then begin
                    cont.TransferFields(rec, false);

                end;
            until comp.next = 0;
        end;
    end;

    trigger
    OnAfterGetRecord()
    begin
        showrole := (rec.FBM_RoleTXT = '');
    end;
}