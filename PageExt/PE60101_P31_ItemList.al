pageextension 60101 FBM_ItemListExt_CO extends "Item List"
{

    layout
    {

    }

    var

        usersetup: Record "User Setup";
        id: Integer;
        itemle: record "Item Ledger Entry";
        loc: record Location;
        subsidiary: text[20];
        buftxt: record "Name/Value Buffer";
        country: record "Country/Region";
        Inventory_New: Decimal;
        Inventory_Used: Decimal;
        cinfo: record "Company Information";


    trigger
    OnOpenPage()
    var
        ceve: Codeunit FBM_Events_CO;
    begin
        if usersetup.Get(UserId) then begin
            if usersetup."FBM_Item Filter" <> '' then
                Rec.SetFilter("No.", usersetup."FBM_Item Filter");

        end;
        // ceve.updNewUsed();
    end;

    // trigger
    // OnAfterGetRecord()
    // begin
    //     cinfo.get;
    //     if buftxt.FindFirst() then
    //         repeat
    //             if country.get(buftxt.Name) then
    //                 subsidiary := cinfo."Custom System Indicator Text" + ' ' + country.FBM_Country3;
    //             itemle.reset;
    //             itemle.SetRange(FBM_Country, buftxt.Name);
    //             itemle.SetRange("Item No.", rec."No.");
    //             itemle.SetRange(FBM_NewItem, true);
    //             itemle.CalcSums(Quantity);
    //             Inventory_New := itemle.Quantity;
    //             rec.FBM_Inventory_New := Inventory_New;
    //             itemle.reset;
    //             itemle.SetRange(FBM_Country, buftxt.Name);
    //             itemle.SetRange("Item No.", rec."No.");
    //             itemle.SetRange(FBM_NewItem, false);
    //             itemle.CalcSums(Quantity);
    //             Inventory_Used := itemle.Quantity;
    //             rec.FBM_Inventory_Used := Inventory_Used;
    //         until buftxt.next = 0;
    //     rec.Modify();



    // end;



}