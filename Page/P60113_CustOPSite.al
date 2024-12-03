page 60113 FBM_CustSite_CO
{
    Caption = 'CustSite';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_CustomerSite_C;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field(CName; cust.Name)
                {
                    ApplicationArea = All;
                }
                field(CAddress; cust.Address)
                {
                    ApplicationArea = All;
                }
                field(CCity; cust.City)
                {
                    ApplicationArea = All;
                }
                field(CVAT; cust."VAT Registration No.")
                {
                    ApplicationArea = All;
                }
                field(CGrCode; cust.FBM_GrCode)
                {
                    ApplicationArea = All;
                }
                field(Operator; cos."Operator No.")
                {
                    ApplicationArea = All;
                }
                field("Site Code"; rec."Site Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(ActiveRec; Rec.ActiveRec)
                {
                    ApplicationArea = All;
                }
                field(SName; rec."Site Name_FF")
                {
                    ApplicationArea = All;
                }
                field(SAddress; rec.Address_FF)
                {
                    ApplicationArea = All;
                }
                field(SCity; rec.City_FF)
                {
                    ApplicationArea = All;
                }
                field("Vat Number"; Rec."Vat Number")
                {
                    ApplicationArea = All;
                }
                field(SiteGrCode; Rec.SiteGrCode)
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
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger
    OnOpenPage()
    begin
        rec.SetRange(ActiveRec, true);
    end;

    trigger
    OnAfterGetRecord()
    begin
        if rec."Customer No." <> '' then begin
            cos.Reset();
            if cust.get(rec."Customer No.") then begin
                cos.setrange("Customer No.", rec."Customer No.");
                cos.SetRange("Site Code", rec."Site Code");
                if cos.FindFirst() then begin end;
            end
        end;

    end;

    var

        cust: record Customer;
        cos: record FBM_CustOpSite;
}