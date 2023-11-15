pageextension 60185 FBM_TransferOrderExt_CO extends "Transfer Order"
{
    layout
    {
        addafter("Transfer-from Code")
        {
            field(FBM_SiteFrom; Rec.FBM_SiteFrom)
            {
                ApplicationArea = all;


            }


        }
        addafter("Transfer-to Code")
        {
            field(FBM_SiteTo; Rec.FBM_SiteTo)
            {
                ApplicationArea = all;


            }


        }

    }
    trigger
    OnAfterGetRecord()
    begin
        rec."Direct Transfer" := true;
    end;
}