pageextension 60181 FBM_ItemJnlExt_CO extends "Item Journal"
{
    layout
    {
        addlast(factboxes)
        {
            part(itemcost; FBM_ItemCost_CO)
            {
                ApplicationArea = all;
                SubPageLink = "Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field("Journal Batch Name"), "Line No." = field("Line No.");

            }


        }

    }
}