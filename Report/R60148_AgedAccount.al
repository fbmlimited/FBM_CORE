report 60148 "FBM_Aged AccRec New_CO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/R50006Aged Accounts Receivable New.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Aged Accounts Receivable New';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Header; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(CompanyName; CompanyDisplayName)
            {
            }
            column(FormatEndingDate; StrSubstNo(Text006, Format(EndingDate, 0, 4)))
            {
            }
            column(PostingDate; StrSubstNo(Text007, SelectStr(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(TableCaptnCustFilter; TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AgingByDueDate; AgingBy = AgingBy::"Due Date")
            {
            }
            column(AgedbyDocumnetDate; StrSubstNo(Text004, SelectStr(AgingBy + 1, Text009)))
            {
            }
            column(HeaderText5; HeaderText[5])
            {
            }
            column(HeaderText4; HeaderText[4])
            {
            }
            column(HeaderText3; HeaderText[3])
            {
            }
            column(HeaderText2; HeaderText[2])
            {
            }
            column(HeaderText1; HeaderText[1])
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(AgedAccReceivableCptn; AgedAccReceivableCptnLbl)
            {
            }
            column(CurrReportPageNoCptn; CurrReportPageNoCptnLbl)
            {
            }
            column(AllAmtinLCYCptn; AllAmtinLCYCptnLbl)
            {
            }
            column(AgedOverdueAmtCptn; AgedOverdueAmtCptnLbl)
            {
            }
            column(CLEEndDateAmtLCYCptn; CLEEndDateAmtLCYCptnLbl)
            {
            }
            column(CLEEndDateDueDateCptn; CLEEndDateDueDateCptnLbl)
            {
            }
            column(CLEEndDateDocNoCptn; CLEEndDateDocNoCptnLbl)
            {
            }
            column(CLEEndDatePstngDateCptn; CLEEndDatePstngDateCptnLbl)
            {
            }
            column(CLEEndDateDocTypeCptn; CLEEndDateDocTypeCptnLbl)
            {
            }
            column(OriginalAmtCptn; OriginalAmtCptnLbl)
            {
            }
            column(TotalLCYCptn; TotalLCYCptnLbl)
            {
            }
            column(NewPagePercustomer; NewPagePercustomer)
            {
            }
            column(GrandTotalCLE5RemAmt; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE4RemAmt; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE3RemAmt; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE2RemAmt; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1RemAmt; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLEAmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE2CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE3CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE4CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE5CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE1AmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE5PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE3PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE2PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE1PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE5RemAmtLCY; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE4RemAmtLCY; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE3RemAmtLCY; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE2RemAmtLCY; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1RemAmtLCY; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            dataitem(Customer; Customer)
            {
                RequestFilterFields = "No.";
                column(PageGroupNo; PageGroupNo)
                {
                }
                column(CustomerPhoneNoCaption; FieldCaption("Phone No."))
                {
                }
                column(CustomerContactCaption; FieldCaption(Contact))
                {
                }

                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD("No.");
                    DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");

                    trigger OnAfterGetRecord()
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                    begin
                        CustLedgEntry.SetCurrentKey("Closed by Entry No.");
                        if "Closed by Entry No." <> 0 then
                            CustLedgEntry.SetFilter("Closed by Entry No.", '%1|%2', "Entry No.", "Closed by Entry No.")
                        else
                            CustLedgEntry.SetRange("Closed by Entry No.", "Entry No.");
                        CustLedgEntry.SetRange("Posting Date", 0D, EndingDate);
                        CopyDimFiltersFromCustomer(CustLedgEntry);
                        if CustLedgEntry.FindSet(false) then
                            repeat
                                InsertTemp(CustLedgEntry);
                            until CustLedgEntry.Next = 0;

                        CustLedgEntry.Reset;
                        CustLedgEntry.SetRange("Entry No.", "Closed by Entry No.");
                        CustLedgEntry.SetRange("Posting Date", 0D, EndingDate);
                        CopyDimFiltersFromCustomer(CustLedgEntry);
                        if CustLedgEntry.FindSet(false) then
                            repeat
                                InsertTemp(CustLedgEntry);
                            until CustLedgEntry.Next = 0;
                        CurrReport.Skip;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Posting Date", EndingDate + 1, DMY2Date(31, 12, 9999));
                        CopyDimFiltersFromCustomer("Cust. Ledger Entry");
                    end;
                }
                dataitem(OpenCustLedgEntry; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD("No.");
                    DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code");

                    trigger OnAfterGetRecord()
                    begin
                        InsertTemp(OpenCustLedgEntry);
                        CurrReport.Skip;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if AgingBy = AgingBy::"Posting Date" then begin
                            SetRange("Posting Date", 0D, EndingDate);
                            SetRange("Date Filter", 0D, EndingDate);
                            CalcFields("Remaining Amt. (LCY)");
                            SetFilter("Remaining Amt. (LCY)", '<>0');
                        end;
                        CopyDimFiltersFromCustomer(OpenCustLedgEntry);
                    end;
                }
                dataitem(CurrencyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = true;
                    dataitem(TempCustLedgEntryLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(Name1_Cust; Customer.Name)
                        {
                            IncludeCaption = true;
                        }
                        column(No_Cust; Customer."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(CustomerPhoneNo; Customer."Phone No.")
                        {
                        }
                        column(CustomerContactName; Customer.Contact)
                        {
                        }
                        column(CLEEndDateRemAmtLCY; CustLedgEntryEndingDate."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE1RemAmtLCY; AgedCustLedgEntry[1]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE2RemAmtLCY; AgedCustLedgEntry[2]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE3RemAmtLCY; AgedCustLedgEntry[3]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE4RemAmtLCY; AgedCustLedgEntry[4]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE5RemAmtLCY; AgedCustLedgEntry[5]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(CLEEndDateAmtLCY; CustLedgEntryEndingDate."Amount (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(CLEEndDueDate; Format(CustLedgEntryEndingDate."Due Date"))
                        {
                        }
                        column(CLEEndDateDocNo; CustLedgEntryEndingDate."Document No.")
                        {
                        }
                        column(CLEDocType; Format(CustLedgEntryEndingDate."Document Type"))
                        {
                        }
                        column(CLEPostingDate; Format(CustLedgEntryEndingDate."Posting Date"))
                        {
                        }
                        column(AgedCLE5TempRemAmt; AgedCustLedgEntry[5]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE4TempRemAmt; AgedCustLedgEntry[4]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE3TempRemAmt; AgedCustLedgEntry[3]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE2TempRemAmt; AgedCustLedgEntry[2]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE1TempRemAmt; AgedCustLedgEntry[1]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(RemAmt_CLEEndDate; CustLedgEntryEndingDate."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(CLEEndDate; CustLedgEntryEndingDate.Amount)
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Name_Cust; StrSubstNo(Text005, Customer.Name))
                        {
                        }
                        column(TotalCLE1AmtLCY; TotalCustLedgEntry[1]."Amount (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE1RemAmtLCY; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE2RemAmtLCY; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE3RemAmtLCY; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE4RemAmtLCY; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE5RemAmtLCY; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(CurrrencyCode; CurrencyCode)
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalCLE5RemAmt; TotalCustLedgEntry[5]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE4RemAmt; TotalCustLedgEntry[4]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE3RemAmt; TotalCustLedgEntry[3]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE2RemAmt; TotalCustLedgEntry[2]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE1RemAmt; TotalCustLedgEntry[1]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE1Amt; TotalCustLedgEntry[1].Amount)
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCheck; CustFilterCheck)
                        {
                        }
                        column(CustomerPostingGroup; CustLedgEntryEndingDate."Customer Posting Group")
                        { }
                        column(CustomerSiteName; VarCustomerSiteName)
                        { }
                        column(CustomerSite; VarCustomerSite)
                        { }
                        column(segment; CustLedgEntryEndingDate.FBM_Segment2)
                        { }
                        trigger OnAfterGetRecord()
                        var
                            PeriodIndex: Integer;
                            sales: Record "Sales Invoice Header";
                            crmemo: Record "Sales Cr.Memo Header";
                            customersite: record FBM_CustomerSite_C;
                        begin
                            if Number = 1 then begin
                                if not TempCustLedgEntry.FindSet(false) then
                                    CurrReport.Break;
                            end else
                                if TempCustLedgEntry.Next = 0 then
                                    CurrReport.Break;

                            CustLedgEntryEndingDate := TempCustLedgEntry;
                            DetailedCustomerLedgerEntry.SetRange("Cust. Ledger Entry No.", CustLedgEntryEndingDate."Entry No.");
                            if DetailedCustomerLedgerEntry.FindSet(false) then
                                repeat
                                    if (DetailedCustomerLedgerEntry."Entry Type" =
                                        DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") and
                                       (CustLedgEntryEndingDate."Posting Date" > EndingDate) and
                                       (AgingBy <> AgingBy::"Posting Date")
                                    then begin
                                        if CustLedgEntryEndingDate."Document Date" <= EndingDate then
                                            DetailedCustomerLedgerEntry."Posting Date" :=
                                              CustLedgEntryEndingDate."Document Date"
                                        else
                                            if (CustLedgEntryEndingDate."Due Date" <= EndingDate) and
                                               (AgingBy = AgingBy::"Due Date")
                                            then
                                                DetailedCustomerLedgerEntry."Posting Date" :=
                                                  CustLedgEntryEndingDate."Due Date"
                                    end;

                                    if (DetailedCustomerLedgerEntry."Posting Date" <= EndingDate) or
                                       (TempCustLedgEntry.Open and
                                        (AgingBy = AgingBy::"Due Date") and
                                        (CustLedgEntryEndingDate."Due Date" > EndingDate) and
                                        (CustLedgEntryEndingDate."Posting Date" <= EndingDate))
                                    then begin
                                        if DetailedCustomerLedgerEntry."Entry Type" in
                                           [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                        then begin
                                            CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                            CustLedgEntryEndingDate."Amount (LCY)" :=
                                              CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                        end;
                                        if DetailedCustomerLedgerEntry."Posting Date" <= EndingDate then begin
                                            CustLedgEntryEndingDate."Remaining Amount" :=
                                              CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                            CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                              CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                        end;
                                    end;
                                until DetailedCustomerLedgerEntry.Next = 0;

                            if CustLedgEntryEndingDate."Remaining Amount" = 0 then
                                CurrReport.Skip;

                            case AgingBy of
                                AgingBy::"Due Date":
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                                AgingBy::"Posting Date":
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                                AgingBy::"Document Date":
                                    begin
                                        if CustLedgEntryEndingDate."Document Date" > EndingDate then begin
                                            CustLedgEntryEndingDate."Remaining Amount" := 0;
                                            CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                            CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
                                        end;
                                        PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                                    end;
                            end;
                            Clear(AgedCustLedgEntry);
                            AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                            AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            TotalCustLedgEntry[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";

                            VarCustomerSite := '';
                            VarCustomerSiteName := '';
                            if CustLedgEntryEndingDate."Document Type" = CustLedgEntryEndingDate."Document Type"::Invoice then begin
                                if sales.get(CustLedgEntryEndingDate."Document No.") then begin
                                    customersite.SetRange("Customer No.", CustLedgEntryEndingDate."Customer No.");
                                    customersite.SetRange("Site Code", sales.FBM_Site);
                                    customersite.SetRange(ActiveRec, true);
                                    if customersite.FindFirst()
                                     then begin
                                        VarCustomerSite := customersite."Site Code";

                                        VarCustomerSiteName := customersite."Site Name_FF";
                                    end;

                                end;
                            end;

                            if CustLedgEntryEndingDate."Document Type" = CustLedgEntryEndingDate."Document Type"::"Credit Memo" then begin
                                if crmemo.get(CustLedgEntryEndingDate."Document No.") then begin
                                    customersite.SetRange("Customer No.", CustLedgEntryEndingDate."Customer No.");
                                    customersite.SetRange("Site Code", crmemo.FBM_Site);
                                    customersite.SetRange(ActiveRec, true);
                                    if customersite.FindFirst()
                                     then begin
                                        VarCustomerSite := customersite."Site Code";

                                        VarCustomerSiteName := customersite."Site Name_FF";
                                    end;

                                end;
                            end;
                        end;

                        trigger OnPostDataItem()
                        begin
                            if not PrintAmountInLCY then
                                UpdateCurrencyTotals;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not PrintAmountInLCY then begin
                                if (TempCurrency.Code = '') or (TempCurrency.Code = GLSetup."LCY Code") then
                                    TempCustLedgEntry.SetFilter("Currency Code", '%1|%2', GLSetup."LCY Code", '')
                                else
                                    TempCustLedgEntry.SetRange("Currency Code", TempCurrency.Code);
                            end;

                            PageGroupNo := NextPageGroupNo;
                            if NewPagePercustomer and (NumberOfCurrencies > 0) then
                                NextPageGroupNo := PageGroupNo + 1;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Clear(TotalCustLedgEntry);

                        if Number = 1 then begin
                            if not TempCurrency.FindSet(false) then
                                CurrReport.Break;
                        end else
                            if TempCurrency.Next = 0 then
                                CurrReport.Break;

                        if TempCurrency.Code <> '' then
                            CurrencyCode := TempCurrency.Code
                        else
                            CurrencyCode := GLSetup."LCY Code";

                        NumberOfCurrencies := NumberOfCurrencies + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        NumberOfCurrencies := 0;
                    end;
                }

                trigger OnAfterGetRecord()

                begin
                    if NewPagePercustomer then
                        PageGroupNo += 1;
                    TempCurrency.Reset;
                    TempCurrency.DeleteAll;
                    TempCustLedgEntry.Reset;
                    TempCustLedgEntry.DeleteAll;

                    //if not CustomersWithLedgerEntriesList.Contains("No.") then
                    //    CurrReport.Skip;


                end;

                trigger OnPreDataItem()
                begin
                    //CustomersWithLedgerEntriesList := CustomersWithLedgerEntriesList.List;

                    //NumCustLedgEntriesperCust.SetFilter(Customer_No, GetFilter("No."));
                    //if NumCustLedgEntriesperCust.Open then
                    //while NumCustLedgEntriesperCust.Read do
                    //if not CustomersWithLedgerEntriesList.Contains(NumCustLedgEntriesperCust.Customer_No) then
                    //CustomersWithLedgerEntriesList.Add(NumCustLedgEntriesperCust.Customer_No);
                end;
            }
            dataitem(CurrencyTotals; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                column(CurrNo; Number = 1)
                {
                }
                column(TempCurrCode; TempCurrency2.Code)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE6RemAmt; AgedCustLedgEntry[6]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE1RemAmt; AgedCustLedgEntry[1]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE2RemAmt; AgedCustLedgEntry[2]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE3RemAmt; AgedCustLedgEntry[3]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE4RemAmt; AgedCustLedgEntry[4]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(AgedCLE5RemAmt; AgedCustLedgEntry[5]."Remaining Amount")
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(CurrSpecificationCptn; CurrSpecificationCptnLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then begin
                        if not TempCurrency2.FindSet(false) then
                            CurrReport.Break;
                    end else
                        if TempCurrency2.Next = 0 then
                            CurrReport.Break;

                    Clear(AgedCustLedgEntry);
                    TempCurrencyAmount.SetRange("Currency Code", TempCurrency2.Code);
                    if TempCurrencyAmount.FindSet(false) then
                        repeat
                            if TempCurrencyAmount.Date <> DMY2Date(31, 12, 9999) then
                                AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                                  TempCurrencyAmount.Amount
                            else
                                AgedCustLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                        until TempCurrencyAmount.Next = 0;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AgedAsOf; EndingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged As Of';
                        ToolTip = 'Specifies the date that you want the aging calculated for.';
                    }
                    field(Agingby; AgingBy)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aging by';
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                        ToolTip = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.';
                    }
                    field(AmountsinLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Amounts in LCY';
                        ToolTip = 'Specifies if you want the report to specify the aging per customer ledger entry.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Details';
                        ToolTip = 'Specifies if you want the report to show the detailed entries that add up the total balance for each customer.';
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
                    }
                    field(perCustomer; NewPagePercustomer)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if EndingDate = 0D then
                EndingDate := WorkDate;
            if Format(PeriodLength) = '' then
                Evaluate(PeriodLength, '<1M>');
        end;
    }

    labels
    {
        BalanceCaption = 'Balance';
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);

        GLSetup.Get;




        CalcDates;
        CreateHeadings;

        PageGroupNo := 1;
        NextPageGroupNo := 1;
        CustFilterCheck := (CustFilter <> 'No.');

        CompanyDisplayName := COMPANYPROPERTY.DisplayName;

    end;

    var
        GLSetup: Record "General Ledger Setup";
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        CustLedgEntryEndingDate: Record "Cust. Ledger Entry";
        TotalCustLedgEntry: array[5] of Record "Cust. Ledger Entry";
        GrandTotalCustLedgEntry: array[5] of Record "Cust. Ledger Entry";
        AgedCustLedgEntry: array[6] of Record "Cust. Ledger Entry";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        DetailedCustomerLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        NumCustLedgEntriesperCust: Query "Num CustLedgEntries per Cust";
        //CustomersWithLedgerEntriesList: DotNet GenericList1;
        CustFilter: Text;
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePercustomer: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text003: Label 'More than';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        CustFilterCheck: Boolean;
        Text032Txt: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        AgedAccReceivableCptnLbl: Label 'Aged Accounts Receivable';
        CurrReportPageNoCptnLbl: Label 'Page';
        AllAmtinLCYCptnLbl: Label 'All Amounts in LCY';
        AgedOverdueAmtCptnLbl: Label 'Aged Overdue Amounts';
        CLEEndDateAmtLCYCptnLbl: Label 'Original Amount ';
        CLEEndDateDueDateCptnLbl: Label 'Due Date';
        CLEEndDateDocNoCptnLbl: Label 'Document No.';
        CLEEndDatePstngDateCptnLbl: Label 'Posting Date';
        CLEEndDateDocTypeCptnLbl: Label 'Document Type';
        OriginalAmtCptnLbl: Label 'Currency Code';
        TotalLCYCptnLbl: Label 'Total (LCY)';
        CurrSpecificationCptnLbl: Label 'Currency Specification';
        EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
        CompanyDisplayName: Text;
        VarCustomerSite: Text;
        VarCustomerSiteName: Text;


    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        if not Evaluate(PeriodLength2, StrSubstNo(Text032Txt, PeriodLength)) then
            Error(EnterDateFormulaErr);
        if AgingBy = AgingBy::"Due Date" then begin
            PeriodEndDate[1] := DMY2Date(31, 12, 9999);
            PeriodStartDate[1] := EndingDate + 1;
        end else begin
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CalcDate(PeriodLength2, EndingDate + 1);
        end;
        for i := 2 to ArrayLen(PeriodEndDate) do begin
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CalcDate(PeriodLength2, PeriodEndDate[i] + 1);
        end;
        PeriodStartDate[i] := 0D;

        for i := 1 to ArrayLen(PeriodEndDate) do
            if PeriodEndDate[i] < PeriodStartDate[i] then
                Error(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        if AgingBy = AgingBy::"Due Date" then begin
            HeaderText[1] := Text000;
            i := 2;
        end else
            i := 1;
        while i < ArrayLen(PeriodEndDate) do begin
            if HeadingType = HeadingType::"Date Interval" then
                HeaderText[i] := StrSubstNo('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            else
                HeaderText[i] :=
                  StrSubstNo('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        end;
        if HeadingType = HeadingType::"Date Interval" then
            HeaderText[i] := StrSubstNo('%1 %2', Text001, PeriodStartDate[i - 1])
        else
            HeaderText[i] := StrSubstNo('%1 \%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry")
    var
        Currency: Record Currency;
    begin
        begin
            if TempCustLedgEntry.Get(CustLedgEntry."Entry No.") then
                exit;
            TempCustLedgEntry := CustLedgEntry;
            TempCustLedgEntry.Insert;
            if PrintAmountInLCY then begin
                Clear(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                if TempCurrency.Insert then;
                exit;
            end;
            if TempCurrency.Get(TempCustLedgEntry."Currency Code") then
                exit;
            if TempCurrency.Get('') and (TempCustLedgEntry."Currency Code" = GLSetup."LCY Code") then
                exit;
            if TempCurrency.Get(GLSetup."LCY Code") and (TempCustLedgEntry."Currency Code" = '') then
                exit;
            if TempCustLedgEntry."Currency Code" <> '' then
                Currency.Get(TempCustLedgEntry."Currency Code")
            else begin
                Clear(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            end;
            TempCurrency := Currency;
            TempCurrency.Insert;
        end;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        for i := 1 to ArrayLen(PeriodEndDate) do
            if Date in [PeriodStartDate[i] .. PeriodEndDate[i]] then
                exit(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30]
    begin
        if b <> 0 then
            exit(Format(Round(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        if TempCurrency2.Insert then;
        begin
            for i := 1 to ArrayLen(TotalCustLedgEntry) do begin
                TempCurrencyAmount."Currency Code" := CurrencyCode;
                TempCurrencyAmount.Date := PeriodStartDate[i];
                if TempCurrencyAmount.Find then begin
                    TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalCustLedgEntry[i]."Remaining Amount";
                    TempCurrencyAmount.Modify;
                end else begin
                    TempCurrencyAmount."Currency Code" := CurrencyCode;
                    TempCurrencyAmount.Date := PeriodStartDate[i];
                    TempCurrencyAmount.Amount := TotalCustLedgEntry[i]."Remaining Amount";
                    TempCurrencyAmount.Insert;
                end;
            end;
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := DMY2Date(31, 12, 9999);
            if TempCurrencyAmount.Find then begin
                TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalCustLedgEntry[1].Amount;
                TempCurrencyAmount.Modify;
            end else begin
                TempCurrencyAmount."Currency Code" := CurrencyCode;
                TempCurrencyAmount.Date := DMY2Date(31, 12, 9999);
                TempCurrencyAmount.Amount := TotalCustLedgEntry[1].Amount;
                TempCurrencyAmount.Insert;
            end;
        end;
    end;

    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewPagePercust: Boolean)
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePercustomer := NewPagePercust;
    end;

    local procedure CopyDimFiltersFromCustomer(var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        if Customer.GetFilter("Global Dimension 1 Filter") <> '' then
            CustLedgerEntry.SetFilter("Global Dimension 1 Code", Customer.GetFilter("Global Dimension 1 Filter"));
        if Customer.GetFilter("Global Dimension 2 Filter") <> '' then
            CustLedgerEntry.SetFilter("Global Dimension 2 Code", Customer.GetFilter("Global Dimension 2 Filter"));
    end;

}

