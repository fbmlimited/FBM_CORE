tableextension 60111 FBM_SInvHeaderExt_CO extends "Sales Invoice Header"
{
    fields
    {

        field(70006; "FBM_Cust Payment Bank Code2_FF"; Code[100])
        {
            caption = 'Payment Bank 2';

            FieldClass = "Flowfield";
            CalcFormula = lookup(Customer."FBM_Payment Bank Code2" where("No." = field("Sell-to Customer No.")));
        }


        field(70011; "FBM_Cust Payment Bank Code_FF"; Code[100])
        {
            caption = 'Payment Bank';
            FieldClass = "Flowfield";
            CalcFormula = lookup(Customer."FBM_Payment Bank Code2" where("No." = field("Sell-to Customer No.")));
        }







    }


}
