pageextension 60134 FBM_PosstedSIUpdateExt_CO extends "Posted Sales Inv. - Update"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Posting Description70122"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
        }
    }
}