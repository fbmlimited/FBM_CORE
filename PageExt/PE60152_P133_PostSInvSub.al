pageextension 60152 FBM_PostSISubExt_CO extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Variant Code")
        {


            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                Visible = showsite;
                ApplicationArea = all;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                Visible = showsite;
                ApplicationArea = all;
            }

        }

        
    }
    actions
    {
        addLast(processing)
        {
            action(ChangeGroup)
            {
                Caption = 'Change Posting Group';

                trigger OnAction();
                var
                    InputDialog: Page "FBM_Input Dialog Post Group_CO";
                    GenBusGroup: Code[20];
                    GenItemgroup: Code[20];
                    search: Text;
                    change: Codeunit FBM_ChangePerDateSales_CO;
                begin

                    CLEAR(InputDialog);
                    search := 'Item Posting Group';
                    InputDialog.SetValues(search, rec."Gen. Bus. Posting Group", rec."Gen. Prod. Posting Group");
                    IF ACTION::OK = InputDialog.RUNMODAL THEN BEGIN
                        InputDialog.GetValues(search, GenBusGroup, GenItemgroup);
                        change.ChangeSalesInvoicePostGroup(GenBusGroup, GenItemgroup, Rec);
                        CurrPage.UPDATE;
                    END;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        uper: Codeunit "User Permissions";
    begin

        if compinfo.Get() then begin
            
            showsite := compinfo.FBM_CustIsOp;
        end;


    end;




    var
        
        compinfo: record "Company Information";
        changedate: Codeunit FBM_ChangePerDateSales_CO;

        showsite: Boolean;

}
