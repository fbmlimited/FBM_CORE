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
        // modify(ShortcutDimCode3)
        // {
        //     ApplicationArea = All;
        //     Visible = true;
        //     trigger OnLookup(var Text: Text): Boolean
        //     var
        //         CustOpSite: Record FBM_CustOpSite;
        //         CustOpSiteFull: Record FBM_CustOpSite;
        //         Custsite: Record FBM_CustomerSite_C;
        //         CustSiteFull: Record FBM_CustomerSite_C;
        //         Companyinfo: record "Company Information";
        //         dimsite: Integer;
        //         dimcontract: Integer;
        //         glsetup: record "General Ledger Setup";
        //         fasetup: record "FA Setup";
        //     begin
        //         glsetup.get;
        //         fasetup.Get();
        //         if glsetup."Global Dimension 1 Code" = fasetup."FBM_Site Dimension" then dimsite := 1;
        //         if glsetup."Global Dimension 2 Code" = fasetup."FBM_Site Dimension" then dimsite := 2;
        //         if glsetup."Shortcut Dimension 3 Code" = fasetup."FBM_Site Dimension" then dimsite := 3;
        //         if glsetup."Shortcut Dimension 4 Code" = fasetup."FBM_Site Dimension" then dimsite := 4;
        //         if glsetup."Shortcut Dimension 5 Code" = fasetup."FBM_Site Dimension" then dimsite := 5;
        //         if glsetup."Shortcut Dimension 6 Code" = fasetup."FBM_Site Dimension" then dimsite := 6;
        //         if glsetup."Shortcut Dimension 7 Code" = fasetup."FBM_Site Dimension" then dimsite := 7;
        //         if glsetup."Shortcut Dimension 8 Code" = fasetup."FBM_Site Dimension" then dimsite := 8;
        //         if glsetup."Global Dimension 1 Code" = fasetup."FBM_Contract Dimension" then dimcontract := 1;
        //         if glsetup."Global Dimension 2 Code" = fasetup."FBM_Contract Dimension" then dimcontract := 2;
        //         if glsetup."Shortcut Dimension 3 Code" = fasetup."FBM_Contract Dimension" then dimcontract := 3;
        //         if glsetup."Shortcut Dimension 4 Code" = fasetup."FBM_Contract Dimension" then dimcontract := 4;
        //         if glsetup."Shortcut Dimension 5 Code" = fasetup."FBM_Contract Dimension" then dimcontract := 5;
        //         if glsetup."Shortcut Dimension 6 Code" = fasetup."FBM_Contract Dimension" then dimcontract := 6;
        //         if glsetup."Shortcut Dimension 7 Code" = fasetup."FBM_Contract Dimension" then dimcontract := 7;
        //         if glsetup."Shortcut Dimension 8 Code" = fasetup."FBM_Contract Dimension" then dimcontract := 8;

        //         DimensionValue.reset;
        //         CustOpSite.Reset();
        //         FASetup.Get();
        //         CustOpSiteFull.Reset();
        //         CustSite.Reset();
        //         CustSiteFull.Reset();
        //         Companyinfo.Reset();
        //         Companyinfo.Get();
        //         if Companyinfo.FBM_CustIsOp then begin
        //             if rec."Account Type" = rec."Account Type"::Customer then
        //                 CustSite.SetFilter("Customer No.", rec."Account No.")
        //             else
        //                 if rec."Bal. Account Type" = rec."Bal. Account Type"::Customer then CustSite.SetFilter("Customer No.", rec."Bal. Account No.");
        //             if CustSite.FindFirst() then begin
        //                 if page.RunModal(60101, CustSite) = Action::LookupOK then SD3 := CustSite."Site Code";
        //             end
        //         end
        //         else begin
        //             if rec."Account Type" = rec."Account Type"::Customer then
        //                 CustOpSite.SetFilter("Customer No.", rec."Account No.")
        //             else
        //                 if rec."Bal. Account Type" = rec."Bal. Account Type"::Customer then CustOpSite.SetFilter("Cust Loc Code", rec."Bal. Account No.");
        //             if CustOpSite.FindFirst() then begin
        //                 if page.RunModal(60103, CustOpSite) = Action::LookupOK then SD3 := CustOpSite."Site Loc Code";
        //             end
        //             else begin //since customer <> operator
        //                 if page.RunModal(60103, CustOpSiteFull) = Action::LookupOK then SD3 := CustOpSiteFull."Site Loc Code";
        //             end;
        //         end;
        //         Rec.ValidateShortcutDimCode(dimsite, SD3);
        //         rec.FBM_Site := sd3;
        //         CurrPage.Update(true);
        //         //DevOps #619 -- begin
        //         Contract_CS.reset;
        //         Contract_CS.SetFilter("Site Code", SD3);
        //         if Contract_CS.FindFirst() then begin
        //             if Contract_CS."Contract Code" <> '' then begin
        //                 Rec.ValidateShortcutDimCode(dimcontract, Contract_CS."Contract Code");

        //                 CurrPage.Update(true);
        //             end;
        //         end;
        //         //DevOps #619 -- end
        //         rec.Modify();
        //     end;
        // }
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
