pageextension 60136 FBM_UsersExt_CO extends Users
{
    layout
    {
        addafter(State)
        {
            field("Authentication Email01384"; Rec."Authentication Email")
            {
                ApplicationArea = All;
            }
        }
    }
}
