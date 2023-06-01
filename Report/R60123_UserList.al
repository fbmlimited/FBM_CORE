report 60123 FBM_UserList_CO
{
    Caption = 'User List';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/R50050 UserList.rdl';


    dataset
    {
        dataitem(DataItemName; "Access Control")
        {

            column(Company_Name; cname)
            {

            }
            column(User_Name; "User Name")
            {

            }
            column(Role_ID; "Role ID")
            {

            }
            trigger

            OnPreDataItem()
            begin
                SetRange("Company Name", parcomp);
                if parcomp = '' then
                    cname := 'All companies'
                else
                    cname := parcomp;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; parcomp)
                    {
                        ApplicationArea = All;
                        TableRelation = Company;

                    }
                }
            }
        }
    }
    var
        parcomp: Text[30];
        cname: text[30];
}