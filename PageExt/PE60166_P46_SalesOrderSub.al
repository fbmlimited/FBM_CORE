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
            begin
                DimensionValue.reset;
                FASetup.Get();
                DimensionValue.SetFilter(DimensionValue."Dimension Code", FASetup."FBM_Operator Dimension");
                //DimensionValue.SetFilter(DimensionValue., Rec."Sell-to Customer No.");
                if page.RunModal(537, DimensionValue) = Action::LookupOK then SD3 := DimensionValue.Code;
                Rec.ValidateShortcutDimCode(3, SD3);
                CurrPage.Update(true);
            end;
        }
        modify("IDPIRPF IRPF")
        {

            visible = isvisES;
        }
        modify("IDPIRPF IRPF Amount")
        {

            visible = isvisES;
        }
        modify("IDPIRPF IRPF Group")
        {

            visible = isvisES;
        }
        modify("IDPIRPF Total IRPF Amount")
        {

            visible = isvisES;
        }
        modify("IDPIRPF TotalAmountWithVATWithoutIRPF")
        {

            visible = isvisES;
        }
        modify("VAT Bus. Posting Group PHL")
        {

            visible = isvisPH;
        }
        modify("WHT Product Posting Group PHL")
        {

            visible = isvisPH;
        }
        modify("WHT Business Posting Group PHL")
        {

            visible = isvisPH;
        }
    }
    trigger OnOpenPage()
    var
        uper: Codeunit "User Permissions";
    begin

        if compinfo.Get() then begin
            isvisES := compinfo."Country/Region Code" = 'ES';
            isvisPH := compinfo."Country/Region Code" = 'PH';
        end;


    end;

    var
        isvisES: Boolean;
        isvisPH: Boolean;
        compinfo: record "Company Information";
        showsite: Boolean;

        DimensionValue: Record "Dimension Value";
        FASetup: Record "FA Setup";
        Salesline: Record "Sales Line";
        SD3: Code[20];
        SD4: Code[20];
        Text000: Label 'You need to choose an operator first!';
}
