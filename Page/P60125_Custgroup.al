page 60125 "Groups"
{
    Caption = 'Groups';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FBM_CustGroup;
    SourceTableView = where(isgroup = const(true));
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
