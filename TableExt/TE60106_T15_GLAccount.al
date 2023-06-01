tableextension 60106 FBM_GLAccountExt_CO extends "G/L Account"
{
    fields
    {

        field(60100; "FBM_Gen. Prod. Posting Group2"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            begin

                if xRec."FBM_Gen. Prod. Posting Group2" <> "FBM_Gen. Prod. Posting Group2" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "FBM_Gen. Prod. Posting Group2") then
                        "VAT Prod. Posting Group" := GenProdPostingGrp."Def. VAT Prod. Posting Group";
                "Gen. Prod. Posting Group" := "FBM_Gen. Prod. Posting Group2"
            end;
        }
    }
    var
        myInt: Integer;
}
