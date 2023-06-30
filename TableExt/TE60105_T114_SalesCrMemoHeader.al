tableextension 60105 FBM_SCrMHeaderExt_CO extends "Sales Cr.Memo Header"
{
    fields
    {

        field(70006; "FBM_Cust Payment Bank Code2_FF"; Code[100])
        {

            FieldClass = "Flowfield";
            CalcFormula = lookup(Customer."FBM_Payment Bank Code2" where("No." = field("Sell-to Customer No.")));
        }


        field(70011; "FBM_Cust Payment Bank Code_FF"; Code[100])
        {

            FieldClass = "Flowfield";
            CalcFormula = lookup(Customer."FBM_Payment Bank Code2" where("No." = field("Sell-to Customer No.")));
        }







    }


}
