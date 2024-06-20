pageextension 60185 FBM_TransferOrderExt_CO extends "Transfer Order"
{
    layout
    {
        addafter("Transfer-from Code")
        {
            field(FBM_SiteFrom; Rec.FBM_SiteFrom)
            {
                ApplicationArea = all;
                Enabled = issiteF;

            }


        }
        addafter("Transfer-to Code")
        {
            field(FBM_SiteTo; Rec.FBM_SiteTo)
            {
                ApplicationArea = all;

                Enabled = issiteT;
            }


        }
        addlast(General)
        {
            field(FBM_FromOrion; Rec.FBM_FromOrion)
            {
                ApplicationArea = all;
                Editable = false;


            }


        }
        modify("Transfer-from Code")
        {
            trigger
            OnAfterValidate()
            begin
                issiteF := rec."Transfer-from Code" = 'SITE';
            end;
        }
        modify("Transfer-to Code")
        {
            trigger
            OnAfterValidate()
            begin
                issiteT := rec."Transfer-to Code" = 'SITE';
            end;
        }
    }
    trigger
    OnAfterGetRecord()
    begin
        rec."Direct Transfer" := true;
    end;

    var
        issiteF: Boolean;
        issiteT: Boolean;
}