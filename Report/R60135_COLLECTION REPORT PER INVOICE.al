report 60135 "FBM_COLLEC. REP. INV._CO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportExt/COLLECTION REPORT PER INVOICE.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'COLLECTION REPORT PER INVOICE';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DataItem1; "Cust. Ledger Entry")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Invoice));
            RequestFilterFields = "Customer No.", "Posting Date";
            column(CustomerNo_CustLedgerEntry; "Customer No.")
            {
            }
            column(PostingDate_CustLedgerEntry; "Posting Date")
            {
            }
            column(DocumentType_CustLedgerEntry; "Document Type")
            {
            }
            column(DocumentNo_CustLedgerEntry; "Document No.")
            {
            }
            column(Description_CustLedgerEntry; Description)
            {
            }
            column(CurrencyCode_CustLedgerEntry; "Currency Code")
            {
            }
            column(Amount_CustLedgerEntry; Amount)
            {
            }
            column(CustomerPostingGroup_CustLedgerEntry; "Customer Posting Group")
            {
            }
            column(GlobalDimension1Code_CustLedgerEntry; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_CustLedgerEntry; "Global Dimension 2 Code")
            {
            }
            column(Custname; cust.Name)
            {
            }
            column(AmountLCY_CustLedgerEntry; "Amount (LCY)")
            {
            }
            // column(sitecode; site."Site Code")
            // {
            // }
            // column(sitename; site."Site Name")
            // { }
            dataitem(DetailedCustLedger; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(Documentno; tempCustLedg."Document No.")
                {
                }
                column(doctype; tempCustLedg."Document Type")
                {
                }
                column(postingdate; tempCustLedg."Posting Date")
                {
                }
                column(amount; tempCustLedg.Amount)
                {
                }
                column(Curr; tempCustLedg."Currency Code")
                {
                }
                column(amountlcy; tempCustLedg."Amount (LCY)")
                {
                }
                column(EntryType; tempCustLedg."Entry Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        tempCustLedg.FIND('-')
                    ELSE
                        tempCustLedg.NEXT;
                    //tempCustLedg.CALCFIELDS(Amount);
                end;

                trigger OnPreDataItem()
                begin
                    tempCustLedg.RESET;
                    SETRANGE(Number, 1, tempCustLedg.COUNT);
                end;
            }

            trigger OnAfterGetRecord()
            var
                inv: Record "Sales Invoice Header";
                crm: Record "Sales Cr.Memo Header";
            begin
                tempCustLedg.DELETEALL;
                FindApplnEntriesDtldtLedgEntry(DataItem1);

                cust.GET("Customer No.");
                CALCFIELDS(Amount, "Amount (LCY)");
                IF cust.GET("Customer No.") THEN;
                if "Document Type" = "Document Type"::Invoice then begin
                    if inv.Get("Document No.") then begin
                        //if site.Get("Customer No.", inv.Site) then;
                    end;
                end;
                if "Document Type" = "Document Type"::"Credit Memo" then begin
                    if crm.Get("Document No.") then begin
                        //if site.Get("Customer No.", crm.Site) then;
                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        tempCustLedg: Record "Detailed Cust. Ledg. Entry" temporary;
        cust: Record "Customer";
        site: Record FBM_CustomerSite_C;

    local procedure FindApplnEntriesDtldtLedgEntry(CreateCustLedgEntry: Record "Cust. Ledger Entry")
    var
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry3: Record "Cust. Ledger Entry";
    begin
        DtldCustLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SETRANGE("Cust. Ledger Entry No.", CreateCustLedgEntry."Entry No.");
        DtldCustLedgEntry1.SETRANGE(Unapplied, FALSE);
        IF DtldCustLedgEntry1.FIND('-') THEN
            REPEAT
                IF DtldCustLedgEntry1."Cust. Ledger Entry No." =
                   DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                THEN BEGIN
                    DtldCustLedgEntry2.INIT;
                    DtldCustLedgEntry2.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SETRANGE(
                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SETRANGE("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                    DtldCustLedgEntry2.SETRANGE(Unapplied, FALSE);
                    IF DtldCustLedgEntry2.FIND('-') THEN
                        REPEAT
                            IF DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                               DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                            THEN BEGIN
                                /*CustLedgEntry3.SETCURRENTKEY("Entry No.");
                                CustLedgEntry3.SETRANGE("Entry No.",DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                IF CustLedgEntry3.FIND('-') THEN
                                  BEGIN
                                    tempCustLedg.TRANSFERFIELDS(CustLedgEntry3);
                                    IF tempCustLedg.INSERT THEN;
                                    END;*/
                                tempCustLedg.TRANSFERFIELDS(DtldCustLedgEntry2);
                                IF tempCustLedg."Entry Type" <> tempCustLedg."Entry Type"::"Initial Entry" THEN
                                    IF tempCustLedg.INSERT THEN;
                            END;
                        UNTIL DtldCustLedgEntry2.NEXT = 0;
                END ELSE BEGIN
                    /*CustLedgEntry3.SETCURRENTKEY("Entry No.");
                    CustLedgEntry3.SETRANGE("Entry No.",DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    IF CustLedgEntry3.FIND('-') THEN
                      BEGIN
                      tempCustLedg.TRANSFERFIELDS(CustLedgEntry3);
                              IF tempCustLedg.INSERT THEN ;
                        END;*/
                    tempCustLedg.TRANSFERFIELDS(DtldCustLedgEntry1);
                    IF tempCustLedg."Entry Type" <> tempCustLedg."Entry Type"::"Initial Entry" THEN
                        IF tempCustLedg.INSERT THEN;
                END;
            UNTIL DtldCustLedgEntry1.NEXT = 0;

    end;
}

