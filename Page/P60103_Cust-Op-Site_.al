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
                field(Subsidiary; Rec.Subsidiary)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Cust Loc Code"; Rec."Cust Loc Code")
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
                field(vatnumber; vatnumber)
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
        Cust: Record FBM_Customer;
        Operator: Record FBM_Customer;
        Site: Record FBM_CustomerSite_C;
        FASetup: Record "FA Setup";
        vatnumber: text[20];
        compinfo: record "Company Information";

    trigger
    OnOpenPage()
    begin
        compinfo.get;
        Rec.Reset();
        Rec.FilterGroup(2);
        rec.setfilter(Subsidiary, '%1', compinfo."Custom System Indicator Text" + '*');
        rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    begin
        Cust.Reset();
        Operator.Reset();
        Site.Reset();
        FASetup.Get();
        cust.SetRange("No.", Rec."Customer No.");
        if cust.FindFirst() then
            "Customer Name" := Cust.Name
        else
            "Customer Name" := '';
        Operator.SetRange("No.", Rec."Operator No.");
        if operator.findlast then
            "Operator Name" := Operator.Name
        else
            "Operator Name" := '';
        if Site.Get(rec."Cust Loc Code", Rec."Site Loc Code") then begin
            site.CalcFields("Site Name_FF");
            "Site Name" := Site."Site Name_FF";
            vatnumber := site."Vat Number"
        end
        else begin
            ;
            "Site Name" := '';
            vatnumber := '';
        end
    end;
}
