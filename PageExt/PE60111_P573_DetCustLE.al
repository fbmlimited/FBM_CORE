pageextension 60111 FBM_DetCustLEExt_CO extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        addafter("Initial Entry Due Date")
        {
            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                ApplicationArea = All;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                ApplicationArea = All;
            }
            field(FBM_Site; Rec.FBM_Site)
            {
                ApplicationArea = All;
            }
            field(FBM_Segment; Rec.FBM_Segment)
            {
                ApplicationArea = All;
            }
        }
    }

}
