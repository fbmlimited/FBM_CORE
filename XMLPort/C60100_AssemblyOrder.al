xmlport 60100 FBM_AssemblyOrderExport_CO
{
    Direction = Export;
    Format = Xml;
    Encoding = UTF8;

    schema
    {

        tableelement(AssemblyHeader; "Posted Assembly Header")
        {
            MaxOccurs = Once;


            fieldelement(No; AssemblyHeader."No.")
            {

            }
            fieldelement("OrderNo"; AssemblyHeader."Order No.")
            {

            }
            fieldelement("ItemNo"; AssemblyHeader."Item No.")
            {

            }

            fieldelement("ItemDescription"; AssemblyHeader."Description")
            {

            }
            fieldelement("ItemQuantity"; AssemblyHeader.Quantity)
            {

            }
            tableelement(ItemSerial; "Item Ledger Entry")
            {
                LinkTable = AssemblyHeader;
                LinkFields = "Document No." = field("No."), "Entry Type" = filter("Assembly Output"),
                     "Item No." = field("Item No.");

                fieldelement("SerialNo"; ItemSerial."Serial No.")
                {

                }
                fieldelement("Quantity"; ItemSerial.Quantity)
                {

                }
            }

            tableelement(AssemblyLine; "Posted Assembly Line")
            {
                LinkTable = AssemblyHeader;
                LinkFields = "Document No." = field("No.");
                fieldelement("ComponentItemNo"; AssemblyLine."No.")
                {

                }

                fieldelement("ComponentDescription"; AssemblyLine.Description)
                {

                }
                fieldelement("ComponentQty"; AssemblyLine.Quantity)
                {

                }
                tableelement(ComponentSerial; "Item Ledger Entry")
                {
                    LinkTable = AssemblyLine;
                    LinkFields = "Document No." = field("Document No."), "Entry Type" = filter("Assembly Consumption"),
                     "Item No." = field("No.");

                    fieldelement("CompSerialNo"; ComponentSerial."Serial No.")
                    {

                    }
                    fieldelement("CompQuantity"; ComponentSerial.Quantity)
                    {

                    }
                }

            }
        }
    }


    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }

    var
        myInt: Integer;
        documentno: Text;

    procedure setDocumentNo(docno: Text)
    begin
        documentno := docno;

    end;

    trigger OnPreXMLport()
    var
        myInt: Integer;
    begin
        //if documentno <> '' then
        // AssemblyHeader.SetRange("No.", documentno);
    end;
}