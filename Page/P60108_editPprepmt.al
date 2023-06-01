page 60108 FBM_editprepmt_CO
{
    Caption = 'Edit Prepayment';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(Edit)
            {
                field("Prepayment %"; rec."Prepayment %")
                {
                    ApplicationArea = All;
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
                        PrepaymentAmount := TotalPurchLine."Line Amount" * rec."Prepayment %" / 100;
                    end;
                }
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
        }
    }


    trigger
     OnAfterGetRecord()
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

    trigger
    OnOpenPage()
    begin
        rec.SetRange("Document Type", rec."Document Type");
        rec.SetRange("No.", rec."No.");

    end;

    var
        PrepaymentAmount: Decimal;

}