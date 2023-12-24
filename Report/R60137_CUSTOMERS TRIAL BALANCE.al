report 60137 "FBM_CUSTOMERS TRIAL BALANCE_CO"
{
    // version NAVW17.10

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Report 50018 CUSTOMERS TRIAL BALANCE.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'CUSTOMERS TRIAL BALANCE';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DataItem23; Customer)
        {
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code";

            dataitem(DataItem1; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                    ORDER(Ascending);
                RequestFilterFields = "Customer No.";
                column(currcode; currcode)
                {
                }
                column(vendno; "Customer No.")
                {
                }
                column(documentno; "Document No.")
                {
                }
                column(postingdate; FORMAT("Posting Date"))
                {
                }
                column(amount; Amount)
                {
                }
                column(beforeperiod; beforeperiod)
                {
                }
                column(fromdate; FORMAT(fromdate))
                {
                }
                column(todate; FORMAT(todate))
                {
                }
                column(filters; GETFILTERS())
                {
                }
                column(desc; Description)
                {
                }
                column(doctype; FORMAT("Document Type"))
                {
                }
                column(vendname; vend.Name)
                {
                }
                column(amountlcy; "Amount (LCY)")
                {
                }
                column(DebitAmount; "Debit Amount")
                {
                }
                column(CreditAmount; "Credit Amount")
                {
                }
                column(CompName; comp.Name)
                {
                }
                column(CompAddrese; comp.Address)
                {
                }
                column(CompPhone; comp."Phone No.")
                {
                }

                column(CompMail; comp."E-Mail")
                {
                }
                column(ExternalDocumentNo_CustLedgerEntry; "External Document No.")
                {
                }
                column(detail; Detail)
                {
                }
                column(Customer_Posting_Group; "Customer Posting Group")
                {
                }
                // column(sitecode; site."Site Code")
                // {

                // }
                // column(sitename; site."Site Name")
                // { }
                trigger OnAfterGetRecord();
                var
                    inv: Record "Sales Invoice Header";
                    crm: Record "Sales Cr.Memo Header";
                begin
                    beforeperiod := FALSE;
                    IF ("Posting Date" < fromdate) THEN
                        beforeperiod := TRUE;

                    currcode := "Currency Code";
                    //IF currcode = '' THEN currcode := 'ALL';

                    IF vend.GET("Customer No.") THEN;
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

                trigger OnPreDataItem();
                begin
                    SETRANGE("Posting Date", 0D, todate);
                    comp.GET;
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
                field(fromdate; fromdate)
                {
                    Caption = 'From date:';
                    ApplicationArea = all;
                }
                field(todate; todate)
                {
                    Caption = 'To date:';
                    ApplicationArea = all;
                }
                field(Detail; Detail)
                {
                    CaptionML = ENU = 'Detail';
                    ApplicationArea = all;

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        Detail := TRUE;
    end;

    trigger OnPreReport();
    begin
        IF (fromdate = 0D) OR (todate = 0D) THEN
            ERROR('Plotesoni datat!');
    end;

    var
        fromdate: Date;
        todate: Date;
        beforeperiod: Boolean;
        currcode: Code[20];
        vend: Record Customer;
        comp: Record "Company Information";
        Detail: Boolean;
        site: Record FBM_CustomerSite_C;
}

