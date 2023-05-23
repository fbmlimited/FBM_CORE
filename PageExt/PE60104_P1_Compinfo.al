pageextension 60104 FBM_CompInfoExt_CO extends "Company Information"
{
    layout
    {
        addafter(General)
        {
            group("FA Defaults")
            {
                field(FBM_FALessee; Rec.FBM_FALessee)
                {
                    ApplicationArea = all;
                }
                field(FBM_FAProperty; Rec.FBM_FAProperty)
                {
                    ApplicationArea = all;
                }
                field(FBM_FABrand; Rec.FBM_FABrand)
                {
                    ApplicationArea = all;
                }


            }
        }
        addlast(General)
        {
            field(FBM_EnWS; Rec.FBM_EnWS)
            {
                ApplicationArea = all;
            }
            field(FBM_EnSiteWS; Rec.FBM_EnSiteWS)
            {
                ApplicationArea = all;
            }
            field(FBM_EnSpin; Rec.FBM_EnSpin)
            {
                ApplicationArea = all;
            }


        }

    }
}