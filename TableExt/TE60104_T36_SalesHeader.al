tableextension 60104 FBM_SalesHeaderExt_CO extends "Sales Header"
{
    fields
    {
        field(70011; "FBM_Cust Payment Bank Code_FF"; Code[100])
        {
            Caption = 'Payment Bank ';
            FieldClass = "Flowfield";
            CalcFormula = lookup(Customer."FBM_Payment Bank Code" where("No." = field("Sell-to Customer No.")));
        }

        field(70006; "FBM_Cust Payment Bank Code2_FF"; Code[100])
        {
            Caption = 'Payment Bank 2';
            FieldClass = "Flowfield";
            CalcFormula = lookup(Customer."FBM_Payment Bank Code2" where("No." = field("Sell-to Customer No.")));
        }











    }


}
