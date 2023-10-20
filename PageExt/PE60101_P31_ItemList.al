pageextension 60101 FBM_ItemListExt_CO extends "Item List"
{
    layout
    {

    }

    var

        usersetup: Record "User Setup";


    trigger OnOpenPage()
    begin
        if usersetup.Get(UserId) then begin
            if usersetup."FBM_Item Filter" <> '' then
                Rec.SetFilter("No.", usersetup."FBM_Item Filter");

        end;


    end;
}