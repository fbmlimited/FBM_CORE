pageextension 60102 FBM_ItemLEExt_CO extends "Item Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field(itemdesc; itemdesc)
            {
                caption = 'Description';
                ApplicationArea = all;
            }
        }
        modify(Description)
        {
            Visible = false;


        }

        addafter("Document No.")
        {
            field("Value Entry Document No."; rec."FBM_Document No Value Entry_FF")
            {
                ApplicationArea = all;
            }
        }
        addlast(Control1)
        {
            field(FBM_Site; Rec.FBM_Site)
            {
                ApplicationArea = all;

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