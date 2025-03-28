tableextension 60109 FBM_ItemLEExt_CO extends "Item Ledger Entry"
{
    fields
    {

        field(60100; "FBM_Document No Value Entry_FF"; Code[20])
        {
            FieldClass = FlowField;


            CalcFormula = lookup("Purch. Rcpt. Header"."Order No." where("No." = FIELD("Document No.")));


        }
    }
    trigger

    OnAfterInsert()
    var
        item: record Item;
        invsetup: record "Inventory Setup";
    begin
        invsetup.Get();
        if invsetup.FBM_SendAlertEmail <> '' then
            if item.get(rec."Item No.") then
                if item.Type = item.Type::Inventory then begin
                    item.CalcFields(Inventory);
                    if item.Inventory < item.FBM_MinStock then
                        sendminstock(item);
                end;

    end;

    local procedure sendminstock(it: record Item)
    var
        message: Codeunit "Email Message";
        mail: codeunit Email;
        bodytxt: Text;
        invsetup: record "Inventory Setup";
    begin
        invsetup.get;
        bodytxt := 'Item: ' + it."No." + ' - ' + it.Description + ' Inventory: ' + format(it.Inventory) + ' Min. Stock: ' + format(it.FBM_MinStock);
        if invsetup.FBM_SendAlertEmail <> '' then begin
            message.create(invsetup.FBM_SendAlertEmail, 'Alert ' + it."No." + ' - ' + it.Description, bodytxt);
            mail.Send(message, enum::"Email Scenario"::"Service Credit Memo");
        end;
    end;
}

