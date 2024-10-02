report 60140 FBM_SalesReportNew_CO
{
    DefaultLayout = RDLC;
    UsageCategory = Administration;

    RDLCLayout = './RDLC/R60140_SalesReport.rdl';
    ApplicationArea = All;
    Caption = 'Sales Report';

    dataset
    {
        dataitem(salesinvoiceline; FBM_SalesInvLineTmp)
        {
            RequestFilterFields = "Posting Date";
            RequestFilterHeading = 'Sales Invoice Line';

            column(DocType; DocType)
            {

            }
            column(invpostingdate; "Posting Date")
            {

            }
            column(filters; filters)
            {

            }
            column(respcent; respcent)
            {

            }

            column(compname; compinfo.Name)
            {

            }
            column(invdocumentno; "Document No.")
            {

            }
            column(invNo; "No.")
            {

            }

            column(invcurrency; invheader."Currency Code")
            {

            }
            column(invDescr; "Description")
            {

            }
            column(invGenBUsPost; "Gen. Bus. Posting Group")
            {

            }
            column(invenProd; "Gen. Prod. Posting Group")
            {

            }
            column(invamount; "Amount")
            {

            }
            column(invperiodstart; salesinvoiceline."FBM_Period Start")
            {

            }
            column(invperiodend; salesinvoiceline."FBM_Period End")
            {

            }
            column(invglaccountname; invglaccountname)
            {

            }
            column(invContract; invContract)
            {

            }
            column(invsite; invsite)
            {

            }
            column(sitename; sitename)
            {

            }
            column(invGlEntryAmount; invGlEntryAmount)
            {


            }

            column(invGlEntryAmountAdditionalcurr; invGlEntryAmountAdditionalcurr)
            {

            }
            column(invGlEntryGlAccountNo; invGlEntryGlAccountNo)
            {

            }
            column(invGlEntryGlAccountName; invGlEntryGlAccountName)
            {

            }

            column(linetype; salesinvoiceline.Type)
            {

            }
            column(startmonth; startmonth)
            {
            }
            column(endmonth; endmonth)
            {
            }
            column(DayMonthEnd; DayMonthEnd)
            {
            }
            column(DaysMonthBegin; DaysMonthBegin)
            {
            }
            column(daysperiod; daysperiod)
            {
            }
            column(SalesMonthBegin; SalesMonthBegin)
            {
            }
            column(SalesMonthEnd; SalesMonthEnd)
            {
            }
            column(SalesCustomerNo; "Sell-to Customer No.")
            { }
            column(SalesCustomerName; SalesCustomerName)
            { }
            column(RegistrationDate; RegistrationDate)
            { }
            column(Grouping; Grouping)
            { }
            column(Summary; summary)
            { }







            trigger OnAfterGetRecord()


            var
                myInt: Integer;
                glentries: Record "G/L Entry";
                csite: record FBM_CustomerSite_C;
                GLACC: RECORD "G/L Account";

                sinvh: record "Sales Invoice Header";
                crmh: record "Sales Cr.Memo Header";

            begin
                if salesinvoiceline.DocType = salesinvoiceline.DocType::Invoice then
                    if sinvh.get(salesinvoiceline."Document No.") then
                        respcent := sinvh."Responsibility Center";
                if salesinvoiceline.DocType = salesinvoiceline.DocType::"Credit Memo" then
                    if crmh.get(salesinvoiceline."Document No.") then
                        respcent := crmh."Responsibility Center";
                IF salesinvoiceline.Type = salesinvoiceline.TYPE::"G/L Account" THEN begin
                    IF GLACC.get(salesinvoiceline."No.") then begin
                        if not showfranchisetax and GLACC.FBM_FranchiseTax then
                            CurrReport.Skip();
                        if not showWithholdingtax and glacc.FBM_WHTax then
                            CurrReport.Skip();
                    end;
                end;
                invsite := '';
                invContract := '';
                invglaccountname := '';
                invGlEntryAmount := 0;
                invGlEntryAmountAdditionalcurr := 0;
                invGlEntryGlAccountNo := '';
                invGlEntryGlAccountName := '';
                sitename := '';
                invsite := salesinvoiceline.FBM_Site;
                csite.SetRange("Site Code", salesinvoiceline.FBM_Site);
                if csite.FindFirst() then begin
                    csite.CalcFields("Site Name_FF");
                    sitename := csite."Site Name_FF";
                end;
                if summary then
                    grouping := salesinvoiceline."Document No."
                else
                    grouping := salesinvoiceline."Document No." + format(salesinvoiceline."Line No.");
                if salesinvoiceline.DocType = salesinvoiceline.DocType::Invoice then begin
                    invheader.SetRange("No.", salesinvoiceline."Document No.");
                    if invheader.FindFirst() then begin
                        if invsite = '' then
                            invsite := invheader.FBM_Site;
                        csite.SetRange("Site Code", invheader.FBM_Site);
                        if csite.FindFirst() then begin
                            csite.CalcFields("Site Name_FF");
                            sitename := csite."Site Name_FF";
                        end;

                        invContract := invheader."FBM_Contract Code";
                        SalesCustomerName := invheader."Sell-to Customer Name";
                    end;

                    if glaccount.Get("No.") then begin
                        invglaccountname := glaccount.Name;
                    end;
                    if (invheader."Currency Factor" > 0) then
                        invGlEntryAmount := salesinvoiceline.Amount / invheader."Currency Factor"
                    else
                        invGlEntryAmount := salesinvoiceline.Amount;
                    if (salesinvoiceline.Type = salesinvoiceline.Type::Item) then begin
                        glentries.SetRange("Document No.", salesinvoiceline."Document No.");
                        glentries.SetRange("Gen. Bus. Posting Group", salesinvoiceline."Gen. Bus. Posting Group");
                        glentries.setrange("Gen. Prod. Posting Group", salesinvoiceline."Gen. Prod. Posting Group");
                        if (glentries.findset) then begin
                            invGlEntryGlAccountNo := glentries."G/L Account No.";
                            RegistrationDate := DT2DATE(glentries."Last Modified DateTime");
                            if glaccount.Get(glentries."G/L Account No.") then begin
                                invGlEntryGlAccountName := glaccount.Name;
                            end;
                            //  invGlEntryGlAccountName := glentries."G/L Account Name";
                            //invGlEntryAmount += glentries.Amount;
                            invGlEntryAmountAdditionalcurr += glentries."Additional-Currency Amount";

                        end;
                    end;

                    if (salesinvoiceline.Type = salesinvoiceline.Type::"G/L Account") then begin
                        glentries.Reset();
                        glentries.SetRange("Document No.", salesinvoiceline."Document No.");
                        glentries.SetRange("G/L Account No.", salesinvoiceline."No.");
                        if (glentries.findset) then begin

                            // invGlEntryAmount += glentries.Amount;
                            invGlEntryAmountAdditionalcurr += glentries."Additional-Currency Amount";
                            RegistrationDate := DT2DATE(glentries."Last Modified DateTime");
                        end;

                    end;

                    // DATE CALCULATIONS FOR AMOUNT SEPARATION PER MONTH
                    startmonth := 0;
                    endmonth := 0;
                    daysperiod := 0;
                    PeriodEndday := 0;
                    DayMonthEnd := 0;
                    DaysMonthBegin := 0;
                    SalesMonthBegin := 0;
                    SalesMonthEnd := 0;
                    if ("FBM_Period Start" <> 0D) and ("FBM_Period End" <> 0D) then begin
                        startmonth := DATE2DMY("FBM_Period Start", 2);
                        endmonth := DATE2DMY("FBM_Period End", 2);
                        daysperiod := "FBM_Period End" - "FBM_Period Start" + 1;
                        PeriodEndday := DATE2DMY("FBM_Period End", 1);
                        if (startmonth = endmonth) then
                            DayMonthEnd := daysperiod
                        else
                            DayMonthEnd := PeriodEndday;

                        if (startmonth = endmonth) then
                            DaysMonthBegin := 0
                        else
                            DaysMonthBegin := daysperiod - DayMonthEnd;

                        if (startmonth <> endmonth) and (daysperiod > 0) then
                            SalesMonthBegin := Amount * DaysMonthBegin / daysperiod
                        else
                            SalesMonthBegin := 0;
                        //Add Amount USD
                        if (invheader."Currency Factor" > 0) then
                            SalesMonthBegin := SalesMonthBegin / invheader."Currency Factor";



                        if (daysperiod > 0) then
                            SalesMonthEnd := Amount * DayMonthEnd / daysperiod
                        else
                            SalesMonthEnd := 0;

                        //Add Amount USD
                        if (invheader."Currency Factor" > 0) then
                            SalesMonthEnd := SalesMonthEnd / invheader."Currency Factor";
                    end;
                end
                else begin
                    crmemoheader.SetRange("No.", salesinvoiceline."Document No.");
                    if crmemoheader.FindFirst() then begin
                        if invsite = '' then
                            invsite := crmemoheader.FBM_Site;
                        invContract := crmemoheader."FBM_Contract Code";
                        SalesCustomerName := crmemoheader."Sell-to Customer Name";
                    end;

                    if glaccount.Get("No.") then begin
                        invglaccountname := glaccount.Name;
                    end;
                    if (crmemoheader."Currency Factor" > 0) then
                        invGlEntryAmount := salesinvoiceline.Amount / crmemoheader."Currency Factor"
                    else
                        invGlEntryAmount := salesinvoiceline.Amount;
                    if (salesinvoiceline.Type = salesinvoiceline.Type::Item) then begin
                        glentries.SetRange("Document No.", salesinvoiceline."Document No.");
                        glentries.SetRange("Gen. Bus. Posting Group", salesinvoiceline."Gen. Bus. Posting Group");
                        glentries.setrange("Gen. Prod. Posting Group", salesinvoiceline."Gen. Prod. Posting Group");
                        if (glentries.findset) then begin
                            invGlEntryGlAccountNo := glentries."G/L Account No.";
                            RegistrationDate := DT2DATE(glentries."Last Modified DateTime");
                            if glaccount.Get(glentries."G/L Account No.") then begin
                                invGlEntryGlAccountName := glaccount.Name;
                            end;
                            //  invGlEntryGlAccountName := glentries."G/L Account Name";
                            //invGlEntryAmount += glentries.Amount;
                            invGlEntryAmountAdditionalcurr += glentries."Additional-Currency Amount";

                        end;
                    end;

                    if (salesinvoiceline.Type = salesinvoiceline.Type::"G/L Account") then begin
                        glentries.Reset();
                        glentries.SetRange("Document No.", salesinvoiceline."Document No.");
                        glentries.SetRange("G/L Account No.", salesinvoiceline."No.");
                        if (glentries.findset) then begin

                            // invGlEntryAmount += glentries.Amount;
                            invGlEntryAmountAdditionalcurr += glentries."Additional-Currency Amount";
                            RegistrationDate := DT2DATE(glentries."Last Modified DateTime");
                        end;

                    end;

                    // DATE CALCULATIONS FOR AMOUNT SEPARATION PER MONTH
                    startmonth := 0;
                    endmonth := 0;
                    daysperiod := 0;
                    PeriodEndday := 0;
                    DayMonthEnd := 0;
                    DaysMonthBegin := 0;
                    SalesMonthBegin := 0;
                    SalesMonthEnd := 0;
                    if ("FBM_Period Start" <> 0D) and ("FBM_Period End" <> 0D) then begin
                        startmonth := DATE2DMY("FBM_Period Start", 2);
                        endmonth := DATE2DMY("FBM_Period End", 2);
                        daysperiod := "FBM_Period End" - "FBM_Period Start" + 1;
                        PeriodEndday := DATE2DMY("FBM_Period End", 1);
                        if (startmonth = endmonth) then
                            DayMonthEnd := daysperiod
                        else
                            DayMonthEnd := PeriodEndday;

                        if (startmonth = endmonth) then
                            DaysMonthBegin := 0
                        else
                            DaysMonthBegin := daysperiod - DayMonthEnd;

                        if (startmonth <> endmonth) and (daysperiod > 0) then
                            SalesMonthBegin := Amount * DaysMonthBegin / daysperiod
                        else
                            SalesMonthBegin := 0;
                        //Add Amount USD
                        if (crmemoheader."Currency Factor" > 0) then
                            SalesMonthBegin := SalesMonthBegin / crmemoheader."Currency Factor";



                        if (daysperiod > 0) then
                            SalesMonthEnd := Amount * DayMonthEnd / daysperiod
                        else
                            SalesMonthEnd := 0;

                        //Add Amount USD
                        if (crmemoheader."Currency Factor" > 0) then
                            SalesMonthEnd := SalesMonthEnd / crmemoheader."Currency Factor";
                    end;
                end;


            end;



        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Parameters)
                {
                    field("Show Withholding Tax"; showWithholdingtax)
                    {
                        ApplicationArea = All;

                    }
                    field("Show Franchise Tax"; showfranchisetax)
                    {
                        ApplicationArea = All;

                    }
                    field(Summary; summary)
                    {
                        ApplicationArea = All;
                        caption = 'Summary';

                    }




                }
            }

        }




    }
    trigger
    OnPreReport()
    begin
        sinvline.CopyFilter("Posting Date", salesinvoiceline."Posting Date");

        sinvline.FindFirst();
        repeat
            salesinvoiceline.Init();
            salesinvoiceline."Line No." := sinvline."Line No.";
            salesinvoiceline.DocType := salesinvoiceline.DocType::Invoice;
            salesinvoiceline."Posting Date" := sinvline."Posting Date";
            salesinvoiceline."Document No." := sinvline."Document No.";
            salesinvoiceline."No." := sinvline."No.";
            salesinvoiceline.Description := sinvline.Description;
            salesinvoiceline.Type := sinvline.Type;
            salesinvoiceline."Gen. Bus. Posting Group" := sinvline."Gen. Bus. Posting Group";
            salesinvoiceline."Gen. Prod. Posting Group" := sinvline."Gen. Prod. Posting Group";
            salesinvoiceline.Amount := sinvline.Amount;
            salesinvoiceline."FBM_Period Start" := sinvline."FBM_Period Start";
            salesinvoiceline."FBM_Period End" := sinvline."FBM_Period End";
            salesinvoiceline.FBM_Site := sinvline.FBM_Site;
            salesinvoiceline."Sell-to Customer No." := sinvline."Sell-to Customer No.";
            salesinvoiceline.Insert();


        until sinvline.Next() = 0;
        scrmline.CopyFilter("Posting Date", salesinvoiceline."Posting Date");
        scrmline.FindFirst();
        repeat
            salesinvoiceline.Init();
            salesinvoiceline."Line No." := scrmline."Line No.";
            salesinvoiceline.DocType := salesinvoiceline.DocType::"Credit Memo";
            salesinvoiceline."Posting Date" := scrmline."Posting Date";
            salesinvoiceline."Document No." := scrmline."Document No.";
            salesinvoiceline."No." := scrmline."No.";
            salesinvoiceline.Description := scrmline.Description;
            salesinvoiceline.Type := scrmline.Type;
            salesinvoiceline."Gen. Bus. Posting Group" := scrmline."Gen. Bus. Posting Group";
            salesinvoiceline."Gen. Prod. Posting Group" := scrmline."Gen. Prod. Posting Group";
            salesinvoiceline.Amount := -scrmline.Amount;
            salesinvoiceline."FBM_Period Start" := scrmline."FBM_Period Start";
            salesinvoiceline."FBM_Period End" := scrmline."FBM_Period End";
            salesinvoiceline.FBM_Site := sinvline.FBM_Site;
            salesinvoiceline."Sell-to Customer No." := scrmline."Sell-to Customer No.";
            salesinvoiceline.Insert();

        until scrmline.Next() = 0;
    end;

    var
        invheader: Record "Sales Invoice Header";
        crmemoheader: Record "Sales Cr.Memo Header";
        invsite: Code[50];
        invContract: Code[50];
        glaccount: Record "G/L Account";
        invglaccountname: Text;
        invGlEntryAmount: decimal;
        invGlEntryAmountAdditionalcurr: decimal;
        invGlEntryGlAccountNo: Code[20];
        invGlEntryGlAccountName: Text;
        filters: Text;
        compinfo: Record "Company Information";
        crmemosite: Code[50];
        crmemoContract: Code[50];
        crmemoglaccountname: Text;
        crmemoGlEntryAmount: decimal;
        crmemoGlEntryAmountAdditionalcurr: decimal;
        crmemoGlEntryGlAccountNo: Code[20];
        crmemoGlEntryGlAccountName: Text;
        showWithholdingtax: Boolean;
        showfranchisetax: Boolean;
        crstartmonth: Integer;
        crendmonth: Integer;
        crdaysperiod: Integer;
        crPeriodEndday: Integer;
        crDayMonthEnd: Integer;
        crDaysMonthBegin: Integer;
        crSalesMonthBegin: Decimal;
        crSalesMonthEnd: Decimal;
        startmonth: Integer;
        endmonth: Integer;
        daysperiod: Integer;
        PeriodEndday: Integer;
        DayMonthEnd: Integer;
        DaysMonthBegin: Integer;
        SalesMonthBegin: Decimal;
        SalesMonthEnd: Decimal;
        crSalesCustomerName: Text[100];
        SalesCustomerName: Text[100];
        RegistrationDate: Date;
        summary: boolean;
        Grouping: text[100];

        sinvline: record "Sales Invoice Line";
        scrmline: record "Sales Cr.Memo Line";
        sitename: text[100];
        respcent: text[10];

}