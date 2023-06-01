page 60104 "FBM_SalRep-Unposted Entries_CO"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Reconciliation Report';
    UsageCategory = Lists;
    SourceTable = "Sales Line";
    SourceTableView = where(Type = FILTER(<> ''));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(GLName; GLName)
                {
                    Caption = 'G/L Name';
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field(LCY_Amount; LCY_Amount)
                {
                    CaptionClass = LCY_Caption;
                    ApplicationArea = All;
                }
                field(ARC_Amount; ARC_Amount)
                {
                    //Caption = 'Add. Reporting Currency Amount';
                    CaptionClass = ARC_Caption;
                    ApplicationArea = all;
                }
                field(Site; SH.FBM_Site)
                {
                    Caption = 'Site';
                    ApplicationArea = all;
                }
                field("Site Name"; SiteName)
                {
                    ApplicationArea = All;
                }
                //DevOps #619 -- begin
                field(SH; SH."FBM_Contract Code")
                {
                    Caption = 'Contract';
                    ApplicationArea = All;
                }
                //DevOps #619 -- end
                field("FBM_Period Start"; Rec."FBM_Period Start")
                {
                    ApplicationArea = all;
                }
                field("FBM_Period End"; Rec."FBM_Period End")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        GLAccount: Record "G/L Account";
        GLName: Text[1024];
        SH: Record "Sales Header";
        GLSetup: record "General Ledger Setup";
        AddRepCurr: Record Currency;
        ARC_Amount: Decimal;
        ARC_CER: Record "Currency Exchange Rate";
        ARC_Caption: Text[80];
        LCY: Record Currency;
        LCY_CER: Record "Currency Exchange Rate";
        LCY_Amount: Decimal;
        LCY_Caption: Text[80];
        CustSite: Record FBM_CustomerSite_C;
        SiteName: Text[1024];

    trigger OnOpenPage()
    begin
        GLSetup.Reset();
        if GLSetup.Get() then begin
            if GLSetup."Additional Reporting Currency" <> '' then begin
                if AddRepCurr.Get(GLSetup."Additional Reporting Currency") then ARC_Caption := 'Add. Reporting Currency Amount (' + AddRepCurr.Symbol + ')';
            end;
            if LCY.Get(GLSetup."LCY Code") then LCY_Caption := 'Amount (' + LCY.Symbol + ')';
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(GLName);
        Clear(ARC_Amount);
        SH.Reset;
        GLSetup.Reset();
        AddRepCurr.Reset();
        Clear(ARC_CER);
        if rec.Type = rec.Type::"G/L Account" then begin
            if GLAccount.Get(rec."No.") then begin
                GLName := GLAccount.Name;
            end
            else
                GLName := '';
        end
        else
            GLName := '';
        SH.Get(rec."Document Type", rec."Document No.");
        //get Additional Reporting Currency
        if GLSetup.Get() then begin
            //get LCY
            LCY.Reset();
            if LCY.get(GLSetup."LCY Code") then begin
                //get exchange rate for posting date
                LCY_CER.reset;
                LCY_Amount := 0;
                if LCY_CER.Get(GLSetup."LCY Code", SH."Posting Date") then begin
                    LCY_Amount := Rec.Amount / LCY_CER."Exchange Rate Amount";
                end
                else begin //get closes exchange rate
                    LCY_CER.Reset();
                    LCY_CER.SetCurrentKey("Starting Date");
                    LCY_CER.SetFilter("Currency Code", rec."Currency Code");
                    LCY_CER.SetFilter("Starting Date", '<=%1', rec."Posting Date");
                    if LCY_CER.FindLast() then begin
                        LCY_Amount := Rec.Amount / LCY_CER."Exchange Rate Amount";
                    end
                    else
                        LCY_Amount := 0;
                end;
            end;
            if GLSetup."Additional Reporting Currency" <> '' then begin
                AddRepCurr.Reset();
                if AddRepCurr.Get(GLSetup."Additional Reporting Currency") then begin
                    //get exchange rate for the posting date
                    ARC_CER.Reset();
                    ARC_Amount := 0;
                    if ARC_CER.get(GLSetup."Additional Reporting Currency", SH."Posting Date") then begin
                        ARC_Amount := LCY_Amount / ARC_CER."Exchange Rate Amount";
                    end
                    else begin //get closest Exchange rate
                        ARC_CER.Reset();
                        ARC_CER.SetCurrentKey("Starting Date");
                        ARC_CER.SetFilter("Currency Code", GLSetup."Additional Reporting Currency");
                        ARC_CER.SetFilter("Starting Date", '<=%1', rec."Posting Date");
                        if ARC_CER.FindLast() then begin
                            ARC_Amount := LCY_Amount / ARC_CER."Exchange Rate Amount";
                        end
                        else
                            ARC_Amount := 0;
                    end;
                end;
            end;
        end;
        //get site name
        CustSite.Reset();
        clear(SiteName);
        if CustSite.get(SH."Sell-to Customer No.", SH.FBM_Site) then
            SiteName := CustSite."Site Name"
        else
            SiteName := '';
    end;
}
