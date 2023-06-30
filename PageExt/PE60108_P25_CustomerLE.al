pageextension 60108 FBM_CustomerLEExt_CO extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Customer No.")
        {
            field("Customer Name15262"; Rec."Customer Name")
            {
                ApplicationArea = All;
            }
        }

        addafter("External Document No.")
        {
            field("Period Start"; rec."FBM_Period Start")
            {
                ApplicationArea = All;
            }
            field("Period End"; rec."FBM_Period End")
            {
                ApplicationArea = All;
            }
            field(Site; rec.FBM_Site)
            {
                ApplicationArea = All;
            }
            field(FBM_Segment; Rec.FBM_Segment)
            {
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {

            field("Gen. Bus. Posting Group"; rec."FBM_Gen. Bus. Posting Group_FF")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

}
