tableextension 60101 FBM_FAExt_CO extends "Fixed Asset"
{
    fields
    {
        modify("Serial No.")
        {
            trigger OnAfterValidate()
            var
                FA: record "Fixed Asset";
            begin
                FA.Reset();
                FA.SetFilter("Serial No.", Rec."Serial No.");
                if FA.FindFirst() then error(Text000, FA."No.");
            end;
        }

    }
    var
        Text000: Label 'Fixed Asset %1 has the same Serial No.!';
}