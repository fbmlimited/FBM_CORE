pageextension 60177 FBM_CashRecJnlExt_CO extends "Cash Receipt Journal"
{
    layout
    {

        addafter("Document No.")
        {
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Amount")
        {
            field("Amount LCY"; rec."Amount (LCY)")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        // Add changes to page layout here
        modify(ShortcutDimCode3)
        {
            ApplicationArea = All;
            Visible = true;
            trigger OnLookup(var Text: Text): Boolean
            var
                CustOpSite: Record FBM_CustOpSite;
                CustOpSiteFull: Record FBM_CustOpSite;
                Custsite: Record FBM_CustomerSite_C;
                CustSiteFull: Record FBM_CustomerSite_C;
                Companyinfo: record "Company Information";
            begin
                DimensionValue.reset;
                CustOpSite.Reset();
                FASetup.Get();
                CustOpSiteFull.Reset();
                CustSite.Reset();
                CustSiteFull.Reset();
                Companyinfo.Reset();
                Companyinfo.Get();
                if Companyinfo.FBM_CustIsOp then begin
                    if rec."Account Type" = rec."Account Type"::Customer then
                        CustSite.SetFilter("Customer No.", rec."Account No.")
                    else
                        if rec."Bal. Account Type" = rec."Bal. Account Type"::Customer then CustSite.SetFilter("Customer No.", rec."Bal. Account No.");
                    if CustSite.FindFirst() then begin
                        if page.RunModal(50001, CustSite) = Action::LookupOK then SD3 := CustSite."Site Code";
                    end
                end
                else begin
                    if rec."Account Type" = rec."Account Type"::Customer then
                        CustOpSite.SetFilter("Customer No.", rec."Account No.")
                    else
                        if rec."Bal. Account Type" = rec."Bal. Account Type"::Customer then CustOpSite.SetFilter("Customer No.", rec."Bal. Account No.");
                    if CustOpSite.FindFirst() then begin
                        if page.RunModal(60103, CustOpSite) = Action::LookupOK then SD3 := CustOpSite."Site Code";
                    end
                    else begin //since customer <> operator
                        if page.RunModal(60103, CustOpSiteFull) = Action::LookupOK then SD3 := CustOpSiteFull."Site Code";
                    end;
                end;
                Rec.ValidateShortcutDimCode(3, SD3);
                CurrPage.Update(true);
                //DevOps #619 -- begin
                Contract_CS.reset;
                Contract_CS.SetFilter("Site Code", SD3);
                if Contract_CS.FindFirst() then begin
                    if Contract_CS."Contract Code" <> '' then begin
                        Rec.ValidateShortcutDimCode(6, Contract_CS."Contract Code");
                        CurrPage.Update(true);
                    end;
                end;
                //DevOps #619 -- end
            end;
        }
        modify("Amount (LCY)")
        {
            Visible = SeeLCY;
        }
        modify("Currency Code")
        {
            Visible = true;
        }

    }
    actions
    {
    }
    var
        DimensionValue: Record "Dimension Value";
        FASetup: Record "FA Setup";
        SD3: Code[20];
        SD4: Code[20];
        //ParentChild: Record "Parent Child Relation";
        Dimset: Record "Dimension Set Entry";
        Text000: Label 'You need to choose an operator first';
        Contract_CS: Record FBM_CustomerSite_C;
        UserSetup: Record "User Setup";
        SeeLCY: Boolean;

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        if UserSetup.Get(USERID) then
            SeeLCY := UserSetup."FBM_See LCY in Journals"
        else
            SeeLCY := false;
    end;
}
