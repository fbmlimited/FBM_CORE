codeunit 60101 FBM_Dimensions_CO
{
    Permissions = tabledata "G/L Entry" = rimd;
    trigger OnRun()
    begin
        /* //create customer dimensions ---------------------------------------------------------------------------------------------------------------------------
            Customer.Reset();
            //Customer.SetFilter("No.", 'PH07SG');
            if Customer.FindFirst() then begin
                repeat
                begin
                    FADM.AddDimensions(Customer);
                end;
                until (Customer.next = 0);
            end; */
        //create site dimensions ---------------------------------------------------------------------------------------------------------------------------
        CS.Reset();
        //cs.SetFilter("Site Code", 'MX0014-0023');
        if CS.FindSet() then begin
            repeat begin
                //Message('started');
                //CS.CheckUniqueSite(CS."Site Code");
                FADM.CreateSiteDim(CS);
                //CS.UpdateCustOpSite(CS);
            end;
            until (Cs.next = 0);
        end;
        /*
                      //posted sales invoices ---------------------------------------------------------------------------------------------------------------------------
                      psi.Reset();
                      DimSet.Reset();
                      //psi.SetFilter("No.", '%1', '2011.0001');
                      if psi.FindFirst() then begin
                          repeat
                          begin
                              CLEAR(DSE_No);
                              if psi."Dimension Set ID" <> 0 then begin
                                  DimSet.Setfilter("Dimension Set ID", FORMAT(PSI."Dimension Set ID"));
                                  if DimSet.FindFirst() then begin
                                      //check if customer dimension is created
                                      DSC.Reset();
                                      dv.Reset();
                                      if not DSC.Get(DimSet."Dimension Set ID", 'CUSTOMERS') then begin
                                          if DV.Get('CUSTOMERS', PSI."Sell-to Customer No.") then begin
                                              DSE.reset;
                                              DSE.Init();
                                              DSE."Dimension Set ID" := psi."Dimension Set ID";
                                              DSE."Dimension Code" := 'CUSTOMERS';
                                              DSE."Dimension Value Code" := psi."Sell-to Customer No.";
                                              DSE."Dimension Value ID" := DV."Dimension Value ID";
                                              DSE.Insert();
                                          end;
                                      end;
                                      //get cust def dim
                                      CDD.reset;
                                      DSO.Reset();
                                      DV.Reset();
                                      CDD.SetFilter("Table ID", '18');
                                      CDD.SetFilter("No.", PSI."Sell-to Customer No.");
                                      cdd.SetFilter("Dimension Code", 'OPERATORS');
                                      if CDD.FindFirst() then begin
                                          if not DSO.Get(DimSet."Dimension Set ID", 'OPERATORS') then begin
                                              if DV.Get('OPERATORS', CDD."Dimension Value Code") then begin
                                                  //message('OPERATORS');
                                                  DSO.Reset();
                                                  DSO.Init();
                                                  DSO."Dimension Set ID" := psi."Dimension Set ID";
                                                  DSO."Dimension Code" := 'OPERATORS';
                                                  DSO."Dimension Value Code" := CDD."Dimension Value Code";
                                                  DSO."Dimension Value ID" := DV."Dimension Value ID";
                                                  DSO.Insert();
                                                  //message('OPERATORS INSERTED - %1', DSO."Dimension Set ID");
                                              end;
                                          end;
                                      end;
                                      if PSI.Site <> '' then begin
                                          //check if hall dimension is created
                                          DSH.Reset();
                                          dv.Reset();
                                          if not DSH.Get(DimSet."Dimension Set ID", 'HALL') then begin
                                              if DV.Get('HALL', PSI.Site) then begin
                                                  DSH.Reset();
                                                  DSH.Init();
                                                  DSH."Dimension Set ID" := psi."Dimension Set ID";
                                                  DSH."Dimension Code" := 'HALL';
                                                  DSH."Dimension Value Code" := psi.Site;
                                                  DSH."Dimension Value ID" := DV."Dimension Value ID";
                                                  DSH.Insert();
                                              end;
                                          end;
                                      end;
                                  end;
                              end
                              else begin //no dim set entry
                                  //message('begin');
                                  DSC.Reset();
                                  dv.Reset();
                                  dimsetentry.reset;
                                  clear(DSE_No);
                                  dimsetentry.FindLast();
                                  DSE_No := dimsetentry."Dimension Set ID" + 1;

                                  if DV.Get('CUSTOMERS', PSI."Sell-to Customer No.") then begin
                                      //message('CUSTOMERS');
                                      DSE.reset;
                                      DSE.Init();
                                      DSE."Dimension Set ID" := DSE_No;
                                      DSE."Dimension Code" := 'CUSTOMERS';
                                      DSE."Dimension Value Code" := psi."Sell-to Customer No.";
                                      DSE."Dimension Value ID" := DV."Dimension Value ID";
                                      DSE.Insert();
                                      message('CUSTOMERS INSERTED - %1', DSE."Dimension Set ID");
                                  end;

                                  //operators
                                  DSO.Reset();
                                  dv.Reset();

                                  //get cust def dim
                                  CDD.reset;
                                  CDD.SetFilter("Table ID", '18');
                                  CDD.SetFilter("No.", PSI."Sell-to Customer No.");
                                  cdd.SetFilter("Dimension Code", 'OPERATORS');
                                  if CDD.FindFirst() then begin
                                      if DV.Get('OPERATORS', CDD."Dimension Value Code") then begin
                                          //message('OPERATORS');
                                          DSO.Reset();
                                          DSO.Init();
                                          DSO."Dimension Set ID" := DSE_No;
                                          DSO."Dimension Code" := 'OPERATORS';
                                          DSO."Dimension Value Code" := CDD."Dimension Value Code";
                                          DSO."Dimension Value ID" := DV."Dimension Value ID";
                                          DSO.Insert();
                                          //message('OPERATORS INSERTED - %1', DSO."Dimension Set ID");
                                      end;
                                  end;

                                  if PSI.Site <> '' then begin
                                      //check if hall dimension is created
                                      DSH.Reset();
                                      dv.Reset();

                                      if DV.Get('HALL', PSI.Site) then begin
                                          //message('HALLS');
                                          DSH.Reset();
                                          DSH.Init();
                                          DSH."Dimension Set ID" := DSE_No;
                                          DSH."Dimension Code" := 'HALL';
                                          DSH."Dimension Value Code" := psi.Site;
                                          DSH."Dimension Value ID" := DV."Dimension Value ID";
                                          DSH.Insert();
                                          //message('HALLS INSERTED - %1', DSH."Dimension Set ID");
                                      end;
                                  end;

                                  PSI."Dimension Set ID" := DSE_No;
                                  PSI.Modify(false);
                                  //message('PSI INSERTED - %1', PSI."Dimension Set ID");
                              end;
                          end;
                          until (psi.next = 0);
                      end;
              */
        /*CDD.reset;
              CDD.SetFilter("Table ID", '18');
              CDD.SetFilter("No.", PSI."Sell-to Customer No.");
              cdd.SetFilter("Dimension Code", 'OPERATORS');
              if CDD.FindFirst() then
                  operator := cdd."Dimension Value Code"
              else
                  operator := ''; */
        /* //salesheader   ---------------------------------------------------------------------------------------------------------------------------
              //salesheader.setfilter(SalesHeader."No.", '2011.0002');
              SalesHeader.reset;
              if SalesHeader.FindFirst() then begin
                  repeat begin
                      //SalesHeader.CreateDim(Database::Customer, SalesHeader."Sell-to Customer No.", Database::"Customer-Site", SalesHeader.Site, Database::"Cust-Op-Site", operator, DATABASE::"Responsibility Center", salesheader."Responsibility Center",
                      //DATABASE::"Customer Template", SalesHeader."Bill-to Customer Template Code");
                      if SalesHeader."Sell-to Customer No." <> '' then begin
                          SalesHeader.CreateDim(Database::Customer, SalesHeader."Sell-to Customer No.",
                                                DATABASE::"Salesperson/Purchaser", SalesHeader."Salesperson Code",
                                                DATABASE::Campaign, SalesHeader."Campaign No.",
                                                DATABASE::"Responsibility Center", SalesHeader."Responsibility Center",
                                                DATABASE::"Customer Template", SalesHeader."Bill-to Customer Template Code");
                      end;
                  end;
                  until (SalesHeader.next = 0);
              end; */
        /* //TODO -- check if PSI.Site is passed as parameter
              //sales invoice header ---------------------------------------------------------------------------------------------------------------------------
              PSI.reset;
              //psi.SetFilter("No.", '%1', '2011.0001');
              if PSI.FindFirst() then begin
                  repeat begin
                      if PSI."Dimension Set ID" = 0 then begin
                          PSICreateDim(PSI, Database::Customer, PSI."Sell-to Customer No.", Database::"Customer-Site", PSI.Site, Database::"Cust-Op-Site", operator, DATABASE::"Responsibility Center", salesheader."Responsibility Center",
                          DATABASE::"Customer Template", SalesHeader."Bill-to Customer Template Code");
                      end;
                  end;
                  until (PSI.next = 0);
              end; */
        /* PSI.reset;
              psi.SetFilter("Dimension Set ID", '<>%1', 0);
              psi.SetFilter(Site, '<>%1', '');
              //psi.setfilter(psi."No.", '2012.0531');
              if PSI.FindFirst() then begin
                  repeat begin
                      if PSI.Site <> '' then begin
                          DSC.reset;
                          dv.Reset();
                          if not DSC.Get(PSI."Dimension Set ID", 'CUSTOMERS') then begin
                              if DV.Get('CUSTOMERS', PSI."Sell-to Customer No.") then begin
                                  DSC.Reset();
                                  DSC.Init();
                                  DSC."Dimension Set ID" := psi."Dimension Set ID";
                                  DSC."Dimension Code" := 'CUSTOMERS';
                                  DSC."Dimension Value Code" := psi."Sell-to Customer No.";
                                  DSC."Dimension Value ID" := DV."Dimension Value ID";
                                  DSC.Insert();
                              end;
                          end;

                          DSO.Reset();
                          dv.Reset();
                          if not DSO.Get(PSI."Dimension Set ID", 'OPERATORS') then begin
                              if DV.Get('OPERATORS', PSI."Sell-to Customer No.") then begin
                                  DSO.Reset();
                                  DSO.Init();
                                  DSO."Dimension Set ID" := psi."Dimension Set ID";
                                  DSO."Dimension Code" := 'OPERATORS';
                                  DSO."Dimension Value Code" := psi."Sell-to Customer No.";
                                  DSO."Dimension Value ID" := DV."Dimension Value ID";
                                  DSO.Insert();
                              end;
                          end;
                      end;
                  end;
                  until (PSI.next = 0);
              end; */
        /* //sales CM header ---------------------------------------------------------------------------------------------------------------------------
              PSCM.reset;
              //pscm.SetFilter("No.", '%1', '2029.0001');
              if PSCM.FindFirst() then begin
                  repeat begin
                      if PSCM."Dimension Set ID" = 0 then begin
                          PSCMCreateDim(PSCM, Database::Customer, PSCM."Sell-to Customer No.", Database::"Customer-Site", PSCM.Site, Database::"Cust-Op-Site", operator, DATABASE::"Responsibility Center", pscm."Responsibility Center",
                          DATABASE::"Customer Template", SalesHeader."Bill-to Customer Template Code");
                      end;
                  end;
                  until (PSCM.next = 0);
              end; */
        /* PSCM.reset;
              PSCM.SetFilter("Dimension Set ID", '<>%1', 0);
              PSCM.SetFilter(Site, '<>%1', '');
              //PSCM.setfilter(PSCM."No.", '2012.0531');
              if PSCM.FindFirst() then begin
                  repeat begin
                      if PSCM.Site <> '' then begin
                          DSC.reset;
                          dv.Reset();
                          if not DSC.Get(PSCM."Dimension Set ID", 'CUSTOMERS') then begin
                              if DV.Get('CUSTOMERS', PSCM."Sell-to Customer No.") then begin
                                  DSC.Reset();
                                  DSC.Init();
                                  DSC."Dimension Set ID" := PSCM."Dimension Set ID";
                                  DSC."Dimension Code" := 'CUSTOMERS';
                                  DSC."Dimension Value Code" := PSCM."Sell-to Customer No.";
                                  DSC."Dimension Value ID" := DV."Dimension Value ID";
                                  DSC.Insert();
                              end;
                          end;

                          DSO.Reset();
                          dv.Reset();
                          if not DSO.Get(PSCM."Dimension Set ID", 'OPERATORS') then begin
                              if DV.Get('OPERATORS', PSCM."Sell-to Customer No.") then begin
                                  DSO.Reset();
                                  DSO.Init();
                                  DSO."Dimension Set ID" := PSCM."Dimension Set ID";
                                  DSO."Dimension Code" := 'OPERATORS';
                                  DSO."Dimension Value Code" := PSCM."Sell-to Customer No.";
                                  DSO."Dimension Value ID" := DV."Dimension Value ID";
                                  DSO.Insert();
                              end;
                          end;
                      end;
                  end;
                  until (PSCM.next = 0);
              end; */
        /* //cust. ledger entries ---------------------------------------------------------------------------------------------------------------------------
              CLE.Reset();
              if CLE.FindSet() then begin
                  repeat begin
                      if CLE."Dimension Set ID" = 0 then begin
                          if CLE."Document Type" = CLE."Document Type"::Invoice then begin
                              PSI.Reset();
                              if PSI.Get(cle."Document No.") then begin
                                  Cle.validate(CLE."Dimension Set ID", PSI."Dimension Set ID");
                                  CLE.Modify();
                              end;
                          end
                          else begin
                              if cle."Document Type" = CLE."Document Type"::"Credit Memo" then begin
                                  PSCM.Reset();
                                  if PSCM.Get(CLE."Document No.") then begin
                                      CLE.Validate("Dimension Set ID", PSCM."Dimension Set ID");
                                      CLE.Modify();
                                  end;
                              end;
                          end;
                      end;
                  end;
                  until (CLE.next = 0);
              end; */
        /* //gen. ledger entries ---------------------------------------------------------------------------------------------------------------------------
              GLE.Reset();
              //gle.SetFilter("Entry No.", '2467');
              if GLE.findset then begin
                  repeat begin
                      if GLE."Dimension Set ID" = 0 then begin
                          if GLE."Document Type" = GLE."Document Type"::Invoice then begin
                              psi.reset;
                              if psi.get(gle."Document No.") then begin
                                  gle.validate(gle."Dimension Set ID", psi."Dimension Set ID");
                                  gle.Modify();
                              end
                          end
                          else begin
                              if gle."Document Type" = gle."Document Type"::"Credit Memo" then begin
                                  PSCM.Reset();
                                  if PSCM.get(gle."Document No.") then begin
                                      gle.Validate(gle."Dimension Set ID", pscm."Dimension Set ID");
                                      gle.Modify();
                                  end;
                              end;
                          end;
                      end;
                  end;
                  until (GLE.next = 0);
              end; */
        /* //Sales Lines
              SalesLine.Reset();
              SH.Reset();
              if SalesLine.findfirst then begin
                  repeat begin
                      if SH.Get(SalesLine."Document Type", SalesLine."Document No.") then begin
                          if SH."Dimension Set ID" <> 0 then begin
                              SalesLine.Validate(SalesLine."Dimension Set ID", SH."Dimension Set ID");
                              SalesLine.Modify();
                          end;
                      end;
                  end;
                  until (SalesLine.next = 0);
              end;

              //sales invoice line
              SalesInvLine.Reset();
              SIHeader.Reset();
              if SalesInvLine.FindFirst() then begin
                  repeat begin
                      if SIHeader.get(SalesInvLine."Document No.") then begin
                          if SIHeader."Dimension Set ID" <> 0 then begin
                              SalesInvLine.validate("Dimension Set ID", SIHeader."Dimension Set ID");
                              SalesInvLine.Modify();
                          end;
                      end;
                  end;
                  until (SalesInvLine.next = 0);
              end;

              //sales cr memo line
              SalesCMLine.Reset();
              SCMHeader.Reset();
              if SalesCMLine.FindFirst() then begin
                  repeat begin
                      if SCMHeader.get(SalesCMLine."Document No.") then begin
                          if SCMHeader."Dimension Set ID" <> 0 then begin
                              SalesCMLine.validate("Dimension Set ID", SCMHeader."Dimension Set ID");
                              SalesCMLine.Modify();
                          end;
                      end;
                  end;
                  until (SalesCMLine.next = 0);
              end; */
        /* //checks ---------------------------------------------------------------------------------------------------------------------------
              Customer.Reset();
              if customer.FindSet() then begin
                  repeat begin
                      DV.reset;
                      dv.setfilter("Dimension Code", 'CUSTOMERS');
                      dv.setfilter(Code, Customer."No.");
                      if not dv.FindFirst() then begin
                          message('Customer not found -- %1', Customer."No.");
                      end;
                  end;
                  until (Customer.next = 0);

                  Message('Customers Done');
              end;

              CS.Reset();
              if cs.FindSet() then begin
                  repeat begin
                      dv.Reset();
                      dv.setfilter("Dimension Code", 'HALL');
                      dv.SetFilter(Code, cs."Site Code");
                      if not dv.findfirst() then begin
                          message('Site not found -- %1', cs."Site Code");
                      end;
                  end;
                  until (CS.next = 0);
                  Message('Sites Done');
              end; */
    end;

    procedure PSICreateDim(PSInv: Record "Sales Invoice Header";
    Type1: Integer;
    No1: Code[20];
    Type2: Integer;
    No2: Code[20];
    Type3: Integer;
    No3: Code[20];
    Type4: Integer;
    No4: Code[20];
    Type5: Integer;
    No5: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableId: Array[10] of Integer;
        No: Array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        TableID[5] := Type5;
        No[5] := No5;
        PSInv."Shortcut Dimension 1 Code" := '';
        PSInv."Shortcut Dimension 2 Code" := '';
        OldDimSetID := PSInv."Dimension Set ID";
        PSInv."Dimension Set ID" := DimMgmt.GetRecDefaultDimID(PSInv, 2, TableID, No, SourceCodeSetup.Sales, PSInv."Shortcut Dimension 1 Code", PSInv."Shortcut Dimension 2 Code", 0, 0);
        IF (OldDimSetID <> PSInv."Dimension Set ID") THEN BEGIN
            PSInv.MODIFY;
        END;
    end;

    procedure PSCMCreateDim(PSCRM: Record "Sales Cr.Memo Header";
    Type1: Integer;
    No1: Code[20];
    Type2: Integer;
    No2: Code[20];
    Type3: Integer;
    No3: Code[20];
    Type4: Integer;
    No4: Code[20];
    Type5: Integer;
    No5: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableId: Array[10] of Integer;
        No: Array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        TableID[5] := Type5;
        No[5] := No5;
        PSCRM."Shortcut Dimension 1 Code" := '';
        PSCRM."Shortcut Dimension 2 Code" := '';
        OldDimSetID := PSCRM."Dimension Set ID";
        PSCRM."Dimension Set ID" := DimMgmt.GetRecDefaultDimID(PSCRM, 2, TableID, No, SourceCodeSetup.Sales, PSCRM."Shortcut Dimension 1 Code", PSCRM."Shortcut Dimension 2 Code", 0, 0);
        IF (OldDimSetID <> PSCRM."Dimension Set ID") THEN BEGIN
            PSCRM.MODIFY;
        END;
    end;
    //DEV008 START
    //[EventSubscriber(ObjectType::codeunit, 12, 'OnBeforeInsertVATForGLEntry', '', true, true)]
    local procedure OnBeforeInsertVATForGLEntry(var GenJnlLine: Record "Gen. Journal Line"; VATPostingSetup: Record "VAT Posting Setup"; GLEntryVATAmount: Decimal; SrcCurrGLEntryVATAmt: Decimal; UnrealizedVAT: Boolean; var IsHandled: Boolean; var VATEntry: Record "VAT Entry"; TaxJurisdiction: Record "Tax Jurisdiction"; SrcCurrCode: Code[10])
    var
        TmpDimensionSetEntry: record "Dimension Set Entry" temporary;
    begin
        AccountNo := GenJnlLine."Account No.";
        IF dimdefault.get(15, AccountNo, 'BUDGET_ACCOUNT') then
            DIM1 := dimdefault."Dimension Value Code";
        //GLEntry.Validate("Global Dimension 1 Code", DIM1);
        IF dimdefault.get(15, AccountNo, 'BUDGET_PROJECT') then
            DIM2 := dimdefault."Dimension Value Code";
        //GLEntry.Validate("Global Dimension 2 Code", DIM2);
        IF dimdefault.get(15, AccountNo, 'BUDGET_GROUP') then
            DIM3 := dimdefault."Dimension Value Code";


        IF DimValue.GET('BUDGET_ACCOUNT', DIM1) then begin
            TmpDimensionSetEntry.INIT;
            TmpDimensionSetEntry."Dimension Set ID" := -1;
            TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_ACCOUNT');
            TmpDimensionSetEntry.validate("Dimension Value Code", DIM1);
            TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
            if not TmpDimensionSetEntry.INSERT then
                TmpDimensionSetEntry.Modify;
        END;
        IF DimValue.GET('BUDGET_PROJECT', DIM2) then begin
            TmpDimensionSetEntry.INIT;
            TmpDimensionSetEntry."Dimension Set ID" := -1;
            TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_PROJECT');
            TmpDimensionSetEntry.validate("Dimension Value Code", DIM2);
            TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
            if not TmpDimensionSetEntry.INSERT then
                TmpDimensionSetEntry.Modify;
        END;

        IF DimValue.GET('BUDGET_GROUP', DIM3) then begin
            TmpDimensionSetEntry.INIT;
            TmpDimensionSetEntry."Dimension Set ID" := -1;
            TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_GROUP');
            TmpDimensionSetEntry.validate("Dimension Value Code", DIM3);
            TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
            if not TmpDimensionSetEntry.INSERT then
                TmpDimensionSetEntry.Modify;

        end;


        GenJnlLine."Dimension Set ID" := DimMgMt.GetDimensionSetID(TmpDimensionSetEntry);
        //GLEntry.Modify();
        GenJnlLine.Modify();
        TmpDimensionSetEntry.DeleteAll();
        CLEAR(TmpDimensionSetEntry);
    END;

    //[EventSubscriber(ObjectType::codeunit, 80, 'OnAfterPostSalesDoc', '', true, true)]
    procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean)
    var
        glentry: record "G/L Entry";
        vatps: record "VAT Posting Setup";
        salesinvline: record "Sales Invoice Line";
        salescrmemoline: record "Sales Cr.Memo Line";
        TmpDimensionSetEntry: record "Dimension Set Entry" temporary;
        customer: record Customer;
        custpg: record "Customer Posting Group";
        vat: code[20];
        nvat: Integer;
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
            salesinvline.SetRange("Document No.", SalesInvHdrNo);
            salesinvline.SetFilter("No.", '<>%1', '');
            nvat := 0;
            if salesinvline.FindFirst() then
                repeat
                    if vatps.get(salesinvline."VAT Bus. Posting Group", salesinvline."VAT Prod. Posting Group") then begin
                        if vat <> vatps."Sales VAT Account" then
                            nvat += 1;
                        glentry.SetRange("Document No.", SalesInvHdrNo);
                        glentry.SetRange("G/L Account No.", vatps."Sales VAT Account");
                        vat := vatps."Sales VAT Account";
                    end;
                until salesinvline.Next() = 0;
        end
        else begin
            salescrmemoline.SetRange("Document No.", SalesCrMemoHdrNo);
            salescrmemoline.SetFilter("No.", '<>%1', '');
            nvat := 0;
            if salescrmemoline.FindFirst() then
                repeat

                    if vatps.get(salescrmemoline."VAT Bus. Posting Group", salescrmemoline."VAT Prod. Posting Group") then begin
                        if vat <> vatps."Sales VAT Account" then
                            nvat += 1;
                        glentry.SetRange("Document No.", SalesCrMemoHdrNo);
                        glentry.SetRange("G/L Account No.", vatps."Sales VAT Account");
                        vat := vatps."Sales VAT Account";
                    end;
                until salescrmemoline.Next() = 0;
        end;
        if nvat > 1 then
            error('The document %1 has more than one %2 Vat Account, Use Correction Dimensions', SalesCrMemoHdrNo + SalesInvHdrNo, 'Sales');
        if glentry.FindFirst() then begin
            AccountNo := glentry."G/L Account No.";
            // IF dimdefault.get(15, AccountNo, 'BUDGET_ACCOUNT') then
            //     DIM1 := dimdefault."Dimension Value Code";
            if customer.get(SalesHeader."Sell-to Customer No.") then
                if custpg.get(customer."Customer Posting Group") then
                    dim1 := custpg.FBM_BudgetAccount;
            GLEntry.Validate("Global Dimension 1 Code", DIM1);
            IF dimdefault.get(15, AccountNo, 'BUDGET_PROJECT') then
                DIM2 := dimdefault."Dimension Value Code";
            GLEntry.Validate("Global Dimension 2 Code", DIM2);
            IF dimdefault.get(15, AccountNo, 'BUDGET_GROUP') then
                DIM3 := dimdefault."Dimension Value Code";


            IF DimValue.GET('BUDGET_ACCOUNT', DIM1) then begin
                TmpDimensionSetEntry.INIT;
                TmpDimensionSetEntry."Dimension Set ID" := -1;
                TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_ACCOUNT');
                TmpDimensionSetEntry.validate("Dimension Value Code", DIM1);
                TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                if not TmpDimensionSetEntry.INSERT then
                    TmpDimensionSetEntry.Modify;
            END;
            IF DimValue.GET('BUDGET_PROJECT', DIM2) then begin
                TmpDimensionSetEntry.INIT;
                TmpDimensionSetEntry."Dimension Set ID" := -1;
                TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_PROJECT');
                TmpDimensionSetEntry.validate("Dimension Value Code", DIM2);
                TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                if not TmpDimensionSetEntry.INSERT then
                    TmpDimensionSetEntry.Modify;
            END;

            IF DimValue.GET('BUDGET_GROUP', DIM3) then begin
                TmpDimensionSetEntry.INIT;
                TmpDimensionSetEntry."Dimension Set ID" := -1;
                TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_GROUP');
                TmpDimensionSetEntry.validate("Dimension Value Code", DIM3);
                TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                if not TmpDimensionSetEntry.INSERT then
                    TmpDimensionSetEntry.Modify;

            end;


            glentry.validate("Dimension Set ID", DimMgMt.GetDimensionSetID(TmpDimensionSetEntry));
            GLEntry.Modify();

            TmpDimensionSetEntry.DeleteAll();
            CLEAR(TmpDimensionSetEntry);
        end;
    end;

    //[EventSubscriber(ObjectType::codeunit, 90, 'OnAfterPostPurchaseDoc', '', true, true)]
    procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        glentry: record "G/L Entry";
        vatps: record "VAT Posting Setup";
        purchinvline: record "Purch. Inv. Line";
        purchcrmemoline: record "Purch. Cr. Memo Line";
        TmpDimensionSetEntry: record "Dimension Set Entry" temporary;
        vendor: record Vendor;
        vendpg: record "Vendor Posting Group";
        vat: code[20];
        nvat: Integer;
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then begin
            purchinvline.SetRange("Document No.", purchInvHdrNo);
            purchinvline.SetFilter("No.", '<>%1', '');
            nvat := 0;
            if purchinvline.FindFirst() then
                repeat

                    if vatps.get(purchinvline."VAT Bus. Posting Group", purchinvline."VAT Prod. Posting Group") then begin
                        if vat <> vatps."Purchase VAT Account" then
                            nvat += 1;
                        glentry.SetRange("Document No.", purchInvHdrNo);
                        glentry.SetRange("G/L Account No.", vatps."Purchase VAT Account");
                        vat := vatps."Purchase VAT Account";
                    end;
                until purchinvline.Next() = 0;
        end
        else begin
            purchcrmemoline.SetRange("Document No.", PurchCrMemoHdrNo);
            purchcrmemoline.SetFilter("No.", '<>%1', '');
            nvat := 0;
            if purchcrmemoline.FindFirst() then
                repeat
                    if vatps.get(purchcrmemoline."VAT Bus. Posting Group", purchcrmemoline."VAT Prod. Posting Group") then begin
                        if vat <> vatps."Purchase VAT Account" then
                            nvat += 1;
                        glentry.SetRange("Document No.", PurchCrMemoHdrNo);
                        glentry.SetRange("G/L Account No.", vatps."Purchase VAT Account");
                        vat := vatps."Purchase VAT Account";
                    end;
                until purchcrmemoline.Next() = 0;
        end;
        if nvat > 1 then
            error('The document %1 has more than one %2 Vat Account, Use Correction Dimensions', PurchCrMemoHdrNo + PurchInvHdrNo, 'Purchase');

        if glentry.FindFirst() then begin
            AccountNo := glentry."G/L Account No.";
            // IF dimdefault.get(15, AccountNo, 'BUDGET_ACCOUNT') then
            //     DIM1 := dimdefault."Dimension Value Code";
            if vendor.get(purchaseHeader."Buy-from Vendor No.") then
                if vendpg.get(vendor."Vendor Posting Group") then
                    dim1 := vendpg.FBM_BudgetAccount;
            GLEntry.Validate("Global Dimension 1 Code", DIM1);
            IF dimdefault.get(15, AccountNo, 'BUDGET_PROJECT') then
                DIM2 := dimdefault."Dimension Value Code";
            GLEntry.Validate("Global Dimension 2 Code", DIM2);
            IF dimdefault.get(15, AccountNo, 'BUDGET_GROUP') then
                DIM3 := dimdefault."Dimension Value Code";


            IF DimValue.GET('BUDGET_ACCOUNT', DIM1) then begin
                TmpDimensionSetEntry.INIT;
                TmpDimensionSetEntry."Dimension Set ID" := -1;
                TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_ACCOUNT');
                TmpDimensionSetEntry.validate("Dimension Value Code", DIM1);
                TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                if not TmpDimensionSetEntry.INSERT then
                    TmpDimensionSetEntry.Modify;
            END;
            IF DimValue.GET('BUDGET_PROJECT', DIM2) then begin
                TmpDimensionSetEntry.INIT;
                TmpDimensionSetEntry."Dimension Set ID" := -1;
                TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_PROJECT');
                TmpDimensionSetEntry.validate("Dimension Value Code", DIM2);
                TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                if not TmpDimensionSetEntry.INSERT then
                    TmpDimensionSetEntry.Modify;
            END;

            IF DimValue.GET('BUDGET_GROUP', DIM3) then begin
                TmpDimensionSetEntry.INIT;
                TmpDimensionSetEntry."Dimension Set ID" := -1;
                TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_GROUP');
                TmpDimensionSetEntry.validate("Dimension Value Code", DIM3);
                TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                if not TmpDimensionSetEntry.INSERT then
                    TmpDimensionSetEntry.Modify;

            end;

            GLEntry.validate("Dimension Set ID", DimMgMt.GetDimensionSetID(TmpDimensionSetEntry));
            glentry.Modify();
            TmpDimensionSetEntry.DeleteAll();
            CLEAR(TmpDimensionSetEntry);
        end;
    end;

    //[EventSubscriber(ObjectType::codeunit, 241, 'OnCodeOnAfterItemJnlPostBatchRun', '', true, true)]
    procedure OnCodeOnAfterItemJnlPostBatchRun(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; SuppressCommit: Boolean)
    var
        genps: record "General Posting Setup";
        glentry: record "G/L Entry";
        TmpDimensionSetEntry: record "Dimension Set Entry" temporary;
    begin
        if genps.get(ItemJournalLine."Gen. Bus. Posting Group", ItemJournalLine."Gen. Prod. Posting Group") then begin
            glentry.SetRange("G/L Account No.", genps."Inventory Adjmt. Account");
            glentry.SetRange("Document No.", ItemJournalLine."Document No.");
            glentry.SetRange("Posting Date", ItemJournalLine."Posting Date");
            if glentry.FindFirst() then
                repeat
                    AccountNo := glentry."G/L Account No.";
                    IF dimdefault.get(15, AccountNo, 'BUDGET_ACCOUNT') then
                        DIM1 := dimdefault."Dimension Value Code";

                    GLEntry.Validate("Global Dimension 1 Code", DIM1);
                    IF dimdefault.get(15, AccountNo, 'BUDGET_PROJECT') then
                        DIM2 := dimdefault."Dimension Value Code";
                    GLEntry.Validate("Global Dimension 2 Code", DIM2);
                    IF dimdefault.get(15, AccountNo, 'BUDGET_GROUP') then
                        DIM3 := dimdefault."Dimension Value Code";


                    IF DimValue.GET('BUDGET_ACCOUNT', DIM1) then begin
                        TmpDimensionSetEntry.INIT;
                        TmpDimensionSetEntry."Dimension Set ID" := -1;
                        TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_ACCOUNT');
                        TmpDimensionSetEntry.validate("Dimension Value Code", DIM1);
                        TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                        if not TmpDimensionSetEntry.INSERT then
                            TmpDimensionSetEntry.Modify;
                    END;
                    IF DimValue.GET('BUDGET_PROJECT', DIM2) then begin
                        TmpDimensionSetEntry.INIT;
                        TmpDimensionSetEntry."Dimension Set ID" := -1;
                        TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_PROJECT');
                        TmpDimensionSetEntry.validate("Dimension Value Code", DIM2);
                        TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                        if not TmpDimensionSetEntry.INSERT then
                            TmpDimensionSetEntry.Modify;
                    END;

                    IF DimValue.GET('BUDGET_GROUP', DIM3) then begin
                        TmpDimensionSetEntry.INIT;
                        TmpDimensionSetEntry."Dimension Set ID" := -1;
                        TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_GROUP');
                        TmpDimensionSetEntry.validate("Dimension Value Code", DIM3);
                        TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                        if not TmpDimensionSetEntry.INSERT then
                            TmpDimensionSetEntry.Modify;
                    end;


                    GLEntry.validate("Dimension Set ID", DimMgMt.GetDimensionSetID(TmpDimensionSetEntry));
                    glentry.Modify();
                    TmpDimensionSetEntry.DeleteAll();
                    CLEAR(TmpDimensionSetEntry);
                until glentry.Next() = 0;
        end;
    end;


    //[EventSubscriber(ObjectType::codeunit, 5633, 'OnPostLinesOnAfterFAJnlPostLine', '', true, true)]
    procedure OnPostLinesOnAfterFAJnlPostLine(var FAJnlLine: Record "FA Journal Line")
    var
        faps: record "FA Posting Group";
        glentry: record "G/L Entry";
        TmpDimensionSetEntry: record "Dimension Set Entry" temporary;
    begin
        if faps.get(FAJnlLine."FA Posting Group") then begin
            glentry.SetRange("G/L Account No.", faps."Depreciation Expense Acc.");
            glentry.SetRange("Document No.", FAJnlLine."Document No.");
            glentry.SetRange("Posting Date", FAJnlLine."Posting Date");
            if glentry.FindFirst() then
                repeat
                    AccountNo := glentry."G/L Account No.";
                    IF dimdefault.get(15, AccountNo, 'BUDGET_ACCOUNT') then
                        DIM1 := dimdefault."Dimension Value Code";

                    GLEntry.Validate("Global Dimension 1 Code", DIM1);
                    IF DimValue.GET('BUDGET_ACCOUNT', DIM1) then begin
                        TmpDimensionSetEntry.INIT;
                        TmpDimensionSetEntry."Dimension Set ID" := -1;
                        TmpDimensionSetEntry.validate("Dimension Code", 'BUDGET_ACCOUNT');
                        TmpDimensionSetEntry.validate("Dimension Value Code", DIM1);
                        TmpDimensionSetEntry."Dimension Value ID" := Dimvalue."Dimension Value ID";
                        if not TmpDimensionSetEntry.INSERT then
                            TmpDimensionSetEntry.Modify;
                    END;
                    GLEntry.validate("Dimension Set ID", DimMgMt.GetDimensionSetID(TmpDimensionSetEntry));
                    glentry.Modify();
                    TmpDimensionSetEntry.DeleteAll();
                    CLEAR(TmpDimensionSetEntry);

                until glentry.Next() = 0;
        end;
    end;
    //DEV008 END
    var
        // DEV008 START
        AccountNo: code[20];
        dimdefault: record "Default Dimension";
        DIM1: CODE[20];
        DIM2: CODE[20];
        DIM3: CODE[20];
        GLSetup: Record "General Ledger Setup";

        // DEV008 END
        DimMgmt: codeunit DimensionManagement;
        Customer: Record Customer;
        DimValue: Record "Dimension Value";
        FADM: Codeunit FBM_FixedAssetDimMgt_CO;
        CS: Record FBM_CustomerSite_C;
        PSI: Record "Sales Invoice Header";
        DimSet: Record "Dimension Set Entry";
        DSC: Record "Dimension Set Entry";
        DSO: Record "Dimension Set Entry";
        DSH: Record "Dimension Set Entry";
        DSE: Record "Dimension Set Entry";
        DV: Record "Dimension Value";
        dimsetentry: record "Dimension Set Entry";
        DSE_No: Integer;
        CDD: record "Default Dimension";
        SalesHeader: Record "Sales Header";
        operator: code[20];
        CLE: record "Cust. Ledger Entry";
        PSCM: record "Sales Cr.Memo Header";
        GLE: Record "G/L Entry";
        SalesLine: Record "Sales Line";
        SH: Record "Sales Header";
        SalesInvLine: Record "Sales Invoice Line";
        SIHeader: record "Sales Invoice Header";
        SCMHeader: Record "Sales Cr.Memo Header";
        SalesCMLine: record "Sales Cr.Memo Line";
}
