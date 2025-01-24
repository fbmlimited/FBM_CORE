tableextension 60101 FBM_FAExt_CO extends "Fixed Asset"
{
    fields
    {
        field(60100; "FBM_Fa Posting Group Depr_FF"; Code[20])
        {
            Caption = 'Fa Posting Group Depr';
            FieldClass = FlowField;
            CalcFormula = lookup("FA Depreciation Book"."FA Posting Group" where("FA No." = field("No."), "Depreciation Book Code" = filter('COMPANY')));
        }
        field(60101; FBM_Is_EGM_FF; Boolean)
        {
            Caption = 'Is EGM';
            FieldClass = FlowField;
            CalcFormula = lookup("FA Subclass".FBM_EGM where(code = field("FA Subclass Code")));

        }

        modify("Serial No.")
        {
            trigger OnAfterValidate()
            var
                FA: record "Fixed Asset";
            begin
                FA.Reset();
                FA.SetFilter("Serial No.", Rec."Serial No.");
                fa.SetFilter("No.", '<>%1', rec."No.");
                if FA.FindFirst() then error(Text000, FA."No.");
            end;
        }

    }
    var
        Text000: Label 'Fixed Asset %1 has the same Serial No.!';
}