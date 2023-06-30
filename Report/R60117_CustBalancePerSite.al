report 60117 CustBalancePerSite
{
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/R50001-CustBalancePerSite.rdl';
    Caption = 'Customer Balance per Site';
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Customer-Site";
        FBM_CustomerSite_C)
        {
            RequestFilterFields = "Customer No.", "Site Code";

            column(Customer_No_;
            "Customer No.")
            {
            }
            column(Site_Code;
            "Site Code")
            {
            }
            column(Site_Name;
            "Site Name_FF")
            {
            }
            column(CustName;
            Cust.Name)
            {
            }
            column(showDetails;
            showDetails)
            {
            }
            column(Contract_Code;
            "Contract Code")
            {
            }
            dataitem("Cust. Ledger Entry";
            "Cust. Ledger Entry")
            {
                DataItemLinkReference = "Customer-Site";
                DataItemLink = "Customer No." = FIELD("Customer No.");

                column(Document_No_;
                "Document No.")
                {
                }
                column(Document_Type;
                "Document Type")
                {
                }
                column(Description;
                Description)
                {
                }
                column(Remaining_Amt___LCY_;
                "Remaining Amt. (LCY)")
                {
                }
                column(Posting_Date;
                "Posting Date")
                {
                }
                trigger OnAfterGetRecord()
                var
                    DimSetEntry: Record "Dimension Set Entry";
                    FASetup: Record "FA Setup";
                begin
                    FASetup.Get();
                    CalcFields("Remaining Amt. (LCY)");
                    if "Remaining Amt. (LCY)" = 0 then CurrReport.Skip();
                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", "Cust. Ledger Entry"."Dimension Set ID");
                    DimSetEntry.SetFilter("Dimension Code", FASetup."FBM_Site Dimension");
                    if not DimSetEntry.FindFirst() then
                        CurrReport.Skip()
                    else begin
                        if DimSetEntry."Dimension Value Code" <> "Customer-Site"."Site Code" then CurrReport.Skip();
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                prevCust := Cust;
                if "Customer-Site"."Customer No." <> '' then begin
                    Cust.Get("Customer-Site"."Customer No.");
                    if CustPostingGrp <> '' then begin
                        if Cust."Customer Posting Group" <> CustPostingGrp then CurrReport.Skip;
                    end;
                end;
                if Format(Cust) <> Format(prevCust) then
                    showDetails := true
                else
                    showDetails := false;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field("Customer Posting Group"; CustPostingGrp)
                    {
                        ApplicationArea = All;
                        TableRelation = "Customer Posting Group".Code;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
        CustNoLbl = 'Customer No.';
        CustNameLbl = 'Customer Name';
        DocTypeLbl = 'Document Type';
        DocNumberLbl = 'Document No.';
        PostingDateLbl = 'Posting Date';
        DescriptionLbl = 'Description';
        AmountLbl = 'Amount';
        TotalLbl = 'Total';
        GrandTotalLbl = 'Grand Total';
        ContractLbl = 'Contract';
    }
    var
        Cust: Record Customer;
        prevCust: Record Customer;
        showDetails: Boolean;
        CustPostingGrp: code[20];
        CPG: Record "Customer Posting Group";

    trigger OnInitReport()
    begin
        Clear(CustPostingGrp);
        CustPostingGrp := CPG.Code;
    end;
}
