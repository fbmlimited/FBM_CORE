page 60124 "FBM_PaymJnl Bank List Part2_CO"
{
    Caption = 'Banks List';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Bank Account";


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
                field("Approval Batch Amount2"; rec."FBM_Approval Batch Amount2_FF")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = true;
                    Visible = false;

                }

                field("Projected Balance"; rec."Balance" + rec."FBM_Approval Batch Amount2_FF")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = true;

                }
            }
        }
    }


}