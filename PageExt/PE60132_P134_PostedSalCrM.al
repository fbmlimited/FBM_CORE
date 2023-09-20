pageextension 60132 FBM_PostedSCrMExt_CO extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("External Document No.")
        {
            field(Site; rec.FBM_Site)
            {
                Visible = showsite;
                ApplicationArea = All;
            }

            field("Contract Code"; rec."FBM_Contract Code")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Period Start"; rec."FBM_Period Start")
            {
                Visible = showsite;
                ApplicationArea = all;
                Editable = false;
            }
            field("Period End"; rec."FBM_Period End")
            {
                Visible = showsite;
                ApplicationArea = all;
                Editable = false;
            }
        }
        addlast(General)
        {
            field(LocalCurrAmt; rec.FBM_LocalCurrAmt)
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addlast(factboxes)
        {

            part(signature; Factbox_SCH_CO)
            {

                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        addLast(Navigation)
        {
            action(ChangePeriodDate)
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

    end;


    var
        changedate: Codeunit FBM_ChangePerDateSales_CO;
        PeriodStart: Date;
        PeriodEnd: Date;
        InputDialog: Page "FBM_Input Dialog Page_CO";
        search: Text;
        compinfo: record "Company Information";
        showsite: Boolean;

}
