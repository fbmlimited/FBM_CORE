pageextension 60181 FBM_ItemJnlExt_CO extends "Item Journal"
{
    layout
    {
        addafter("Location Code")
        {
            field(FBM_Site; Rec.FBM_Site)
            {
                ApplicationArea = all;

            }

        }
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