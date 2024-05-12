tableextension 60100 FBM_ItemExt_CO extends Item
{
    fields
    {
        modify("Item Category Code")
        {
            TableRelation = "Item Category" where(FBM_Standard = const(true));
        }
        field(60100; FBM_SiteFilter; code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = FBM_CustomerSite_C."Site Code";
        }
        field(60101; FBM_Inventory_FF; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Unit of Measure Code" = FIELD("Unit of Measure Filter"),
                                                                  "Package No." = FIELD("Package No. Filter"),
                                                                  FBM_Site = field(FBM_SiteFilter)));
            Caption = 'Inventory 2';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }

    }

    fieldgroups
    {
        addlast(DropDown; "Description 2") { }
    }

}
