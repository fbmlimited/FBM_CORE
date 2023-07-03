page 60131 FBM_CustLookup_CO
{
    Caption = 'Customer Lookup';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_Customer;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Customer Code"; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Version; Rec.Version)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }

            }
        }

    }


}