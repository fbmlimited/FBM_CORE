pageextension 60163 FBM_SalesInvListExt_CO extends "Sales Invoice List"
{
    layout
    {
        addafter("No.")
        {


            field("FBM_Billing Statement"; Rec."FBM_Billing Statement")
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
