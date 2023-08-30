page 60103 "FBM_Cust-Op-Site_CO"
{
    caption = 'Cust-Op-Site';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FBM_CustOpSite;

    layout
    {
        area(Content)
        {
            repeater("Cust-Op-Site")
            {
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Operator No."; rec."Operator No.")
                {
                    ApplicationArea = All;
                }
                field("Operator Name"; "Operator Name")
                {
                    ApplicationArea = All;
                }
                field("Site Code"; rec."Site Code")
                {
                    ApplicationArea = All;
                }
                field("Site Loc Code"; Rec."Site Loc Code")
                {
                    ApplicationArea = All;
                }
                field("Site Name"; "Site Name")
                {
                    ApplicationArea = All;
                }



            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
    }
    var
        "Customer Name": Text[250];
        "Operator Name": Text[250];
        "Site Name": Text[250];
        Cust: Record Customer;
        Operator: Record "Dimension Value";
        Site: Record FBM_CustomerSite_C;
        FASetup: Record "FA Setup";

    trigger OnAfterGetRecord()
    begin
        Cust.Reset();
        Operator.Reset();
        Site.Reset();
        FASetup.Get();
        if cust.Get(Rec."Customer No.") then
            "Customer Name" := Cust.Name
        else
            "Customer Name" := '';
        if Operator.Get(FASetup."FBM_Operator Dimension", Rec."Operator No.") then
            "Operator Name" := Operator.Name
        else
            "Operator Name" := '';
        if Site.Get(rec."Customer No.", Rec."Site Code") then
            "Site Name" := Site."Site Name_FF"
        else
            "Site Name" := '';
    end;
}
