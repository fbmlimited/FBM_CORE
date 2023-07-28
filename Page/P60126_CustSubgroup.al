page 60126 "FBM_SubGroups_CO"
{
    Caption = 'SubGroups';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FBM_CustGroup;
    SourceTableView = where(isgroup = const(false));
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
                field("SubGroup Customer"; rec."SubGroup")
                {
                    Caption = 'SubGroup Customer';
                    ApplicationArea = All;
                }
                field("SubGroup Name"; rec."SubGroup Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}