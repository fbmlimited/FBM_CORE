pageextension 60182 FBM_LocCardExt_CO extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field(FBM_NewItem; Rec.FBM_NewItem)
            {
                ApplicationArea = all;

            }
            field(FBM_UsedItem; Rec.FBM_UsedItem)
            {
                ApplicationArea = all;

            }
            field(FBM_TransitLoc; Rec.FBM_TransitLoc)
            {
                ApplicationArea = all;

            }
            field("Country/Region Code2"; Rec."Country/Region Code")
            {
                ApplicationArea = all;

            }
            field(FBM_Site; Rec.FBM_Site)
            {
                ApplicationArea = all;

            }



        }
        modify("Country/Region Code")
        {
            Visible = false;

        }


    }
}