tableextension 60102 FBM_BankAccountExt_CO extends "Bank Account"
{
    fields
    {




        field(70003; "FBM_Approval Batch Amount_FF"; Decimal)
        {
            FieldClass = FlowField;


            CalcFormula = Sum("Gen. Journal Line"."Amount" where("Bal. Account No." = FIELD("No."),
             "Journal Batch Name" = filter('APPROVALS'),
             "Reason Code" = filter('APPROVED')));



        }

        field(70004; "FBM_Approval Batch Amount2_FF"; Decimal)
        {
            FieldClass = FlowField;

            CalcFormula = Sum("Vendor Ledger Entry".FBM_RemAmount where
             ("FBM_Default Bank Account_FF" = field("No."), Open = const(true), FBM_approved1 = const(true)));
        }
    }

    var
        myInt: Integer;
}