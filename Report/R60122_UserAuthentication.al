report 60122 FBM_UserAuthentication_CO
{
    Caption = 'User Authentication';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/R50051 UserAuthentication.rdl';


    dataset
    {
        dataitem(User; User)
        {

            column(User_Name; "User Name")
            {

            }
            column(Full_Name; "Full Name")
            {

            }
            column(Authentication_Email; "Authentication Email")
            {

            }
            trigger

            OnPreDataItem()
            begin
                SetRange(State, User.State::Enabled);

            end;
        }
    }



}