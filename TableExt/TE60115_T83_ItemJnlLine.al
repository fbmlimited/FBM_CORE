tableextension 60115 FBM_PurchInvLineExt_CO extends "Item Journal Line"
{
    var
        ValueEntry: record "Value Entry";
        StartingInvoicedValue: Decimal;
        StartingExpectedValue: Decimal;
        StartingInvoicedQty: Decimal;
        StartingExpectedQty: Decimal;
        IncreaseInvoicedValue: Decimal;
        IncreaseExpectedValue: Decimal;
        IncreaseInvoicedQty: Decimal;
        IncreaseExpectedQty: Decimal;
        DecreaseInvoicedValue: Decimal;
        DecreaseExpectedValue: Decimal;
        DecreaseInvoicedQty: Decimal;
        DecreaseExpectedQty: Decimal;
        IsEmptyLine: Boolean;

    procedure CalcItemCost(loccode: code[20]): Decimal
    var
    // pinvline: record "Purch. Inv. Line";
    // totline: Decimal;

    // totqty: decimal;

    begin
        // pinvline.SetRange("No.", rec."Item No.");
        // pinvline.SetRange(Type, pinvline.Type::Item);
        // if pinvline.FindFirst() then
        //     repeat
        //         totline += pinvline.Quantity * pinvline."Direct Unit Cost";
        //     until pinvline.next = 0;
        // pinvline.CalcSums(Quantity);
        // totqty := pinvline.Quantity;
        // if totqty = 0 then
        //     exit(0)
        // else
        //     exit(totline / totqty);
        StartingInvoicedValue := 0;
        StartingExpectedValue := 0;
        StartingInvoicedQty := 0;
        StartingExpectedQty := 0;
        IncreaseInvoicedValue := 0;
        IncreaseExpectedValue := 0;
        IncreaseInvoicedQty := 0;
        IncreaseExpectedQty := 0;
        DecreaseInvoicedValue := 0;
        DecreaseExpectedValue := 0;
        DecreaseInvoicedQty := 0;
        DecreaseExpectedQty := 0;


        IsEmptyLine := true;
        ValueEntry.Reset();
        ValueEntry.SetRange("Item No.", rec."Item No.");
        if loccode <> '' then
            ValueEntry.SetRange("Location Code", loccode);




        ValueEntry.SetRange("Posting Date", 0D, rec."Posting Date");
        ValueEntry.SetFilter(
            "Item Ledger Entry Type", '%1|%2|%3|%4',
            ValueEntry."Item Ledger Entry Type"::Purchase,
            ValueEntry."Item Ledger Entry Type"::"Positive Adjmt.",
            ValueEntry."Item Ledger Entry Type"::Output,
            ValueEntry."Item Ledger Entry Type"::"Assembly Output");
        ValueEntry.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
        AssignAmounts(ValueEntry, IncreaseInvoicedValue, IncreaseInvoicedQty, IncreaseExpectedValue, IncreaseExpectedQty, 1);

        ValueEntry.SetRange("Posting Date", 0D, rec."Posting Date");
        ValueEntry.SetFilter(
            "Item Ledger Entry Type", '%1|%2|%3|%4',
            ValueEntry."Item Ledger Entry Type"::Sale,
            ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.",
            ValueEntry."Item Ledger Entry Type"::Consumption,
            ValueEntry."Item Ledger Entry Type"::"Assembly Consumption");
        ValueEntry.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
        AssignAmounts(ValueEntry, DecreaseInvoicedValue, DecreaseInvoicedQty, DecreaseExpectedValue, DecreaseExpectedQty, -1);

        ValueEntry.SetRange("Posting Date", 0D, rec."Posting Date");
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Transfer);
        if ValueEntry.FindSet() then
            repeat
                if true in [ValueEntry."Valued Quantity" < 0, not GetOutboundItemEntry(ValueEntry."Item Ledger Entry No.", loccode)] then
                    AssignAmounts(ValueEntry, DecreaseInvoicedValue, DecreaseInvoicedQty, DecreaseExpectedValue, DecreaseExpectedQty, -1)
                else
                    AssignAmounts(ValueEntry, IncreaseInvoicedValue, IncreaseInvoicedQty, IncreaseExpectedValue, IncreaseExpectedQty, 1);
            until ValueEntry.Next() = 0;

        IsEmptyLine := IsEmptyLine and ((IncreaseInvoicedValue = 0) and (IncreaseInvoicedQty = 0));
        IsEmptyLine := IsEmptyLine and ((DecreaseInvoicedValue = 0) and (DecreaseInvoicedQty = 0));


        ValueEntry.SetRange("Posting Date", 0D, rec."Posting Date");
        ValueEntry.SetRange("Item Ledger Entry Type");
        ValueEntry.CalcSums("Cost Posted to G/L", "Expected Cost Posted to G/L");


        StartingExpectedValue += StartingInvoicedValue;
        IncreaseExpectedValue += IncreaseInvoicedValue;
        DecreaseExpectedValue += DecreaseInvoicedValue;
        if (IncreaseInvoicedQty - DecreaseInvoicedQty) <> 0 then
            exit((StartingInvoicedValue + IncreaseInvoicedValue - DecreaseInvoicedValue) / (IncreaseInvoicedQty - DecreaseInvoicedQty))
        else
            exit(0);

    end;

    local procedure GetOutboundItemEntry(ItemLedgerEntryNo: Integer; loccode: code[20]): Boolean
    var
        ItemApplnEntry: Record "Item Application Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemApplnEntry.SetCurrentKey("Item Ledger Entry No.");
        ItemApplnEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntryNo);
        if not ItemApplnEntry.FindFirst() then
            exit(true);

        ItemLedgEntry.SetRange("Item No.", rec."Item No.");
        if loccode <> '' then
            ValueEntry.SetRange("Location Code", loccode);

        ItemLedgEntry.SetRange("Entry No.", ItemApplnEntry."Outbound Item Entry No.");
        exit(ItemLedgEntry.IsEmpty());
    end;

    local procedure AssignAmounts(ValueEntry: Record "Value Entry"; var InvoicedValue: Decimal; var InvoicedQty: Decimal; var ExpectedValue: Decimal; var ExpectedQty: Decimal; Sign: Decimal)
    begin
        InvoicedValue += ValueEntry."Cost Amount (Actual)" * Sign;
        InvoicedQty += ValueEntry."Invoiced Quantity" * Sign;
        ExpectedValue += ValueEntry."Cost Amount (Expected)" * Sign;
        ExpectedQty += ValueEntry."Item Ledger Entry Quantity" * Sign;
    end;

}