pageextension 60183 FBM_LocListExt_CO extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field(FBM_NewItem; Rec.FBM_NewItem)
            {
                ApplicationArea = all;

            }
            field("Country/Region Code"; Rec."Country/Region Code")
            {
                ApplicationArea = all;

            }


        }


    }
}