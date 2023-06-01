tableextension 60107 FBM_CustLEExt_CO extends "Cust. Ledger Entry"
{
    fields
    {


        field(70002; "FBM_Gen. Bus. Posting Group"; Code[20])
        {
            CalcFormula = Lookup(Customer."Gen. Bus. Posting Group" WHERE("No." = FIELD("Customer No.")));
            CaptionML = ENU = 'Gen. Bus. Posting Group',
                        SQI = 'Gr.Pergj.Biznesi';
            FieldClass = FlowField;
        }

    }
    var
}