page 60116 Factbox_SCH_CO
{
    Caption = 'Media';
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Cr.Memo Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            group(Signature)
            {
                field(signature_pic; rec.FBM_Signature_pic)
                {
                    ApplicationArea = All;
                }

            }
        }
    }


}