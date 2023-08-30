tableextension 60114 FBM_GenJnlLineExt_CO extends "Gen. Journal Line"
{
    fields
    {
        field(70010; FBM_DueDate_FF; Date)
        {
            Caption = 'DueDate';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."Due Date" where("No." = field("Applies-to Doc. No.")));

        }

    }

}