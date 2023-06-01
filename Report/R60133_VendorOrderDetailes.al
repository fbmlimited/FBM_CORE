report 60133 "FBM_Vendor Order Detailes_CO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Vendor Order Detailes.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "Buy-from Vendor No.", "No.", "Posting Date";
            column(No_PurchaseHeader; "No.")
            {
            }
            column(PostingDate_PurchaseHeader; "Posting Date")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Type", "No.")
                                    WHERE(Quantity = FILTER(> 0));
                column(DocumentType_PurchaseLine; "Document Type")
                {
                }
                column(Type_PurchaseLine; Type)
                {
                }
                column(No_PurchaseLine; "No.")
                {
                }
                column(Description_PurchaseLine; Description)
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(DirectUnitCost_PurchaseLine; "Direct Unit Cost")
                {
                }
                column(LineDiscount_PurchaseLine; "Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Line Discount Amount")
                {
                }
                column(AmountIncludingVAT_PurchaseLine; "Amount Including VAT")
                {
                }
                column(InvDiscountAmount_PurchaseLine; "Inv. Discount Amount")
                {
                }
                dataitem("Reservation Entry"; "Reservation Entry")
                {
                    DataItemLink = "Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Entry No.", "Positive");
                    column(LotNo_ReservationEntry; "Serial No.")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        IF NOT FirstLine THEN BEGIN
                            "Purchase Line".Quantity := 0;
                            "Purchase Line"."Amount Including VAT" := 0;
                        END;
                        FirstLine := FALSE;
                    end;

                    trigger OnPreDataItem();
                    begin
                        FirstLine := TRUE
                    end;
                }
            }
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
        FirstLine: Boolean;
}

