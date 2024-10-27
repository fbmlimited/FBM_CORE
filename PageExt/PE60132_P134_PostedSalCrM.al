pageextension 60132 FBM_PostedSCrMExt_CO extends "Posted Sales Credit Memo"
{
    layout
    {
        moveafter("External Document No."; "Shortcut Dimension 1 Code")
        moveafter("External Document No."; "Shortcut Dimension 2 Code")
        addafter("Shortcut Dimension 1 Code")
        {
            field("Posting Description63167"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field(Site_CO; rec.FBM_Site)
            {
                Visible = showsite;
                ApplicationArea = All;
            }

            field("Contract Code_CO"; rec."FBM_Contract Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(FBM_Segment2; Rec.FBM_Segment2)
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Period Start_CO"; rec."FBM_Period Start")
            {
                Visible = showsite;
                ApplicationArea = all;
                Editable = false;
            }
            field("Period End_CO"; rec."FBM_Period End")
            {
                Visible = showsite;
                ApplicationArea = all;
                Editable = false;
            }
        }

        addlast(General)
        {
            field(Currency2; rec.FBM_Currency2)
            {
                ApplicationArea = all;

            }
            field(LocalCurrAmt; rec.FBM_LocalCurrAmt)
            {
                ApplicationArea = all;

            }

            field(LCY; glsetup."LCY Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(factboxes)
        {

            part(signature; Factbox_SCH_CO)
            {

                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addLast(Navigation)
        {
            action(ChangePeriodDate_CO)
            {
                Caption = 'Change Period Date';
                Image = ChangeDate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                begin

                    CLEAR(InputDialog);
                    search := 'Period Date';
                    InputDialog.SetValues(search, rec."FBM_Period Start", rec."FBM_Period End");
                    IF ACTION::OK = InputDialog.RUNMODAL THEN BEGIN
                        InputDialog.GetValues(search, PeriodStart, PeriodEnd);
                        changedate.ChangeSalesCrMemoDate(PeriodStart, PeriodEnd, Rec);
                        CurrPage.UPDATE;
                    END;
                end;
            }
        }
    }
    trigger
    OnOpenPage()
    begin
        compinfo.Get();
        showsite := compinfo.FBM_CustIsOp;
        glsetup.Get();

    end;


    var
        changedate: Codeunit FBM_Events_CO;
        PeriodStart: Date;
        PeriodEnd: Date;
        InputDialog: Page "FBM_Input Dialog Page_CO";
        search: Text;
        compinfo: record "Company Information";
        showsite: Boolean;
        glsetup: record "General Ledger Setup";

}
