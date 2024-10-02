codeunit 60104 FBM_Events_CO
{
    Permissions = tabledata 32 = rimd, tabledata "Sales Cr.Memo Header" = rimd,
    TableData "Sales Invoice Header" = rm,

                  tabledata "Sales Cr.Memo Line" = rm,
                  tabledata "Sales Invoice Line" = rm;

    EventSubscriberInstance = StaticAutomatic;

    var
        FormatAddress: Codeunit "Format Address";

        sales: Integer;

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = 393 then
            NewReportId := 60134;
        if ReportId = 405 then
            NewReportId := 60142;
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnLookUpAppliesToDocVendOnAfterSetFilters', '', false, false)]
    local procedure OnLookUpAppliesToDocVendOnAfterSetFilters(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; AccNo: Code[20])
    begin
        // VendorLedgerEntry.SetRange(FBM_approved, true);
        // VendorLedgerEntry.SetRange(FBM_approved1, true);
        // VendorLedgerEntry.SetRange(FBM_approved2, true);

    end;

    [IntegrationEvent(false, false)]
    procedure OnReasonCodeChanged(currpage: Page "FBM_PayJnl Bank List Part_CO");
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure AssignDocDimSetEntryValue(var SalesHeader: Record "Sales Header")//procedure to create Dim. Set Entries for Sales Doc. being posted
    var
        FASetup: Record "FA Setup";
        DimMgmt: Codeunit DimensionManagement;
        DimVal: Record "Dimension Value";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        Text000: label 'There are  start/end dates and no Site, please amend. Line %1';
        salesline: record "Sales Line";
    begin
        // salesline.SetRange("Document Type", SalesHeader."Document Type");
        // salesline.SetRange("Document No.", SalesHeader."No.");
        // if salesline.FindFirst() then
        //     repeat
        //         if ((salesline."FBM_Period Start" <> 0D) or (salesline."FBM_Period End" <> 0D)) and (salesline.FBM_Site = '') then
        //             error(Text000, salesline."Line No.");
        //     until salesline.next = 0;
        FASetup.Get();
        // if FASetup."FBM_Enable FA Site Tracking" then begin
        //     DimMgmt.GetDimensionSet(TempDimSetEntry, SalesHeader."Dimension Set ID");
        //     DimVal.Reset();
        //     if DimVal.get(FASetup."FBM_Site Dimension", SalesHeader.FBM_Site) then begin
        //         TempDimSetEntry.Init();
        //         //TempDimSetEntry."Dimension Set ID" := DimMgmt.GetDimensionSetID(TempDimSetEntry);
        //         TempDimSetEntry."Dimension Code" := FASetup."FBM_Site Dimension";
        //         TempDimSetEntry."Dimension Value Code" := SalesHeader.FBM_Site;
        //         TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
        //         TempDimSetEntry.Insert();
        //         SalesHeader."Dimension Set ID" := DimMgmt.GetDimensionSetID(TempDimSetEntry);
        //         SalesHeader.Modify();
        //     end;
        //     CLEAR(TempDimSetEntry);
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure AssignContractDocDimSetEntryValue(var SalesHeader: Record "Sales Header")//procedure to create Dim. Set Entries for Sales Doc. being posted
    var
        FASetup: Record "FA Setup";
        DimMgmt: Codeunit DimensionManagement;
        DimVal: Record "Dimension Value";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DSE_C: Record "Dimension Set Entry";
        salessetup: Record "Sales & Receivables Setup";
    begin
        salessetup.Get();
        if (salessetup."FBM_Period Start End mandatory") then begin
            // SalesHeader.TestField("Period Start");
            // SalesHeader.TestField("Period End");

            if (SalesHeader."FBM_Period Start" = 0D) then
                Error('Period start is mandatory');
            if (SalesHeader."FBM_Period End" = 0D) then
                Error('Period end is mandatory');

            FASetup.Get();
            DSE_C.Reset();
            if not DSE_C.Get(SalesHeader."Dimension Set ID", FASetup."FBM_Contract Dimension") then begin
                if FASetup."FBM_Enable FA Site Tracking" then begin
                    DimMgmt.GetDimensionSet(TempDimSetEntry, SalesHeader."Dimension Set ID");
                    DimVal.Reset();
                    if DimVal.get(FASetup."FBM_Contract Dimension", SalesHeader."FBM_Contract Code") then begin
                        TempDimSetEntry.Init();
                        TempDimSetEntry."Dimension Code" := FASetup."FBM_Contract Dimension";
                        TempDimSetEntry."Dimension Value Code" := SalesHeader."FBM_Contract Code";
                        TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                        TempDimSetEntry.Insert();
                        SalesHeader."Dimension Set ID" := DimMgmt.GetDimensionSetID(TempDimSetEntry);
                        SalesHeader.Modify();
                    end;
                    CLEAR(TempDimSetEntry);
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure "Gen. Journal Line_OnAfterCopyGenJnlLineFromSalesHeader"(SalesHeader: Record "Sales Header";
    var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."FBM_Period Start" := SalesHeader."FBM_Period Start";
        GenJournalLine."FBM_Period End" := SalesHeader."FBM_Period End";
        GenJournalLine.FBM_Segment2 := SalesHeader.FBM_Segment2;
        GenJournalLine.FBM_Site := SalesHeader.FBM_Site;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitGLEntry"(var GLEntry: Record "G/L Entry";
    GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        GLEntry."FBM_Period End" := GenJournalLine."FBM_Period End";

        GLEntry.FBM_Segment2 := GenJournalLine.FBM_Segment2;
        GLEntry.FBM_Site := GenJournalLine.FBM_Site;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterHandleAddCurrResidualGLEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterHandleAddCurrResidualGLEntry"(GenJournalLine: Record "Gen. Journal Line";
    GLEntry2: Record "G/L Entry")
    begin
        GLEntry2."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        GLEntry2."FBM_Period End" := GenJournalLine."FBM_Period End";
        GLEntry2.FBM_Segment2 := GenJournalLine.FBM_Segment2;
        GLEntry2.FBM_Site := GenJournalLine.FBM_Site;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeInsertGLEntryBuffer"(var TempGLEntryBuf: Record "G/L Entry";
    var GenJournalLine: Record "Gen. Journal Line";
    var BalanceCheckAmount: Decimal;
    var BalanceCheckAmount2: Decimal;
    var BalanceCheckAddCurrAmount: Decimal;
    var BalanceCheckAddCurrAmount2: Decimal;
    var NextEntryNo: Integer)
    begin
        TempGLEntryBuf."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        TempGLEntryBuf."FBM_Period End" := GenJournalLine."FBM_Period End";
        TempGLEntryBuf.FBM_Segment2 := GenJournalLine.FBM_Segment2;
        TempGLEntryBuf.FBM_Site := GenJournalLine.FBM_Site;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure "Cust. Ledger Entry_OnAfterCopyCustLedgerEntryFromGenJnlLine"(var CustLedgerEntry: Record "Cust. Ledger Entry";
    GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        CustLedgerEntry."FBM_Period End" := GenJournalLine."FBM_Period End";
        CustLedgerEntry.FBM_Segment2 := GenJournalLine.FBM_Segment2;
        CustLedgerEntry.FBM_Site := GenJournalLine.FBM_Site;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitCustLedgEntry"(var CustLedgerEntry: Record "Cust. Ledger Entry";
    GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        CustLedgerEntry."FBM_Period End" := GenJournalLine."FBM_Period End";
        CustLedgerEntry.FBM_Segment2 := GenJournalLine.FBM_Segment2;
        CustLedgerEntry.FBM_Site := GenJournalLine.FBM_Site;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeInsertDtldCustLedgEntry"(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    GenJournalLine: Record "Gen. Journal Line";
    DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldCustLedgEntry."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        DtldCustLedgEntry."FBM_Period End" := GenJournalLine."FBM_Period End";
        DtldCustLedgEntry.FBM_Segment2 := GenJournalLine.FBM_Segment2;
        DtldCustLedgEntry.FBM_Site := GenJournalLine.FBM_Site;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeTempPrepmtPurchLineInsert', '', false, false)]
    local procedure SetAmt
    (
        var TempPrepmtPurchLine: Record "Purchase Line" temporary;
    var TempPurchLine: Record "Purchase Line" temporary; PurchaseHeader: Record "Purchase Header"; CompleteFunctionality: Boolean
    )

    begin
        TempPrepmtPurchLine."Prepmt Amt to Deduct" := TempPurchLine."Prepmt Amt to Deduct";
        TempPrepmtPurchLine."Prepmt. Amt. Inv." := TempPurchLine."Prepmt. Amt. Inv.";
        TempPrepmtPurchLine."Prepmt. Amt. Incl. VAT" := TempPurchLine."Prepmt. Amt. Incl. VAT";



    end;


    [EventSubscriber(ObjectType::Codeunit, 60104, 'OnReasonCodeChanged', '', true, true)]
    procedure RefreshBanksList(currpage: Page "FBM_PayJnl Bank List Part_CO");
    begin
        currpage.Update(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 231, 'OnBeforeCode', '', true, true)]
    procedure OnBeforeCode(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean);
    begin
        if GenJournalLine.FindSet() then begin
            if GenJournalLine."Journal Batch Name" = 'APPROVALS' then begin
                // Message('APPROVALS');
                GenJournalLine.SetRange("Reason Code", 'APPROVED');

            end;

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 13, 'OnAfterCode', '', true, true)]
    procedure OnAfterCode(var GenJournalLine: Record "Gen. Journal Line"; PreviewMode: Boolean);
    begin
        // GenJournalLine.SetRange("Reason Code", 'REJECTED');
        // if GenJournalLine.FindSet() then begin
        // if GenJournalLine."Journal Batch Name" = 'APPROVALS' then begin
        // Message('APPROVALS');

        // GenJournalLine.DeleteAll();

        // end;

        // end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnPostUpdateOrderLineOnAfterReceive', '', true, true)]
    procedure OnAfterProcessPurchLines(var PurchHeader: Record "Purchase Header"; var TempPurchLine: Record "Purchase Line" temporary);
    var
        purchline: record "Purch. Inv. Line";
        itemtrack: record "Tracking Specification";
        fa: record "Fixed Asset";
    begin
        if PurchHeader.Receive then begin
            itemtrack.SetRange("Source ID", PurchHeader."No.");
            itemtrack.SetRange("Source Type", 39);
            itemtrack.SetRange("Source Subtype", 1);
            if itemtrack.FindFirst() then
                repeat
                    if itemtrack."Serial No." <> '' then begin
                        fa.SetRange("Serial No.", itemtrack."Serial No.");
                        if fa.FindFirst() then begin
                            fa.FBM_Status := fa.FBM_Status::"C. stock";
                            fa.Modify();
                        end
                    end;
                until itemtrack.Next() = 0


        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 5856, 'OnAfterCreateItemJnlLine', '', true, true)]
    procedure OnAfterCreateItemJnlLine(var ItemJnlLine: Record "Item Journal Line"; TransLine: Record "Transfer Line"; DirectTransHeader: Record "Direct Trans. Header"; DirectTransLine: Record "Direct Trans. Line")
    begin
        if ItemJnlLine.Quantity < 0 then
            ItemJnlLine.FBM_Site := DirectTransHeader.FBM_SiteFrom
        else
            ItemJnlLine.FBM_Site := DirectTransHeader.FBM_SiteTo;
        ItemJnlLine.FBM_FromOrion := DirectTransHeader.FBM_FromOrion;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5856, 'OnAfterInsertDirectTransHeader', '', true, true)]
    procedure OnAfterInsertDirectTransHeader(var DirectTransHeader: Record "Direct Trans. Header"; TransferHeader: Record "Transfer Header")
    begin
        DirectTransHeader.FBM_SiteFrom := TransferHeader.FBM_SiteFrom;
        DirectTransHeader.FBM_SiteTo := TransferHeader.FBM_SiteTo;
        DirectTransHeader.FBM_FromOrion := TransferHeader.FBM_FromOrion;

    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterPostItemJnlLine', '', true, true)]
    procedure OnAfterPostItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; var ItemRegister: Record "Item Register"; var ItemLedgEntryNo: Integer; var ItemApplnEntryNo: Integer)
    var
        itemLE: record "Item Ledger Entry";
        resentry: record "Reservation Entry";
    begin
        if itemLE.get(ItemJournalLine."Item Shpt. Entry No.") then begin
            itemLE.FBM_Site := ItemJournalLine.FBM_Site;
            itemLE.Modify();
            resentry.SetRange("Item Ledger Entry No.", itemLE."Entry No.");
            if resentry.FindFirst() then begin
                resentry.FBM_Site := ItemJournalLine.FBM_Site;
                resentry.FBM_Pedimento := ItemJournalLine.FBM_Pedimento;
                resentry.FBM_Pedimento12 := ItemJournalLine.FBM_Pedimento12;

                resentry.FBM_Pedimento3 := ItemJournalLine.FBM_Pedimento3;
                resentry.FBM_Pedimento4 := ItemJournalLine.FBM_Pedimento4;
                resentry.Modify();
            end;

        end;
        if itemLE.get(ItemLedgEntryNo) then begin
            itemLE.FBM_Site := ItemJournalLine.FBM_Site;
            itemLE.Modify();
            resentry.SetRange("Item Ledger Entry No.", itemLE."Entry No.");
            if resentry.FindFirst() then begin
                resentry.FBM_Site := ItemJournalLine.FBM_Site;
                resentry.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5705, 'OnBeforePostItemJournalLine', '', true, true)]

    procedure OnBeforePostItemJournalLineR(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean)
    var
        traheader: record "Transfer Header";
    begin
        if traheader.get(TransferLine."Document No.") then begin
            ItemJournalLine.FBM_Site := traheader.FBM_SiteTo;
            ItemJournalLine.FBM_FromOrion := traheader.FBM_FromOrion;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnBeforePostItemJournalLine', '', true, true)]

    procedure OnBeforePostItemJournalLineS(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line"; CommitIsSuppressed: Boolean)
    var
        traheader: record "Transfer Header";
    begin
        if traheader.get(TransferLine."Document No.") then begin
            ItemJournalLine.FBM_Site := traheader.FBM_SiteFrom;
            ItemJournalLine.FBM_FromOrion := traheader.FBM_FromOrion;

        end;
    end;



    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromPurchLine', '', true, true)]
    procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    begin
        ItemJnlLine.FBM_Site := PurchLine.FBM_Site;
        ItemJnlLine.FBM_Pedimento := PurchLine.FBM_Pedimento;
        ItemJnlLine.FBM_Pedimento12 := PurchLine.FBM_Pedimento12;

        ItemJnlLine.FBM_Pedimento3 := PurchLine.FBM_Pedimento3;
        ItemJnlLine.FBM_Pedimento4 := PurchLine.FBM_Pedimento4;


    end;

    [EventSubscriber(ObjectType::Table, 5740, 'OnUpdateTransLines', '', true, true)]
    procedure OnUpdateTransLines(var TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header"; FieldID: Integer)
    begin
        TransferLine.FBM_SiteFrom := TransferHeader.FBM_SiteFrom;
        TransferLine.FBM_SiteTo := TransferHeader.FBM_SiteTo;
        TransferLine.FBM_FromOrion := TransferHeader.FBM_FromOrion;

    end;

    [EventSubscriber(ObjectType::codeunit, 22, 'OnBeforeInsertItemLedgEntry', '', true, true)]
    procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    begin
        ItemLedgerEntry.FBM_Pedimento12 := ItemJournalLine.FBM_Pedimento12;

        ItemLedgerEntry.FBM_Pedimento3 := ItemJournalLine.FBM_Pedimento3;

        ItemLedgerEntry.FBM_Pedimento4 := ItemJournalLine.FBM_Pedimento4;

        ItemLedgerEntry.FBM_Pedimento := ItemJournalLine.FBM_Pedimento;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5400, 'OnAfterCalcAvailableQty', '', true, true)]
    procedure OnAfterCalcAvailableQty(var Item: Record Item; CalcAvailable: Boolean; PlannedOrderReceiptDate: Date; var AvailableQty: Decimal)
    begin
        item.CalcFields(Inventory, FBM_Inventory_FF);
        AvailableQty := AvailableQty - item.Inventory;
        AvailableQty := AvailableQty + item.FBM_Inventory_FF;

    end;

    [EventSubscriber(ObjectType::Codeunit, 5790, 'OnAfterCalcAvailableInventory', '', true, true)]
    procedure OnAfterCalcAvailableInventory(var Item: Record Item; var AvailableInventory: Decimal)
    begin
        item.CalcFields(Inventory, FBM_Inventory_FF);
        AvailableInventory := AvailableInventory - item.Inventory;
        AvailableInventory := AvailableInventory + item.FBM_Inventory_FF;
    end;
    //format address

    procedure GetCompanyAddrCountry(RespCenterCode: Code[10];
    var ResponsibilityCenter: Record "Responsibility Center";
    var CompanyInfo: Record "Company Information";
    var CompanyAddr: array[8] of Text[100])
    begin
        if ResponsibilityCenter.Get(RespCenterCode) then begin
            RespCenterCountry(CompanyAddr, ResponsibilityCenter);
            CompanyInfo."Phone No." := ResponsibilityCenter."Phone No.";
            CompanyInfo."Fax No." := ResponsibilityCenter."Fax No.";
        end
        else
            CompanyCountry(CompanyAddr, CompanyInfo);
    end;

    procedure CompanyCountry(var AddrArray: array[8] of Text[100];
    var CompanyInfo: Record "Company Information")
    begin
        FormatAddress.FormatAddr(AddrArray, CompanyInfo.Name, CompanyInfo."Name 2", '', CompanyInfo.Address, CompanyInfo."Address 2", CompanyInfo.City, CompanyInfo."Post Code", CompanyInfo.County, CompanyInfo."Country/Region Code");
    end;

    procedure RespCenterCountry(var AddrArray: array[8] of Text[100];
    var RespCenter: Record "Responsibility Center")
    begin
        FormatAddress.FormatAddr(AddrArray, RespCenter.Name, RespCenter."Name 2", RespCenter.Contact, RespCenter.Address, RespCenter."Address 2", RespCenter.City, RespCenter."Post Code", RespCenter.County, RespCenter."Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvSellTo', '', true, true)]
    procedure OnBeforeSalesInvSellTo(var AddrArray: array[8] of Text[100]; var SalesInvoiceHeader: Record "Sales Invoice Header"; var Handled: Boolean)
    var
        format: codeunit "Format Address";
    begin
        if SalesInvoiceHeader."Sell-to Customer Name 2" = '' then
            format.FormatAddr(
              AddrArray, SalesInvoiceHeader."Sell-to Customer Name", 'a', '', SalesInvoiceHeader."Sell-to Address", SalesInvoiceHeader."Sell-to Address 2",
              SalesInvoiceHeader."Sell-to City", SalesInvoiceHeader."Sell-to Post Code", SalesInvoiceHeader."Sell-to County", SalesInvoiceHeader."Sell-to Country/Region Code")
        else
            format.FormatAddr(
            AddrArray, SalesInvoiceHeader."Sell-to Customer Name", SalesInvoiceHeader."Sell-to Customer Name 2", '', SalesInvoiceHeader."Sell-to Address", SalesInvoiceHeader."Sell-to Address 2",
            SalesInvoiceHeader."Sell-to City", SalesInvoiceHeader."Sell-to Post Code", SalesInvoiceHeader."Sell-to County", SalesInvoiceHeader."Sell-to Country/Region Code");
        Handled := true;
    end;







    procedure ChangeSalesInvoiceDate(PeriodeStart: Date; PeriodeEnd: Date; sales: Record "Sales Invoice Header");
    var
        salesline: Record "Sales Invoice Line";
    begin
        sales."FBM_Period Start" := PeriodeStart;
        sales."FBM_Period End" := PeriodeEnd;
        sales.MODIFY;
        salesline.SETRANGE("Document No.", sales."No.");
        IF salesline.FINDFIRST THEN
            REPEAT
                salesline."FBM_Period Start" := PeriodeStart;
                salesline."FBM_Period End" := PeriodeEnd;
                salesline.MODIFY;
            UNTIL salesline.NEXT = 0;
    end;

    procedure ChangeSalesCrMemoDate(PeriodeStart: Date; PeriodeEnd: Date; sales: Record "Sales Cr.Memo Header");
    var
        salesline: Record "Sales Cr.Memo Line";
    begin
        sales."FBM_Period Start" := PeriodeStart;
        sales."FBM_Period End" := PeriodeEnd;
        sales.MODIFY;
        salesline.SETRANGE("Document No.", sales."No.");
        IF salesline.FINDFIRST THEN
            REPEAT
                salesline."FBM_Period Start" := PeriodeStart;
                salesline."FBM_Period End" := PeriodeEnd;
                salesline.MODIFY;
            UNTIL salesline.NEXT = 0;
    end;

    procedure ChangeSalesInvoicePostGroup(GenBusGroup: Code[20]; GenItemGroup: Code[20]; sales: Record "Sales Invoice Line");
    var
    begin
        IF GenBusGroup <> '' THEN
            sales."Gen. Bus. Posting Group" := GenBusGroup;
        IF GenItemGroup <> '' THEN
            sales."Gen. Prod. Posting Group" := GenItemGroup;
        sales.MODIFY;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterLogin', '', false, false)]
    procedure OnAfterLogin()
    var


    begin
        //updNewUsed('ALL');
    end;

    procedure updNewUsed(ItemNo: code[20])
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
    begin
        if itemno <> 'ALL' then
            itemle.setrange("Item No.", ItemNo);

        buftxt.DeleteAll();
        if itemle.FindFirst() then
            repeat
                country.Reset();
                if loc.get(itemle."Location Code") then begin
                    itemle.FBM_NewItem := loc.FBM_NewItem;
                    itemle.FBM_Country := loc."Country/Region Code";
                    itemle.Modify();
                    buftxt.reset;
                    buftxt.SetRange(name, loc."Country/Region Code");
                    if not buftxt.FindFirst() then begin
                        buftxt.Init();
                        id += 1;
                        buftxt.id := id;
                        buftxt.Name := loc."Country/Region Code";
                        if country.get(loc."Country/Region Code") then
                            buftxt.value := country.FBM_Country3;
                        buftxt.Insert();
                    end;

                end;
            until itemle.Next() = 0;


    end;

    [EventSubscriber(ObjectType::Table, 1173, 'OnAfterInitFieldsFromRecRef', '', false, false)]
    procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: code[20];
    begin
        if recref.Number = 70015 then begin
            FieldRef := RecRef.Field(16);
            RecNo := FieldRef.Value();
            DocumentAttachment."No." := RecNo;
            DocumentAttachment."Document Type" := DocumentAttachment."Document Type"::Note;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeRunWithCheck', '', false, false)]
    procedure OnBeforeRunWithCheck(var GenJournalLine: Record "Gen. Journal Line"; var GenJournalLine2: Record "Gen. Journal Line")
    var
        cinfo: record "Company Information";
        exchrate: record "Currency Exchange Rate";
        glsetup: record "General Ledger Setup";
    begin
        cinfo.get();
        glsetup.Get();
        if glsetup.FBM_CheckMinMaMax then
            if (cinfo."Country/Region Code" = 'PH') and (glsetup."LCY Code" = 'PHP') then begin
                exchrate.setfilter("Starting Date", '<=%1', GenJournalLine2."Posting Date");
                exchrate.SetRange("Currency Code", 'USD');
                // if not exchrate.FindFirst() then
                //     error('Missing USD exchange rate for posting date  %1', format(GenJournalLine2."Posting Date"))
                // else
                if exchrate.FindLast() then
                    if (exchrate."Relational Exch. Rate Amount" < glsetup.FBM_ExchRatePHPMin) or (exchrate."Relational Exch. Rate Amount" > glsetup.FBM_ExchRatePHPMax) then
                        error('Wrong exch rate for USD and date %1', format(GenJournalLine2."Posting Date"));
            end;

    end;


    [EventSubscriber(ObjectType::Table, 36, 'OnAfterGetPostingNoSeriesCode', '', false, false)]
    procedure OnAfterGetPostingNoSeriesCode(SalesHeader: Record "Sales Header"; var PostingNos: Code[20])
    var
        salessetup: record "Sales & Receivables Setup";
    begin
        salessetup.Get();
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
            if SalesHeader."FBM_Billing Statement" then begin
                salessetup.TestField("FBM_Billing Statement Nos.");
                PostingNos := salessetup."FBM_Billing Statement Nos.";
            end;
    end;


}
