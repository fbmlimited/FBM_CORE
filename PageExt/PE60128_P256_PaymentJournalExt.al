pageextension 60128 FBM_PaymentJournalExt_CO extends "Payment Journal"
{
    layout
    {
        modify("Amount (LCY)")
        {
            Visible = true;
            //Visible = SeeLCY;
        }
        modify("Currency Code")
        {
            Visible = true;
        }
        addafter("Bal. Account No.")
        {
            field("Check No. PHL"; rec."Check No. PHL")//restore
            {
                ApplicationArea = all;
            }
        }
        modify("Reason Code")
        {
            trigger OnBeforeValidate();
            var
                Publisher: Codeunit FBM_MyPublishers_CO;
            begin
                Publisher.OnReasonCodeChanged(CurrPage.Banks.Page);
            end;
        }

        modify("Amount")
        {
            trigger OnBeforeValidate();
            var
                Publisher: Codeunit FBM_MyPublishers_CO;
            begin
                Publisher.OnReasonCodeChanged(CurrPage.Banks.Page);
            end;
        }
        addlast(factboxes)
        {
            part("Banks"; "FBM_PayJnl Bank List Part_CO")
            {
                ApplicationArea = Basic, Suite;

            }
        }
    }
    actions
    {
    }
    var
        UserSetup: Record "User Setup";
        SeeLCY: Boolean;

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        if UserSetup.Get(USERID) then
            SeeLCY := UserSetup."FBM_See LCY in Journals"
        else
            SeeLCY := false;
    end;
}
