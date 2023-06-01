page 60115 FBM_Factbox_SIH_CO
{
    Caption = 'Media';
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Header";
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