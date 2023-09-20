codeunit 60104 FBM_Events_CO
{
    EventSubscriberInstance = StaticAutomatic;
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = 393 then
            NewReportId := 60134;
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
        if FASetup."FBM_Enable FA Site Tracking" then begin
            DimMgmt.GetDimensionSet(TempDimSetEntry, SalesHeader."Dimension Set ID");
            DimVal.Reset();
            if DimVal.get(FASetup."FBM_Site Dimension", SalesHeader.FBM_Site) then begin
                TempDimSetEntry.Init();
                //TempDimSetEntry."Dimension Set ID" := DimMgmt.GetDimensionSetID(TempDimSetEntry);
                TempDimSetEntry."Dimension Code" := FASetup."FBM_Site Dimension";
                TempDimSetEntry."Dimension Value Code" := SalesHeader.FBM_Site;
                TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                TempDimSetEntry.Insert();
                SalesHeader."Dimension Set ID" := DimMgmt.GetDimensionSetID(TempDimSetEntry);
                SalesHeader.Modify();
            end;
            CLEAR(TempDimSetEntry);
        end;
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
        GenJournalLine.FBM_Segment := SalesHeader.FBM_Segment;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitGLEntry"(var GLEntry: Record "G/L Entry";
    GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        GLEntry."FBM_Period End" := GenJournalLine."FBM_Period End";

        GLEntry.FBM_Segment := GenJournalLine.FBM_Segment;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterHandleAddCurrResidualGLEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterHandleAddCurrResidualGLEntry"(GenJournalLine: Record "Gen. Journal Line";
    GLEntry2: Record "G/L Entry")
    begin
        GLEntry2."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        GLEntry2."FBM_Period End" := GenJournalLine."FBM_Period End";
        GLEntry2.FBM_Segment := GenJournalLine.FBM_Segment;

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
        TempGLEntryBuf.FBM_Segment := GenJournalLine.FBM_Segment;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure "Cust. Ledger Entry_OnAfterCopyCustLedgerEntryFromGenJnlLine"(var CustLedgerEntry: Record "Cust. Ledger Entry";
    GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        CustLedgerEntry."FBM_Period End" := GenJournalLine."FBM_Period End";
        CustLedgerEntry.FBM_Segment := GenJournalLine.FBM_Segment;
        CustLedgerEntry.FBM_Site := GenJournalLine.FBM_Site;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitCustLedgEntry"(var CustLedgerEntry: Record "Cust. Ledger Entry";
    GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        CustLedgerEntry."FBM_Period End" := GenJournalLine."FBM_Period End";
        CustLedgerEntry.FBM_Segment := GenJournalLine.FBM_Segment;
        CustLedgerEntry.FBM_Site := GenJournalLine.FBM_Site;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeInsertDtldCustLedgEntry"(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    GenJournalLine: Record "Gen. Journal Line";
    DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldCustLedgEntry."FBM_Period Start" := GenJournalLine."FBM_Period Start";
        DtldCustLedgEntry."FBM_Period End" := GenJournalLine."FBM_Period End";
        DtldCustLedgEntry.FBM_Segment := GenJournalLine.FBM_Segment;
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

}
