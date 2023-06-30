page 60101 "FBM_CustomerSite_CO"
{
    PageType = List;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = FBM_CustomerSite_C;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Site Code"; rec."Site Code")
                {
                    ApplicationArea = All;
                    Caption = 'Site Code';
                }
                field("Site Name"; rec."Site Name_FF")
                {
                    ApplicationArea = All;
                    Caption = 'Site Name';
                }
                field(Address; rec.Address_FF)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; rec."Address 2_FF")
                {
                    ApplicationArea = All;
                }
                field(City; rec.City_FF)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; rec."Post Code_FF")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; rec."Country/Region Code_FF")
                {
                    ApplicationArea = All;
                }


                field(Contact; rec.Contact)
                {
                    ApplicationArea = all;
                }
                field("Contract Code"; rec."Contract Code")
                {
                    ApplicationArea = all;
                }

                field("Contract Code2"; rec."Contract Code2")
                {
                    ApplicationArea = all;
                    visible = EnableSpin;
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
    trigger
    OnAfterGetRecord()
    begin
        compinfo.get;
        EnableSpin := compinfo.FBM_EnSpin;
    end;

    var
        DimensionValue: Record "Dimension Value";
        FASetup: Record "FA Setup";
        EnableSpin: Boolean;
        compinfo: record "Company Information";
}
