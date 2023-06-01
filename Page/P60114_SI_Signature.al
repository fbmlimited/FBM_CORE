page 60114 FBM_Factbox_SI_CO
{
    Caption = 'Media';
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Header";
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