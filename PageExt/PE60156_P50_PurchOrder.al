pageextension 60156 FBM_PurchOrderExt_CO extends "Purchase Order"
{
    layout
    {
        modify("Buy-from Vendor No.")
        {
            trigger
                    OnAfterValidate()

            begin
                compinfo.get();
                begin
                    if rec."FBM_Consignee Name" = '' then begin
                        rec."FBM_Consignee Address" := compinfo.Address;
                        rec."FBM_Consignee Address 2" := compinfo."Address 2";
                        rec."FBM_Consignee Name" := compinfo.Name;
                        rec."FBM_Consignee City" := compinfo.City;
                        rec."FBM_Consignee Contact" := compinfo."Name 2";
                        rec."FBM_Consignee Post Code" := compinfo."Post Code";
                        rec."FBM_Consignee Country" := compinfo."Country/Region Code";
                        rec."FBM_Consignee County" := compinfo.County;
                        // rec."Consignee Address" := compinfo.Address;
                        // rec."Consignee Address 2" := compinfo."Address 2";
                        // rec."Consignee Name" := compinfo.Name;
                        // rec."Consignee City" := compinfo.City;
                        // rec."Consignee Contact" := compinfo."Name 2";
                        // rec."Consignee Post Code" := compinfo."Post Code";
                        // rec."Consignee Country" := compinfo."Country/Region Code";
                        // rec."Consignee County" := compinfo.County;
                        rec.Modify();
                    END;
                    if rec."Ship-to Name" = '' then begin
                        rec."Ship-to Address" := compinfo.Address;
                        rec."Ship-to Address 2" := compinfo."Address 2";
                        rec."Ship-to Name" := compinfo."Name";
                        rec."Ship-to City" := compinfo.City;
                        rec."Ship-to Contact" := compinfo."Name 2";
                        rec."Ship-to Post Code" := compinfo."Post Code";
                        rec."Ship-to Country/Region Code" := compinfo."Country/Region Code";
                        rec."Ship-to County" := compinfo.County;
                        rec.Modify();
                    END;
                end;


            end;
        }
        addlast(General)
        {
            field(Requisition; rec.FBM_Requisition)
            {
                ApplicationArea = all;
            }
        }
        addafter(ShippingOptionWithLocation)
        {
            group(Control198)
            {
                ShowCaption = false;
                Visible = ShipToOptions2 = ShipToOptions2::Site;
                field(Site; rec.FBM_Site)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    ToolTip = 'Specifies a code for the Site where you want the items to be placed when they are received.';
                    trigger
                    OnValidate()
                    var
                        cs: record FBM_CustomerSite_C;
                    begin
                        compinfo.get();
                        cs.SetRange("Site Code", rec.FBM_Site);
                        if cs.FindFirst() then begin
                            cs.CalcFields(Address_FF, "Address 2_FF", "Site Name_FF", City_FF, "Post Code_FF", "Country/Region Code_FF", County_FF);
                            rec."Ship-to Address" := cs.Address_FF;
                            rec."Ship-to Address 2" := cs."Address 2_FF";
                            rec."Ship-to Name" := cs."Site Name_FF";
                            rec."Ship-to City" := cs.City_FF;
                            rec."Ship-to Contact" := cs.Contact;
                            rec."Ship-to Post Code" := cs."Post Code_FF";
                            rec."Ship-to Country/Region Code" := cs."Country/Region Code_FF";
                            rec."Ship-to County" := cs.County_FF;
                            rec."Ship-to Contact" := cs.Contact;
                            rec.Modify();
                        end
                        else begin
                            rec."Ship-to Address" := compinfo.Address;
                            rec."Ship-to Address 2" := compinfo."Address 2";
                            rec."Ship-to Name" := compinfo."Name";
                            rec."Ship-to City" := compinfo.City;
                            rec."Ship-to Contact" := compinfo."Name 2";
                            rec."Ship-to Post Code" := compinfo."Post Code";
                            rec."Ship-to Country/Region Code" := compinfo."Country/Region Code";
                            rec."Ship-to County" := compinfo.County;
                            rec."Ship-to Contact" := compinfo."Name 2";
                            rec.Modify();
                        end;

                    end;
                }

                // field("Site Name"; rec."Ship-to Name")
                // {
                //     ApplicationArea = all;
                //     Importance = Promoted;

                // }
                // field("Site Address"; rec."Ship-to Address")
                // {
                //     ApplicationArea = all;
                //     Importance = Promoted;

                // }
                // field("Site Address 2"; rec."Ship-to Address 2")
                // {
                //     ApplicationArea = all;
                //     Importance = Promoted;

                // }
                // field("Site City"; rec."Ship-to City")
                // {
                //     ApplicationArea = all;
                //     Importance = Promoted;

                // }
                // field("Site Post Code"; rec."Ship-to Post Code")
                // {
                //     ApplicationArea = all;
                //     Importance = Promoted;

                // }
                // field("Site County"; rec."Ship-to County")
                // {
                //     ApplicationArea = all;
                //     Importance = Promoted;

                // }
                // field("Site Country"; rec."Ship-to Country/Region Code")
                // {
                //     ApplicationArea = all;
                //     Importance = Promoted;

                // }
                // field("Site Contact"; rec."Ship-to Contact")
                // {
                //     ApplicationArea = all;
                //     Importance = Promoted;

                // }
            }
        }
        modify("Ship-to Name")
        {
            Caption = 'Ship-to Name';

        }
        modify("Ship-to Address")
        {
            Caption = 'Ship-to Address';

        }
        modify("Ship-to Address 2")
        {
            Caption = 'Ship-to Address 2';

        }
        modify("Ship-to City")
        {
            Caption = 'Ship-to City';

        }
        modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code';

        }
        modify("Ship-to County")
        {
            Caption = 'Ship-to County';

        }
        modify("Ship-to Country/Region Code")
        {
            Caption = 'Ship-to Country';

        }
        modify("Ship-to Contact")
        {
            Caption = 'Ship-to Contact';

        }
        addlast(Control99)
        {
            field(Consignee; rec.FBM_Consignee)
            {
                ApplicationArea = all;
                trigger
                    OnValidate()
                var
                    cust: record Customer;
                begin
                    compinfo.get();
                    if cust.get(rec.FBM_Consignee) then begin
                        rec."FBM_Consignee Address" := cust.Address;
                        rec."FBM_Consignee Address 2" := cust."Address 2";
                        rec."FBM_Consignee Name" := cust.Name;
                        rec."FBM_Consignee City" := cust.City;
                        rec."FBM_Consignee Contact" := cust."Name 2";
                        rec."FBM_Consignee Post Code" := cust."Post Code";
                        rec."FBM_Consignee Country" := cust."Country/Region Code";
                        rec."FBM_Consignee County" := cust.County;
                        // rec."Consignee Address" := cust.Address;
                        // rec."Consignee Address 2" := cust."Address 2";
                        // rec."Consignee Name" := cust.Name;
                        // rec."Consignee City" := cust.City;
                        // rec."Consignee Contact" := cust."Name 2";
                        // rec."Consignee Post Code" := cust."Post Code";
                        // rec."Consignee Country" := cust."Country/Region Code";
                        // rec."Consignee County" := cust.County;
                    end
                    else begin
                        rec."FBM_Consignee Address" := compinfo.Address;
                        rec."FBM_Consignee Address 2" := compinfo."Address 2";
                        rec."FBM_Consignee Name" := compinfo.Name;
                        rec."FBM_Consignee City" := compinfo.City;
                        rec."FBM_Consignee Contact" := compinfo."Name 2";
                        rec."FBM_Consignee Post Code" := compinfo."Post Code";
                        rec."FBM_Consignee Country" := compinfo."Country/Region Code";
                        rec."FBM_Consignee County" := compinfo.County;
                        // rec."Consignee Address" := compinfo.Address;
                        // rec."Consignee Address 2" := compinfo."Address 2";
                        // rec."Consignee Name" := compinfo.Name;
                        // rec."Consignee City" := compinfo.City;
                        // rec."Consignee Contact" := compinfo."Name 2";
                        // rec."Consignee Post Code" := compinfo."Post Code";
                        // rec."Consignee Country" := compinfo."Country/Region Code";
                        // rec."Consignee County" := compinfo.County;
                    end;


                end;
            }
            field("consignee Name"; rec."FBM_Consignee Name")
            {
                ApplicationArea = all;
                Importance = Promoted;

            }
            field("consignee Address"; rec."FBM_Consignee Address")
            {
                ApplicationArea = all;
                Importance = Promoted;

            }
            field("consignee Address 2"; rec."FBM_Consignee Address 2")
            {
                ApplicationArea = all;
                Importance = Promoted;

            }
            field("consignee City"; rec."FBM_Consignee City")
            {
                ApplicationArea = all;
                Importance = Promoted;

            }
            field("consignee Post Code"; rec."FBM_Consignee Post Code")
            {
                ApplicationArea = all;
                Importance = Promoted;

            }
            field("consignee Country"; rec."FBM_Consignee Country")
            {
                ApplicationArea = all;
                Importance = Promoted;

            }
            field("consignee County"; rec."FBM_Consignee County")
            {
                ApplicationArea = all;
                Importance = Promoted;

            }
            field("consignee Contact"; rec."FBM_Consignee Contact")
            {
                ApplicationArea = all;
                Importance = Promoted;

            }
        }

        addfirst("Shipping and Payment")
        {
            field(ShippingOption; ShipToOptions2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Ship-to';

                OptionCaption = 'Default (Company Address),Location,Customer Address,Custom Address,Site';
                ToolTip = 'Specifies the address that the products on the purchase document are shipped to. Default (Company Address): The same as the company address specified in the Company Information window. Location: One of the company''s location addresses. Customer Address: Used in connection with drop shipment. Custom Address: Any ship-to address that you specify in the fields below.';

                trigger OnValidate()
                begin
                    ValidateShippingOption2;
                end;
            }

        }
        addbefore("Prepayment %")
        {
            field(PrepaymentAmount; PrepaymentAmount)
            {
                ApplicationArea = all;
                Caption = 'Prepayment Amount';
                trigger OnValidate()
                var
                    pl: Record "Purchase Line";
                    DocumentTotals: Codeunit "Document Totals";
                    TotalPurchLine: Record "Purchase Line";
                    VATAmount: Decimal;
                begin

                    pl.SETRANGE("Document Type", rec."Document Type");
                    pl.SETRANGE("Document No.", rec."No.");
                    IF pl.FINDFIRST THEN
                        DocumentTotals.CalculatePurchaseTotals(TotalPurchLine, VATAmount, pl);
                    rec.VALIDATE("Prepayment %", PrepaymentAmount / TotalPurchLine."Line Amount" * 100);
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
        modify("Prepayment %")
        {
            trigger OnAfterValidate()
            var
                pl: Record "Purchase Line";
                DocumentTotals: Codeunit "Document Totals";
                TotalPurchLine: Record "Purchase Line";
                VATAmount: Decimal;
            begin
                pl.SETRANGE("Document Type", rec."Document Type");
                pl.SETRANGE("Document No.", rec."No.");
                IF pl.FINDFIRST THEN
                    DocumentTotals.CalculatePurchaseTotals(TotalPurchLine, VATAmount, pl);
                PrepaymentAmount := TotalPurchLine."Line Amount" * rec."Prepayment %" / 100;
            end;
        }


        modify(ShippingOptionWithLocation)
        {
            Visible = false;
        }
    }
    actions
    {
        addfirst(processing)
        {
            action("Approval Request Entries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Request Entries';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Open Approval Request Entries page';
                RunObject = Page "FBM_ApprRequest Entries New_CO";
                RunPageLink = "Document No." = field("No.");
            }
            // action("Check Approvals")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Check Approvals';
            //     Image = Check;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Check Approval Entries';
            //     trigger
            //     OnAction()
            //     var
            //         apprentry: record "Approval Entry";
            //     begin
            //         apprentry.SetRange("Document No.", rec."No.");
            //         apprentry.SetRange("Document Type", rec."Document Type");
            //         if apprentry.Count > 0 then begin
            //             apprentry.Setfilter(Status, '<>%1', apprentry.Status::Approved);
            //             if apprentry.Count = 0 then begin
            //                 pl.SETRANGE("Document Type", rec."Document Type");
            //                 pl.SETRANGE("Document No.", rec."No.");
            //                 IF pl.FINDFIRST THEN
            //                     DocumentTotals.CalculatePurchaseTotals(TotalPurchLine, VATAmount, pl);
            //                 PrepaymentAmount := TotalPurchLine."Line Amount" * rec."Prepayment %" / 100;

            //                 if (rec."Prepayment %" <> 0) and (PrepaymentAmount <> rec."Amount Including VAT" * rec."Prepayment %") then
            //                     rec.Status := rec.Status::"Pending Prepayment"
            //                 else
            //                     rec.Status := rec.Status::Released;
            //             end;
            //         end;
            //     end;
            // }
            action("Edit Posting Date")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Edit Posting Date';
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger
                OnAction()
                var
                    statori: Enum "Purchase Document Status";
                    ph: record "Purchase Header";
                begin


                    statori := rec.Status;
                    rec.Status := rec.Status::Open;
                    rec.Modify();
                    commit;

                    page.RunModal(Page::FBM_editpostingdate_CO, rec);

                    Commit();

                    ph.get(rec."Document Type", rec."No.");
                    ph.Status := statori;
                    ph.Modify();

                end;
            }
            action("EditPrepayment")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Edit Prepayment';
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger
                OnAction()
                var
                    statori: Enum "Purchase Document Status";
                    ph: record "Purchase Header";
                begin


                    statori := rec.Status;
                    rec.Status := rec.Status::Open;
                    rec.Modify();
                    commit;

                    page.RunModal(Page::FBM_editprepmt_CO, rec);

                    Commit();

                    ph.get(rec."Document Type", rec."No.");
                    ph.Status := statori;
                    ph.Modify();

                end;
            }
        }
    }
    trigger
    OnOpenPage()
    begin
        compinfo.get;
        if rec."FBM_Consignee Name" = '' then begin
            rec."FBM_Consignee Address" := compinfo.Address;
            rec."FBM_Consignee Address 2" := compinfo."Address 2";
            rec."FBM_Consignee Name" := compinfo.Name;
            rec."FBM_Consignee City" := compinfo.City;
            rec."FBM_Consignee Contact" := compinfo."Name 2";
            rec."FBM_Consignee Post Code" := compinfo."Post Code";
            rec."FBM_Consignee Country" := compinfo."Country/Region Code";
            rec."FBM_Consignee County" := compinfo.County;
            // rec."Consignee Address" := compinfo.Address;
            // rec."Consignee Address 2" := compinfo."Address 2";
            // rec."Consignee Name" := compinfo.Name;
            // rec."Consignee City" := compinfo.City;
            // rec."Consignee Contact" := compinfo."Name 2";
            // rec."Consignee Post Code" := compinfo."Post Code";
            // rec."Consignee Country" := compinfo."Country/Region Code";
            // rec."Consignee County" := compinfo.County;
            //rec.Modify();
        end;
        if rec."Ship-to Name" = '' then begin
            rec."Ship-to Address" := compinfo.Address;
            rec."Ship-to Address 2" := compinfo."Address 2";
            rec."Ship-to Name" := compinfo."Name";
            rec."Ship-to City" := compinfo.City;
            rec."Ship-to Contact" := compinfo."Name 2";
            rec."Ship-to Post Code" := compinfo."Post Code";
            rec."Ship-to Country/Region Code" := compinfo."Country/Region Code";
            rec."Ship-to County" := compinfo.County;
            //rec.Modify();
        end;



    end;

    trigger OnAfterGetRecord()
    var
        pl: Record "Purchase Line";
        DocumentTotals: Codeunit "Document Totals";
        TotalPurchLine: Record "Purchase Line";
        VATAmount: Decimal;
    begin
        pl.SETRANGE("Document Type", rec."Document Type");
        pl.SETRANGE("Document No.", rec."No.");
        IF pl.FINDFIRST THEN
            DocumentTotals.CalculatePurchaseTotals(TotalPurchLine, VATAmount, pl);
        PrepaymentAmount := TotalPurchLine."Line Amount" * rec."Prepayment %" / 100;
    end;


    var
        PrepaymentAmount: Decimal;
        DocumentTotals: Codeunit "Document Totals";
        TotalPurchLine: record "Purchase Line";
        pl: record "Purchase Line";
        VATAmount: Decimal;
        ShipToOptions2: Option "Default (Company Address)",Location,"Customer Address","Custom Address",Site;
        compinfo: record "Company Information";

    local procedure ValidateShippingOption2()
    begin
        case ShipToOptions of
            ShipToOptions::"Default (Company Address)",
            ShipToOptions::"Custom Address":
                begin
                    rec.Validate("Sell-to Customer No.", '');
                    rec.Validate("Location Code", '');
                end;
            ShipToOptions::Location:
                begin
                    rec.Validate("Sell-to Customer No.", '');
                    rec.Validate("Location Code");
                end;
            ShipToOptions::"Customer Address":
                begin
                    rec.Validate("Sell-to Customer No.");
                    rec.Validate("Location Code", '');
                end;
        end;
    end;
}

