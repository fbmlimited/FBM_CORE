pageextension 60101 FBM_ItemListExt_CO extends "Item List"
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