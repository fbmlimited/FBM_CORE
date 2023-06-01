report 60100 "FBM_Bank Trial Balance_CO"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/R50005-BankTrialBalance.rdl';
    Caption = 'Bank Trial Balance';
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Bank Account";
        "Bank Account")
        {
            RequestFilterFields = "No.";

            column(Bank_Account_No_;
            "No.")
            {
            }
            column(Name;
            Name)
            {
            }
            column(PeriodStart;
            PeriodStart)
            {
            }
            column(PeriodEnd;
            PeriodEnd)
            {
            }
            column(ReportTitle;
            ReportTitle)
            {
            }
            column(Period_Cptn;
            Period_Cptn)
            {
            }
            column(CompanyName_Cptn;
            CompanyName_Cptn)
            {
            }
            column(AccountNo_Cptn;
            AccountNo_Cptn)
            {
            }
            column(Currency_Cptn;
            Currency_Cptn)
            {
            }
            column(OpenBal_Cptn;
            OpenBal_Cptn)
            {
            }
            column(NC11_Cptn;
            NC11_Cptn)
            {
            }
            column(NCP_Cptn;
            NCP_Cptn)
            {
            }
            column(CloseBal_Cptn;
            CloseBal_Cptn)
            {
            }
            column(DR_Cptn;
            DR_Cptn)
            {
            }
            column(CR_Cptn;
            CR_Cptn)
            {
            }
            column(CurrRecap_Cptn;
            CurrRecap_Cptn)
            {
            }
            column(Total_Cptn;
            Total_Cptn)
            {
            }
            column(CompanyName;
            CompanyName)
            {
            }
            column(BankCurr;
            "Currency Code")
            {
            }
            column(LCY;
            GLS."LCY Code")
            {
            }
            column(Op1BalLCY;
            BLE_Op1BalLCY)
            {
            }
            column(Op1BalFCY;
            BLE_Op1BalFCY)
            {
            }
            column(startdate;
            startdate)
            {
            }
            column(showFCY;
            showFCY)
            {
            }
            column(NCP_CR_FCY;
            NCP_CR_FCY)
            {
            }
            column(NCP_CR_LCY;
            NCP_CR_LCY)
            {
            }
            column(NCP_DR_FCY;
            NCP_DR_FCY)
            {
            }
            column(NCP_DR_LCY;
            NCP_DR_LCY)
            {
            }
            column(NC1_DR_FCY;
            NC1_DR_FCY)
            {
            }
            column(NC1_DR_LCY;
            NC1_DR_LCY)
            {
            }
            column(NC1_CR_FCY;
            NC1_CR_FCY)
            {
            }
            column(NC1_CR_LCY;
            NC1_CR_LCY)
            {
            }
            column(BLE_OPSBalLCY;
            BLE_OPSBalLCY)
            {
            }
            column(BLE_OPSBalFCY;
            BLE_OPSBalFCY)
            {
            }
            column(CloseBalFCY;
            CloseBalFCY)
            {
            }
            column(CloseBalLCY;
            CloseBalLCY)
            {
            }
            column(CloseBalLCY_DR;
            CloseBalLCY_DR)
            {
            }
            column(CloseBalLCY_CR;
            CloseBalLCY_CR)
            {
            }
            column(CloseBalFCY_DR;
            CloseBalFCY_DR)
            {
            }
            column(CloseBalFCY_CR;
            CloseBalFCY_CR)
            {
            }
            column(TotalOp1Bal;
            TotalOp1Bal)
            {
            }
            column(TotalNC1DR;
            TotalNC1DR)
            {
            }
            column(TotalNC1CR;
            TotalNC1CR)
            {
            }
            column(TotalOPSBal;
            TotalOPSBal)
            {
            }
            column(TotalNCPDR;
            TotalNCPDR)
            {
            }
            column(TotalNCPCR;
            TotalNCPCR)
            {
            }
            column(TotalCloseBalDR;
            TotalCloseBalDR)
            {
            }
            column(TotalCloseBalCR;
            TotalCloseBalCR)
            {
            }
            //column(FCYCurrencyTotalOP1; FCYCurrencyTotalOP1[CurrCount]) { }
            column(FCYCurrencyTotalOP11;
            FCYCurrencyTotalOP1[1])
            {
            }
            column(FCYCurrencyTotalOP1_1;
            FCYCurrencyTotalOP1[1])
            {
            }
            column(FCYCurrencyTotalNC1DR_1;
            FCYCurrencyTotalNC1DR[1])
            {
            }
            column(FCYCurrencyTotalNC1CR_1;
            FCYCurrencyTotalNC1CR[1])
            {
            }
            column(FCYCurrencyTotalOPS_1;
            FCYCurrencyTotalOPS[1])
            {
            }
            column(FCYCurrencyTotalNCPDR_1;
            FCYCurrencyTotalNCPDR[1])
            {
            }
            column(FCYCurrencyTotalNCPCR_1;
            FCYCurrencyTotalNCPCR[1])
            {
            }
            column(FCYCurrencyTotalCloseDR_1;
            FCYCurrencyTotalCloseDR[1])
            {
            }
            column(FCYCurrencyTotalCloseCr_1;
            FCYCurrencyTotalCloseCr[1])
            {
            }
            column(FCYCurrencyTotalOP1_2;
            FCYCurrencyTotalOP1[2])
            {
            }
            column(FCYCurrencyTotalNC1DR_2;
            FCYCurrencyTotalNC1DR[2])
            {
            }
            column(FCYCurrencyTotalNC1CR_2;
            FCYCurrencyTotalNC1CR[2])
            {
            }
            column(FCYCurrencyTotalOPS_2;
            FCYCurrencyTotalOPS[2])
            {
            }
            column(FCYCurrencyTotalNCPDR_2;
            FCYCurrencyTotalNCPDR[2])
            {
            }
            column(FCYCurrencyTotalNCPCR_2;
            FCYCurrencyTotalNCPCR[2])
            {
            }
            column(FCYCurrencyTotalCloseDR_2;
            FCYCurrencyTotalCloseDR[2])
            {
            }
            column(FCYCurrencyTotalCloseCr_2;
            FCYCurrencyTotalCloseCr[2])
            {
            }
            column(FCYCurrencyTotalOP1_3;
            FCYCurrencyTotalOP1[3])
            {
            }
            column(FCYCurrencyTotalNC1DR_3;
            FCYCurrencyTotalNC1DR[3])
            {
            }
            column(FCYCurrencyTotalNC1CR_3;
            FCYCurrencyTotalNC1CR[3])
            {
            }
            column(FCYCurrencyTotalOPS_3;
            FCYCurrencyTotalOPS[3])
            {
            }
            column(FCYCurrencyTotalNCPDR_3;
            FCYCurrencyTotalNCPDR[3])
            {
            }
            column(FCYCurrencyTotalNCPCR_3;
            FCYCurrencyTotalNCPCR[3])
            {
            }
            column(FCYCurrencyTotalCloseDR_3;
            FCYCurrencyTotalCloseDR[3])
            {
            }
            column(FCYCurrencyTotalCloseCr_3;
            FCYCurrencyTotalCloseCr[3])
            {
            }
            column(FCYCurrencyTotalOP1_4;
            FCYCurrencyTotalOP1[4])
            {
            }
            column(FCYCurrencyTotalNC1DR_4;
            FCYCurrencyTotalNC1DR[4])
            {
            }
            column(FCYCurrencyTotalNC1CR_4;
            FCYCurrencyTotalNC1CR[4])
            {
            }
            column(FCYCurrencyTotalOPS_4;
            FCYCurrencyTotalOPS[4])
            {
            }
            column(FCYCurrencyTotalNCPDR_4;
            FCYCurrencyTotalNCPDR[4])
            {
            }
            column(FCYCurrencyTotalNCPCR_4;
            FCYCurrencyTotalNCPCR[4])
            {
            }
            column(FCYCurrencyTotalCloseDR_4;
            FCYCurrencyTotalCloseDR[4])
            {
            }
            column(FCYCurrencyTotalCloseCr_4;
            FCYCurrencyTotalCloseCr[4])
            {
            }
            column(LCYCurrencyTotalOP1_1;
            LCYCurrencyTotalOP1[1])
            {
            }
            column(LCYCurrencyTotalNC1DR_1;
            LCYCurrencyTotalNC1DR[1])
            {
            }
            column(LCYCurrencyTotalNC1CR_1;
            LCYCurrencyTotalNC1CR[1])
            {
            }
            column(LCYCurrencyTotalOPS_1;
            LCYCurrencyTotalOPS[1])
            {
            }
            column(LCYCurrencyTotalNCPDR_1;
            LCYCurrencyTotalNCPDR[1])
            {
            }
            column(LCYCurrencyTotalNCPCR_1;
            LCYCurrencyTotalNCPCR[1])
            {
            }
            column(LCYCurrencyTotalCloseDR_1;
            LCYCurrencyTotalCloseDR[1])
            {
            }
            column(LCYCurrencyTotalCloseCr_1;
            LCYCurrencyTotalCloseCr[1])
            {
            }
            column(LCYCurrencyTotalOP1_2;
            LCYCurrencyTotalOP1[2])
            {
            }
            column(LCYCurrencyTotalNC1DR_2;
            LCYCurrencyTotalNC1DR[2])
            {
            }
            column(LCYCurrencyTotalNC1CR_2;
            LCYCurrencyTotalNC1CR[2])
            {
            }
            column(LCYCurrencyTotalOPS_2;
            LCYCurrencyTotalOPS[2])
            {
            }
            column(LCYCurrencyTotalNCPDR_2;
            LCYCurrencyTotalNCPDR[2])
            {
            }
            column(LCYCurrencyTotalNCPCR_2;
            LCYCurrencyTotalNCPCR[2])
            {
            }
            column(LCYCurrencyTotalCloseDR_2;
            LCYCurrencyTotalCloseDR[2])
            {
            }
            column(LCYCurrencyTotalCloseCr_2;
            LCYCurrencyTotalCloseCr[2])
            {
            }
            column(LCYCurrencyTotalOP1_3;
            LCYCurrencyTotalOP1[3])
            {
            }
            column(LCYCurrencyTotalNC1DR_3;
            LCYCurrencyTotalNC1DR[3])
            {
            }
            column(LCYCurrencyTotalNC1CR_3;
            LCYCurrencyTotalNC1CR[3])
            {
            }
            column(LCYCurrencyTotalOPS_3;
            LCYCurrencyTotalOPS[3])
            {
            }
            column(LCYCurrencyTotalNCPDR_3;
            LCYCurrencyTotalNCPDR[3])
            {
            }
            column(LCYCurrencyTotalNCPCR_3;
            LCYCurrencyTotalNCPCR[3])
            {
            }
            column(LCYCurrencyTotalCloseDR_3;
            LCYCurrencyTotalCloseDR[3])
            {
            }
            column(LCYCurrencyTotalCloseCr_3;
            LCYCurrencyTotalCloseCr[3])
            {
            }
            column(LCYCurrencyTotalOP1_4;
            LCYCurrencyTotalOP1[4])
            {
            }
            column(LCYCurrencyTotalNC1DR_4;
            LCYCurrencyTotalNC1DR[4])
            {
            }
            column(LCYCurrencyTotalNC1CR_4;
            LCYCurrencyTotalNC1CR[4])
            {
            }
            column(LCYCurrencyTotalOPS_4;
            LCYCurrencyTotalOPS[4])
            {
            }
            column(LCYCurrencyTotalNCPDR_4;
            LCYCurrencyTotalNCPDR[4])
            {
            }
            column(LCYCurrencyTotalNCPCR_4;
            LCYCurrencyTotalNCPCR[4])
            {
            }
            column(LCYCurrencyTotalCloseDR_4;
            LCYCurrencyTotalCloseDR[4])
            {
            }
            column(LCYCurrencyTotalCloseCr_4;
            LCYCurrencyTotalCloseCr[4])
            {
            }
            column(indextoupdate;
            IndexToUpdate)
            {
            }
            column(showPHP;
            showPHP)
            {
            }
            column(showUSD;
            showUSD)
            {
            }
            column(showMX;
            showMX)
            {
            }
            column(showEUR;
            showEUR)
            {
            }
            //Bank account
            trigger OnAfterGetRecord()
            begin //1
                  //create start date
                Clear(StartDateYear);
                Clear(BLE_Op1BalLCY);
                Clear(BLE_Op1BalFCY);
                Clear(NC1_DR_FCY);
                Clear(NC1_CR_FCY);
                Clear(NC1_DR_LCY);
                Clear(NC1_CR_LCY);
                Clear(BLE_OPSBalLCY);
                Clear(BLE_OPSBalFCY);
                Clear(NCP_CR_LCY);
                Clear(NCP_DR_LCY);
                Clear(NCP_CR_FCY);
                Clear(NCP_DR_FCY);
                Clear(CloseBalFCY);
                Clear(CloseBalLCY);
                Clear(CloseBalFCY_DR);
                Clear(CloseBalFCY_CR);
                Clear(CloseBalLCY_DR);
                Clear(CloseBalLCY_CR);
                /* CLEAR(TotalOp1Bal);
                            CLEAR(TotalNC1DR);
                            CLEAR(TotalNC1CR);
                            CLEAR(TotalOPSBal);
                            CLEAR(TotalNCPDR);
                            CLEAR(TotalNCPCR);
                            CLEAR(TotalCloseBalDR);
                            CLEAR(TotalCloseBalCR); */
                clear(FCYCurrencies);
                Clear(i);
                Clear(j);
                //get year from Period Start
                StartDateYear := FORMAT(DATE2DMY(PeriodStart, 3));
                StartDateYear := '0101' + StartDateYear;
                Evaluate(startdate, StartDateYear);
                //Get Opening Balance as at 1.1. -----------------------------------------
                BLE_OP1.Reset();
                BLE_Op1.SetCurrentKey("Bank Account No.", "Posting Date");
                BLE_Op1.SetFilter(BLE_Op1."Bank Account No.", "Bank Account"."No.");
                BLE_OP1.SetFilter(BLE_Op1."Posting Date", '..%1', startdate);
                if BLE_Op1.FindSet() then begin //2
                    repeat begin //3
                        BLE_Op1BalLCY += BLE_Op1."Amount (LCY)";
                        BLE_Op1BalFCY += BLE_Op1.Amount;
                        TotalOp1Bal += BLE_OP1BalLCY;
                    end; //3
                    until (BLE_Op1.Next = 0);
                end; //2
                     //calculate Net Change Since 1.1. -------------------------------
                BLE_NC1.Reset();
                BLE_NC1.SetCurrentKey("Bank Account No.", "Posting Date");
                BLE_NC1.SetFilter(BLE_NC1."Bank Account No.", "Bank Account"."No.");
                BLE_NC1.SetFilter(BLE_NC1."Posting Date", '%1..%2', startdate, PeriodEnd);
                if BLE_NC1.FindSet() then begin //4
                    repeat begin //5
                        if BLE_NC1.Amount > 0 then begin //6
                                                         //Debit
                            NC1_DR_FCY += BLE_NC1.Amount;
                            NC1_DR_LCY += BLE_NC1."Amount (LCY)";
                            TotalNC1DR += NC1_DR_LCY;
                        end //6
                        else begin //7
                                   //Credit
                            NC1_CR_FCY += BLE_NC1.Amount * -1;
                            NC1_CR_LCY += BLE_NC1."Amount (LCY)" * -1;
                        end; //7
                    end; //5
                    until (BLE_NC1.Next = 0);
                    NC1_CR_FCY := NC1_CR_FCY * -1;
                    NC1_CR_LCY := NC1_CR_LCY * -1;
                    TotalNC1CR += NC1_CR_LCY;
                end; //4
                     //get opening balance as at period start -----------------------------------------
                BLE_OPS.Reset();
                BLE_OPS.SetCurrentKey("Bank Account No.", "Posting Date");
                BLE_OPS.SetFilter(BLE_OPS."Bank Account No.", "Bank Account"."No.");
                BLE_OPS.SetFilter("Posting Date", '..%1', PeriodStart);
                if BLE_OPS.FindSet() then begin //8
                    repeat begin //9
                        BLE_OPSBalLCY += BLE_OPS."Amount (LCY)";
                        BLE_OPSBalFCY += BLE_OPS.Amount;
                        TotalOPSBal += BLE_OPSBalLCY;
                    end; //9
                    until (BLE_OPS.Next = 0);
                end; //8
                     //calculate Net Change in Period   -----------------------------------------              
                BLE_NCP.Reset();
                BLE_NCP.SetCurrentKey("Bank Account No.", "Posting Date");
                BLE_NCP.SetFilter(BLE_NCP."Bank Account No.", "Bank Account"."No.");
                BLE_NCP.SetFilter(BLE_NCP."Posting Date", '%1..%2', PeriodStart, PeriodEnd);
                if BLE_NCP.FindSet() then begin //10
                    repeat begin //11
                        if BLE_NCP.Amount > 0 then begin //12
                                                         //Debit
                            NCP_DR_FCY += BLE_NCP.Amount;
                            NCP_DR_LCY += BLE_NCP."Amount (LCY)";
                            TotalNCPDR += NCP_DR_LCY;
                        end //12
                        else begin //13
                                   //Credit
                            NCP_CR_FCY += BLE_NCP.Amount * -1;
                            NCP_CR_LCY += BLE_NCP."Amount (LCY)" * -1;
                        end; //13
                    end; //11
                    until (BLE_NCP.Next = 0);
                    NCP_CR_FCY := NCP_CR_FCY * -1;
                    NCP_CR_LCY := NCP_CR_LCY * -1;
                    TotalNCPCR += NCP_CR_LCY;
                end; //10
                     //get closing balance as at period end -----------------------------------------
                BLE_Close.Reset();
                BLE_Close.SetCurrentKey("Bank Account No.", "Posting Date");
                BLE_Close.SetFilter("Bank Account No.", "Bank Account"."No.");
                BLE_Close.SetFilter(BLE_Close."Posting Date", '..%1', PeriodEnd);
                if BLE_Close.FindSet() then begin //14
                    CloseBalLCY += BLE_Close."Amount (LCY)";
                    CloseBalFCY += BLE_Close.Amount;
                end; //14
                if CloseBalFCY >= 0 then
                    CloseBalFCY_DR := CloseBalFCY
                else
                    CloseBalFCY_CR := CloseBalFCY;
                if CloseBalLCY >= 0 then begin //15
                    CloseBalLCY_DR := CloseBalLCY;
                    TotalCloseBalDR += NCP_DR_LCY;
                end //15
                else begin //16
                    CloseBalLCY_CR := CloseBalLCY;
                    TotalCloseBalCR += CloseBalLCY_CR;
                end; //16
                     //determine whether to show FCY-----------------------------------------
                if "Bank Account"."Currency Code" = GLS."LCY Code" then
                    showFCY := false
                else
                    showFCY := true;
                //CURRENCY RECAPITULATION - update F/LCY currency totals array-----------------------------------------                
                case "Bank Account"."Currency Code" of //17
                    'USD':
                        begin
                            IndexToUpdate := 1;
                            showUSD := true;
                        end;
                    '':
                        begin
                            IndexToUpdate := 1;
                            showUSD := true;
                        end;
                    'PHP':
                        begin
                            IndexToUpdate := 2;
                            showPHP := true;
                        end;
                    'EUR':
                        begin
                            IndexToUpdate := 3;
                            showEUR := true;
                        end;
                    'MX':
                        begin
                            IndexToUpdate := 4;
                            showMX := true;
                        end;
                end; //17
                if ((IndexToUpdate >= 2) AND (IndexToUpdate <= 4)) then begin //18
                    FCYCurrencyTotalOP1[IndexToUpdate] += BLE_OP1BalFCY;
                    FCYCurrencyTotalNC1DR[IndexToUpdate] += NC1_DR_FCY;
                    FCYCurrencyTotalNC1CR[IndexToUpdate] += NC1_CR_FCY;
                    FCYCurrencyTotalOPS[IndexToUpdate] += BLE_OPSBalFCY;
                    FCYCurrencyTotalNCPDR[IndexToUpdate] += NCP_DR_FCY;
                    FCYCurrencyTotalNCPCR[IndexToUpdate] += NCP_CR_FCY;
                    FCYCurrencyTotalCloseDR[IndexToUpdate] += CloseBalFCY_DR;
                    FCYCurrencyTotalCloseCr[IndexToUpdate] += CloseBalFCY_CR;
                    LCYCurrencyTotalOP1[IndexToUpdate] += BLE_OP1BalLCY;
                    LCYCurrencyTotalNC1DR[IndexToUpdate] += NC1_DR_LCY;
                    LCYCurrencyTotalNC1CR[IndexToUpdate] += NC1_CR_LCY;
                    LCYCurrencyTotalOPS[IndexToUpdate] += BLE_OPSBalLCY;
                    LCYCurrencyTotalNCPDR[IndexToUpdate] += NCP_DR_LCY;
                    LCYCurrencyTotalNCPCR[IndexToUpdate] += NCP_CR_LCY;
                    LCYCurrencyTotalCloseDR[IndexToUpdate] += CloseBalLCY_DR;
                    LCYCurrencyTotalCloseCr[IndexToUpdate] += CloseBalLCY_CR;
                end //18
                else begin //19
                    if (IndexToUpdate = 1) then begin //20
                        FCYCurrencyTotalOP1[IndexToUpdate] += BLE_OP1BalLCY;
                        FCYCurrencyTotalNC1DR[IndexToUpdate] += NC1_DR_LCY;
                        FCYCurrencyTotalNC1CR[IndexToUpdate] += NC1_CR_LCY;
                        FCYCurrencyTotalOPS[IndexToUpdate] += BLE_OPSBalLCY;
                        FCYCurrencyTotalNCPDR[IndexToUpdate] += NCP_DR_LCY;
                        FCYCurrencyTotalNCPCR[IndexToUpdate] += NCP_CR_LCY;
                        FCYCurrencyTotalCloseDR[IndexToUpdate] += CloseBalLCY_DR;
                        FCYCurrencyTotalCloseCr[IndexToUpdate] += CloseBalLCY_CR;
                        LCYCurrencyTotalOP1[IndexToUpdate] += BLE_OP1BalLCY;
                        LCYCurrencyTotalNC1DR[IndexToUpdate] += NC1_DR_LCY;
                        LCYCurrencyTotalNC1CR[IndexToUpdate] += NC1_CR_LCY;
                        LCYCurrencyTotalOPS[IndexToUpdate] += BLE_OPSBalLCY;
                        LCYCurrencyTotalNCPDR[IndexToUpdate] += NCP_DR_LCY;
                        LCYCurrencyTotalNCPCR[IndexToUpdate] += NCP_CR_LCY;
                        LCYCurrencyTotalCloseDR[IndexToUpdate] += CloseBalLCY_DR;
                        LCYCurrencyTotalCloseCr[IndexToUpdate] += CloseBalLCY_CR;
                    end; //20
                end; //19
            end; //1   
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
                    Caption = 'Options';

                    field(PeriodStart; PeriodStart)
                    {
                        ApplicationArea = All;
                        Caption = 'Period Start Date';
                    }
                    field(PeriodEnd; PeriodEnd)
                    {
                        ApplicationArea = All;
                        Caption = 'Period End Date';
                    }
                }
            }
        }
    }
    var
        PeriodStart: Date;
        PeriodEnd: Date;
        ReportTitle: Label 'Bank Trial Balance';
        Period_Cptn: Label 'Period: ';
        CompanyName_Cptn: Label 'Company:';
        AccountNo_Cptn: Label 'Account No.';
        Currency_Cptn: Label 'Currency';
        OpenBal_Cptn: Label 'Opening Bal.';
        NC11_Cptn: Label 'Net Change since 1.1.';
        NCP_Cptn: Label 'Net Change in period';
        CloseBal_Cptn: Label 'Closing Balance';
        DR_Cptn: Label 'Debit';
        CR_Cptn: Label 'Credit';
        CurrRecap_Cptn: Label 'Currency Recapitulation: ';
        Total_Cptn: Label 'TOTAL: ';
        GLS: Record "General Ledger Setup";
        StartDateYear: Text[10];
        startdate: Date;
        showFCY: Boolean;
        BLE_NCP: Record "Bank Account Ledger Entry";
        NCP_DR_LCY: Decimal;
        NCP_CR_LCY: Decimal;
        NCP_DR_FCY: Decimal;
        NCP_CR_FCY: Decimal;
        BLE_OPS: Record "Bank Account Ledger Entry";
        BLE_OPSBalLCY: Decimal;
        BLE_OPSBalFCY: Decimal;
        BLE_OP1: Record "Bank Account Ledger Entry";
        BLE_OP1BalLCY: Decimal;
        BLE_OP1BalFCY: Decimal;
        BLE_NC1: Record "Bank Account Ledger Entry";
        NC1_DR_LCY: Decimal;
        NC1_CR_LCY: Decimal;
        NC1_DR_FCY: Decimal;
        NC1_CR_FCY: Decimal;
        BLE_Close: Record "Bank Account Ledger Entry";
        CloseBalLCY: Decimal;
        CloseBalFCY: Decimal;
        CloseBalFCY_DR: Decimal;
        CloseBalFCY_CR: Decimal;
        CloseBalLCY_DR: Decimal;
        CloseBalLCY_CR: Decimal;
        TotalOp1Bal: Decimal;
        TotalNC1DR: Decimal;
        TotalNC1CR: Decimal;
        TotalOPSBal: Decimal;
        TotalNCPDR: Decimal;
        TotalNCPCR: Decimal;
        TotalCloseBalDR: Decimal;
        TotalCloseBalCR: Decimal;
        FCYCurrencies: array[25] of code[10];
        i: Integer;
        j: Integer;
        CER_Today: Decimal;
        CER: Record "Currency Exchange Rate";
        LCYCurrencyTotalOP1: array[25] of Decimal;
        LCYCurrencyTotalNC1DR: array[25] of Decimal;
        LCYCurrencyTotalNC1CR: array[25] of Decimal;
        LCYCurrencyTotalOPS: array[25] of Decimal;
        LCYCurrencyTotalNCPDR: array[25] of Decimal;
        LCYCurrencyTotalNCPCR: array[25] of Decimal;
        LCYCurrencyTotalCloseDR: array[25] of Decimal;
        LCYCurrencyTotalCloseCr: array[25] of Decimal;
        FCYCurrencyTotalOP1: array[25] of Decimal;
        FCYCurrencyTotalNC1DR: array[25] of Decimal;
        FCYCurrencyTotalNC1CR: array[25] of Decimal;
        FCYCurrencyTotalOPS: array[25] of Decimal;
        FCYCurrencyTotalNCPDR: array[25] of Decimal;
        FCYCurrencyTotalNCPCR: array[25] of Decimal;
        FCYCurrencyTotalCloseDR: array[25] of Decimal;
        FCYCurrencyTotalCloseCr: array[25] of Decimal;
        IndexToUpdate: Integer;
        showPHP: Boolean;
        showMX: Boolean;
        showEUR: Boolean;
        showUSD: Boolean;

    procedure CurrencyInArray(CurrCode: Code[10]): Integer
    begin
        //check if currency is in array
        clear(j);
        for j := 1 to ArrayLen(FCYCurrencies) do begin
            if FCYCurrencies[j] = CurrCode then exit(i);
        end;
        exit(0);
    end;

    trigger OnInitReport()
    begin
        GLS.Reset();
        GLS.Get();
        showPHP := false;
        showMX := false;
        showEUR := false;
        showUSD := false;
    end;
}
