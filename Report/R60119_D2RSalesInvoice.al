report 60119 "D2R Sales - Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/R50030 D2R Sales Invoice.rdl';
    Caption = 'Sales Invoice';
    Permissions = TableData "Sales Shipment Buffer" = rimd, tabledata "Sales Invoice Header" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header";
        "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(CustomerNo;
            g_Customer."No.")
            {
            }
            column(No_SalesInvHdr;
            ConvertStr("No.", '.', ' '))
            {
            }
            column(InvDiscountAmtCaption;
            InvDiscountAmtCaptionLbl)
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(nonvatsales;
            nonvatsales)
            {
            }

            column(vatsales;
            vatsales)
            {
            }

            column(DocumentDateCaption;
            DocumentDateCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption;
            PaymentTermsDescCaptionLbl)
            {
            }
            column(ShptMethodDescCaption;
            ShptMethodDescCaptionLbl)
            {
            }
            column(VATPercentageCaption;
            VATPercentageCaptionLbl)
            {
            }
            column(TotalCaption;
            TotalCaptionLbl)
            {
            }
            column(VATBaseCaption;
            VATBaseCaptionLbl)
            {
            }
            column(VATAmtCaption;
            VATAmtCaptionLbl)
            {
            }
            column(VATIdentifierCaption;
            VATIdentifierCaptionLbl)
            {
            }
            column(HomePageCaption;
            HomePageCaptionLbl)
            {
            }
            column(EMailCaption;
            EMailCaptionLbl)
            {
            }
            column(DisplayAdditionalFeeNote;
            DisplayAdditionalFeeNote)
            {
            }
            column(FBM_Signature_pic; FBM_Signature_pic)
            {
            }
            dataitem(CopyLoop;
            "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop;
                "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(HomePage;
                    CompanyInfo."Home Page")
                    {
                    }
                    column(EMail;
                    CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfo2Picture;
                    CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture;
                    CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture;
                    CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo3Picture;
                    CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfoCity;
                    CompanyInfo3.City)
                    {
                    }
                    column(DocumentCaptionCopyText;
                    StrSubstNo(DocumentCaption, CopyText))
                    {
                    }
                    column(CustAddr1;
                    CustAddr[1])
                    {
                    }
                    column(CompanyAddr1;
                    CompanyAddr[1])
                    {
                    }
                    column(CustAddr2;
                    CustAddr[2])
                    {
                    }
                    column(CompanyAddr2;
                    CompanyAddr[2])
                    {
                    }
                    column(CustAddr3;
                    CustAddr[3])
                    {
                    }
                    column(CompanyAddr3;
                    CompanyAddr[3])
                    {
                    }
                    column(CustAddr4;
                    CustAddr[4])
                    {
                    }
                    column(CompanyAddr4;
                    CompanyAddr[4])
                    {
                    }
                    column(CustAddr5;
                    CustAddr[5])
                    {
                    }
                    column(PhoneNo;
                    CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6;
                    CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegNo;
                    CompanyInfo.FBM_TINNumber)
                    {
                    }
                    column(CompanyInfoGiroNo;
                    CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName;
                    CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo;
                    CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr;
                    "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr;
                    Format("Sales Invoice Header"."Posting Date", 0, 4))
                    {
                    }
                    column(VATNoText;
                    VATNoText)
                    {
                    }
                    //column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
                    column(VATRegNo_SalesInvHdr;
                    g_Customer."VAT Registration No.")
                    {
                    }
                    //column(DueDate_SalesInvHdr; Format("Sales Invoice Header"."Due Date", 0, 4))
                    column(DueDate_SalesInvHdr;
                    Format("Sales Invoice Header"."Due Date", 0, '<Month Text,3> <Day>, <Year4>'))
                    {
                    }
                    column(SalesPersonText;
                    SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName;
                    SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText;
                    ReferenceText)
                    {
                    }
                    column(YourReference_SalesInvHdr;
                    "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(OrderNoText;
                    OrderNoText)
                    {
                    }
                    column(HdrOrderNo_SalesInvHdr;
                    "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(CustAddr7;
                    CustAddr[7])
                    {
                    }
                    column(CustAddr8;
                    CustAddr[8])
                    {
                    }
                    column(CompanyAddr5;
                    CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6;
                    CompanyAddr[6])
                    {
                    }
                    //BFT-001
                    //column(DocDate_SalesInvHdr; Format("Sales Invoice Header"."Document Date", 0, 4))
                    column(DocDate_SalesInvHdr;
                    Format("Sales Invoice Header"."Document Date", 0, '<Month Text,3> <Day>, <Year4>'))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr;
                    "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo;
                    OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo_SalesInvHdr;
                    Format("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption;
                    PageCaptionCap)
                    {
                    }
                    column(PaymentTermsDesc;
                    PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc;
                    ShipmentMethod.Description)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption;
                    CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCptn;
                    CompanyInfoVATRegNoCptnLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption;
                    CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCptn;
                    CompanyInfoBankNameCptnLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCptn;
                    CompanyInfoBankAccNoCptnLbl)
                    {
                    }
                    column(SalesInvDueDateCaption;
                    SalesInvDueDateCaptionLbl)
                    {
                    }
                    column(InvNoCaption;
                    InvNoCaptionLbl)
                    {
                    }
                    column(SalesInvPostingDateCptn;
                    SalesInvPostingDateCptnLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdrCaption;
                    "Sales Invoice Header".FieldCaption("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption;
                    "Sales Invoice Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    column(PreparedBy;
                    prepby)
                    {
                    }
                    column(ApprovedBy;
                    apprby)
                    {
                    }
                    //BFT-001 -- begin
                    column(ContractCode;
                    "Sales Invoice Header"."FBM_Contract Code")
                    {
                    }
                    column(RFCaption;
                    RFCCaption)
                    {
                    }
                    column(InqEmail;
                    InqEmail)
                    {
                    }
                    column(CustomerRefCaption;
                    CustomerRefCaption)
                    {
                    }
                    column(CustomerCaption;
                    CustomerCaption)
                    {
                    }
                    column(AddressCaption;
                    AddressCaption)
                    {
                    }
                    column(InvoiceNumberCaption;
                    InvoiceNumberCaption)
                    {
                    }
                    column(DateCaption;
                    DateCaption)
                    {
                    }
                    column(CompanyInfoSWIFT;
                    CompanyInfo."SWIFT Code")
                    {
                    }
                    column(InquiriesCaption;
                    InquiriesCaption)
                    {
                    }
                    column(PhoneCaption;
                    PhoneCaption)
                    {
                    }
                    column(PaymentCaption;
                    PaymentCaption)
                    {
                    }
                    column(SWIFTCaption;
                    SWIFTCaption)
                    {
                    }
                    column(AccountCaption;
                    AccountCaption)
                    {
                    }
                    column(BankAddress;
                    BankAddressCaption)
                    {
                    }
                    column(VATIDNoCaption;
                    VATIDNoCaption)
                    {
                    }
                    column(TitleCaption;
                    TitleCaption)
                    {
                    }
                    column(SiteCaption;
                    SiteCaption)
                    {
                    }
                    column(IntBankCaption;
                    IntBankCaption)
                    {
                    }
                    column(IBANCaption;
                    IBANCaption)
                    {
                    }
                    column(BankCurrencyCaption;
                    BankCurrencyCaption)
                    {
                    }
                    column(FurtherTransferCaption;
                    FurtherTransferCaption)
                    {
                    }
                    column(PeriodStartCaption;
                    PeriodStartCaption)
                    {
                    }
                    column(PeriodEndCaption;
                    PeriodEndCaption)
                    {
                    }
                    column(CompanyInfoBankAddress;
                    CompanyInfo.FBM_BankAddress)
                    {
                    }
                    column(SIH_Currency;
                    Curr2)
                    {
                    }
                    column(HasVAT;
                    HasVAT)
                    {
                    }
                    column(SiteAddr1;
                    SiteAddr[1])
                    {
                    }
                    column(SiteAddr2;
                    SiteAddr[2])
                    {
                    }
                    column(SiteAddr3;
                    SiteAddr[3])
                    {
                    }
                    column(SiteAddr4;
                    SiteAddr[4])
                    {
                    }
                    column(SiteAddr5;
                    SiteAddr[5])
                    {
                    }
                    column(SiteAddr6;
                    SiteAddr[6])
                    {
                    }
                    column(SiteAddr7;
                    SiteAddr[7])
                    {
                    }
                    column(HasSite;
                    HasSite)
                    {
                    }
                    column(BankDetails1;
                    BankDetails[1])
                    {
                    }
                    column(BankDetails2;
                    BankDetails[2])
                    {
                    }
                    column(BankDetails3;
                    BankDetails[3])
                    {
                    }
                    column(BankDetails4;
                    BankDetails[4])
                    {
                    }
                    column(BankDetails5;
                    BankDetails[5])
                    {
                    }
                    column(BankDetails6;
                    BankDetails[6])
                    {
                    }
                    column(BankDetails7;
                    BankDetails[7])
                    {
                    }
                    column(BankDetails8;
                    BankDetails[8])
                    {
                    }
                    column(HasBank;
                    HasBank)
                    {
                    }
                    column(HasIntBank;
                    HasIntBank)
                    {
                    }
                    column(exchRate;
                    exchRate)
                    {
                    }
                    //BFT-001 -- end                
                    dataitem(DimensionLoop1;
                    "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                        column(DimText;
                        DimText)
                        {
                        }
                        column(DimensionLoop1Number;
                        Number)
                        {
                        }
                        column(HeaderDimCaption;
                        HeaderDimCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet then CurrReport.Break;
                            end
                            else
                                if not Continue then CurrReport.Break;
                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText := StrSubstNo('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.Next = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then CurrReport.Break;
                        end;
                    }
                    dataitem("Sales Invoice Line";
                    "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");

                        column(LineAmt_SalesInvLine;
                        "Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesInvLine;
                        Description)
                        {
                        }
                        column(No_SalesInvLine;
                        "No.")
                        {
                        }
                        column(Qty_SalesInvLine;
                        Quantity)
                        {
                        }
                        column(UOM_SalesInvLine;
                        "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine;
                        "Unit Price")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Discount_SalesInvLine;
                        "Line Discount %")
                        {
                        }
                        column(VATIdentifier_SalesInvLine;
                        "VAT Identifier")
                        {
                        }
                        column(PostedShipmentDate;
                        Format("Shipment Date"))
                        {
                        }
                        column(Type_SalesInvLine;
                        Format(Type))
                        {
                        }
                        column(InvDiscLineAmt_SalesInvLine;
                        -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal;
                        TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmount;
                        TotalInvDiscAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText;
                        TotalText)
                        {
                        }
                        column(Amount_SalesInvLine;
                        Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalAmount;
                        TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Amount_AmtInclVAT;
                        "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtInclVAT_SalesInvLine;
                        "Amount Including VAT")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText;
                        'VAT')
                        {
                        }
                        column(TotalExclVATText;
                        TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText;
                        TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT;
                        TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVAT;
                        TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineAmtAfterInvDiscAmt;
                        -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr;
                        "Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVAT;
                        TotalPaymentDiscOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_SalesInvLine;
                        TotalInclVATText)
                        {
                        }
                        column(VATAmtText_SalesInvLine;
                        VATAmountLine.VATAmountText)
                        {
                        }
                        column(DocNo_SalesInvLine;
                        "Document No.")
                        {
                        }
                        column(LineNo_SalesInvLine;
                        "Line No.")
                        {
                        }
                        column(UnitPriceCaption;
                        UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesInvLineDiscCaption;
                        SalesInvLineDiscCaptionLbl)
                        {
                        }
                        column(AmountCaption;
                        AmountCaptionLbl)
                        {
                        }
                        column(PostedShipmentDateCaption;
                        PostedShipmentDateCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;
                        SubtotalCaptionLbl)
                        {
                        }
                        column(LineAmtAfterInvDiscCptn;
                        LineAmtAfterInvDiscCptnLbl)
                        {
                        }
                        column(Desc_SalesInvLineCaption;
                        FieldCaption(Description))
                        {
                        }
                        column(No_SalesInvLineCaption;
                        FieldCaption("No."))
                        {
                        }
                        column(Qty_SalesInvLineCaption;
                        QtyCaption)
                        {
                        }
                        column(UOM_SalesInvLineCaption;
                        FieldCaption("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesInvLineCaption;
                        FieldCaption("VAT Identifier"))
                        {
                        }
                        column(IsLineWithTotals;
                        LineNoWithTotal = "Line No.")
                        {
                        }
                        //BFT-001 -- begin
                        column(VATRateCaption;
                        VATRateCaption)
                        {
                        }
                        column(SIL_VATP;
                        "Sales Invoice Line"."VAT %")
                        {
                        }
                        column(VATLinePrint;
                        VATLinePrint)
                        {
                        }
                        column(Curr1;
                        Curr1)
                        {
                        }
                        column(Curr2;
                        Curr2)
                        {
                        }
                        column(Curr1Cptn;
                        Curr1Cptn)
                        {
                        }
                        column(Curr2Cptn;
                        Curr2Cptn)
                        {
                        }
                        column(TotalSubTotalC1;
                        TotalSubTotalC1)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscountAmountC1;
                        TotalInvDiscountAmountC1)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVATC1;
                        TotalAmountVATC1)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVATC1;
                        TotalAmountInclVATC1)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVATC1;
                        TotalPaymentDiscOnVATC1)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalAmountC1;
                        TotalAmountC1)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotalC2;
                        TotalSubTotalC2)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscountAmountC2;
                        TotalInvDiscountAmountC2)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVATC2;
                        TotalAmountVATC2)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVATC2;
                        TotalAmountInclVATC2)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVATC2;
                        TotalPaymentDiscOnVATC2)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalAmountC2;
                        TotalAmountC2)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalPreVATEUR;
                        TotalPreVATEUR)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalVATEUR;
                        TotalVATEUR)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(TotalEUR;
                        TotalEUR)
                        {
                            AutoFormatExpression = 'USD';
                            AutoFormatType = 1;
                        }
                        column(VATText;
                        VATText)
                        {
                        }
                        column(TotalInclVATLbl;
                        TotalInclVATLbl)
                        {
                        }
                        column(TotalExclVATLbl;
                        TotalExclVATLbl)
                        {
                        }
                        column(Period_Start;
                        Format("FBM_Period Start", 0, '<Month Text,3> <Day>, <Year4>'))
                        {
                        }
                        column(Period_End;
                        Format("FBM_Period End", 0, '<Month Text,3> <Day>, <Year4>'))
                        {
                        }
                        //BFT-001 -- end
                        dataitem("Sales Shipment Buffer";
                        "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            column(SalesShptBufferPostDate;
                            Format(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShptBufferQty;
                            SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShipmentCaption;
                            ShipmentCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    SalesShipmentBuffer.Find('-')
                                else
                                    SalesShipmentBuffer.Next;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                SalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                                SetRange(Number, 1, SalesShipmentBuffer.Count);
                            end;
                        }
                        dataitem(DimensionLoop2;
                        "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                            column(DimText_DimLoop;
                            DimText)
                            {
                            }
                            column(LineDimCaption;
                            LineDimCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet then CurrReport.Break;
                                end
                                else
                                    if not Continue then CurrReport.Break;
                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText := StrSubstNo('%1, %2 %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then CurrReport.Break;
                                DimSetEntry2.SetRange("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop;
                        "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            column(TempPostedAsmLineNo;
                            BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }
                            column(TempPostedAsmLineQuantity;
                            TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineDesc;
                            BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostAsmLineVartCode;
                            BlanksForIndent + TempPostedAsmLine."Variant Code")
                            {
                            }
                            column(TempPostedAsmLineUOM;
                            GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            }
                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                if Number = 1 then
                                    TempPostedAsmLine.FindSet
                                else
                                    TempPostedAsmLine.Next;
                                if ItemTranslation.Get(TempPostedAsmLine."No.", TempPostedAsmLine."Variant Code", "Sales Invoice Header"."Language Code") then TempPostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                Clear(TempPostedAsmLine);
                                if not DisplayAssemblyInformation then CurrReport.Break;
                                CollectAsmInformation;
                                Clear(TempPostedAsmLine);
                                SetRange(Number, 1, TempPostedAsmLine.Count);
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin

                            InitializeShipmentBuffer;
                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then "No." := '';
                            VATAmountLine.Init;
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            if "Allow Invoice Disc." then VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            VATAmountLine.InsertLine;
                            CalcVATAmountLineLCY("Sales Invoice Header", VATAmountLine, TempVATAmountLineLCY, VATBaseRemainderAfterRoundingLCY, AmtInclVATRemainderAfterRoundingLCY);
                            TotalSubTotal += "Line Amount";
                            TotalInvDiscAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            //BFT1.00
                            CalculateCurrencyTotals("Sales Invoice Header", Curr1, Curr2);
                            //BFT
                            if ("Sales Invoice Line"."VAT %" = 0) then
                                VATLinePrint := '-'
                            else
                                VATLinePrint := StrSubstNo('%1%', "Sales Invoice Line"."VAT %");
                            //BFT

                            // non vat / vat sales
                            if ("Sales Invoice Line"."VAT %" = 0) then begin
                                nonvatsales += "Sales Invoice Line".Amount;
                            end
                            else begin
                                vatsales += "Sales Invoice Line".Amount
                            end;

                            // non vat / vat sales

                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DeleteAll;
                            TempVATAmountLineLCY.DeleteAll;
                            VATBaseRemainderAfterRoundingLCY := 0;
                            AmtInclVATRemainderAfterRoundingLCY := 0;
                            SalesShipmentBuffer.Reset;
                            SalesShipmentBuffer.DeleteAll;
                            FirstValueEntryNo := 0;
                            MoreLines := Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do MoreLines := Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break;
                            LineNoWithTotal := "Line No.";
                            SetRange("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(VATCounter;
                    "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(VATAmtLineVATBase;
                        VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt;
                        VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt;
                        VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt;
                        VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt;
                        VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPer;
                        VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier;
                        VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn;
                        VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption;
                        InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption;
                        LineAmtCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, VATAmountLine.Count);
                        end;
                    }
                    dataitem(VATClauseEntryCounter;
                    "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(VATClauseVATIdentifier;
                        VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode;
                        VATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription;
                        VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2;
                        VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount;
                        VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption;
                        VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption;
                        VATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption;
                        VATAmtCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            if not VATClause.Get(VATAmountLine."VAT Clause Code") then CurrReport.Skip;
                            VATClause.TranslateDescription("Sales Invoice Header"."Language Code");
                        end;

                        trigger OnPreDataItem()
                        begin
                            Clear(VATClause);
                            SetRange(Number, 1, VATAmountLine.Count);
                        end;
                    }
                    dataitem(VatCounterLCY;
                    "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(VALSpecLCYHeader;
                        VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate;
                        VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY;
                        VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY;
                        VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATPer_VATCounterLCY;
                        TempVATAmountLineLCY."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATCounterLCY;
                        TempVATAmountLineLCY."VAT Identifier")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLineLCY.GetLine(Number);
                            VALVATBaseLCY := TempVATAmountLineLCY."VAT Base";
                            VALVATAmountLCY := TempVATAmountLineLCY."Amount Including VAT" - TempVATAmountLineLCY."VAT Base";
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or ("Sales Invoice Header"."Currency Code" = '') then CurrReport.Break;
                            SetRange(Number, 1, VATAmountLine.Count);
                            Clear(VALVATBaseLCY);
                            Clear(VALVATAmountLCY);
                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");
                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := Round(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := StrSubstNo(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(PaymentReportingArgument;
                    "Payment Reporting Argument")
                    {
                        DataItemTableView = SORTING(Key);
                        UseTemporary = true;

                        column(PaymentServiceLogo;
                        Logo)
                        {
                        }
                        column(PaymentServiceURLText;
                        "URL Caption")
                        {
                        }
                        column(PaymentServiceURL;
                        GetTargetURL)
                        {
                        }
                        trigger OnPreDataItem()
                        var
                            PaymentServiceSetup: Record "Payment Service Setup";
                        begin
                            PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, "Sales Invoice Header");
                            if IsEmpty then CurrReport.Break;
                        end;
                    }
                    dataitem(Total;
                    "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        column(SelltoCustNo_SalesInvHdr;
                        "Sales Invoice Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1;
                        ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2;
                        ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3;
                        ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4;
                        ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5;
                        ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6;
                        ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7;
                        ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8;
                        ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddrCaption;
                        ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdrCaption;
                        "Sales Invoice Header".FieldCaption("Sell-to Customer No."))
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then CurrReport.Break;
                        end;
                    }
                    //BFT-001
                    dataitem(TC;
                    FBM_TermsConditions)
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemLink = Country = field("Sell-to Country/Region code");

                        column(TermsConditions;
                        "Terms Conditions")
                        {
                        }
                        column(termslineno;
                        "Line No.")
                        {
                        }
                        trigger
                        OnPreDataItem()
                        begin
                            SetRange(DocType, DocType::SI);
                        end;

                        trigger OnAfterGetRecord()
                        begin
                            // if ((g_Customer."Country/Region Code" = 'MX') OR (g_Customer."Country/Region Code" = 'PH')) then begin
                            //     if (TC.Country <> g_Customer."Country/Region Code") then CurrReport.Skip();
                            // end
                            // else
                            //     if (TC.Country <> '') then CurrReport.Skip();
                        end;
                    }

                    //BFT-001
                    dataitem(LineFee;
                    "Integer")
                    {
                        DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));

                        column(LineFeeCaptionLbl;
                        TempLineFeeNoteOnReportHist.ReportText)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if not DisplayAdditionalFeeNote then CurrReport.Break;
                            if Number = 1 then begin
                                if not TempLineFeeNoteOnReportHist.FindSet then CurrReport.Break
                            end
                            else
                                if TempLineFeeNoteOnReportHist.Next = 0 then CurrReport.Break;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    user.setrange("User Name", glentry."User ID");
                    if user.FindFirst() then
                        apprby := user."Full Name";
                    user.SetRange("User Name", "Sales Invoice Header"."User ID");
                    if user.FindFirst() then
                        prepby := user."Full Name";
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                    end;
                    TotalSubTotal := 0;
                    TotalInvDiscAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscOnVAT := 0;
                    ResetLCYValues();
                end;

                trigger OnPostDataItem()
                begin
                    if not IsReportInPreviewMode then CODEUNIT.Run(CODEUNIT::"Sales Inv.-Printed", "Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }


            trigger OnAfterGetRecord()
            var
                Handled: Boolean;
                mediaid: Guid;
            begin
                if usersetup.get("Sales Invoice Header"."User ID") then begin
                    FOR Index := 1 to usersetup."Signature PHL".COUNT DO BEGIN
                        mediaid := usersetup."Signature PHL".Item(1);
                        "Sales Invoice Header".FBM_Signature_pic.Insert(mediaid);
                        "Sales Invoice Header".Modify();
                    end;
                end;
                FOR Index := 1 to "Sales Invoice Header".FBM_Signature_pic.COUNT DO BEGIN
                    IF TenantMedia.GET("Sales Invoice Header".FBM_Signature_pic.Item(1)) THEN BEGIN
                        TenantMedia.CALCFIELDS(Content);
                    END;
                END;
                glentry.SetRange("Document No.", "Sales Invoice Header"."No.");
                if glentry.FindFirst() then begin end;
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                FormatSiteAddress("Sales Invoice Header");
                FormatAddressFields("Sales Invoice Header");
                FormatDocumentFields("Sales Invoice Header");
                if not Cust.Get("Bill-to Customer No.") then Clear(Cust);
                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
                GetLineFeeNoteOnReportHist("No.");
                //BFT1.00
                SetReportCurrencies(Curr1, Curr2, "Sales Invoice Header");
                //HasVAT := InvoiceHasVAT("Sales Invoice Header");
                OnAfterGetRecordSalesInvoiceHeader("Sales Invoice Header");
                //OnGetReferenceText("Sales Invoice Header", ReferenceText, Handled);
                //BFT-001
                RFCCaption := 'RFC:';
                g_Customer.SetFilter(g_Customer."No.", "Sales Invoice Header"."Bill-to Customer No.");
                g_Customer.FindFirst;
                if (g_Customer."Country/Region Code" = 'PH') then begin
                    RFCCaption := 'TIN:';
                end;
                FormatBankInfo(g_Customer);
                //BFT-001
            end;

            trigger OnPostDataItem()
            begin
                OnAfterPostDataItem("Sales Invoice Header");
            end;
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

                    /*
                              field(NoOfCopies; NoOfCopies)
                              {
                                  ApplicationArea = Basic, Suite;
                                  Caption = 'No. of Copies';
                                  ToolTip = 'Specifies how many copies of the document to print.';
                              }
                              */
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies that any notes about additional fees are included on the document.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        GLSetup.Get;
        SalesSetup.Get;
        CompanyInfo.Get;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
        OnAfterInitReport;
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode then
            if "Sales Invoice Header".FindSet then
                repeat
                    if "Sales Invoice Header"."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(SegManagement.SalesInvoiceInterDocType, "Sales Invoice Header"."No.", 0, 0, DATABASE::Contact, "Sales Invoice Header"."Bill-to Contact No.", "Sales Invoice Header"."Salesperson Code", "Sales Invoice Header"."Campaign No.", "Sales Invoice Header"."Posting Description", '')
                    else
                        SegManagement.LogDocument(SegManagement.SalesInvoiceInterDocType, "Sales Invoice Header"."No.", 0, 0, DATABASE::Customer, "Sales Invoice Header"."Bill-to Customer No.", "Sales Invoice Header"."Salesperson Code", "Sales Invoice Header"."Campaign No.", "Sales Invoice Header"."Posting Description", '');
                until "Sales Invoice Header".Next = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then InitLogInteraction;
    end;

    var
        Text004: Label 'INVOICE %1', Comment = '%1 = Document No.';
        PageCaptionCap: Label 'Page %1 of %2';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        TempVATAmountLineLCY: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        VATClause: Record "VAT Clause";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        OrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        VALExchRate: Text[50];
        Text009: Label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        Text010: Label 'Sales - Prepayment Invoice %1';
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCptnLbl: Label 'VAT Reg. No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCptnLbl: Label 'Bank: ';
        CompanyInfoBankAccNoCptnLbl: Label 'IBAN: ';
        SalesInvDueDateCaptionLbl: Label 'Due Date:';
        InvNoCaptionLbl: Label 'Invoice No.';
        SalesInvPostingDateCptnLbl: Label 'Posting Date';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        SalesInvLineDiscCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        VATClausesCap: Label 'VAT Clause';
        PostedShipmentDateCaptionLbl: Label 'Posted Shipment Date';
        SubtotalCaptionLbl: Label 'SUBTOTAL';
        LineAmtAfterInvDiscCptnLbl: Label 'Payment Discount on VAT';
        ShipmentCaptionLbl: Label 'Shipment';
        LineDimCaptionLbl: Label 'Line Dimensions';
        VATAmtSpecificationCptnLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
        DocumentDateCaptionLbl: Label 'Document Date';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        ShptMethodDescCaptionLbl: Label 'Shipment Method';
        VATPercentageCaptionLbl: Label 'VAT %';
        TotalCaptionLbl: Label 'TOTAL';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT @';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        HomePageCaptionLbl: Label 'Home Page';
        EMailCaptionLbl: Label 'Email';
        DisplayAdditionalFeeNote: Boolean;
        LineNoWithTotal: Integer;
        VATBaseRemainderAfterRoundingLCY: Decimal;
        AmtInclVATRemainderAfterRoundingLCY: Decimal;
        //BFT-001 -- begin
        RFCCaption: Text[30];
        CustomerRefCaption: Label 'Customer Reference:';
        CustomerCaption: Label 'Customer:';
        AddressCaption: Label 'Address:';
        InvoiceNumberCaption: Label 'Invoice Number:';
        DateCaption: Label 'Invoice Date:';
        VATRateCaption: Label 'VAT Rate';
        InquiriesCaption: Label 'DIRECT ALL INQUIRIES TO:';
        EmailCaption: Label 'Email';
        PhoneCaption: Label 'Phone';
        PaymentCaption: Label 'PLEASE SEND PAYMENT TO:';
        SWIFTCaption: Label 'SWIFT: ';
        AccountCaption: Label 'Account';
        BankAddressCaption: Label 'Bank Address: ';
        VATIDNoCaption: Label 'VAT ID Number';
        TitleCaption: Label 'INVOICE';
        SiteCaption: Label 'Site:';
        IntBankCaption: Label 'Intermediary Bank: ';
        IBANCaption: Label 'Account: ';
        BankCurrencyCaption: Label 'Currency: ';
        FurtherTransferCaption: Label 'FOR FURTHER TRANSFER TO BE FOWARDED TO:';
        PeriodStartCaption: Label 'Period Start';
        PeriodEndCaption: Label 'Period End';
        Curr1: Code[10];
        Curr2: Code[10];
        Curr1Cptn: Text[10];
        Curr2Cptn: Text[10];
        TotalSubTotalC1: Decimal;
        TotalInvDiscountAmountC1: Decimal;
        TotalAmountC1: Decimal;
        TotalAmountVATC1: Decimal;
        AmountInclVATC1: Decimal;
        TotalPaymentDiscOnVATC1: Decimal;
        TotalAmountInclVATC1: Decimal;
        TotalSubTotalC2: Decimal;
        TotalInvDiscountAmountC2: Decimal;
        TotalAmountC2: Decimal;
        TotalAmountVATC2: Decimal;
        AmountInclVATC2: Decimal;
        TotalPaymentDiscOnVATC2: Decimal;
        TotalAmountInclVATC2: Decimal;
        FormatAddrCountry: Codeunit "FBM_Format Addr_CO";
        HasVAT: Boolean;
        TotalInclVATLbl: Label 'W/TAX';
        TotalExclVATLbl: Label 'NET AMOUNT';
        QtyCaption: Label 'Qty';
        g_Customer: Record "Customer";
        Site: Record FBM_CustomerSite_C;
        SiteAddr: array[7] of Text[100];
        HasSite: Boolean;
        exchRate: Decimal;
        BankDetails: array[8] of Text[250];
        HasBank: Boolean;
        HasIntBank: Boolean;
        VATLinePrint: Text[10];
        TotalPreVATEUR: Decimal;
        TotalVATEUR: Decimal;
        TotalEUR: Decimal;
        VATText: Text[200];
        InqEmail: Text[200];

        nonvatsales: Decimal;
        vatsales: Decimal;
        glentry: record "G/L Entry";
        user: record User;
        prepby: Text;
        apprby: Text;
        //BFT-001 -- end
        usersetup: record "User Setup";
        index: integer;
        TenantMedia: record "Tenant Media";

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    local procedure InitializeShipmentBuffer()
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Sales Invoice Line"."Shipment No." <> '' then if SalesShipmentHeader.Get("Sales Invoice Line"."Shipment No.") then exit;
        if "Sales Invoice Header"."Order No." = '' then exit;
        case "Sales Invoice Line".Type of
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource, "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
        end;
        SalesShipmentBuffer.Reset;
        SalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        SalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
        if SalesShipmentBuffer.Find('-') then begin
            TempSalesShipmentBuffer := SalesShipmentBuffer;
            if SalesShipmentBuffer.Next = 0 then begin
                SalesShipmentBuffer.Get(TempSalesShipmentBuffer."Document No.", TempSalesShipmentBuffer."Line No.", TempSalesShipmentBuffer."Entry No.");
                SalesShipmentBuffer.Delete;
                exit;
            end;
            SalesShipmentBuffer.CalcSums(Quantity);
            if SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
                SalesShipmentBuffer.DeleteAll;
                exit;
            end;
        end;
    end;

    local procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SetCurrentKey("Document No.");
        ValueEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SetRange("Item Charge No.", '');
        ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.Find('-') then
            repeat
                if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                    if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    else
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(SalesInvoiceLine2, -Quantity, ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            until (ValueEntry.Next = 0) or (TotalQuantity = 0);
    end;

    local procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SetCurrentKey("Order No.");
        SalesInvoiceHeader.SetFilter("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        if SalesInvoiceHeader.Find('-') then
            repeat
                SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SetRange("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SetRange("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                if SalesInvoiceLine2.Find('-') then
                    repeat
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    until SalesInvoiceLine2.Next = 0;
            until SalesInvoiceHeader.Next = 0;
        SalesShipmentLine.SetCurrentKey("Order No.", "Order Line No.");
        SalesShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SetRange("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SetRange("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);
        if SalesShipmentLine.Find('-') then
            repeat
                if "Sales Invoice Header"."Get Shipment Used" then CorrectShipment(SalesShipmentLine);
                if Abs(SalesShipmentLine.Quantity) <= Abs(TotalQuantity - SalesInvoiceLine.Quantity) then
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                else begin
                    if Abs(SalesShipmentLine.Quantity) > Abs(TotalQuantity) then SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity := SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;
                    if SalesShipmentHeader.Get(SalesShipmentLine."Document No.") then AddBufferEntry(SalesInvoiceLine, Quantity, SalesShipmentHeader."Posting Date");
                end;
            until (SalesShipmentLine.Next = 0) or (TotalQuantity = 0);
    end;

    local procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetCurrentKey("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SetRange("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");
        if SalesInvoiceLine.Find('-') then
            repeat
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            until SalesInvoiceLine.Next = 0;
    end;

    local procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line";
    QtyOnShipment: Decimal;
    PostingDate: Date)
    begin
        SalesShipmentBuffer.SetRange("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SetRange("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SetRange("Posting Date", PostingDate);
        if SalesShipmentBuffer.Find('-') then begin
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.Modify;
            exit;
        end;
        with SalesShipmentBuffer do begin
            "Document No." := SalesInvoiceLine."Document No.";
            "Line No." := SalesInvoiceLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesInvoiceLine.Type;
            "No." := SalesInvoiceLine."No.";
            Quantity := QtyOnShipment;
            "Posting Date" := PostingDate;
            Insert;
            NextEntryNo := NextEntryNo + 1
        end;
    end;

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption("Sales Invoice Header", DocCaption);
        if DocCaption <> '' then exit(DocCaption);
        if "Sales Invoice Header"."Prepayment Invoice" then exit(Text010);
        exit(Text004);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer;
    NewShowInternalInfo: Boolean;
    NewLogInteraction: Boolean;
    DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        with SalesInvoiceHeader do begin
            //BFT-001
            //FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);            
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
            OrderNoText := FormatDocument.SetText("Order No." <> '', FieldCaption("Order No."));
            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FieldCaption("Your Reference"));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FieldCaption("VAT Registration No."));
        end;
    end;

    local procedure FormatAddressFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        //BFT-001
        //FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddrCountry.GetCompanyAddrCountry(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
    end;

    local procedure CollectAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DeleteAll;
        if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item then exit;
        with ValueEntry do begin
            SetCurrentKey("Document No.");
            SetRange("Document No.", "Sales Invoice Line"."Document No.");
            SetRange("Document Type", "Document Type"::"Sales Invoice");
            SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
            SetRange(Adjustment, false);
            if not FindSet then exit;
        end;
        repeat
            if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then begin
                    SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
                        PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                        if PostedAsmLine.FindSet then
                            repeat
                                TreatAsmLineBuffer(PostedAsmLine);
                            until PostedAsmLine.Next = 0;
                    end;
                end;
        until ValueEntry.Next = 0;
    end;

    local procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        Clear(TempPostedAsmLine);
        TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FindFirst then begin
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.Modify;
        end
        else begin
            Clear(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.Insert;
        end;
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PadStr('', 2, ' '));
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DeleteAll;
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst then exit;
        if not Customer.Get(CustLedgerEntry."Customer No.") then exit;
        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet then begin
            repeat
                InsertTempLineFeeNoteOnReportHist(LineFeeNoteOnReportHist, TempLineFeeNoteOnReportHist);
            until LineFeeNoteOnReportHist.Next = 0;
        end
        else begin
            LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguageCode);
            if LineFeeNoteOnReportHist.FindSet then
                repeat
                    InsertTempLineFeeNoteOnReportHist(LineFeeNoteOnReportHist, TempLineFeeNoteOnReportHist);
                until LineFeeNoteOnReportHist.Next = 0;
        end;
    end;

    local procedure CalcVATAmountLineLCY(SalesInvoiceHeader: Record "Sales Invoice Header";
    TempVATAmountLine2: Record "VAT Amount Line" temporary;
    var TempVATAmountLineLCY2: Record "VAT Amount Line" temporary;
    var VATBaseRemainderAfterRoundingLCY2: Decimal;
    var AmtInclVATRemainderAfterRoundingLCY2: Decimal)
    var
        VATBaseLCY: Decimal;
        AmtInclVATLCY: Decimal;
    begin
        if (not GLSetup."Print VAT specification in LCY") or (SalesInvoiceHeader."Currency Code" = '') then exit;
        TempVATAmountLineLCY2.Init;
        TempVATAmountLineLCY2 := TempVATAmountLine2;
        with SalesInvoiceHeader do begin
            VATBaseLCY := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", TempVATAmountLine2."VAT Base", "Currency Factor") + VATBaseRemainderAfterRoundingLCY2;
            AmtInclVATLCY := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", TempVATAmountLine2."Amount Including VAT", "Currency Factor") + AmtInclVATRemainderAfterRoundingLCY2;
        end;
        TempVATAmountLineLCY2."VAT Base" := Round(VATBaseLCY);
        TempVATAmountLineLCY2."Amount Including VAT" := Round(AmtInclVATLCY);
        TempVATAmountLineLCY2.InsertLine;
        VATBaseRemainderAfterRoundingLCY2 := VATBaseLCY - TempVATAmountLineLCY2."VAT Base";
        AmtInclVATRemainderAfterRoundingLCY2 := AmtInclVATLCY - TempVATAmountLineLCY2."Amount Including VAT";
    end;

    local procedure InsertTempLineFeeNoteOnReportHist(var LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
    var TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary)
    begin
        repeat
            TempLineFeeNoteOnReportHist.Init;
            TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
            TempLineFeeNoteOnReportHist.Insert;
        until TempLineFeeNoteOnReportHist.Next = 0;
    end;

    local procedure SetReportCurrencies(var Currency1: Code[10];
    var Currency2: Code[10];
    SIH: Record "Sales Invoice Header")
    var
        l_GLSetup: record "General Ledger Setup";
    begin
        Clear(Currency1);
        Clear(Currency2);
        GLSetup.get();
        /*if InvoiceHasVAT(SIH) then begin                    //if VAT is present, values to be shown are in LCY & EUR
                Currency1 := GLSetup."LCY Code";
                Currency2 := GLSetup."Additional Reporting Currency"; //Additional reporting currency = EUR
                Curr1Cptn := GLSetup."LCY Code";
                Curr2Cptn := GLSetup."Additional Reporting Currency";
            end
            else*/
        if ((SIH."Currency Code" <> '') AND (SIH."Currency Code" <> GLSetup."LCY Code")) then //if not in LCY, values should be shown in FCY & LCY
     begin
            Currency1 := SIH."Currency Code";
            Currency2 := GLSetup."LCY Code";
            Curr1Cptn := SIH."Currency Code";
            Curr2Cptn := GLSetup."LCY Code";
        end
        else begin //if in LCY, values should be shown in LCY;
            Currency1 := GLSetup."LCY Code";
            Currency2 := '';
            Curr1Cptn := GLSetup."LCY Code";
            Curr2Cptn := '';
        end;
    end;
    //end;
    //BFT-001 -- begin
    local procedure CalculateCurrencyTotals(var SIHeader: record "Sales Invoice Header";
    Currency1: Code[10];
    Currency2: Code[10])
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.get();
        if ((Currency1 = GLSetup."LCY Code") AND (Currency2 = '')) then begin
            //calculate LCY only
            CalcLCY();
        end
        /*else
                if ((Currency1 = GLSetup."LCY Code") AND (Currency2 = GLSetup."Additional Reporting Currency")) then begin
                    //calculate LCY & EUR
                    ARC := GLSetup."Additional Reporting Currency";
                    CalcLCYARC(SIHeader."Posting Date", ARC);
                end*/
        else
            if ((Currency1 <> GLSetup."LCY Code") AND (Currency2 = GLSetup."LCY Code")) then begin
                //calculate FCY & LCY
                CalcFCYLCY(SIHeader);
            end;
        CalcVATEUR(SIHeader."Posting Date");
    end;

    local procedure CalcLCY()
    begin
        TotalSubTotalC1 := TotalSubTotal;
        TotalInvDiscountAmountC1 := TotalInvDiscAmount;
        TotalAmountC1 := TotalAmount;
        TotalAmountVATC1 := TotalAmountVAT;
        TotalAmountInclVATC1 := TotalAmountInclVAT;
        TotalPaymentDiscOnVATC1 := TotalPaymentDiscOnVAT;
        TotalSubTotalC2 := 0;
        TotalInvDiscountAmountC2 := 0;
        TotalAmountC2 := 0;
        TotalAmountVATC2 := 0;
        TotalAmountInclVATC2 := 0;
        TotalPaymentDiscOnVATC2 := 0;
    end;

    local procedure CalcLCYARC(PostingDate: Date;
    ARC: Code[10])
    var
        exchRate: Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        //get exchange rate
        CurrencyExchangeRate.Reset();
        CurrencyExchangeRate.setfilter(CurrencyExchangeRate."Currency Code", ARC);
        CurrencyExchangeRate.SetFilter(CurrencyExchangeRate."Starting Date", '<=%1', PostingDate);
        if CurrencyExchangeRate.FindLast() then begin
            exchRate := CurrencyExchangeRate."Exchange Rate Amount";
        end;
        TotalSubTotalC1 := TotalSubTotal;
        TotalInvDiscountAmountC1 := TotalInvDiscAmount;
        TotalAmountC1 := TotalAmount;
        TotalAmountVATC1 := TotalAmountVAT;
        TotalAmountInclVATC1 := TotalAmountInclVAT;
        TotalPaymentDiscOnVATC1 := TotalPaymentDiscOnVAT;
        TotalSubTotalC2 := TotalSubTotal * exchRate;
        TotalInvDiscountAmountC2 := TotalInvDiscAmount * exchRate;
        TotalAmountC2 := TotalAmount * exchRate;
        TotalAmountVATC2 := TotalAmountVAT * exchRate;
        TotalAmountInclVATC2 := TotalAmountInclVAT * exchRate;
        TotalPaymentDiscOnVATC2 := TotalPaymentDiscOnVAT * exchRate;
    end;

    local procedure CalcVATEUR(PostingDate: Date)
    var
        exchrate: Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        if (not HasVAT) then VATText := 'No VAT is chargeable as the service is deemed to be provided outside Malta in terms of the Third Schedule, Part 2, Item 2(1) to the Value Added Tax Act.';
        //get exchange rate
        CurrencyExchangeRate.Reset();
        CurrencyExchangeRate.setfilter(CurrencyExchangeRate."Currency Code", 'EUR');
        CurrencyExchangeRate.SetFilter(CurrencyExchangeRate."Starting Date", '<=%1', PostingDate);
        if CurrencyExchangeRate.FindLast() then begin
            exchRate := CurrencyExchangeRate."Exchange Rate Amount";
        end;
        If (Curr1 = GLSetup."LCY Code") then begin
            TotalPreVATEUR := TotalSubTotalC1 * exchrate;
            TotalVATEUR := TotalAmountVATC1 * exchrate;
            TotalEUR := TotalAmountInclVATC1 * exchrate;
        end
        else begin
            TotalPreVATEUR := TotalSubTotalC2 * exchrate;
            TotalVATEUR := TotalAmountVATC2 * exchrate;
            TotalEUR := TotalAmountInclVATC2 * exchrate;
        end;
    end;

    local procedure CalcFCYLCY(SIHeader: Record "Sales Invoice Header")
    begin
        exchRate := SIHeader."Currency Factor";
        TotalSubTotalC1 := TotalSubTotal;
        TotalInvDiscountAmountC1 := TotalInvDiscAmount;
        TotalAmountC1 := TotalAmount;
        TotalAmountVATC1 := TotalAmountVAT;
        TotalAmountInclVATC1 := TotalAmountInclVAT;
        TotalPaymentDiscOnVATC1 := TotalPaymentDiscOnVAT;
        TotalSubTotalC2 := TotalSubTotal / exchRate;
        TotalInvDiscountAmountC2 := TotalInvDiscAmount / exchRate;
        TotalAmountC2 := TotalAmount / exchRate;
        TotalAmountVATC2 := TotalAmountVAT / exchRate;
        TotalAmountInclVATC2 := TotalAmountInclVAT / exchRate;
        TotalPaymentDiscOnVATC2 := TotalPaymentDiscOnVAT / exchRate;
    end;

    local procedure ResetLCYValues()
    begin
        TotalSubTotalC1 := 0;
        TotalInvDiscountAmountC1 := 0;
        TotalAmountC1 := 0;
        TotalAmountVATC1 := 0;
        TotalAmountInclVATC1 := 0;
        TotalPaymentDiscOnVATC1 := 0;
        TotalSubTotalC2 := 0;
        TotalInvDiscountAmountC2 := 0;
        TotalAmountC2 := 0;
        TotalAmountVATC2 := 0;
        TotalAmountInclVATC2 := 0;
        TotalPaymentDiscOnVATC2 := 0;
    end;

    local procedure InvoiceHasVAT(VATSIH: Record "Sales Invoice Header"): Boolean
    begin
        VATSIH.CalcFields("Amount Including VAT");
        VATSIH.CalcFields(Amount);
        if VATSIH."Amount Including VAT" - VATSIH.Amount <> 0 then
            exit(true)
        else
            exit(false);
    end;
    //BFT-001 -- end
    [IntegrationEvent(false, false)]
    procedure OnAfterGetRecordSalesInvoiceHeader(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesInvoiceHeader: Record "Sales Invoice Header";
    var DocCaption: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnGetReferenceText(SalesInvoiceHeader: Record "Sales Invoice Header";
    var ReferenceText: Text[80];
    var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    local procedure OnAfterInitReport()
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    local procedure OnAfterPostDataItem(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    local procedure FormatSiteAddress(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        Cnt: Record "Country/Region";
    begin
        if (SalesInvoiceHeader.FBM_Site <> '') then begin
            Site.SetFilter(Site."Site Code", SalesInvoiceHeader.FBM_Site);
            if (Site.FindFirst()) then begin
                HasSite := true;
                SiteAddr[1] := Site."Site Name";
                SiteAddr[2] := Site.Address;
                SiteAddr[3] := Site."Address 2";
                if Site.City <> '' then
                    SiteAddr[4] := STRSUBSTNO('%1, ', Site.City)
                else
                    SiteAddr[4] := Site.City;
                SiteAddr[5] := Site."Post Code";
                if Cnt.Get(Site."Country/Region Code") then
                    SiteAddr[6] := Cnt.Name
                else
                    SiteAddr[6] := '';
                SiteAddr[7] := Site."Site Code";
            end
            else
                HasSite := false
        end
        else
            HasSite := false
    end;

    local procedure FormatBankInfo(var Cust: Record Customer)
    var
        PaymentBank: Record "Bank Account";
    begin
        if (Cust."FBM_Payment Bank Code" <> '') then begin
            PaymentBank.SetFilter("No.", Cust."FBM_Payment Bank Code");
            if (PaymentBank.FindFirst()) then begin
                // BankDetails[1] := PaymentBank."Intermediary Bank";
                // BankDetails[2] := PaymentBank."Intermediary SWIFT";
                BankDetails[3] := PaymentBank.Name;
                BankDetails[4] := PaymentBank."SWIFT Code";
                BankDetails[5] := PaymentBank."Bank Account No.";
                BankDetails[6] := PaymentBank."Currency Code";
                BankDetails[7] := PaymentBank.Address;
                BankDetails[8] := PaymentBank."Address 2";
                HasBank := true;
                if ((BankDetails[1] = '') OR (BankDetails[2] = '')) then
                    HasIntBank := false
                else
                    HasIntBank := true;
            end
            else
                HasBank := false;
        end
        else
            HasBank := false;
    end;
}
