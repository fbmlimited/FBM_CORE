pageextension 60121 FBM_GenJnlExt_CO extends "General Journal"
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
        // modify(ShortcutDimCode3)
        // {
        //     trigger OnLookup(var Text: Text): Boolean
        //     var
        //         CustOpSite: Record FBM_CustOpSite;
        //         CustOpSiteFull: Record FBM_CustOpSite;
        //         CustSite: Record FBM_CustomerSite_C;
        //         CustSiteFull: Record FBM_CustomerSite_C;
        //         Companyinfo: Record "Company Information";
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
        //             //DimensionValue.SetFilter(DimensionValue."Dimension Code", FASetup."Site Dimension");
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
        //                 if page.RunModal(50007, CustOpSite) = Action::LookupOK then SD3 := CustOpSite."Site Loc Code";
        //             end
        //             else begin //since customer <> operator
        //                 if page.RunModal(50007, CustOpSiteFull) = Action::LookupOK then SD3 := CustOpSiteFull."Site Loc Code";
        //             end;
        //         end;
        //         Rec.ValidateShortcutDimCode(dimsite, SD3);
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
        //     end;
        // }
        /*modify(ShortcutDimCode4)
            {
                trigger OnLookup(var Text: Text): Boolean
                begin

                    if SD3 = '' then Error(Text000);

                    DimensionValue.reset;
                    FASetup.Get();

                    DimensionValue.SetFilter(DimensionValue."Dimension Code", FASetup."Site Dimension");
                    DimensionValue.SetFilter(DimensionValue."Parent Code", SD3);

                    if page.RunModal(537, DimensionValue) = Action::LookupOK then
                        SD4 := DimensionValue.Code;

                    Rec.ValidateShortcutDimCode(4, SD4);

                    CurrPage.Update(true);
                end;

                trigger OnAfterValidate()
                begin
                    if SD3 = '' then Error(Text000);
                end;
            }*/
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            Visible = true;
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Amount (LCY)")
        {
            Visible = SeeLCY;
        }
    }
    actions
    {
        addlast(processing)
        {
            group("Exchange")
            {
                action("Add Exchange")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Add Exchange';
                    Image = EditLines;
                    Visible = True;

                    trigger OnAction()
                    var
                        genline: Record "Gen. Journal Line";
                        genline1: Record "Gen. Journal Line";
                        GenJnlManagement: codeunit "GenJnlManagement";
                        TotalBalance: decimal;
                        Balance: decimal;
                        ShowBalance: boolean;
                        ShowTotalBalance: Boolean;

                    begin
                        GenJnlManagement.CalcBalance(Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
                        //If TotalBalance <> 0 then Begin
                        genline.setrange("Journal Template Name", rec."Journal Template Name");
                        genline.setrange("Journal Batch Name", rec."Journal Batch Name");
                        if genline.findLAST then begin
                            genline1.INIT;
                            genline1.VALIDATE("Journal Template Name", genline."Journal Template Name");
                            genline1.VALIDATE("Journal Batch Name", genline."Journal Batch Name");
                            genline1."Line No." := genline."Line No." + 10000;
                            genline1.VALIDATE("Account Type", 0);

                            genline1.VALIDATE("Account No.", '660120');
                            genline1."Document No." := genline."Document No.";
                            genline1."Posting Date" := genline."Posting Date";
                            genline1."Document Date" := genline."Document Date";
                            genline1.VALIDATE("Amount", -TotalBalance);
                            genline1.insert;
                        end;
                        //End;
                    end;
                }
            }
        }
    }
    var
        DimensionValue: Record "Dimension Value";
        FASetup: Record "FA Setup";
        SD3: Code[20];
        SD4: Code[20];
        Text000: Label 'You need to choose an operator first!';
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
