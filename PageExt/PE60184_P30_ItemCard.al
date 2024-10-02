pageextension 60184 FBM_ItemCardExt_CO extends "Item Card"
{
    layout
    {

        modify("Item Category Code")
        {

            trigger OnLookup(var Text: Text): Boolean
            var
                CatList: Page "Item Categories";
                itemcat: record "Item Category";
            begin
                Clear(CatList);
                Text := '';
                itemcat.SetRange(fbm_standard, true);
                catlist.SetTableView(itemcat);
                CatList.LookupMode(true);
                if CatList.RunModal() = Action::LookupOK then begin
                    Text := catlist.GetSelectionFilter();
                    exit(true);

                end else
                    exit(false);
            end;
        }

        addfirst(Replenishment)
        {
            field(FBM_MinStock; Rec.FBM_MinStock)
            {
                ApplicationArea = all;
            }
        }
        addafter(Inventory)
        {
            field(FBM_Inventory_New; Rec.FBM_Inventory_New)
            {
                ApplicationArea = all;
            }
            field(FBM_Inventory_Used; Rec.FBM_Inventory_Used)
            {
                ApplicationArea = all;
            }

        }
        addlast(Item)
        {
            field(FBM_MachineType; Rec.FBM_MachineType)
            {
                ApplicationArea = all;
            }
            field(FBM_MultiCat; Rec.FBM_MultiCat)
            {
                Caption = 'Multi Categorías';
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                var
                    CatList: Page "Item Categories";
                    itemcat: record "Item Category";
                begin
                    Clear(CatList);
                    Text := '';
                    itemcat.SetRange(FBM_Orion, true);
                    catlist.SetTableView(itemcat);
                    CatList.LookupMode(true);
                    if CatList.RunModal() = Action::LookupOK then begin
                        Text += CatList.GetSelectionFilter();
                        exit(true);

                    end else
                        exit(false);
                end;
            }

        }
    }
    actions
    {

        addlast(ItemAvailabilityBy)
        {
            action(ItemsBySite)
            {

                AccessByPermission = TableData FBM_Customer = R;
                ApplicationArea = Location;
                Caption = 'Items b&y Site';
                Image = ItemAvailbyLoc;
                ToolTip = 'Show a list of items grouped by location.';

                trigger OnAction()
                begin
                    PAGE.Run(PAGE::FBM_ItemsBySite_CO, Rec);
                end;
            }
        }
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
   OnAfterGetRecord()
    begin
        cinfo.get;
        // if buftxt.FindFirst() then
        //     repeat
        if country.get(buftxt.Name) then
            subsidiary := cinfo."Custom System Indicator Text" + ' ' + country.FBM_Country3;
        itemle.reset;
        itemle.SetRange(FBM_Country, cinfo."Country/Region Code");
        itemle.SetRange("Item No.", rec."No.");
        itemle.SetRange(FBM_NewItem, true);
        itemle.CalcSums(Quantity);
        Inventory_New := itemle.Quantity;
        itemle.reset;
        itemle.SetRange(FBM_Country, cinfo."Country/Region Code");
        itemle.SetRange("Item No.", rec."No.");
        itemle.SetRange(FBM_UsedItem, true);
        itemle.CalcSums(Quantity);
        Inventory_Used := itemle.Quantity;
        // until buftxt.next = 0;



    end;


}