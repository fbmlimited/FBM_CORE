report 60109 FBM_EPS_PurchInvoiceBook_CO
{
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/R50037_EPS_PurchInvoiceBook.rdl';
    Caption = 'Libro Compras';
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = sorting("No.");
            column(datefrom; datefrom)
            {

            }
            column(dateto; dateto)
            {

            }
            column(classinvoice; format(classinvoice))
            {

            }
            column(Order_No_; ordenno)
            {

            }
            column(No_; "No.")
            {

            }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(Posting_Description; "Posting Description")
            {

            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }





            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLink = "Document No." = field("No.");
                column(Line_Amount; "Line Amount")
                {

                }
                column(VAT__; "VAT %")
                {

                }
                column(cuota; "Line Amount" * "VAT %" / 100)
                {

                }
                column(Retencion; Retencion)
                {

                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {

                }


                trigger
                OnPreDataItem()
                begin
                    Retencion := 0;
                end;

                trigger
                OnAfterGetRecord()
                begin
                    if copystr("Purch. Inv. Line"."No.", 1, 4) = '4751' then
                        Retencion += "Purch. Inv. Line"."Line Amount";
                    if classinvoice <> oldclass then
                        ordenno := 1
                    else
                        ordenno += 1;
                    oldclass := classinvoice;
                end;
            }
            trigger
            OnPreDataItem()
            begin
                "Purch. Inv. Header".SetRange("Posting Date", datefrom, dateto);
            end;

            trigger
            OnAfterGetRecord()
            var
                country: record "Country/Region";
            begin
                classinvoice := classinvoice::" ";
                if ("Buy-from Country/Region Code" = 'ES') or ("Buy-from Country/Region Code" = '') then
                    classinvoice := classinvoice::FACN
                else
                    if country.get("Purch. Inv. Header"."Buy-from Country/Region Code") then
                        if country."EU Country/Region Code" = '' then
                            classinvoice := classinvoice::SUJP
                        else
                            classinvoice := classinvoice::IMPO;



            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filtros)
                {
                    field(datefrom; datefrom)
                    {
                        Caption = 'Fecha Inicio';
                        ApplicationArea = All;

                    }
                    field(dateto; dateto)
                    {
                        Caption = 'Fecha Fin';
                        ApplicationArea = All;

                    }
                }
            }
        }
    }
    var
        Retencion: Decimal;
        classinvoice: option " ",FACN,SUJP,IMPO;
        datefrom: Date;
        dateto: Date;
        OrdenNo: integer;
        oldclass: option " ",FACN,SUJP,IMPO;
}