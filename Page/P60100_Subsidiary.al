page 60100 FBM_SubsidiaryList_CO
{
    Caption = 'Subsidiary List';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_Subsidiary;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(Lessee; Rec.Lessee)
                {
                    ApplicationArea = All;
                }
                field(EGM_Property; Rec.EGM_Property)
                {
                    ApplicationArea = All;
                }
                field(Brand; Rec.Brand)
                {
                    ApplicationArea = All;
                }

            }
        }

    }


}