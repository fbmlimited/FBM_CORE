pageextension 60128 FBM_PaymentJournalExt_CO extends "Payment Journal"
{
    layout
    {
        addafter(AppliesToDocNo)
        {
            field(FBM_DueDate_FF; Rec.FBM_DueDate_FF)
            {
                ApplicationArea = all;
            }
        }
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
            field("Check No. PHL"; rec."Check No. PHL")
            {
                ApplicationArea = all;
            }
        }
        modify("Reason Code")
        {
            trigger OnBeforeValidate();
            var
                Publisher: Codeunit FBM_Events_CO;
            begin
                Publisher.OnReasonCodeChanged(CurrPage.Banks.Page);
            end;
        }

        modify("Amount")
        {
            trigger OnBeforeValidate();
            var
                Publisher: Codeunit FBM_Events_CO;
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
        addfirst("&Payments")
        {
            action(PrintCheck2)
            {
                AccessByPermission = TableData "Check Ledger Entry" = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Print Check';
                Ellipsis = true;
                Image = PrintCheck;
                ToolTip = 'Prepare to print the check.';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    DocumentPrint: Codeunit "Document-Print";
                    bankacc: record "Bank Account";
                    repsel: Record "Report Selections";
                begin

                    GenJournalLine.Reset();
                    GenJournalLine.Copy(Rec);
                    GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    bankacc.get(rec."Bal. Account No.");
                    rls.SetTempLayoutSelected(BankAcc."FBM_Check Layout Code");
                    repsel.setrange(Usage, repsel.Usage::"B.Check");
                    if repsel.FindFirst() then
                        report.RunModal(repsel."Report ID");
                    //DocumentPrint.PrintCheck(GenJournalLine);
                    CODEUNIT.Run(CODEUNIT::"Adjust Gen. Journal Balance", Rec);
                end;
            }

        }
        modify(PrintCheck)
        {
            Visible = false;

        }
    }
    var
        rls: record "Report Layout Selection";
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
