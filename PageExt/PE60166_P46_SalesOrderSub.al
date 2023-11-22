pageextension 60166 FBM_SalesOrdSubExt_CO extends "Sales Order Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        addafter("VAT Prod. Posting Group")
        {

            field(FBM_Site; Rec.FBM_Site)
            {
                Visible = showsite;
                ApplicationArea = all;
            }
            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                Visible = showsite;
                ApplicationArea = all;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                Visible = showsite;
                ApplicationArea = all;
            }
            //DEVOPS #622 -- end
            /*field(SD3; SD3)
                    {
                        ApplicationArea = all;
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            DimensionValue.reset;
                            FASetup.Get();

                            DimensionValue.SetFilter(DimensionValue."Dimension Code", FASetup."Operator Dimension");
                            DimensionValue.SetFilter(DimensionValue."Parent Code", Rec."Sell-to Customer No.");

                            if page.RunModal(537, DimensionValue) = Action::LookupOK then begin
                                SD3 := DimensionValue.code;


                            end;
                        end;

                    }*/
        }
        modify(ShortcutDimCode3)
        {
            //Visible = false;
            trigger OnLookup(var Text: Text): Boolean
            var
                dimoperator: Integer;
                dimcontract: Integer;
                glsetup: record "General Ledger Setup";
                fasetup: record "FA Setup";
            begin
                glsetup.get;
                fasetup.Get();
                if glsetup."Global Dimension 1 Code" = fasetup."FBM_Operator Dimension" then dimoperator := 1;
                if glsetup."Global Dimension 2 Code" = fasetup."FBM_Operator Dimension" then dimoperator := 2;
                if glsetup."Shortcut Dimension 3 Code" = fasetup."FBM_Operator Dimension" then dimoperator := 3;
                if glsetup."Shortcut Dimension 4 Code" = fasetup."FBM_Operator Dimension" then dimoperator := 4;
                if glsetup."Shortcut Dimension 5 Code" = fasetup."FBM_Operator Dimension" then dimoperator := 5;
                if glsetup."Shortcut Dimension 6 Code" = fasetup."FBM_Operator Dimension" then dimoperator := 6;
                if glsetup."Shortcut Dimension 7 Code" = fasetup."FBM_Operator Dimension" then dimoperator := 7;
                if glsetup."Shortcut Dimension 8 Code" = fasetup."FBM_Operator Dimension" then dimoperator := 8;

                DimensionValue.reset;
                FASetup.Get();
                DimensionValue.SetFilter(DimensionValue."Dimension Code", FASetup."FBM_Operator Dimension");
                //DimensionValue.SetFilter(DimensionValue., Rec."Sell-to Customer No.");
                if page.RunModal(537, DimensionValue) = Action::LookupOK then SD3 := DimensionValue.Code;
                Rec.ValidateShortcutDimCode(dimoperator, SD3);
                CurrPage.Update(true);
            end;
        }

    }


    var

        showsite: Boolean;

        DimensionValue: Record "Dimension Value";
        FASetup: Record "FA Setup";
        Salesline: Record "Sales Line";
        SD3: Code[20];
        SD4: Code[20];
        Text000: Label 'You need to choose an operator first!';
}
