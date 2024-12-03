pageextension 60124 FBM_GLAccCardExt_CO extends "G/L Account Card"
{
    layout
    {
        //addafter("No.")
        //{
        //field("No. 2";"No. 2")
        //{
        //ApplicationArea = all;
        //}
        //}
        addbefore(Blocked)
        {
            field("Period Required2"; rec."FBM_Periods Required")
            {
                ApplicationArea = all;
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group2"; rec."FBM_Gen. Prod. Posting Group2")
            {
                ApplicationArea = all;
            }
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        addlast(General)
        {
            field(FBM_FranchiseTax; Rec.FBM_FranchiseTax)
            {
                ApplicationArea = all;
            }
            field(FBM_WHTax; Rec.FBM_WHTax)
            {
                ApplicationArea = all;
            }
            field(FBM_IsFreight; Rec.FBM_IsFreight)
            {
                ApplicationArea = all;
            }
            field(FBM_IsWht; Rec.FBM_IsWht)
            {
                ApplicationArea = all;
            }

        }
    }
    actions
    {
    }
    trigger
    OnAfterGetRecord()
    begin
        rec."FBM_Gen. Prod. Posting Group2" := rec."Gen. Prod. Posting Group";
    end;
}
