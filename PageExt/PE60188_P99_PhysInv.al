pageextension 60188 FBM_PhysInvExt_CO extends "Phys. Inventory Journal"
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
    }
}