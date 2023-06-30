tableextension 60109 FBM_ItemLEExt_CO extends "Item Ledger Entry"
{
    fields
    {

        field(60100; "FBM_Document No Value Entry_FF"; Code[20])
        {
            FieldClass = FlowField;


            CalcFormula = lookup("Purch. Rcpt. Header"."Order No." where("No." = FIELD("Document No.")));


        }
    }


}

