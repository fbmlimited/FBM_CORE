page 60129 FBM_FinAttributes
{
    Caption = 'Financial Attributes';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_FinAttributes;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                }
                field(Rectype; Rec.Rectype)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Segment; Rec.FBM_Segment2)
                {
                    ApplicationArea = All;
                }
                field(Share; Rec.Share)
                {
                    ApplicationArea = All;
                }
                field(low; Rec.low)
                {
                    ApplicationArea = All;
                }
                field(high; Rec.high)
                {
                    ApplicationArea = All;
                }
                field(FranchiseTax; Rec.FranchiseTax)
                {
                    ApplicationArea = All;
                }
                field(WTHTax; Rec.WTHTax)
                {
                    ApplicationArea = All;
                }
                // field(Royalty; Rec.Royalty)
                // {
                //     ApplicationArea = All;
                // }
                field(InvInt; Rec.InvInt)
                {
                    ApplicationArea = All;
                }
                field(InvExt; Rec.InvExt)
                {
                    ApplicationArea = All;
                }
            }
        }

    }


}