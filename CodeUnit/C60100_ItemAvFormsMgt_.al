codeunit 60100 FBM_ItemAvFormsMgt_CO
{

    trigger OnRun()
    begin
    end;

    var
        ItemAvailByBOMLevel: Page "Item Availability by BOM Level";
        ForecastName: Code[10];
        AvailabilityType: Option Date,Variant,Location,Bin,"Event",BOM,UOM;
        QtyByUnitOfMeasure: Decimal;

        Text012: Label 'Do you want to change %1 from %2 to %3?', Comment = '%1=FieldCaption, %2=OldDate, %3=NewDate';

    procedure CalcItemPlanningFields(var Item: Record Item; CalculateTransferQuantities: Boolean)
    var
        JobPlanningLine: Record "Job Planning Line";
    begin

        Item.Init();
        Item.CalcFields(
          "Qty. on Purch. Order",
          "Qty. on Sales Order",
          "Qty. on Service Order",
          Inventory,
          "Net Change",
          "Scheduled Receipt (Qty.)",
          "Qty. on Component Lines",
          "Planned Order Receipt (Qty.)",
          "FP Order Receipt (Qty.)",
          "Rel. Order Receipt (Qty.)",
          "Planned Order Release (Qty.)",
          "Purch. Req. Receipt (Qty.)",
          "Planning Issues (Qty.)",
          "Purch. Req. Release (Qty.)");

        if JobPlanningLine.ReadPermission then
            Item.CalcFields("Qty. on Job Order");
        Item.CalcFields(
          "Qty. on Assembly Order",
          "Qty. on Asm. Component",
          "Qty. on Purch. Return",
          "Qty. on Sales Return");
        if CalculateTransferQuantities then
            Item.CalcFields(
              "Trans. Ord. Shipment (Qty.)",
              "Qty. in Transit",
              "Trans. Ord. Receipt (Qty.)");

        OnAfterCalcItemPlanningFields(Item);
    end;


    procedure CalculateNeed(var Item: Record Item; var GrossRequirement: Decimal; var PlannedOrderReceipt: Decimal; var ScheduledReceipt: Decimal; var PlannedOrderReleases: Decimal)
    var
        TransOrdShipmentQty: Decimal;
        QtyinTransit: Decimal;
        TransOrdReceiptQty: Decimal;
    begin
        CalcItemPlanningFields(Item, true);


        if Item.GetFilter("Location Filter") = '' then begin
            TransOrdShipmentQty := 0;
            QtyinTransit := 0;
            TransOrdReceiptQty := 0;
        end else begin
            TransOrdShipmentQty := Item."Trans. Ord. Shipment (Qty.)";
            QtyinTransit := Item."Qty. in Transit";
            TransOrdReceiptQty := Item."Trans. Ord. Receipt (Qty.)";
        end;
        GrossRequirement :=
            Item."Qty. on Sales Order" + Item."Qty. on Service Order" + Item."Qty. on Job Order" + Item."Qty. on Component Lines" +
            TransOrdShipmentQty + Item."Planning Issues (Qty.)" + Item."Qty. on Asm. Component" + Item."Qty. on Purch. Return";
        PlannedOrderReceipt :=
            Item."Planned Order Receipt (Qty.)" + Item."Purch. Req. Receipt (Qty.)";
        ScheduledReceipt :=
            Item."FP Order Receipt (Qty.)" + Item."Rel. Order Receipt (Qty.)" + Item."Qty. on Purch. Order" +
            QtyinTransit + TransOrdReceiptQty + Item."Qty. on Assembly Order" + Item."Qty. on Sales Return";
        OnCalculateNeedOnAfterCalcScheduledReceipt(Item, ScheduledReceipt, QtyinTransit, TransOrdReceiptQty);
        PlannedOrderReleases :=
            Item."Planned Order Release (Qty.)" + Item."Purch. Req. Release (Qty.)";

        OnAfterCalculateNeed(Item, GrossRequirement, PlannedOrderReceipt, ScheduledReceipt, PlannedOrderReleases);

    end;

    local procedure CalcProjAvailableBalance(var Item: Record Item): Decimal
    var
        Item2: Record Item;
        GrossRequirement: Decimal;
        PlannedOrderReceipt: Decimal;
        ScheduledReceipt: Decimal;
        PlannedOrderReleases: Decimal;
    begin
        Item2.Copy(Item);
        Item2.SetRange("Date Filter", 0D, Item.GetRangeMax("Date Filter"));
        CalculateNeed(Item2, GrossRequirement, PlannedOrderReceipt, ScheduledReceipt, PlannedOrderReleases);
        exit(Item2.Inventory + PlannedOrderReceipt + ScheduledReceipt - GrossRequirement);
    end;

    local procedure CalcProjAvailableBalance(Inventory: Decimal; GrossRequirement: Decimal; PlannedOrderReceipt: Decimal; ScheduledReceipt: Decimal): Decimal
    begin
        exit(Inventory + PlannedOrderReceipt + ScheduledReceipt - GrossRequirement);
    end;

    procedure CalcAvailQuantities(var Item: Record Item; IsBalanceAtDate: Boolean; var GrossRequirement: Decimal; var PlannedOrderRcpt: Decimal; var ScheduledRcpt: Decimal; var PlannedOrderReleases: Decimal; var ProjAvailableBalance: Decimal; var ExpectedInventory: Decimal; var QtyAvailable: Decimal)
    var
        AvailableMgt: Codeunit "Available Management";
    begin
        CalculateNeed(Item, GrossRequirement, PlannedOrderRcpt, ScheduledRcpt, PlannedOrderReleases);
        if IsBalanceAtDate then
            ProjAvailableBalance :=
              CalcProjAvailableBalance(Item.Inventory, GrossRequirement, PlannedOrderRcpt, ScheduledRcpt)
        else
            ProjAvailableBalance := CalcProjAvailableBalance(Item);

        OnAfterCalculateProjAvailableBalance(Item, ProjAvailableBalance);

        ExpectedInventory := AvailableMgt.ExpectedQtyOnHand(Item, true, 0, QtyAvailable, DMY2Date(31, 12, 9999));
    end;

    procedure CalcAvailQuantities(var Item: Record Item; IsBalanceAtDate: Boolean; var GrossRequirement: Decimal; var PlannedOrderRcpt: Decimal; var ScheduledRcpt: Decimal; var PlannedOrderReleases: Decimal; var ProjAvailableBalance: Decimal; var ExpectedInventory: Decimal; var QtyAvailable: Decimal; var AvailableInventory: Decimal)
    var
        AvailableToPromise: Codeunit "Available to Promise";
    begin
        CalcAvailQuantities(
            Item, isBalanceAtDate, GrossRequirement, PlannedOrderRcpt, ScheduledRcpt,
            PlannedOrderReleases, ProjAvailableBalance, ExpectedInventory, QtyAvailable);
        AvailableInventory := AvailableToPromise.CalcAvailableInventory(Item);
    end;

    procedure ShowItemLedgerEntries(var Item: Record Item; NetChange: Boolean)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.FindLinesWithItemToPlan(Item, NetChange);
        PAGE.Run(0, ItemLedgEntry);
    end;

    procedure ShowSalesLines(var Item: Record Item)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.FindLinesWithItemToPlan(Item, SalesLine."Document Type"::Order);
        PAGE.Run(0, SalesLine);
    end;

    procedure ShowServLines(var Item: Record Item)
    var
        ServLine: Record "Service Line";
    begin
        ServLine.FindLinesWithItemToPlan(Item);
        PAGE.Run(0, ServLine);
    end;

    procedure ShowJobPlanningLines(var Item: Record Item)
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        JobPlanningLine.FindLinesWithItemToPlan(Item);
        PAGE.Run(0, JobPlanningLine);
    end;

    procedure ShowPurchLines(var Item: Record Item)
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.FindLinesWithItemToPlan(Item, PurchLine."Document Type"::Order);
        PAGE.Run(0, PurchLine);
    end;

    procedure ShowSchedReceipt(var Item: Record Item)
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderLine.FindLinesWithItemToPlan(Item, true);
        PAGE.Run(0, ProdOrderLine);
    end;

    procedure ShowSchedNeed(var Item: Record Item)
    var
        ProdOrderComp: Record "Prod. Order Component";
    begin
        ProdOrderComp.FindLinesWithItemToPlan(Item, true);
        PAGE.Run(0, ProdOrderComp);
    end;

    procedure ShowTransLines(var Item: Record Item; What: Integer)
    var
        TransLine: Record "Transfer Line";
    begin
        case What of
            Item.FieldNo("Trans. Ord. Shipment (Qty.)"):
                TransLine.FindLinesWithItemToPlan(Item, false, false);
            Item.FieldNo("Qty. in Transit"),
          Item.FieldNo("Trans. Ord. Receipt (Qty.)"):
                TransLine.FindLinesWithItemToPlan(Item, true, false);
        end;
        PAGE.Run(0, TransLine);
    end;

    procedure ShowAsmOrders(var Item: Record Item)
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        AssemblyHeader.FindItemToPlanLines(Item, AssemblyHeader."Document Type"::Order);
        PAGE.Run(0, AssemblyHeader);
    end;

    procedure ShowAsmCompLines(var Item: Record Item)
    var
        AssemblyLine: Record "Assembly Line";
    begin
        AssemblyLine.FindItemToPlanLines(Item, AssemblyLine."Document Type"::Order);
        PAGE.Run(0, AssemblyLine);
    end;

    procedure ShowItemAvailLineList(var Item: Record Item; What: Integer)
    var
        ItemCopy: Record Item;
        ItemAvailLineList: Page "Item Availability Line List";
    begin
        ItemCopy.Copy(Item);
        CalcItemPlanningFields(ItemCopy, ItemCopy.GetFilter("Location Filter") <> '');
        IF QtyByUnitOfMeasure <> 0 THEN
            ItemAvailLineList.SetQtyByUnitOfMeasure(QtyByUnitOfMeasure);
        ItemAvailLineList.Init(What, ItemCopy);
        ItemAvailLineList.RunModal();
    end;

    procedure ShowItemAvailFromItem(var Item: Record Item; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin

        Item.TestField("No.");

        OnBeforeShowItemAvailFromItem(Item);
        case AvailabilityType of
            AvailabilityType::Date:
                ShowItemAvailByDate(Item, '', NewDate, NewDate);
            AvailabilityType::Variant:
                ShowItemAvailVariant(Item, '', NewVariantCode, NewVariantCode);
            AvailabilityType::Site:
                ShowItemAvailByLoc(Item, '', NewSiteCode, NewSiteCode);
            AvailabilityType::"Event":
                ShowItemAvailByEvent(Item, '', NewDate, NewDate, false);
            AvailabilityType::BOM:
                ShowItemAvailByBOMLevel(Item, '', NewDate, NewDate);
            AvailabilityType::UOM:
                ShowItemAvailByUOM(Item, '', NewUnitOfMeasureCode, NewUnitOfMeasureCode);
        end;
    end;


    procedure ShowItemAvailFromSalesLine(var SalesLine: Record "Sales Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        AsmHeader: Record "Assembly Header";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
        IsHandled: Boolean;
    begin

        SalesLine.TestField(Type, SalesLine.Type::Item);
        SalesLine.TestField("No.");
        Item.Reset();
        Item.Get(SalesLine."No.");
        FilterItem(Item, SalesLine."Location Code", SalesLine."Variant Code", SalesLine."Shipment Date");

        IsHandled := false;
        OnBeforeShowItemAvailFromSalesLine(Item, SalesLine, IsHandled, AvailabilityType);
        if IsHandled then
            exit;

        case AvailabilityType of
            AvailabilityType::Date:
                if ShowItemAvailByDate(Item, SalesLine.FieldCaption("Shipment Date"), SalesLine."Shipment Date", NewDate) then
                    SalesLine.Validate("Shipment Date", NewDate);
            AvailabilityType::Variant:
                if ShowItemAvailVariant(Item, SalesLine.FieldCaption("Variant Code"), SalesLine."Variant Code", NewVariantCode) then begin
                    SalesLine.Validate("Variant Code", NewVariantCode);
                    ItemCheckAvail.SalesLineCheck(SalesLine);
                end;
            AvailabilityType::Site:
                if ShowItemAvailByLoc(Item, SalesLine.FieldCaption(FBM_Site), SalesLine.FBM_Site, NewSiteCode) then begin
                    SalesLine.Validate(FBM_Site, NewSiteCode);
                    ItemCheckAvail.SalesLineCheck(SalesLine);
                end;
            AvailabilityType::"Event":
                if ShowItemAvailByEvent(Item, SalesLine.FieldCaption("Shipment Date"), SalesLine."Shipment Date", NewDate, false) then
                    SalesLine.Validate("Shipment Date", NewDate);
            AvailabilityType::BOM:
                if SalesLine.AsmToOrderExists(AsmHeader) then
                    ShowItemAvailFromAsmHeader(AsmHeader, AvailabilityType)
                else
                    if ShowItemAvailByBOMLevel(Item, SalesLine.FieldCaption("Shipment Date"), SalesLine."Shipment Date", NewDate) then
                        SalesLine.Validate("Shipment Date", NewDate);
            AvailabilityType::UOM:
                if ShowItemAvailByUOM(Item, SalesLine.FieldCaption("Unit of Measure Code"), SalesLine."Unit of Measure Code", NewUnitOfMeasureCode) then
                    SalesLine.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
        end;
    end;


    procedure ShowItemAvailFromPurchLine(var PurchLine: Record "Purchase Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[10];
        NewUnitOfMeasureCode: Code[10];
        IsHandled: Boolean;
    begin
        begin
            PurchLine.TestField(Type, PurchLine.Type::Item);
            PurchLine.TestField("No.");
            Item.Reset();
            Item.Get(PurchLine."No.");
            FilterItem(Item, PurchLine.FBM_Site, PurchLine."Variant Code", PurchLine."Expected Receipt Date");

            IsHandled := false;
            OnBeforeShowItemAvailFromPurchLine(Item, PurchLine, IsHandled, AvailabilityType);
            if IsHandled then
                exit;

            case AvailabilityType of
                AvailabilityType::Date:
                    if ShowItemAvailByDate(Item, PurchLine.FieldCaption("Expected Receipt Date"), PurchLine."Expected Receipt Date", NewDate) then
                        PurchLine.Validate("Expected Receipt Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, PurchLine.FieldCaption("Variant Code"), PurchLine."Variant Code", NewVariantCode) then
                        PurchLine.Validate("Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    if ShowItemAvailByLoc(Item, PurchLine.FieldCaption(FBM_Site), PurchLine.FBM_Site, NewSiteCode) then
                        PurchLine.Validate("Location Code", NewsiteCode);
                AvailabilityType::"Event":
                    if ShowItemAvailByEvent(Item, PurchLine.FieldCaption("Expected Receipt Date"), PurchLine."Expected Receipt Date", NewDate, false) then
                        PurchLine.Validate("Expected Receipt Date", NewDate);
                AvailabilityType::BOM:
                    if ShowItemAvailByBOMLevel(Item, PurchLine.FieldCaption("Expected Receipt Date"), PurchLine."Expected Receipt Date", NewDate) then
                        PurchLine.Validate("Expected Receipt Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, PurchLine.FieldCaption("Unit of Measure Code"), PurchLine."Unit of Measure Code", NewUnitOfMeasureCode) then
                        PurchLine.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromReqLine(var ReqLine: Record "Requisition Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[10];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            ReqLine.TestField(Type, ReqLine.Type::Item);
            ReqLine.TestField("No.");
            Item.Reset();
            Item.Get(ReqLine."No.");
            FilterItem(Item, ReqLine."Location Code", ReqLine."Variant Code", ReqLine."Due Date");

            OnBeforeShowItemAvailFromReqLine(Item, ReqLine, AvailabilityType);
            case AvailabilityType of
                AvailabilityType::Date:
                    if ShowItemAvailByDate(Item, ReqLine.FieldCaption("Due Date"), ReqLine."Due Date", NewDate) then
                        ReqLine.Validate("Due Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, ReqLine.FieldCaption("Variant Code"), ReqLine."Variant Code", NewVariantCode) then
                        ReqLine.Validate("Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    if ShowItemAvailByLoc(Item, ReqLine.FieldCaption("Location Code"), ReqLine."Location Code", NewSiteCode) then
                        ReqLine.Validate("Location Code", NewSiteCode);
                AvailabilityType::"Event":
                    begin
                        Item.SetRange("Date Filter");

                        ForecastName := '';
                        ReqLine.FindCurrForecastName(ForecastName);

                        if ShowItemAvailByEvent(Item, ReqLine.FieldCaption("Due Date"), ReqLine."Due Date", NewDate, true) then
                            ReqLine.Validate("Due Date", NewDate);
                    end;
                AvailabilityType::BOM:
                    if ShowItemAvailByBOMLevel(Item, ReqLine.FieldCaption("Due Date"), ReqLine."Due Date", NewDate) then
                        ReqLine.Validate("Due Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, ReqLine.FieldCaption("Unit of Measure Code"), ReqLine."Unit of Measure Code", NewUnitOfMeasureCode) then
                        ReqLine.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromProdOrderLine(var ProdOrderLine: Record "Prod. Order Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[10];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            ProdOrderLine.TestField("Item No.");
            Item.Reset();
            Item.Get(ProdOrderLine."Item No.");
            FilterItem(Item, ProdOrderLine."Location Code", ProdOrderLine."Variant Code", ProdOrderLine."Due Date");

            OnBeforeShowItemAvailFromProdOrderLine(Item, ProdOrderLine);
            case AvailabilityType of
                AvailabilityType::Date:
                    if ShowItemAvailByDate(Item, ProdOrderLine.FieldCaption("Due Date"), ProdOrderLine."Due Date", NewDate) then
                        ProdOrderLine.Validate("Due Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, ProdOrderLine.FieldCaption("Variant Code"), ProdOrderLine."Variant Code", NewVariantCode) then
                        ProdOrderLine.Validate("Variant Code", NewVariantCode);
                AvailabilityType::site:
                    if ShowItemAvailByLoc(Item, ProdOrderLine.FieldCaption("Location Code"), ProdOrderLine."Location Code", NewSiteCode) then
                        ProdOrderLine.Validate("Location Code", NewSiteCode);
                AvailabilityType::"Event":
                    if ShowItemAvailByEvent(Item, ProdOrderLine.FieldCaption("Due Date"), ProdOrderLine."Due Date", NewDate, false) then
                        ProdOrderLine.Validate("Due Date", NewDate);
                AvailabilityType::BOM:
                    if ShowCustomProdItemAvailByBOMLevel(ProdOrderLine, ProdOrderLine.FieldCaption("Due Date"), ProdOrderLine."Due Date", NewDate) then
                        ProdOrderLine.Validate("Due Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, ProdOrderLine.FieldCaption("Unit of Measure Code"), ProdOrderLine."Unit of Measure Code", NewUnitOfMeasureCode) then
                        ProdOrderLine.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromProdOrderComp(var ProdOrderComp: Record "Prod. Order Component"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[10];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            ProdOrderComp.TestField("Item No.");
            Item.Reset();
            Item.Get(ProdOrderComp."Item No.");
            FilterItem(Item, ProdOrderComp."Location Code", ProdOrderComp."Variant Code", ProdOrderComp."Due Date");

            OnBeforeShowItemAvailFromProdOrderComp(Item, ProdOrderComp);
            case AvailabilityType of
                AvailabilityType::Date:
                    if ShowItemAvailByDate(Item, ProdOrderComp.FieldCaption("Due Date"), ProdOrderComp."Due Date", NewDate) then
                        ProdOrderComp.Validate("Due Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, ProdOrderComp.FieldCaption("Variant Code"), ProdOrderComp."Variant Code", NewVariantCode) then
                        ProdOrderComp.Validate("Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    if ShowItemAvailByLoc(Item, ProdOrderComp.FieldCaption("Location Code"), ProdOrderComp."Location Code", NewSiteCode) then
                        ProdOrderComp.Validate("Location Code", NewSiteCode);
                AvailabilityType::"Event":
                    if ShowItemAvailByEvent(Item, ProdOrderComp.FieldCaption("Due Date"), ProdOrderComp."Due Date", NewDate, false) then
                        ProdOrderComp.Validate("Due Date", NewDate);
                AvailabilityType::BOM:
                    if ShowItemAvailByBOMLevel(Item, ProdOrderComp.FieldCaption("Due Date"), ProdOrderComp."Due Date", NewDate) then
                        ProdOrderComp.Validate("Due Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, ProdOrderComp.FieldCaption("Unit of Measure Code"), ProdOrderComp."Unit of Measure Code", NewUnitOfMeasureCode) then
                        ProdOrderComp.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromTransLine(var TransLine: Record "Transfer Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            TransLine.TestField("Item No.");
            Item.Reset();
            Item.Get(TransLine."Item No.");
            FilterItem(Item, TransLine."Transfer-from Code", TransLine."Variant Code", TransLine."Shipment Date");

            OnBeforeShowItemAvailFromTransLine(Item, TransLine, AvailabilityType);
            case AvailabilityType of
                AvailabilityType::Date:
                    if ShowItemAvailByDate(Item, TransLine.FieldCaption("Shipment Date"), TransLine."Shipment Date", NewDate) then
                        TransLine.Validate("Shipment Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, TransLine.FieldCaption("Variant Code"), TransLine."Variant Code", NewVariantCode) then
                        TransLine.Validate("Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    if ShowItemAvailByLoc(Item, TransLine.FieldCaption("Transfer-from Code"), TransLine."Transfer-from Code", NewSiteCode) then
                        TransLine.Validate("Transfer-from Code", NewSiteCode);
                AvailabilityType::"Event":
                    if ShowItemAvailByEvent(Item, TransLine.FieldCaption("Shipment Date"), TransLine."Shipment Date", NewDate, false) then
                        TransLine.Validate("Shipment Date", NewDate);
                AvailabilityType::BOM:
                    if ShowItemAvailByBOMLevel(Item, TransLine.FieldCaption("Shipment Date"), TransLine."Shipment Date", NewDate) then
                        TransLine.Validate("Shipment Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, TransLine.FieldCaption("Unit of Measure Code"), TransLine."Unit of Measure Code", NewUnitOfMeasureCode) then
                        TransLine.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromWhseActivLine(var WhseActivLine: Record "Warehouse Activity Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            WhseActivLine.TestField("Item No.");
            Item.Reset();
            Item.Get(WhseActivLine."Item No.");
            FilterItem(Item, WhseActivLine."Location Code", WhseActivLine."Variant Code", WhseActivLine."Due Date");

            OnBeforeShowItemAvailFromWhseActivLine(Item, WhseActivLine, AvailabilityType);
            case AvailabilityType of
                AvailabilityType::Date:
                    ShowItemAvailByDate(Item, WhseActivLine.FieldCaption("Due Date"), WhseActivLine."Due Date", NewDate);
                AvailabilityType::Variant:
                    ShowItemAvailVariant(Item, WhseActivLine.FieldCaption("Variant Code"), WhseActivLine."Variant Code", NewVariantCode);
                AvailabilityType::site:
                    ShowItemAvailByLoc(Item, WhseActivLine.FieldCaption("Location Code"), WhseActivLine."Location Code", NewSiteCode);
                AvailabilityType::"Event":
                    ShowItemAvailByEvent(Item, WhseActivLine.FieldCaption("Due Date"), WhseActivLine."Due Date", NewDate, false);
                AvailabilityType::BOM:
                    ShowItemAvailByBOMLevel(Item, WhseActivLine.FieldCaption("Due Date"), WhseActivLine."Due Date", NewDate);
                AvailabilityType::UOM:
                    ShowItemAvailByUOM(Item, WhseActivLine.FieldCaption("Unit of Measure Code"), WhseActivLine."Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromServLine(var ServLine: Record "Service Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        ServHeader: Record "Service Header";
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            ServHeader.Get(ServLine."Document Type", ServLine."Document No.");
            ServLine.TestField(Type, ServLine.Type::Item);
            ServLine.TestField("No.");
            Item.Reset();
            Item.Get(ServLine."No.");
            FilterItem(Item, ServLine."Location Code", ServLine."Variant Code", ServHeader."Response Date");

            OnBeforeShowItemAvailFromServLine(Item, ServLine);
            case AvailabilityType of
                AvailabilityType::Date:
                    ShowItemAvailByDate(Item, ServHeader.FieldCaption("Response Date"), ServHeader."Response Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, ServLine.FieldCaption("Variant Code"), ServLine."Variant Code", NewVariantCode) then
                        ServLine.Validate("Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    if ShowItemAvailByLoc(Item, ServLine.FieldCaption("Location Code"), ServLine."Location Code", NewSiteCode) then
                        ServLine.Validate("Location Code", NewSiteCode);
                AvailabilityType::"Event":
                    ShowItemAvailByEvent(Item, ServHeader.FieldCaption("Response Date"), ServHeader."Response Date", NewDate, false);
                AvailabilityType::BOM:
                    ShowItemAvailByBOMLevel(Item, ServHeader.FieldCaption("Response Date"), ServHeader."Response Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, ServLine.FieldCaption("Unit of Measure Code"), ServLine."Unit of Measure Code", NewUnitOfMeasureCode) then
                        ServLine.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromWhseRcptLine(var WhseRcptLine: Record "Warehouse Receipt Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            WhseRcptLine.TestField("Item No.");
            Item.Reset();
            Item.Get(WhseRcptLine."Item No.");
            FilterItem(Item, WhseRcptLine."Location Code", WhseRcptLine."Variant Code", WhseRcptLine."Due Date");

            OnBeforeShowItemAvailFromWhseRcptLine(Item, WhseRcptLine, AvailabilityType);
            case AvailabilityType of
                AvailabilityType::Date:
                    ShowItemAvailByDate(Item, WhseRcptLine.FieldCaption("Due Date"), WhseRcptLine."Due Date", NewDate);
                AvailabilityType::Variant:
                    ShowItemAvailVariant(Item, WhseRcptLine.FieldCaption("Variant Code"), WhseRcptLine."Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    ShowItemAvailByLoc(Item, WhseRcptLine.FieldCaption("Location Code"), WhseRcptLine."Location Code", NewSiteCode);
                AvailabilityType::"Event":
                    ShowItemAvailByEvent(Item, WhseRcptLine.FieldCaption("Due Date"), WhseRcptLine."Due Date", NewDate, false);
                AvailabilityType::BOM:
                    ShowItemAvailByBOMLevel(Item, WhseRcptLine.FieldCaption("Due Date"), WhseRcptLine."Due Date", NewDate);
                AvailabilityType::UOM:
                    ShowItemAvailByUOM(Item, WhseRcptLine.FieldCaption("Unit of Measure Code"), WhseRcptLine."Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromItemJnlLine(var ItemJnlLine: Record "Item Journal Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            ItemJnlLine.TestField("Item No.");
            Item.Reset();
            Item.Get(ItemJnlLine."Item No.");
            FilterItem(Item, ItemJnlLine.FBM_Site, ItemJnlLine."Variant Code", ItemJnlLine."Posting Date");

            OnBeforeShowItemAvailFromItemJnlLine(Item, ItemJnlLine, AvailabilityType);
            case AvailabilityType of
                AvailabilityType::Date:
                    if ShowItemAvailByDate(Item, ItemJnlLine.FieldCaption("Posting Date"), ItemJnlLine."Posting Date", NewDate) then
                        ItemJnlLine.Validate("Posting Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, ItemJnlLine.FieldCaption("Variant Code"), ItemJnlLine."Variant Code", NewVariantCode) then
                        ItemJnlLine.Validate("Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    if ShowItemAvailByLoc(Item, ItemJnlLine.FieldCaption(FBM_Site), ItemJnlLine.FBM_Site, NewSiteCode) then
                        ItemJnlLine.Validate(FBM_Site, NewSiteCode);
                AvailabilityType::"Event":
                    if ShowItemAvailByEvent(Item, ItemJnlLine.FieldCaption("Posting Date"), ItemJnlLine."Posting Date", NewDate, false) then
                        ItemJnlLine.Validate("Posting Date", NewDate);
                AvailabilityType::BOM:
                    if ShowItemAvailByBOMLevel(Item, ItemJnlLine.FieldCaption("Posting Date"), ItemJnlLine."Posting Date", NewDate) then
                        ItemJnlLine.Validate("Posting Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, ItemJnlLine.FieldCaption("Unit of Measure Code"), ItemJnlLine."Unit of Measure Code", NewUnitOfMeasureCode) then
                        ItemJnlLine.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromAsmHeader(var AsmHeader: Record "Assembly Header"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            AsmHeader.TestField("Item No.");
            Item.Reset();
            Item.Get(AsmHeader."Item No.");
            FilterItem(Item, AsmHeader."Location Code", AsmHeader."Variant Code", AsmHeader."Due Date");

            OnBeforeShowItemAvailFromAsmHeader(Item, AsmHeader);
            case AvailabilityType of
                AvailabilityType::Date:
                    if ShowItemAvailByDate(Item, AsmHeader.FieldCaption("Due Date"), AsmHeader."Due Date", NewDate) then
                        AsmHeader.Validate("Due Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, AsmHeader.FieldCaption("Variant Code"), AsmHeader."Variant Code", NewVariantCode) then
                        AsmHeader.Validate("Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    if ShowItemAvailByLoc(Item, AsmHeader.FieldCaption("Location Code"), AsmHeader."Location Code", NewsiteCode) then
                        AsmHeader.Validate("Location Code", NewsiteCode);
                AvailabilityType::"Event":
                    if ShowItemAvailByEvent(Item, AsmHeader.FieldCaption("Due Date"), AsmHeader."Due Date", NewDate, false) then
                        AsmHeader.Validate("Due Date", NewDate);
                AvailabilityType::BOM:
                    if ShowCustomAsmItemAvailByBOMLevel(AsmHeader, AsmHeader.FieldCaption("Due Date"), AsmHeader."Due Date", NewDate) then
                        AsmHeader.Validate("Due Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, AsmHeader.FieldCaption("Unit of Measure Code"), AsmHeader."Unit of Measure Code", NewUnitOfMeasureCode) then
                        AsmHeader.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromAsmLine(var AsmLine: Record "Assembly Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            AsmLine.TestField(Type, AsmLine.Type::Item);
            AsmLine.TestField("No.");
            Item.Reset();
            Item.Get(AsmLine."No.");
            FilterItem(Item, AsmLine."Location Code", AsmLine."Variant Code", AsmLine."Due Date");

            OnBeforeShowItemAvailFromAsmLine(Item, AsmLine);
            case AvailabilityType of
                AvailabilityType::Date:
                    if ShowItemAvailByDate(Item, AsmLine.FieldCaption("Due Date"), AsmLine."Due Date", NewDate) then
                        AsmLine.Validate("Due Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, AsmLine.FieldCaption("Variant Code"), AsmLine."Variant Code", NewVariantCode) then
                        AsmLine.Validate("Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    if ShowItemAvailByLoc(Item, AsmLine.FieldCaption("Location Code"), AsmLine."Location Code", NewSiteCode) then
                        AsmLine.Validate("Location Code", NewSiteCode);
                AvailabilityType::"Event":
                    if ShowItemAvailByEvent(Item, AsmLine.FieldCaption("Due Date"), AsmLine."Due Date", NewDate, false) then
                        AsmLine.Validate("Due Date", NewDate);
                AvailabilityType::BOM:
                    if ShowItemAvailByBOMLevel(Item, AsmLine.FieldCaption("Due Date"), AsmLine."Due Date", NewDate) then
                        AsmLine.Validate("Due Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, AsmLine.FieldCaption("Unit of Measure Code"), AsmLine."Unit of Measure Code", NewUnitOfMeasureCode) then
                        AsmLine.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromPlanningComp(var PlanningComp: Record "Planning Component"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM,UOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin
        begin
            PlanningComp.TestField("Item No.");
            Item.Reset();
            Item.Get(PlanningComp."Item No.");
            FilterItem(Item, PlanningComp."Location Code", PlanningComp."Variant Code", PlanningComp."Due Date");

            OnBeforeShowItemAvailFromPlanningComp(Item, PlanningComp);
            case AvailabilityType of
                AvailabilityType::Date:
                    if ShowItemAvailByDate(Item, PlanningComp.FieldCaption("Due Date"), PlanningComp."Due Date", NewDate) then
                        PlanningComp.Validate("Due Date", NewDate);
                AvailabilityType::Variant:
                    if ShowItemAvailVariant(Item, PlanningComp.FieldCaption("Variant Code"), PlanningComp."Variant Code", NewVariantCode) then
                        PlanningComp.Validate("Variant Code", NewVariantCode);
                AvailabilityType::Site:
                    if ShowItemAvailByLoc(Item, PlanningComp.FieldCaption("Location Code"), PlanningComp."Location Code", NewSiteCode) then
                        PlanningComp.Validate("Location Code", NewSiteCode);
                AvailabilityType::"Event":
                    begin
                        ForecastName := '';
                        PlanningComp.FindCurrForecastName(ForecastName);

                        if ShowItemAvailByEvent(Item, PlanningComp.FieldCaption("Due Date"), PlanningComp."Due Date", NewDate, true) then
                            PlanningComp.Validate("Due Date", NewDate);
                    end;
                AvailabilityType::BOM:
                    if ShowItemAvailByBOMLevel(Item, PlanningComp.FieldCaption("Due Date"), PlanningComp."Due Date", NewDate) then
                        PlanningComp.Validate("Due Date", NewDate);
                AvailabilityType::UOM:
                    if ShowItemAvailByUOM(Item, PlanningComp.FieldCaption("Unit of Measure Code"), PlanningComp."Unit of Measure Code", NewUnitOfMeasureCode) then
                        PlanningComp.Validate("Unit of Measure Code", NewUnitOfMeasureCode);
            end;
        end;
    end;

    procedure ShowItemAvailFromInvtDocLine(var InvtDocLine: Record "Invt. Document Line"; AvailabilityType: Option Date,Variant,Site,Bin,"Event",BOM)
    var
        Item: Record Item;
        NewDate: Date;
        NewVariantCode: Code[10];
        NewSiteCode: Code[20];
        CaptionText: Text[80];
    begin
        InvtDocLine.TestField("Item No.");
        Item.Reset();
        Item.Get(InvtDocLine."Item No.");
        FilterItem(Item, InvtDocLine."Location Code", InvtDocLine."Variant Code", InvtDocLine."Posting Date");

        case AvailabilityType of
            AvailabilityType::Date:
                begin
                    CaptionText := CopyStr(InvtDocLine.FieldCaption("Posting Date"), 1, 80);
                    if ShowItemAvailByDate(Item, CaptionText, InvtDocLine."Posting Date", NewDate) then
                        InvtDocLine.Validate("Posting Date", NewDate);
                end;
            AvailabilityType::Variant:
                begin
                    CaptionText := CopyStr(InvtDocLine.FieldCaption("Variant Code"), 1, 80);
#pragma warning disable AA0139 // required fix
                    if ShowItemAvailVariant(Item, CaptionText, InvtDocLine."Variant Code", NewVariantCode) then
                        InvtDocLine.Validate("Variant Code", NewVariantCode);
#pragma warning restore AA0139
                end;
            AvailabilityType::Site:
                begin
                    CaptionText := CopyStr(InvtDocLine.FieldCaption("Location Code"), 1, 80);
#pragma warning disable AA0139 // required fix
                    if ShowItemAvailByLoc(Item, CaptionText, InvtDocLine."Location Code", NewSiteCode) then
                        InvtDocLine.Validate("Location Code", NewSiteCode);
#pragma warning restore AA0139
                end;
            AvailabilityType::"Event":
                begin
                    CaptionText := CopyStr(InvtDocLine.FieldCaption("Posting Date"), 1, 80);
                    if ShowItemAvailByEvent(Item, CaptionText, InvtDocLine."Posting Date", NewDate, false) then
                        InvtDocLine.Validate("Posting Date", NewDate);
                end;
            AvailabilityType::BOM:
                begin
                    CaptionText := CopyStr(InvtDocLine.FieldCaption("Posting Date"), 1, 80);
                    if ShowItemAvailByBOMLevel(Item, CaptionText, InvtDocLine."Posting Date", NewDate) then
                        InvtDocLine.Validate("Posting Date", NewDate);
                end;
        end;
    end;

    procedure ShowItemAvailByEvent(var Item: Record Item; FieldCaption: Text[80]; OldDate: Date; var NewDate: Date; IncludeForecast: Boolean): Boolean
    var
        ItemAvailByEvent: Page "Item Availability by Event";
        IsHandled: Boolean;
        Result: Boolean;
    begin
        // Do not make global
        // Request to make function global has been rejected as it is a skeleton function of the codeunit
        IsHandled := false;
        OnBeforeShowItemAvailByEvent(Item, FieldCaption, OldDate, NewDate, IncludeForecast, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if FieldCaption <> '' then
            ItemAvailByEvent.LookupMode(true);
        ItemAvailByEvent.SetItem(Item);
        if IncludeForecast then begin
            ItemAvailByEvent.SetIncludePlan(true);
            if ForecastName <> '' then
                ItemAvailByEvent.SetForecastName(ForecastName);
        end;
        if ItemAvailByEvent.RunModal() = ACTION::LookupOK then begin
            NewDate := ItemAvailByEvent.GetSelectedDate();
            if (NewDate <> 0D) and (NewDate <> OldDate) then
                if Confirm(Text012, true, FieldCaption, OldDate, NewDate) then
                    exit(true);
        end;
    end;

    procedure ShowItemAvailByLoc(var Item: Record Item; FieldCaption: Text[80]; OldSiteCode: Code[20]; var NewSiteCode: Code[20]): Boolean
    var
        ItemAvailByLoc: Page FBM_ItemAvBySite;
        IsHandled: Boolean;
        Result: Boolean;
    begin
        // Do not make global
        // Request to make function global has been rejected as it is a skeleton function of the codeunit
        IsHandled := false;
        OnBeforeShowItemAvailByLoc(Item, FieldCaption, OldSiteCode, NewSiteCode, Result, IsHandled);
        if IsHandled then
            exit(Result);

        Item.SetRange(FBM_SiteFilter);
        if FieldCaption <> '' then
            ItemAvailByLoc.LookupMode(true);
        ItemAvailByLoc.SetRecord(Item);
        ItemAvailByLoc.SetTableView(Item);
        if ItemAvailByLoc.RunModal() = ACTION::LookupOK then begin
            NewSiteCode := ItemAvailByLoc.GetLastLocation();
            if OldSiteCode <> NewSiteCode then
                if Confirm(Text012, true, FieldCaption, OldSiteCode, NewSiteCode) then
                    exit(true);
        end;
    end;

    procedure ShowItemAvailByDate(var Item: Record Item; FieldCaption: Text[80]; OldDate: Date; var NewDate: Date): Boolean
    var
        ItemAvailByPeriods: Page "Item Availability by Periods";
        IsHandled: Boolean;
        Result: Boolean;
    begin
        // Do not make global
        // Request to make function global has been rejected as it is a skeleton function of the codeunit
        IsHandled := false;
        OnBeforeShowItemAvailByDate(Item, FieldCaption, OldDate, NewDate, Result, IsHandled);
        if IsHandled then
            exit(Result);

        Item.SetRange("Date Filter");
        if FieldCaption <> '' then
            ItemAvailByPeriods.LookupMode(true);
        ItemAvailByPeriods.SetRecord(Item);
        ItemAvailByPeriods.SetTableView(Item);
        if ItemAvailByPeriods.RunModal() = ACTION::LookupOK then begin
            NewDate := ItemAvailByPeriods.GetLastDate();
            if OldDate <> NewDate then
                if Confirm(Text012, true, FieldCaption, OldDate, NewDate) then
                    exit(true);
        end;
    end;

    procedure ShowItemAvailVariant(var Item: Record Item; FieldCaption: Text[80]; OldVariant: Code[20]; var NewVariant: Code[20]): Boolean
    var
        ItemAvailByVariant: Page "Item Availability by Variant";
        IsHandled: Boolean;
        Result: Boolean;
    begin
        // Do not make global
        // Request to make function global has been rejected as it is a skeleton function of the codeunit
        IsHandled := false;
        OnBeforeShowItemAvailVariant(Item, FieldCaption, OldVariant, NewVariant, Result, IsHandled);
        if IsHandled then
            exit(Result);

        Item.SetRange("Variant Filter");
        if FieldCaption <> '' then
            ItemAvailByVariant.LookupMode(true);
        ItemAvailByVariant.SetRecord(Item);
        ItemAvailByVariant.SetTableView(Item);
        if ItemAvailByVariant.RunModal() = ACTION::LookupOK then begin
            NewVariant := ItemAvailByVariant.GetLastVariant();
            if OldVariant <> NewVariant then
                if Confirm(Text012, true, FieldCaption, OldVariant, NewVariant) then
                    exit(true);
        end;
    end;

    procedure ShowItemAvailByBOMLevel(var Item: Record Item; FieldCaption: Text[80]; OldDate: Date; var NewDate: Date): Boolean
    var
        IsHandled: Boolean;
        Result: Boolean;
    begin
        // Do not make global
        // Request to make function global has been rejected as it is a skeleton function of the codeunit
        IsHandled := false;
        OnBeforeShowItemAvailByBOMLevel(Item, FieldCaption, OldDate, NewDate, Result, IsHandled);
        if IsHandled then
            exit(Result);

        Clear(ItemAvailByBOMLevel);
        Item.SetRange("Date Filter");
        ItemAvailByBOMLevel.InitItem(Item);
        ItemAvailByBOMLevel.InitDate(OldDate);
        exit(ShowBOMLevelAbleToMake(FieldCaption, OldDate, NewDate));
    end;

    procedure ShowItemAvailByUOM(var Item: Record Item; FieldCaption: Text[80]; OldUoMCode: Code[10]; var NewUoMCode: Code[10]): Boolean
    var
        ItemAvailByUOM: Page "Item Availability by UOM";
        IsHandled: Boolean;
        Result: Boolean;
    begin
        // Do not make global
        // Request to make function global has been rejected as it is a skeleton function of the codeunit
        IsHandled := false;
        OnBeforeShowItemAvailByUOM(Item, FieldCaption, OldUoMCode, NewUoMCode, Result, IsHandled);
        if IsHandled then
            exit(Result);

        Item.SetRange("Base Unit of Measure");
        if FieldCaption <> '' then
            ItemAvailByUOM.LookupMode(true);
        ItemAvailByUOM.SetRecord(Item);
        ItemAvailByUOM.SetTableView(Item);
        if ItemAvailByUOM.RunModal() = ACTION::LookupOK then begin
            NewUoMCode := ItemAvailByUOM.GetLastUOM();
            if OldUoMCode <> NewUoMCode then
                if Confirm(Text012, true, FieldCaption, OldUoMCode, NewUoMCode) then
                    exit(true);
        end;
    end;

    local procedure ShowCustomAsmItemAvailByBOMLevel(var AsmHeader: Record "Assembly Header"; FieldCaption: Text[80]; OldDate: Date; var NewDate: Date): Boolean
    begin
        Clear(ItemAvailByBOMLevel);
        ItemAvailByBOMLevel.InitAsmOrder(AsmHeader);
        ItemAvailByBOMLevel.InitDate(OldDate);
        exit(ShowBOMLevelAbleToMake(FieldCaption, OldDate, NewDate));
    end;

    local procedure ShowCustomProdItemAvailByBOMLevel(var ProdOrderLine: Record "Prod. Order Line"; FieldCaption: Text[80]; OldDate: Date; var NewDate: Date): Boolean
    begin
        Clear(ItemAvailByBOMLevel);
        ItemAvailByBOMLevel.InitProdOrder(ProdOrderLine);
        ItemAvailByBOMLevel.InitDate(OldDate);
        exit(ShowBOMLevelAbleToMake(FieldCaption, OldDate, NewDate));
    end;

    local procedure ShowBOMLevelAbleToMake(FieldCaption: Text[80]; OldDate: Date; var NewDate: Date): Boolean
    begin
        if FieldCaption <> '' then
            ItemAvailByBOMLevel.LookupMode(true);
        if ItemAvailByBOMLevel.RunModal() = ACTION::LookupOK then begin
            NewDate := ItemAvailByBOMLevel.GetSelectedDate();
            if OldDate <> NewDate then
                if Confirm(Text012, true, FieldCaption, OldDate, NewDate) then
                    exit(true);
        end;
    end;

    procedure SetQtyByUnitOfMeasure(NewQtyByUnitOfMeasure: Decimal);
    begin
        QtyByUnitOfMeasure := NewQtyByUnitOfMeasure;
    end;

    procedure FilterItem(var Item: Record Item; LocationCode: Code[20]; VariantCode: Code[20]; Date: Date)
    begin
        // Do not make global
        // Request to make function global has been rejected as it is a skeleton function of the codeunit
        Item.SetRange("No.", Item."No.");
        Item.SetRange("Date Filter", 0D, Date);
        Item.SetRange("Variant Filter", VariantCode);
        Item.SetRange("Location Filter", LocationCode);

        OnAfterFilterItem(Item, LocationCode, VariantCode, Date);
    end;

    procedure ByEvent(): Integer
    begin
        exit(AvailabilityType::"Event");
    end;

    procedure ByLocation(): Integer
    begin
        exit(AvailabilityType::Location);
    end;

    procedure ByVariant(): Integer
    begin
        exit(AvailabilityType::Variant);
    end;

    procedure ByPeriod(): Integer
    begin
        exit(AvailabilityType::Date);
    end;

    procedure ByBOM(): Integer
    begin
        exit(AvailabilityType::BOM);
    end;

    procedure ByUOM(): Integer
    begin
        exit(AvailabilityType::UOM);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcItemPlanningFields(var Item: Record Item)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalculateNeed(var Item: Record Item; var GrossRequirement: Decimal; var PlannedOrderReceipt: Decimal; var ScheduledReceipt: Decimal; var PlannedOrderReleases: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalculateProjAvailableBalance(var Item: Record Item; var ProjAvailableBalance: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailByBOMLevel(var Item: Record Item; FieldCaption: Text[80]; OldDate: Date; var NewDate: Date; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailByDate(var Item: Record Item; FieldCaption: Text[80]; OldDate: Date; var NewDate: Date; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailByEvent(var Item: Record Item; FieldCaption: Text[80]; OldDate: Date; var NewDate: Date; var IncludeForecast: Boolean; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailByLoc(var Item: Record Item; FieldCaption: Text[80]; OldLocationCode: Code[20]; var NewLocationCode: Code[20]; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailByUOM(var Item: Record Item; FieldCaption: Text[80]; OldUoMCode: Code[20]; var NewUoMCode: Code[20]; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromItem(var Item: Record Item)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromItemJnlLine(var Item: Record Item; var ItemJnlLine: Record "Item Journal Line"; AvailabilityType: Option Date,Variant,Location,Bin,"Event",BOM,UOM)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromSalesLine(var Item: Record Item; var SalesLine: Record "Sales Line"; var IsHandled: Boolean; AvailabilityType: Option Date,Variant,Location,Bin,"Event",BOM,UOM)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromPurchLine(var Item: Record Item; var PurchLine: Record "Purchase Line"; var IsHandled: Boolean; AvailabilityType: Option Date,Variant,Location,Bin,"Event",BOM,UOM)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromServLine(var Item: Record Item; var ServLine: Record "Service Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromReqLine(var Item: Record Item; var ReqLine: Record "Requisition Line"; AvailabilityType: Option Date,Variant,Location,Bin,"Event",BOM,UOM)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromProdOrderLine(var Item: Record Item; var ProdOrderLine: Record "Prod. Order Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromProdOrderComp(var Item: Record Item; var ProdOrderComp: Record "Prod. Order Component")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromTransLine(var Item: Record Item; var TransLine: Record "Transfer Line"; AvailabilityType: Option Date,Variant,Location,Bin,"Event",BOM,UOM)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromWhseActivLine(var Item: Record Item; var WhseActivLine: Record "Warehouse Activity Line"; AvailabilityType: Option Date,Variant,Location,Bin,"Event",BOM,UOM)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromWhseRcptLine(var Item: Record Item; var WhseRcptLine: Record "Warehouse Receipt Line"; AvailabilityType: Option Date,Variant,Location,Bin,"Event",BOM,UOM)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromAsmHeader(var Item: Record Item; var AssemblyHeader: Record "Assembly Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromAsmLine(var Item: Record Item; var AssemblyLine: Record "Assembly Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailFromPlanningComp(var Item: Record Item; var PlanningComp: Record "Planning Component")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowItemAvailVariant(var Item: Record Item; FieldCaption: Text[80]; OldVariant: Code[20]; var NewVariant: Code[20]; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCalculateNeedOnAfterCalcScheduledReceipt(var Item: Record Item; var ScheduledReceipt: Decimal; QtyinTransit: Decimal; TransOrdReceiptQty: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFilterItem(var Item: Record Item; LocationCode: Code[20]; VariantCode: Code[20]; Date: Date)
    begin
    end;
}
