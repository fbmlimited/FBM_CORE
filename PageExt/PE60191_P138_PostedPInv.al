pageextension 60191 FBM_PostedPInvExt_CO extends "Posted Purchase Invoice"
{
    layout
    {
        addafter(General)
        {
            group(Pedimento)
            {
                visible = isped;
                field(FBM_Pedimento1; Rec.FBM_Pedimento1)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento2; Rec.FBM_Pedimento2)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento3; Rec.FBM_Pedimento3)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento4; Rec.FBM_Pedimento4)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento; Rec.FBM_Pedimento)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger
    OnOpenPage()
    ;
    begin

        purchsetup.get;
        isped := purchsetup.FBM_Use_Pedimento;
    end;

    var
        purchsetup: record "Purchases & Payables Setup";
        isped: Boolean;
}