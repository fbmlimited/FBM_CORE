page 60125 "Groups"
{
    Caption = 'Groups';
    PageType = List;
    //ApplicationArea = All;
    //UsageCategor y = Lists;
    SourceTable = FBM_CustGroup;
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Group Customer"; rec."Group")
                {
                    Caption = 'Group Customer';
                    ApplicationArea = All;
                }

                field("Group Name"; rec."Group Name")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}
