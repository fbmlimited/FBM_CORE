page 60137 FBM_CustListMaster_CO
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Customer Master List RO';
    CardPageID = FBM_CustCardMaster_DD;
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;
    PageType = List;



    SourceTable = FBM_Customer;
    UsageCategory = Lists;



    layout
    {
        area(content)
        {

            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name. This name will appear on all sales documents for the customer.';
                }
                field("Name 2"; rec."Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies an additional part of the name.';
                    Visible = false;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies from which location sales to this customer will be processed by default.';
                }
                field("Post Code"; rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code.';
                    Visible = false;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                    Visible = false;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s telephone number.';
                }
                field(Contact; rec.Contact)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';
                    Visible = false;
                }
                field("Customer Posting Group"; rec."Customer Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s market type to link business transactions to.';
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s trade type to link transactions made for this customer with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    Visible = false;
                }
                field("Customer Price Group"; rec."Customer Price Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer price group code, which you can use to set up special sales prices in the Sales Prices window.';
                    Visible = false;
                }
                field("Customer Disc. Group"; rec."Customer Disc. Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer discount group code, which you can use as a criterion to set up special discounts in the Sales Line Discounts window.';
                    Visible = false;
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                    Visible = false;
                }
                field("Reminder Terms Code"; rec."Reminder Terms Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies how reminders about late payments are handled for this customer.';
                    Visible = false;
                }
                field("Fin. Charge Terms Code"; rec."Fin. Charge Terms Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the involved finance charges in case of late payment.';
                    Visible = false;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the default currency for the customer.';
                    Visible = false;
                }
                field("Language Code"; rec."Language Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the language that is used when translating specified text on documents to foreign business partner, such as an item description on an order confirmation.';
                    Visible = false;
                }
                field("Search Name"; rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                    Visible = false;
                }
                field("Credit Limit (LCY)"; rec."Credit Limit (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                    Visible = false;
                }
                field(Blocked; rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                    Visible = false;
                }
                field("Privacy Blocked"; rec."Privacy Blocked")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                    Visible = false;
                }
                field("Last Date Modified"; rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the customer card was last modified.';
                    Visible = false;
                }
                field("Application Method"; rec."Application Method")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how to apply payments to entries for this customer.';
                    Visible = false;
                }
                field("Combine Shipments"; rec."Combine Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if several orders delivered to the customer can appear on the same sales invoice.';
                    Visible = false;
                }
                field(Reserve; rec.Reserve)
                {
                    ApplicationArea = Reservation;
                    ToolTip = 'Specifies whether items will never, automatically (Always), or optionally be reserved for this customer. Optional means that you must manually reserve items for this customer.';
                    Visible = false;
                }
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';
                    Visible = false;
                }
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the customer accepts partial shipment of orders.';
                    Visible = false;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                    Visible = false;
                }
                field("Base Calendar Code"; rec."Base Calendar Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a customizable calendar for shipment planning that holds the customer''s working days and holidays.';
                    Visible = false;
                }


                field(FBM_Group; Rec.FBM_Group)
                {
                    ApplicationArea = All;

                }
                field(FBM_SubGroup; Rec.FBM_SubGroup)
                {
                    ApplicationArea = All;

                }
            }
        }
    }






}

