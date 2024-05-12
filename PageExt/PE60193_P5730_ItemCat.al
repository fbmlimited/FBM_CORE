pageextension 60193 FBM_Itemcat_CO extends "Item Categories"
{
    layout
    {


        addlast(Control1)
        {
            field(FBM_Standard; Rec.FBM_Standard)
            {
                ApplicationArea = all;

            }
            field(FBM_Orion; Rec.FBM_Orion)
            {
                ApplicationArea = all;

            }


        }

    }
}