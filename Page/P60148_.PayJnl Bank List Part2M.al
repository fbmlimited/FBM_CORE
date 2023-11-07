page 60148 "FBM_PaymJnlBankListPart2M_CO"
{
    Caption = 'Banks List';
    Editable = false;
    PageType = ListPart;
    SourceTable = FBM_BankAccountTMP;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; rec."No.")
                {
                    ApplicationArea = Basic, Suite;


                }

                field("Balance"; rec."Balance")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = true;

                }
                field("Approval Batch Amount2"; rec."FBM_Approval Batch Amount2")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = true;
                    Visible = false;

                }

                field("Projected Balance"; rec."Balance" + rec."FBM_Approval Batch Amount2")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = true;

                }
            }
        }
    }
    procedure upd()
    var
        bankacc: record "Bank Account";
    begin

        CurrPage.Update();
    end;





}