

report 60143 FBM_SalesReportNP_CO
{
    DefaultLayout = RDLC;
    UsageCategory = Administration;
    RDLCLayout = './RDLC/R60143_SalesReportNP.rdl';
    ApplicationArea = All;
    Caption = 'Sales Report Not Posted New';

    dataset
    {

        dataitem(salesinvoiceline; "Sales Line")
        {
            RequestFilterFields = "Posting Date", "Sell-to customer no.";

            column(invpostingdate; format(invheader."Posting Date"))
            {

            }
            column(filters; filters)
            {

            }
            column(doctype; invheader."Document Type")
            {

            }

            column(compname; compinfo.Name)
            {

            }
            column(invdocumentno; "Document No.")
            {

            }
            column(invNo; "No.")
            {

            }
            column(invDescr; "Description")
            {

            }
            column(invGenBUsPost; "Gen. Bus. Posting Group")
            {

            }
            column(invenProd; "Gen. Prod. Posting Group")
            {

            }
            column(invamount; "Amount")
            {

            }
            column(invperiodstart; format("FBM_Period Start"))
            {

            }
            column(invperiodend; format("FBM_Period End"))
            {

            }
            column(invglaccountname; invglaccountname)
            {

            }

            column(invContract; invContract)
            {

            }
            column(invsite; invsite)
            {

            }
            column(Grouping; Grouping)
            { }
            column(Summary; summary)
            { }

            trigger OnPreDataItem()
            begin
                salesinvoiceline.SetFilter("Document Type", '%1|%2', salesinvoiceline."Document Type"::Invoice, salesinvoiceline."Document Type"::"Credit Memo");
                filters := salesinvoiceline.GetFilters();
                if (filters <> '') then begin

                end;
                compinfo.get();
            end;

            trigger OnAfterGetRecord()




            begin
                grouping := '';
                if summary then
                    grouping := salesinvoiceline."Document No."
                else
                    grouping := salesinvoiceline."Document No." + format(salesinvoiceline."Line No.");
                invsite := '';
                invContract := '';
                invglaccountname := '';
                invsite := salesinvoiceline.FBM_Site;
                invheader.SetRange("No.", salesinvoiceline."Document No.");
                if invheader.FindFirst() then begin
                    invsite := invheader.FBM_Site;
                    invContract := invheader."FBM_Contract Code";
                end;
                if glaccount.Get("No.") then begin
                    invglaccountname := glaccount.Name;
                end;

            end;

        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Summary; summary)
                    {
                        ApplicationArea = All;
                        caption = 'Summary';

                    }

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        invheader: Record "Sales Header";

        invsite: Code[50];
        invContract: Code[50];
        glaccount: Record "G/L Account";
        invglaccountname: Text;
        filters: Text;

        compinfo: Record "Company Information";

        crmemosite: Code[50];
        crmemoContract: Code[50];
        crmemoglaccountname: Text;
        summary: boolean;
        Grouping: text[100];
}