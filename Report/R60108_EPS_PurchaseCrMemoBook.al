report 60108 FBM_EPS_PurchCrMemoBook_CO
{
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/R50038_EPS_PurchCrMemoBook.rdl';
    Caption = 'Libro Compras - Rectificaciones';
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
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
            column(Vendor_Cr__Memo_No_; "Vendor Cr. Memo No.")
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





            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
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
                    if copystr("Purch. Cr. Memo Line"."No.", 1, 4) = '4751' then
                        Retencion += "Purch. Cr. Memo Line"."Line Amount";
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
                "Purch. Cr. Memo Hdr.".SetRange("Posting Date", datefrom, dateto);
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
                    if country.get("Purch. Cr. Memo Hdr."."Buy-from Country/Region Code") then
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