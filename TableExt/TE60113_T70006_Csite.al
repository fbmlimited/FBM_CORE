tableextension 60113 FBM_CSiteExt_CO extends FBM_CustomerSite_C
{

    fields
    {
        modify("Contract Code")
        {
            trigger OnAfterValidate()
            begin
                //if "Contract Code" <> '' then FADimMgt.ContractDimension(Rec);
            end;
        }
        modify("Contract Code2")
        {
            trigger OnAfterValidate()
            begin
                //                if "Contract Code2" <> '' then FADimMgt.ContractDimension(Rec);
            end;
        }
    }
    var
        FADimMgt: Codeunit FBM_FixedAssetDimMgt_CO;
}