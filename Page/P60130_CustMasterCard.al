page 60130 FBM_CustCardMaster_CO
{
    Caption = 'Customer Card Master';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Prices & Discounts,Navigate,Customer';
    RefreshOnActivate = true;
    SourceTable = FBM_Customer;

    AboutTitle = 'About customer details';
    AboutText = 'With the **Customer Card** you manage information about a customer and specify the terms of business, such as payment terms, prices and discounts. From here you can also drill down on past and ongoing sales activity.';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the customer''s name. This name will appear on all sales documents for the customer.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Name 2"; rec."Name 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies an additional part of the name.';
                    Visible = false;
                }
                field("Search Name"; rec."Search Name")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies an alternate name that you can use to search for a customer.';
                    Visible = false;
                }


                field(BalanceAsVendor; BalanceAsVendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance (LCY) As Vendor';
                    Editable = false;
                    Enabled = BalanceAsVendorEnabled;
                    ToolTip = 'Specifies the amount that you owe this vendor. This is relevant when your vendor is also your customer. The amount is the result of netting their payable and receivable balances.';

                    trigger OnDrillDown()
                    var
                        DtldVendLedgEntry: Record 380;
                        VendLedgEntry: Record 25;
                    begin
                        if LinkedVendorNo = '' then
                            exit;
                        DtldVendLedgEntry.SetRange("Vendor No.", LinkedVendorNo);
                        Rec.CopyFilter("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
                        Rec.CopyFilter("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                        Rec.CopyFilter("Currency Filter", DtldVendLedgEntry."Currency Code");
                        VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                    end;
                }
                field(Company1; Rec.FBM_Company1)
                {
                    ApplicationArea = all;
                }
                field(Company2; Rec.FBM_Company2)
                {
                    ApplicationArea = all;
                }
                field(Company3; Rec.FBM_Company3)
                {
                    ApplicationArea = all;
                }
                field(Blocked; rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies which transactions with the customer that cannot be processed, for example, because the customer is insolvent.';
                }
                field("Privacy Blocked"; rec."Privacy Blocked")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the code for the responsibility center that will administer this customer by default.';
                }
                field("Service Zone Code"; rec."Service Zone Code")
                {
                    ApplicationArea = Service;
                    Importance = Additional;
                    ToolTip = 'Specifies the code for the service zone that is assigned to the customer.';
                }
                field("Document Sending Profile"; rec."Document Sending Profile")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the preferred method of sending documents to this customer, so that you do not have to select a sending option every time that you post and send a document to the customer. Sales documents to this customer will be sent using the specified sending profile and will override the default document sending profile.';
                }

                field("Last Date Modified"; rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies when the customer card was last modified.';
                }
                field("Disable Search by Name"; rec."Disable Search by Name")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies that you can change the customer name on open sales documents. The change applies only to the documents.';
                }
            }
            group("Address & Contact")
            {
                Caption = 'Address & Contact';
                group(AddressDetails)
                {
                    Caption = 'Address';
                    field(Address; rec.Address)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
                    }
                    field("Address 2"; rec."Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Country/Region Code"; rec."Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible := FormatAddress.UseCounty(rec."Country/Region Code");
                        end;
                    }
                    field(City; rec.City)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the customer''s city.';
                    }
                    group(Control10)
                    {
                        ShowCaption = false;
                        Visible = IsCountyVisible;
                        field(County; rec.County)
                        {
                            ApplicationArea = Basic, Suite;
                            ToolTip = 'Specifies the state, province or county as a part of the address.';
                        }
                    }
                    field("Post Code"; rec."Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field(ShowMap; ShowMapLbl)
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ToolTip = 'Specifies the customer''s address on your preferred map website.';

                        trigger OnDrillDown()
                        begin
                            CurrPage.Update(true);
                            rec.DisplayMap;
                        end;
                    }
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s telephone number.';
                }
                field(MobilePhoneNo; rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = PhoneNo;
                    ToolTip = 'Specifies the customer''s mobile telephone number.';
                }
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                    ToolTip = 'Specifies the customer''s email address.';
                }
                field("Fax No."; rec."Fax No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the customer''s fax number.';
                }
                field("Home Page"; rec."Home Page")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s home page address.';
                }
                field("Language Code"; rec."Language Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the language to be used on printouts for this customer.';
                }
                group(ContactDetails)
                {
                    Caption = 'Contact';
                    field("Primary Contact No."; rec."Primary Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the contact number for the customer.';
                    }
                    field(ContactName; rec.Contact)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact Name';
                        Editable = ContactEditable;
                        Importance = Promoted;
                        ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';

                        trigger OnValidate()
                        begin
                            ContactOnAfterValidate;
                        end;
                    }
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                AboutTitle = 'Manage the customer''s invoicing';
                AboutText = 'Specify tax settings and choose how invoicing takes place for the customer. Assign posting groups to control how the customer''s transactions are grouped and posted, based on type of trade or market.';

                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bill-to Customer';
                    Importance = Additional;
                    ToolTip = 'Specifies a different customer who will be invoiced for products that you sell to the customer in the Name field on the customer card.';
                }
                field("VAT Registration No."; rec."VAT Registration No.")
                {
                    ApplicationArea = VAT;
                    ToolTip = 'Specifies the customer''s VAT registration number for customers in EU countries/regions.';

                    trigger OnDrillDown()
                    var
                        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
                    begin
                        //VATRegistrationLogMgt.AssistEditCustomerVATReg(Rec);
                    end;
                }
                field("EORI Number"; rec."EORI Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Economic Operators Registration and Identification number that is used when you exchange information with the customs authorities due to trade into or out of the European Union.';
                }
                field(GLN; rec.GLN)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the customer in connection with electronic document sending.';
                }
                field("Use GLN in Electronic Document"; rec."Use GLN in Electronic Document")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether the GLN is used in electronic documents as a party identification number.';
                }
                field("Copy Sell-to Addr. to Qte From"; rec."Copy Sell-to Addr. to Qte From")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies which customer address is inserted on sales quotes that you create for the customer.';
                }
                field("Tax Liable"; rec."Tax Liable")
                {
                    ApplicationArea = SalesTax;
                    ToolTip = 'Specifies if the customer or vendor is liable for sales tax.';
                }
                field("Tax Area Code"; rec."Tax Area Code")
                {
                    ApplicationArea = SalesTax;
                    ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';
                }
                group(PostingDetails)
                {
                    Caption = 'Posting Details';
                    field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the customer''s trade type to link transactions made for this customer with the appropriate general ledger account according to the general posting setup.';
                    }
                    field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ToolTip = 'Specifies the customer''s VAT specification to link transactions made for this customer to.';
                    }
                    field("Customer Posting Group"; rec."Customer Posting Group")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the customer''s market type to link business transactions to.';
                    }
                }
                group(PricesandDiscounts)
                {
                    Caption = 'Prices and Discounts';
                    field("Currency Code"; rec."Currency Code")
                    {
                        ApplicationArea = Suite;
                        Importance = Additional;
                        ToolTip = 'Specifies the default currency for the customer.';
                    }
                    field("Price Calculation Method"; rec."Price Calculation Method")
                    {
                        Visible = ExtendedPriceEnabled;
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the default price calculation method.';
                    }
                    field("Customer Price Group"; rec."Customer Price Group")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the customer price group code, which you can use to set up special sales prices in the Sales Prices window.';
                    }
                    field("Customer Disc. Group"; rec."Customer Disc. Group")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the customer discount group code, which you can use as a criterion to set up special discounts in the Sales Line Discounts window.';
                    }
                    field("Allow Line Disc."; rec."Allow Line Disc.")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ToolTip = 'Specifies if a sales line discount is calculated when a special sales price is offered according to setup in the Sales Prices window.';
                    }
                    field("Invoice Disc. Code"; rec."Invoice Disc. Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        NotBlank = true;
                        ToolTip = 'Specifies a code for the invoice discount terms that you have defined for the customer.';
                    }
                    field("Prices Including VAT"; rec."Prices Including VAT")
                    {
                        ApplicationArea = VAT;
                        Importance = Additional;
                        ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';
                    }
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                AboutTitle = 'Manage the customer''s payment';
                AboutText = 'Specify the customer''s default payment terms and settings for how payments from the customer is processed.';

                field("Prepayment %"; rec."Prepayment %")
                {
                    ApplicationArea = Prepayments;
                    Importance = Additional;
                    ToolTip = 'Specifies a prepayment percentage that applies to all orders for this customer, regardless of the items or services on the order lines.';
                }
                field("Application Method"; rec."Application Method")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how to apply payments to entries for this customer.';
                }
                field("Partner Type"; rec."Partner Type")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies for direct debit collections if the customer that the payment is collected from is a person or a company.';
                }
                field("Intrastat Partner Type"; Rec."Intrastat Partner Type")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies for Intrastat reporting if the customer is a person or a company.';
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies a code that indicates the payment terms that you require of the customer.';
                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how the customer usually submits payment, such as bank transfer or check.';
                }
                field("Reminder Terms Code"; rec."Reminder Terms Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how reminders about late payments are handled for this customer.';
                }
                field("Fin. Charge Terms Code"; rec."Fin. Charge Terms Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies finance charges are calculated for the customer.';
                }
                field("Cash Flow Payment Terms Code"; rec."Cash Flow Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies a payment term that will be used to calculate cash flow for the customer.';
                }
                field("Print Statements"; rec."Print Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to include this customer when you print the Statement report.';
                }
                field("Last Statement No."; rec."Last Statement No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the last statement that was printed for this customer.';
                }
                field("Block Payment Tolerance"; rec."Block Payment Tolerance")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies that the customer is not allowed a payment tolerance.';
                }
                field("Preferred Bank Account Code"; rec."Preferred Bank Account Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the customer''s bank account that will be used by default when you process refunds to the customer and direct debit collections.';
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = Location;
                    Importance = Promoted;
                    ToolTip = 'Specifies from which location sales to this customer will be processed by default.';
                }
                field("Combine Shipments"; rec."Combine Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if several orders delivered to the customer can appear on the same sales invoice.';
                }
                field(Reserve; rec.Reserve)
                {
                    ApplicationArea = Reservation;
                    ToolTip = 'Specifies whether items will never, automatically (Always), or optionally be reserved for this customer.';
                }
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies if the customer accepts partial shipment of orders.';
                }
                group("Shipment Method")
                {
                    Caption = 'Shipment Method';
                    field("Shipment Method Code"; rec."Shipment Method Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Code';
                        Importance = Promoted;
                        ToolTip = 'Specifies which shipment method to use when you ship items to the customer.';
                    }
                    field("Shipping Agent Code"; rec."Shipping Agent Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Agent';
                        Importance = Additional;
                        ToolTip = 'Specifies which shipping company is used when you ship items to the customer.';
                    }
                    field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Agent Service';
                        Importance = Additional;
                        ToolTip = 'Specifies the code for the shipping agent service to use for this customer.';
                    }
                }
                field("Shipping Time"; rec."Shipping Time")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how long it takes from when the items are shipped from the warehouse to when they are delivered.';
                }
                field("Base Calendar Code"; rec."Base Calendar Code")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    ToolTip = 'Specifies a customizable calendar for shipment planning that holds the customer''s working days and holidays.';
                }
                field("Customized Calendar"; format(HasCustomBaseCalendar))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customized Calendar';
                    Editable = false;
                    ToolTip = 'Specifies that you have set up a customized version of a base calendar.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        rec.TestField("Base Calendar Code");
                        CalendarMgmt.ShowCustomizedCalendar(Rec);
                    end;
                }
            }
        }

        area(factboxes)
        {
            part(Control149; "Customer Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
                Visible = NOT IsOfficeAddin;
            }

            part(Details; "Office Customer Details")
            {
                ApplicationArea = All;
                Caption = 'Details';
                SubPageLink = "No." = FIELD("No.");
                Visible = IsOfficeAddin;
            }










        }
    }

    actions
    {


    }

    trigger OnAfterGetCurrRecord()
    begin
        if GuiAllowed() then
            OnAfterGetCurrRecordFunc();
    end;

    local procedure OnAfterGetCurrRecordFunc()
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        if NewMode then
            CreateCustomerFromTemplate()
        else
            StartBackgroundCalculations();
        ActivateFields();


        if CRMIntegrationEnabled or CDSIntegrationEnabled then begin
            CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(rec.RecordId);
            if rec."No." <> xRec."No." then
                CRMIntegrationManagement.SendResultNotification(Rec);
        end;
        WorkflowWebhookManagement.GetCanRequestAndCanCancel(rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        if AnyWorkflowExists then begin
            CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RecordId);
            WorkflowStepInstance.SetRange("Record ID", rec.RecordId);
            ShowWorkflowStatus := not WorkflowStepInstance.IsEmpty();

            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RecordId);
            if OpenApprovalEntriesExist then
                OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId)
            else
                OpenApprovalEntriesExistCurrUser := false;
        end;
    end;

    trigger OnInit()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        PrevCountryCode := '*';
        FoundationOnly := ApplicationAreaMgmtFacade.IsFoundationEnabled;

        ContactEditable := true;

        OpenApprovalEntriesExistCurrUser := true;

        CaptionTxt := CurrPage.Caption;
        //SetCaption(CaptionTxt);
        CurrPage.Caption(CaptionTxt);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        if GuiAllowed then
            if rec."No." = '' then
                if DocumentNoVisibility.CustomerNoSeriesIsDefault then
                    NewMode := true;
    end;

    trigger OnOpenPage()
    begin
        if Rec.GetFilter("Date Filter") = '' then
            rec.SetRange("Date Filter", 0D, WorkDate());
        if GuiAllowed() then
            OnOpenPageFunc();
        OnAfterOnOpenPage(Rec, xRec);
    end;

    local procedure OnOpenPageFunc()
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        EnvironmentInfo: Codeunit "Environment Information";
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        OfficeManagement: Codeunit "Office Management";
    begin
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();
        if CRMIntegrationEnabled or CDSIntegrationEnabled then
            if IntegrationTableMapping.Get('CUSTOMER') then
                BlockedFilterApplied := IntegrationTableMapping.GetTableFilter().Contains('Field39=1(0)');
        ExtendedPriceEnabled := PriceCalculationMgt.IsExtendedPriceCalculationEnabled();

        OnBeforeGetSalesPricesAndSalesLineDisc(LoadOnDemand);
        SetNoFieldVisible();

        IsSaaS := EnvironmentInfo.IsSaaS();
        IsOfficeAddin := OfficeManagement.IsAvailable;
        WorkFlowEventFilter :=
            WorkflowEventHandling.RunWorkflowOnSendCustomerForApprovalCode + '|' +
            WorkflowEventHandling.RunWorkflowOnCustomerChangedCode;

        SetWorkFlowEnabled();
    end;

    local procedure StartBackgroundCalculations()
    var
        CustomerCardCalculations: Codeunit "Customer Card Calculations";
        Args: Dictionary of [Text, Text];
    begin
        if Rec."No." = PrevCustNo then
            exit;
        PrevCustNo := Rec."No.";
        if (BackgroundTaskId <> 0) then
            CurrPage.CancelBackgroundTask(BackgroundTaskId);

        DaysPastDueDate := 0;
        ExpectedMoneyOwed := 0;
        AvgDaysToPay := 0;
        TotalMoneyOwed := 0;
        AttentionToPaidDay := false;
        AmountOnPostedInvoices := 0;
        AmountOnPostedCrMemos := 0;
        AmountOnOutstandingInvoices := 0;
        AmountOnOutstandingCrMemos := 0;
        Totals := 0;
        AdjmtCostLCY := 0;
        AdjCustProfit := 0;
        AdjProfitPct := 0;
        CustInvDiscAmountLCY := 0;
        CustPaymentsLCY := 0;
        CustSalesLCY := 0;
        CustProfit := 0;
        NoPostedInvoices := 0;
        NoPostedCrMemos := 0;
        NoOutstandingInvoices := 0;
        NoOutstandingCrMemos := 0;
        OverdueBalance := 0;
        LinkedVendorNo := '';
        BalanceAsVendor := 0;
        BalanceAsVendorEnabled := false;

        // Args.Add(CustomerCardCalculations.GetCustomerNoLabel(), "No.");
        // Args.Add(CustomerCardCalculations.GetFiltersLabel(), GetView());
        // Args.Add(CustomerCardCalculations.GetWorkDateLabel(), Format(WorkDate()));

        CurrPage.EnqueueBackgroundTask(BackgroundTaskId, Codeunit::"Customer Card Calculations", Args);

        Session.LogMessage('0000D4Q', StrSubstNo(PageBckGrndTaskStartedTxt, rec."No."), Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CustomerCardServiceCategoryTxt);
    end;


    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        CustomerCardCalculations: Codeunit "Customer Card Calculations";
        DictionaryValue: Text;
    begin
        if (TaskId = BackgroundTaskId) then begin
            if Results.Count() = 0 then
                exit;


            AttentionToPaidDay := DaysPastDueDate > 0;

            Session.LogMessage('0000D4R', PageBckGrndTaskCompletedTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CustomerCardServiceCategoryTxt);
        end;
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CustomerMgt: Codeunit "Customer Mgt.";
        FormatAddress: Codeunit "Format Address";
        LinkedVendorNo: Code[20];
        BalanceAsVendor: Decimal;
        StyleTxt: Text;
        CRMIntegrationEnabled: Boolean;
        CDSIntegrationEnabled: Boolean;
        BlockedFilterApplied: Boolean;
        ExtendedPriceEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        NoFieldVisible: Boolean;
        BalanceExhausted: Boolean;
        AttentionToPaidDay: Boolean;
        Totals: Decimal;
        AmountOnPostedInvoices: Decimal;
        AmountOnPostedCrMemos: Decimal;
        AmountOnOutstandingInvoices: Decimal;
        AmountOnOutstandingCrMemos: Decimal;
        AdjmtCostLCY: Decimal;
        AdjCustProfit: Decimal;
        CustProfit: Decimal;
        AdjProfitPct: Decimal;
        CustInvDiscAmountLCY: Decimal;
        CustPaymentsLCY: Decimal;
        CustSalesLCY: Decimal;
        OverdueBalance: Decimal;
        OverduePaymentsMsg: Label 'Overdue Payments';
        DaysPastDueDate: Decimal;
        PostedInvoicesMsg: Label 'Posted Invoices (%1)', Comment = 'Invoices (5)';
        CreditMemosMsg: Label 'Posted Credit Memos (%1)', Comment = 'Credit Memos (3)';
        OutstandingInvoicesMsg: Label 'Ongoing Invoices (%1)', Comment = 'Ongoing Invoices (4)';
        OutstandingCrMemosMsg: Label 'Ongoing Credit Memos (%1)', Comment = 'Ongoing Credit Memos (4)';
        ShowMapLbl: Label 'Show on Map';
        CustomerCardServiceCategoryTxt: Label 'Customer Card', Locked = true;
        PageBckGrndTaskStartedTxt: Label 'Page Background Task to calculate customer statistics for customer %1 started.', Locked = true, Comment = '%1 = Customer No.';
        PageBckGrndTaskCompletedTxt: Label 'Page Background Task to calculate customer statistics completed successfully.', Locked = true;
        ExpectedMoneyOwed: Decimal;
        TotalMoneyOwed: Decimal;
        AvgDaysToPay: Decimal;
        FoundationOnly: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        AnyWorkflowExists: Boolean;
        NewMode: Boolean;
        WorkFlowEventFilter: Text;
        CaptionTxt: Text;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        IsSaaS: Boolean;
        IsCountyVisible: Boolean;
        StatementFileNameTxt: Label 'Statement', Comment = 'Shortened form of ''Customer Statement''';
        LoadOnDemand: Boolean;
        PrevCustNo: Code[20];
        PrevCountryCode: Code[10];
        BackgroundTaskId: Integer;
        BalanceAsVendorEnabled: Boolean;

    protected var
        [InDataSet]
        ContactEditable: Boolean;
        IsOfficeAddin: Boolean;
        NoPostedInvoices: Integer;
        NoPostedCrMemos: Integer;
        NoOutstandingInvoices: Integer;
        NoOutstandingCrMemos: Integer;

    [TryFunction]
    local procedure TryGetDictionaryValueFromKey(var DictionaryToLookIn: Dictionary of [Text, Text]; KeyToSearchFor: Text; var ReturnValue: Text)
    begin
        ReturnValue := DictionaryToLookIn.Get(KeyToSearchFor);
    end;

    local procedure SetWorkFlowEnabled()
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        AnyWorkflowExists := WorkflowManagement.AnyWorkflowExists();
        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Customer, WorkFlowEventFilter);
    end;

    local procedure ActivateFields()
    begin
        ContactEditable := rec."Primary Contact No." = '';
        if rec."Country/Region Code" <> PrevCountryCode then
            IsCountyVisible := FormatAddress.UseCounty(rec."Country/Region Code");
        PrevCountryCode := rec."Country/Region Code";
        OnAfterActivateFields(Rec);
    end;



    local procedure HasCustomBaseCalendar(): Boolean
    begin
        if rec."Base Calendar Code" = '' then
            exit(false)
        else
            exit(CalendarMgmt.CustomizedChangesExist(Rec));
    end;

    local procedure ContactOnAfterValidate()
    begin
        ActivateFields;
    end;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.CustomerNoIsVisible;
    end;

    procedure RunReport(ReportNumber: Integer; CustomerNumber: Code[20])
    var
        Customer: Record Customer;
    begin
        Customer.SetRange("No.", CustomerNumber);
        REPORT.RunModal(ReportNumber, true, true, Customer);
    end;

    local procedure CreateCustomerFromTemplate()
    var
        Customer: Record FBM_Customer;
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
    begin
        OnBeforeCreateCustomerFromTemplate(NewMode, Customer);

        if not NewMode then
            exit;
        NewMode := false;

        // if CustomerTemplMgt.InsertCustomerFromTemplate(Customer) then begin
        //     VerifyVatRegNo(Customer);
        //     Copy(Customer);
        //     CurrPage.Update();
        // end else
        //     if CustomerTemplMgt.TemplatesAreNotEmpty() then
        //         if not CustomerTemplMgt.IsOpenBlankCardConfirmed() then
        CurrPage.Close;
    end;

    local procedure VerifyVatRegNo(var Customer: Record Customer)
    var
        VATRegNoSrvConfig: Record "VAT Reg. No. Srv Config";
        EUVATRegistrationNoCheck: Page "EU VAT Registration No Check";
        CustomerRecRef: RecordRef;
    begin
        if VATRegNoSrvConfig.VATRegNoSrvIsEnabled then
            if Customer."Validate EU Vat Reg. No." then begin
                EUVATRegistrationNoCheck.SetRecordRef(Customer);
                Commit();
                EUVATRegistrationNoCheck.RunModal();
                EUVATRegistrationNoCheck.GetRecordRef(CustomerRecRef);
                CustomerRecRef.SetTable(Customer);
            end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterActivateFields(var Customer: Record FBM_Customer)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterOnOpenPage(var Customer: Record FBM_Customer; xCustomer: Record FBM_Customer)
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure SetCaption(var InText: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateCustomerFromTemplate(var NewMode: Boolean; var Customer: Record FBM_Customer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetSalesPricesAndSalesLineDisc(var LoadOnDemand: Boolean)
    begin
    end;
}

