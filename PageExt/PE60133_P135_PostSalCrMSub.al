pageextension 60133 FBM_PostSCrMSubExt_CO extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Variant Code")
        {


            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                ApplicationArea = all;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                ApplicationArea = all;
            }

        }
    }
    actions
    {
    }
    var
}
