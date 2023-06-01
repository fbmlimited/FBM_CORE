report 60125 FBM_SalesReport_CO
{
    DefaultLayout = RDLC;
    UsageCategory = Administration;

    RDLCLayout = './OnetechSalesReport.rdl';
    ApplicationArea = All;
    Caption = 'Sales Report';

    dataset
    {
        dataitem(salesinvoiceline; "Sales Invoice Line")
        {
            RequestFilterFields = "Posting Date", "Sell-to customer no.";

            //column(invpostingdate; format("Posting Date"))
            column(invpostingdate; "Posting Date")
            {

            }
            column(filters; filters)
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

            trigger OnPreDataItem()
            begin
                filters := salesinvoiceline.GetFilters();
                if (filters <> '') then begin

                end;
                compinfo.get();
                if (showWithholdingtax = false) and (showfranchisetax = false) then begin
                    SetFilter("No.", '<>S0011|<>S0012|<>S0007|<>S0008|<>S0009|<>S0010');
                end
                else
                    if (showfranchisetax = false) then begin
                        SetFilter("No.", '<>S0008|<>S0009|<>S0010');
                    end
                    else
                        if (showWithholdingtax = false) then
                            SetFilter("No.", '<>S0011|<>S0012|<>S0007');

            end;

            trigger OnAfterGetRecord()


            var
                myInt: Integer;
                glentries: Record "G/L Entry";

            begin
                invsite := '';
                invContract := '';
                invglaccountname := '';
                invGlEntryAmount := 0;
                invGlEntryAmountAdditionalcurr := 0;
                invGlEntryGlAccountNo := '';
                invGlEntryGlAccountName := '';

                invsite := FBM_Site;
                invheader.SetRange("No.", salesinvoiceline."Document No.");
                if invheader.FindFirst() then begin
                    if invsite = '' then
                        invsite := invheader.FBM_Site;
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


            end;



        }
        dataitem(salescrmemoline; "Sales Cr.Memo Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.");
            column(crmemopostingdate; "Posting Date")
            {

            }
            //column(invdocumenttype; "Document Type")
            // {

            //  }
            column(crmemodocumentno; "Document No.")
            {

            }
            column(crmemoNo; "No.")
            {

            }
            column(crcurreny; crmemoheader."Currency Code")
            {

            }
            column(crmemoDescr; "Description")
            {

            }
            column(crmemoGenBUsPost; "Gen. Bus. Posting Group")
            {

            }
            column(crmemoenProd; "Gen. Prod. Posting Group")
            {

            }
            column(crmemoamount; "Amount")
            {

            }
            column(crmemoperiodstart; salescrmemoline."FBM_Period Start")
            {

            }
            column(crmemoperiodend; salescrmemoline."FBM_Period End")
            {

            }
            column(crmemoglaccountname; crmemoglaccountname)
            {

            }

            column(crmemoContract; crmemoContract)
            {

            }
            column(crmemosite; crmemosite)
            {


            }

            column(linecrtype; salescrmemoline.Type)
            {

            }
            column(crmemoGlEntryAmount; crmemoGlEntryAmount)
            {
            }
            column(crmemoGlEntryAmountAdditionalcurr; crmemoGlEntryAmountAdditionalcurr)
            {
            }
            column(crmemoGlEntryGlAccountNo; crmemoGlEntryGlAccountNo)
            {
            }
            column(crmemoGlEntryGlAccountName; crmemoGlEntryGlAccountName)
            {
            }
            column(crstartmonth; crstartmonth)
            {
            }
            column(crendmonth; crendmonth)
            {
            }
            column(crDayMonthEnd; crDayMonthEnd)
            {
            }
            column(crDaysMonthBegin; crDaysMonthBegin)
            {
            }
            column(crdaysperiod; crdaysperiod)
            {
            }
            column(crSalesMonthBegin; crSalesMonthBegin)
            {
            }
            column(crSalesMonthEnd; crSalesMonthEnd)
            {
            }
            column(crSalesCustomerNo; "Sell-to Customer No.")
            {

            }
            column(crSalesCustomerName; crSalesCustomerName)
            { }
            column(crRegistrationDate; RegistrationDate)
            { }
            trigger OnPreDataItem()
            begin
                if (filters <> '')
                 then begin
                    salescrmemoline.SetFilter("Posting Date", salesinvoiceline.GetFilter("Posting Date"));
                    salescrmemoline.SetFilter("Sell-to Customer No.", salesinvoiceline.GetFilter("Sell-to Customer No."));
                end;

                if (showWithholdingtax = false) and (showfranchisetax = false) then begin
                    SetFilter("No.", '<>S0011|<>S0012|<>S0007|<>S0008|<>S0009|<>S0010');
                end
                else
                    if (showfranchisetax = false) then begin
                        SetFilter("No.", '<>S0008|<>S0009|<>S0010');
                    end
                    else
                        if (showWithholdingtax = false) then
                            SetFilter("No.", '<>S0011|<>S0012|<>S0007');


            end;

            trigger OnAfterGetRecord()


            var
                myInt: Integer;
                glentries: Record "G/L Entry";



            begin
                crmemosite := '';
                crmemoContract := '';
                crmemoglaccountname := '';
                crmemoGlEntryAmount := 0;
                crmemoGlEntryAmountAdditionalcurr := 0;
                crmemoGlEntryGlAccountNo := '';
                crmemoGlEntryGlAccountName := '';

                crmemosite := FBM_Site;
                crmemoheader.SetRange("No.", salescrmemoline."Document No.");
                if crmemoheader.FindFirst() then begin
                    if crmemosite = '' then
                        crmemosite := crmemoheader.FBM_Site;
                    crmemoContract := crmemoheader."FBM_Contract Code";
                    crSalesCustomerName := crmemoheader."Sell-to Customer Name";
                end;

                if glaccount.Get("No.") then begin
                    invglaccountname := glaccount.Name;
                end;
                if (crmemoheader."Currency Factor" > 0) then
                    crmemoGlEntryAmount := salescrmemoline.Amount / crmemoheader."Currency Factor"
                else
                    crmemoGlEntryAmount := salescrmemoline.Amount;
                if (salescrmemoline.Type = salescrmemoline.Type::Item) then begin
                    glentries.SetRange("Document No.", salescrmemoline."Document No.");
                    glentries.SetRange("Gen. Bus. Posting Group", salescrmemoline."Gen. Bus. Posting Group");
                    glentries.setrange("Gen. Prod. Posting Group", salescrmemoline."Gen. Prod. Posting Group");
                    if (glentries.findset) then begin
                        crmemoGlEntryGlAccountNo := glentries."G/L Account No.";
                        RegistrationDate := DT2DATE(glentries."Last Modified DateTime");
                        if glaccount.Get(glentries."G/L Account No.") then begin
                            crmemoGlEntryGlAccountName := glaccount.Name;
                        end;
                        // crmemoGlEntryGlAccountName := glentries."G/L Account Name";
                        // crmemoGlEntryAmount += glentries.Amount;
                        crmemoGlEntryAmountAdditionalcurr += glentries."Additional-Currency Amount";

                    end;

                end;

                if (salescrmemoline.Type = salescrmemoline.Type::"G/L Account") then begin
                    glentries.Reset();
                    glentries.SetRange("Document No.", salescrmemoline."Document No.");
                    glentries.SetRange("G/L Account No.", salescrmemoline."No.");
                    if (glentries.findset) then begin
                        if glaccount.Get("No.") then begin
                            crmemoglaccountname := glaccount.Name;
                        end;
                        // crmemoGlEntryAmount += glentries.Amount;
                        crmemoGlEntryAmountAdditionalcurr += glentries."Additional-Currency Amount";
                        RegistrationDate := DT2DATE(glentries."Last Modified DateTime");
                    end;

                end;

                // DATE CALCULATIONS FOR AMOUNT SEPARATION PER MONTH
                crstartmonth := 0;
                crendmonth := 0;
                crdaysperiod := 0;
                crPeriodEndday := 0;
                crDayMonthEnd := 0;
                crDaysMonthBegin := 0;
                crSalesMonthBegin := 0;
                crSalesMonthEnd := 0;
                if ("FBM_Period Start" <> 0D) and ("FBM_Period End" <> 0D) then begin
                    crstartmonth := DATE2DMY("FBM_Period Start", 2);
                    crendmonth := DATE2DMY("FBM_Period End", 2);
                    crdaysperiod := "FBM_Period End" - "FBM_Period Start" + 1;
                    crPeriodEndday := DATE2DMY("FBM_Period End", 1);
                    if (crstartmonth = crendmonth) then
                        crDayMonthEnd := crdaysperiod
                    else
                        crDayMonthEnd := crPeriodEndday;

                    if (crstartmonth = crendmonth) then
                        crDaysMonthBegin := 0
                    else
                        crDaysMonthBegin := crdaysperiod - crDayMonthEnd;

                    if (crstartmonth <> crendmonth) and (crdaysperiod > 0) then
                        crSalesMonthBegin := Amount * crDaysMonthBegin / crdaysperiod
                    else
                        crSalesMonthBegin := 0;
                    //Add Onetech convert USD
                    if (crmemoheader."Currency Factor" > 0) then
                        crSalesMonthBegin := crSalesMonthBegin / crmemoheader."Currency Factor";


                    if (crdaysperiod > 0) then
                        crSalesMonthEnd := Amount * crDayMonthEnd / crdaysperiod
                    else
                        crSalesMonthEnd := 0;

                    //Add Onetech convert USD
                    if (crmemoheader."Currency Factor" > 0) then
                        crSalesMonthEnd := crSalesMonthEnd / crmemoheader."Currency Factor";
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
                group(GroupName)
                {
                    field("Show Withholding Tax"; showWithholdingtax)
                    {
                        ApplicationArea = All;

                    }
                    field("Show Franchise Tax"; showfranchisetax)
                    {
                        ApplicationArea = All;

                    }




                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

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
}