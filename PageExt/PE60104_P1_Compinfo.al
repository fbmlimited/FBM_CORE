pageextension 60104 FBM_CompInfoExt_CO extends "Company Information"
{
    layout
    {
        addafter(Name)
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = all;
            }
        }
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
        addafter("Bank Name")
        {
            field(FBM_BankAddress; Rec.FBM_BankAddress)
            {
                ApplicationArea = all;
            }
        }
        addlast(General)
        {
            field(FBM_EnWS; Rec.FBM_EnWS)
            {
                ApplicationArea = all;
                visible = false;
            }
            field(FBM_EnSiteWS; Rec.FBM_EnSiteWS)
            {
                ApplicationArea = all;
            }
            field(FBM_EnSpin; Rec.FBM_EnSpin)
            {
                ApplicationArea = all;
            }
            field(FBM_EnMigr; Rec.FBM_EnMigr)
            {
                ApplicationArea = all;
                visible = false;
            }
            field(FBM_EnAppr; Rec.FBM_EnAppr)
            {
                ApplicationArea = all;
            }
            field(FBM_CustIsOp; Rec.FBM_CustIsOp)
            {
                ApplicationArea = all;
                visible = false;
            }
            field(FBM_TINNumber; Rec.FBM_TINNumber)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(FBM_Conso1; Rec.FBM_Conso1)
            {
                ApplicationArea = all;
            }
            field(FBM_Conso2; Rec.FBM_Conso2)
            {
                ApplicationArea = all;
            }
            field(FBM_Conso3; Rec.FBM_Conso3)
            {
                ApplicationArea = all;
            }
            field(FBM_IsOnMainServer; Rec.FBM_IsOnMainServer)
            {
                ApplicationArea = all;
            }

        }
#if MAIN
        modify("BIR PHL")
        {
            visible = isph;
        }

#endif

    }
    trigger
    OnAfterGetRecord()
    var
        fasetup: record "FA Setup";
    begin
        isph := rec."Country/Region Code" = 'PH';
        rec.FBM_CustIsOp := rec.FBM_EnSiteWS;

        fasetup.Get();
        fasetup."FBM_FA Company" := rec.FBM_FAProperty;
        fasetup.Modify();


    end;

    var
        isph: Boolean;


}