pageextension 60114 FBM_FALedgEntrPrwExt_CO extends "FA Ledger Entries Preview"
{
    layout
    {
        addafter("FA No.")
        {
            field(FADesc; FADesc)
            {
                Caption = 'FA Description';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    var
        FADesc: Text[150];
        FA: Record "Fixed Asset";

    trigger OnAfterGetRecord()
    begin
        FA.reset;
        if FA.Get(Rec."FA No.") then
            FADesc := FA.Description
        else
            FADesc := '';
    end;
}
