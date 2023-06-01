pageextension 60103 FBM_CountryExt_CO extends "Countries/Regions"
{
    layout
    {
        addlast(Control1)
        {
            field(FBM_Country3; Rec.FBM_Country3)
            {
                ApplicationArea = all;
            }
            field(FBM_Account; Rec.FBM_Account)
            {
                ApplicationArea = all;
            }

        }

    }
}