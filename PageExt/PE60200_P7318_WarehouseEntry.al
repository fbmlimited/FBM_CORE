pageextension 60200 FBM_WarehouseEntryExt_CO extends "Warehouse Entries"
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