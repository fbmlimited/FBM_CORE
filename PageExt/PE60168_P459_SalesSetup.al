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
                visible = isph;

            }
        }
        addafter(General)
        {
            group(BIR)
            {

                Visible = isph;


                field(FBM_SI_PTU; Rec.FBM_SI_PTU)
                {
                    ApplicationArea = All;

                }
                field(FBM_SI_DateIssued; Rec.FBM_SI_DateIssued)
                {
                    ApplicationArea = All;

                }
                field(FBM_CM_PTU; Rec.FBM_CM_PTU)
                {
                    ApplicationArea = All;

                }
                field(FBM_CM_DateIssued; Rec.FBM_CM_DateIssued)
                {
                    ApplicationArea = All;

                }
                field(FBM_BS_PTU; Rec.FBM_BS_PTU)
                {
                    ApplicationArea = All;

                }
                field(FBM_BS_DateIssued; Rec.FBM_BS_DateIssued)
                {
                    ApplicationArea = All;

                }



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
    trigger
    OnOpenPage()
    begin
        cinfo.get;
        isph := cinfo."Country/Region Code" = 'PH';

    end;

    var
        TCP: Page FBM_TermsConditions_CO;
        isph: Boolean;
        cinfo: record "Company Information";
}
