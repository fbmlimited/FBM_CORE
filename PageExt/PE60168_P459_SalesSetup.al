pageextension 60168 FBM_SalesSetupExt_CO extends "Sales & Receivables Setup"
{
    layout
    {
        addbefore("Discount Posting")
        {
            field("FBM_Show Hall Invoice Warning"; Rec."FBM_Show Hall Invoice Warning")
            {
                ApplicationArea = All;
                Caption = 'Show Hall Invoice Warning';
                ToolTip = 'Determine whether to show a warning when a customer is set to Separate Halls Inv. in Sales Documents';
            }
        }
        addlast(General)
        {
            field("FBM_Period Start End mandatory"; Rec."FBM_Period Start End mandatory")
            {
                ApplicationArea = All;

            }
        }
        addlast("Number Series")
        {
            field("FBM_Billing Statement Nos."; Rec."FBM_Billing Statement Nos.")
            {
                ApplicationArea = All;

            }
        }
    }
    actions
    {
        addlast(navigation)
        {
            group("Sales T&&C")
            {
                action("Terms & Conditions")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        TCP.Run();
                    end;
                }
            }
        }
    }
    var
        TCP: Page FBM_TermsConditions_CO;
}
