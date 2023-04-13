pageextension 60100 FBM_ItemCardExt_CO extends "Item Card"
{
    layout
    {
        addafter("Description")
        {
            field("Description 2"; rec."Description 2")
            {
                ApplicationArea = all;
            }

        }
    }

    
}
