pageextension 60201 FBM_BinContentExt_CO extends "Bin Content"
{
    layout
    {
        addafter("Item No.")
        {
            field(itemdesc; itemdesc)
            {
                ApplicationArea = all;
                Caption = 'Description';

            }

        }

    }
    trigger
    OnAfterGetRecord()
    begin
        if item.get(rec."Item No.") then
            itemdesc := item.Description;

    end;

    var
        item: record Item;
        itemdesc: text[100];
}