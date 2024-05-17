pageextension 60150 FBM_PostSIExt_CO extends "Posted Sales Invoice"
{
    layout
    {
        addafter("External Document No.")
        {
            field(Site_CO; rec.FBM_Site)
            {
                Visible = showsite;
                ApplicationArea = All;
            }
            field(Segment; rec.FBM_Segment2)
            {
                ApplicationArea = All;
            }

            field("Contract Code_CO"; rec."FBM_Contract Code")
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
            field(LocalCurrAmt; rec.FBM_LocalCurrAmt)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Currency2; rec.FBM_Currency2)
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
        addafter("Currency Code")
        {
            field("Customer Payment Bank Code_CO"; rec."FBM_Cust Payment Bank Code_FF")
            {
                ApplicationArea = all;
                Editable = false;
            }

            field("Customer Payment Bank Code2"; rec."FBM_Cust Payment Bank Code2_FF")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
        modify("Company Bank Account Code")
        {

            Visible = false;
        }
        addlast(factboxes)
        {

            part(signature; FBM_Factbox_SIH_CO)
            {

                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addfirst(Navigation)
        {
            action("Print Billing Statement")
            {
                ApplicationArea = all;
                // RunObject = Report "NTT Sales - Billing Statement";

                Image = Print;
                trigger OnAction()
                var
                    rep: report "FBM_NTT Sales - BillStat_CO";
                    currentdoc: Record "Sales Invoice Header";
                    rep1: report "FBM_NTT SALES BILLING NEW_CO";

                begin
                    currentdoc.SetRange("No.", rec."No.");

                    if (CompanyName = 'D2R Ltd Branch') then begin

                        rep1.SetTableView(currentdoc);
                        rep1.Run();
                    end

                    else
                        if (currentdoc.FindFirst()) then begin
                            rep.SetTableView(currentdoc);
                            rep.Run();

                        end;

                end;

            }
        }
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
                        changedate.ChangeSalesInvoiceDate(PeriodStart, PeriodEnd, Rec);
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
        changedate: Codeunit FBM_Events_CO;
        PeriodStart: Date;
        PeriodEnd: Date;
        InputDialog: Page "FBM_Input Dialog Page_CO";
        search: Text;




        compinfo: record "Company Information";
        showsite: Boolean;
}
