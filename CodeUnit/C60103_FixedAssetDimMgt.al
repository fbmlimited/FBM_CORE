codeunit 60103 FBM_FixedAssetDimMgt_CO
{
    trigger OnRun()
    begin
    end;

    procedure TrimDimName(RecordName: Text[2480]) DimName: Text[50]
    var
        RecordNameLength: Integer;
    begin
        Clear(RecordNameLength);
        Clear(DimName);
        RecordNameLength := strlen(RecordName);
        if RecordNameLength > 50 then begin
            DimName := DelStr(RecordName, 51, RecordNameLength);
        end
        else begin
            DimName := RecordName;
        end;
        exit(DimName);
    end;

    procedure AddDimensions(var Rec: Record Customer)
    var
        CompInfo: Record "Company Information";
    begin
        //Message('Here 1');
        if CompInfo.get then begin
            if CompInfo.FBM_CustIsOp then begin
                AddSameCustOperatorDim(Rec);
            end
            else
                AddCustDim(Rec);
        end;
    end;

    local procedure AddCustDim(var Rec: Record Customer)
    var
        FASetup: Record "FA Setup";
        CustDimValue: record "Dimension Value";
        CustDefDim: Record "Default Dimension";
        DimName: Text[50];
        NameLength: Integer;
    begin
        //add customer dimension only (no operator)
        if FASetup.Get() then begin
            //if FASetup."Enable FA Site Tracking" then begin
            //Message('Here 2');
            CustDimValue.reset;
            CustDimValue.SetFilter(CustDimValue."Dimension Code", FASetup."FBM_Customer Dimension");
            CustDimValue.SetFilter(CustDimValue."Code", Rec."No.");
            if CustDimValue.FindFirst() then begin
                //customer dimension already exist - update it only
                if CustDimValue.Name <> Rec.Name then begin
                    //CustDimValue.Name := Rec.Name;
                    CustDimValue.Name := TrimDimName(Rec.Name);
                    CustDimValue.Modify();
                end;
            end
            else begin
                //customer dimension does not exist - create
                CustDimValue.Reset();
                CustDimValue.Init();
                CustDimValue."Dimension Code" := FASetup."FBM_Customer Dimension";
                CustDimValue."Code" := Rec."No.";
                //CustDimValue.Name := rec.Name;
                CustDimValue.Name := TrimDimName(Rec.Name);
                CustDimValue.Insert(true);
            end;
            //add default dims to the customer
            CustDefDim.reset;
            CustDefDim.SetFilter(CustDefDim."Table ID", '18');
            CustDefDim.SetFilter(CustDefDim."Dimension Code", FASetup."FBM_Customer Dimension");
            CustDefDim.SetFilter(CustDefDim."No.", Rec."No.");
            if not CustDefDim.FindFirst() then begin
                CustDefDim.Init();
                CustDefDim."Table ID" := 18;
                CustDefDim."No." := Rec."No.";
                CustDefDim."Dimension Code" := FASetup."FBM_Customer Dimension";
                CustDefDim."Dimension Value Code" := Rec."No.";
                CustDefDim.Insert();
            end;
            //end;
        end;
    end;

    local procedure AddSameCustOperatorDim(var Rec: Record Customer)
    var
        FASetup: Record "FA Setup";
        CompInfo: Record "Company Information";
        CustDimValue: record "Dimension Value";
        OpDimValue: Record "Dimension Value";
        CustDefDim: Record "Default Dimension";
        CustOpDefDim: Record "Default Dimension";
    begin
        //add customer dimension & operator
        if FASetup.Get() then begin
            //if FASetup."Enable FA Site Tracking" then begin
            //Message('Here 3');
            CustDimValue.reset;
            CustDimValue.SetFilter(CustDimValue."Dimension Code", FASetup."FBM_Customer Dimension");
            CustDimValue.SetFilter(CustDimValue."Code", Rec."No.");
            if CustDimValue.FindFirst() then begin
                //Message('ongoing maintenance -- already exist cust');
                //customer dimension already exist - update it only
                if CustDimValue.Name <> Rec.Name then begin
                    //CustDimValue.Name := Rec.Name;
                    CustDimValue.Name := TrimDimName(Rec.Name);
                    CustDimValue.Modify();
                end;
            end
            else begin
                //customer dimension does not exist - create
                //Message('ongoing maintenance -- creating new dim cust');
                CustDimValue.Reset();
                CustDimValue.Init();
                CustDimValue."Dimension Code" := FASetup."FBM_Customer Dimension";
                CustDimValue."Code" := Rec."No.";
                //CustDimValue.Name := rec.Name;
                CustDimValue.Name := TrimDimName(Rec.Name);
                CustDimValue.Insert(true);
            end;
            OpDimValue.Reset();
            OpDimValue.SetFilter(OpDimValue."Dimension Code", FASetup."FBM_Operator Dimension");
            OpDimValue.SetFilter(OpDimValue."Code", Rec."No.");
            if OpDimValue.FindFirst() then begin
                //operator dimension already exist - update it only 
                //Message('ongoing maintenance -- already exist operator');
                if OpDimValue.Name <> Rec.Name then begin
                    //OpDimValue.Name := Rec.Name;
                    OpDimValue.Name := TrimDimName(Rec.Name);
                    OpDimValue.Modify();
                end;
            end
            else begin
                //operator dimension does not exist - create  
                //Message('ongoing maintenance -- creating new dim operator');
                OpDimValue.Reset();
                OpDimValue.Init();
                OpDimValue."Dimension Code" := FASetup."FBM_Operator Dimension";
                OpDimValue."Code" := Rec."No.";
                //OpDimValue.Name := rec.Name;
                OpDimValue.Name := TrimDimName(Rec.Name);
                OpDimValue.Insert(true);
            end;
            //add default dims to the customer
            CustDefDim.reset;
            CustDefDim.SetFilter(CustDefDim."Table ID", '18');
            CustDefDim.SetFilter(CustDefDim."Dimension Code", FASetup."FBM_Customer Dimension");
            CustDefDim.SetFilter(CustDefDim."No.", Rec."No.");
            if not CustDefDim.FindFirst() then begin
                //Message('CustDefDim');
                //Message('ongoing maintenance -- cust def dim - cust');
                CustDefDim.Init();
                CustDefDim."Table ID" := 18;
                CustDefDim."No." := Rec."No.";
                CustDefDim."Dimension Code" := FASetup."FBM_Customer Dimension";
                CustDefDim."Dimension Value Code" := Rec."No.";
                CustDefDim.Insert();
            end;
            CustOpDefDim.reset;
            CustOpDefDim.SetFilter(CustOpDefDim."Table ID", '18');
            CustOpDefDim.SetFilter(CustOpDefDim."Dimension Code", FASetup."FBM_Operator Dimension");
            CustOpDefDim.SetFilter(CustOpDefDim."No.", Rec."No.");
            if not CustOpDefDim.FindFirst() then begin
                //Message('OpDefDim');
                //Message('ongoing maintenance -- cust def dim - operator');
                CustOpDefDim.Init();
                CustOpDefDim."Table ID" := 18;
                CustOpDefDim."No." := OpDimValue."Code";
                CustOpDefDim."Dimension Code" := FASetup."FBM_Operator Dimension";
                CustOpDefDim."Dimension Value Code" := Rec."No.";
                CustOpDefDim.Insert();
            end;
            //end;
        end;
    end;
    /*local procedure AddCustomerDim(Rec: Record Customer)
      var
          DefDim_Cust: Record "Default Dimension";
          DimValue_Cust: Record "Dimension Value";
          FASetup: Record "FA Setup";
      begin
          FASetup.Get();
          if FASetup."Enable FA Site Tracking" then begin
              //create dimension value
              DimValue_Cust.Reset();
              DimValue_Cust.SetFilter(DimValue_Cust."Dimension Code", FASetup."Customer Dimension");
              DimValue_Cust.SetFilter(DimValue_Cust."Code", Rec."No.");
              if DimValue_Cust.FindFirst() then begin
                  //check if same name - update if not
                  if DimValue_Cust.Name <> Rec.Name then begin
                      DimValue_Cust.Name := Rec.Name;
                      DimValue_Cust.Modify();
                  end;
              end
              else begin
                  //if not found, create
                  DimValue_Cust.Init();
                  DimValue_Cust."Dimension Code" := FASetup."Customer Dimension";
                  DimValue_Cust."Code" := Rec."No.";
                  DimValue_Cust.Name := Rec.Name;
                  DimValue_Cust.Insert(true);
              end;

              //assign dimension as default dim. to customer record
              DefDim_Cust.Reset();
              DefDim_Cust.SetFilter(DefDim_Cust."Table ID", '18');
              DefDim_Cust.SetFilter(DefDim_Cust."Dimension Code", FASetup."Customer Dimension");
              DefDim_Cust.SetFilter(DefDim_Cust."No.", Rec."No.");
              if not DefDim_Cust.FindFirst() then begin
                  DefDim_Cust.Init();
                  DefDim_Cust."Table ID" := 18;
                  DefDim_Cust."No." := Rec."No.";
                  DefDim_Cust."Dimension Code" := FASetup."Customer Dimension";
                  DefDim_Cust."Dimension Value Code" := Rec."No.";
                  DefDim_Cust.Insert();
              end;
          end;
      end;

      local procedure AddOperatorDim(Rec: Record Customer)
      var
          Text000: Label 'Is this customer an operator too?';
          Text001: Label 'Upload operators list for this customer manually.';
          DimValue_Op: Record "Dimension Value";
          DefaultDim_Op: Record "Default Dimension";
          NoSeriesMgt: codeunit "NoSeriesManagement";
          FASetup: Record "FA Setup";
          ParentChild: Record "Parent Child Relation";
      begin
          FASetup.Get();
          if FASetup."Enable FA Site Tracking" then begin
              ParentChild.reset;

              ParentChild.SetFilter(ParentChild.Child, FASetup."Operator Dimension");
              ParentChild.FindFirst();

              //add operator dimensions
              DimValue_Op.Reset();
              DimValue_Op.SetFilter("Dimension Code", FASetup."Operator Dimension");
              DimValue_Op.SetFilter("Code", Rec."No.");
              if not DimValue_Op.FindFirst() then begin
                  //check whether customer is an operator
                  if Confirm(Text000) then begin
                      DimValue_Op.Reset();
                      DimValue_Op.Init();
                      DimValue_Op."Dimension Code" := FASetup."Operator Dimension";
                      DimValue_Op."Code" := Rec."No.";
                      DimValue_Op.Name := Rec.Name;
                      DimValue_Op."Parent Code" := Rec."No.";     //link operator to customer
                      DimValue_Op.Insert(true);
                  end
                  else begin
                      //create operator with different operator code
                      DimValue_Op.Reset();
                      DimValue_Op.Init();
                      DimValue_Op."Dimension Code" := FASetup."Operator Dimension";
                      DimValue_Op."Code" := NoSeriesMgt.GetNextNo('OPERATORS', Today, true);
                      DimValue_Op.Name := Rec.Name;
                      DimValue_Op."Parent Code" := Rec."No."; //link operator to customer
                      DimValue_Op.Insert(true);
                  end;

                  InsertDimCombination(FASetup."Operator Dimension", DimValue_Op."Code", ParentChild.Parent, Rec."No.");
              end;
          end;
      end;*/
    procedure CreateSiteDim(CustSite: Record FBM_CustomerSite_C)
    var
        DimValue_Site: Record "Dimension Value";
        FASetup: Record "FA Setup";
        companyinfo: Record "Company Information";
    begin
        //Message('start here - %1', CustSite."Site Code");
        //create Site Dimension Value 
        FASetup.Get();
        //if FASetup."Enable FA Site Tracking" then begin
        DimValue_Site.Reset();
        DimValue_Site.SetFilter(DimValue_Site."Dimension Code", FASetup."FBM_Site Dimension");
        DimValue_Site.SetFilter(DimValue_Site."Code", CustSite."Site Code");
        if not DimValue_Site.FindFirst() then begin
            //message('not found - creating- %1', CustSite."Site Code");
            DimValue_Site.Reset();
            DimValue_Site.Init();
            DimValue_Site."Dimension Code" := FASetup."FBM_Site Dimension";
            DimValue_Site."Code" := CustSite."Site Code";
            //DimValue_Site.Name := CustSite."Site Name";
            DimValue_Site.Name := TrimDimName(CustSite."Site Name_FF");
            //DimValue_Site."Parent Code" := CustSite.Operator;   //link site to operator
            DimValue_Site.Insert(true);
            //message('created- %1', CustSite."Site Code");
        end
        else begin
            //Message('2.. start here - %1', CustSite."Site Code");
            //update name
            if DimValue_Site.Name <> CustSite."Site Name_FF" then begin
                //Message('rename - %1', CustSite."Site Code");
                //DimValue_Site.Name := CustSite."Site Name";
                DimValue_Site.Name := TrimDimName(CustSite."Site Name_FF");
                DimValue_Site.Modify();
            end;
        end;
        //insert entry in CustOpSite table
        if companyinfo.Get() then begin
            if companyinfo.FBM_CustIsOp then CreateCustOpSite(CustSite);
        end;
        //end;
    end;

    procedure CreateSiteDim2(CustSite: Record FBM_Site)
    var
        DimValue_Site: Record "Dimension Value";
        FASetup: Record "FA Setup";
        companyinfo: Record "Company Information";
    begin
        //Message('start here - %1', CustSite."Site Code");
        //create Site Dimension Value 
        FASetup.Get();
        //if FASetup."Enable FA Site Tracking" then begin
        DimValue_Site.Reset();
        DimValue_Site.SetFilter(DimValue_Site."Dimension Code", FASetup."FBM_Site Dimension");
        DimValue_Site.SetFilter(DimValue_Site."Code", CustSite."Site Code");
        if not DimValue_Site.FindFirst() then begin
            //message('not found - creating- %1', CustSite."Site Code");
            DimValue_Site.Reset();
            DimValue_Site.Init();
            DimValue_Site."Dimension Code" := FASetup."FBM_Site Dimension";
            DimValue_Site."Code" := CustSite."Site Code";
            //DimValue_Site.Name := CustSite."Site Name";
            DimValue_Site.Name := TrimDimName(CustSite."Site Name");
            //DimValue_Site."Parent Code" := CustSite.Operator;   //link site to operator
            DimValue_Site.Insert(true);
            //message('created- %1', CustSite."Site Code");
        end
        else begin
            //Message('2.. start here - %1', CustSite."Site Code");
            //update name
            if DimValue_Site.Name <> CustSite."Site Name" then begin
                //Message('rename - %1', CustSite."Site Code");
                //DimValue_Site.Name := CustSite."Site Name";
                DimValue_Site.Name := TrimDimName(CustSite."Site Name");
                DimValue_Site.Modify();
            end;
        end;

    end;

    procedure CreateCustOpSite(CustomerSite: Record FBM_CustomerSite_C)
    var
        COS: Record FBM_CustOpSite;
    begin
        COS.Reset();
        if not COS.get(CustomerSite."Customer No.", CustomerSite."Customer No.", CustomerSite."Site Code") then begin
            COS.Init();
            COS."Customer No." := CustomerSite."Customer No.";
            COS."Operator No." := CustomerSite."Customer No.";
            COS."Site Code" := CustomerSite."Site Code";
            COS.insert(true);
        end;
    end;

    procedure UpdateSiteDim(CustSite: Record FBM_CustomerSite_C)
    var
        DimValue_Site: Record "Dimension Value";
        //ParentChild: Record "Parent Child Relation";
        FASetup: Record "FA Setup";
        companyinfo: Record "Company Information";
    begin
        FASetup.Get();
        //if FASetup."Enable FA Site Tracking" then begin
        DimValue_Site.Reset();
        DimValue_Site.SetFilter(DimValue_Site."Dimension Code", FASetup."FBM_Site Dimension");
        DimValue_Site.SetFilter(DimValue_Site."Code", CustSite."Site Code");
        if DimValue_Site.FindFirst() then begin
            //update Name
            if DimValue_Site.Name <> CustSite."Site Name_FF" then begin
                //DimValue_Site.Name := CustSite."Site Name";
                DimValue_Site.Name := TrimDimName(CustSite."Site Name_FF");
                DimValue_Site.Modify();
            end;

            //update operator
            //get parent
            /*  ParentChild.Reset();
             ParentChild.SetFilter(ParentChild.Child, FASetup."Site Dimension");
             if ParentChild.FindFirst() then begin
                 if DimValue_Site."Parent Dimension" = ParentChild.Parent then begin
                     if DimValue_Site."Parent Code" <> CustSite.Operator then begin
                         DimValue_Site."Parent Code" := CustSite.Operator;
                         DimValue_Site.Modify();
                     end;
                 end;
             end; */
        end;
        //end;
    end;

    procedure UpdateSiteDim2(CustSite: Record FBM_Site)
    var
        DimValue_Site: Record "Dimension Value";
        //ParentChild: Record "Parent Child Relation";
        FASetup: Record "FA Setup";
        companyinfo: Record "Company Information";
    begin
        FASetup.Get();
        //if FASetup."Enable FA Site Tracking" then begin
        DimValue_Site.Reset();
        DimValue_Site.SetFilter(DimValue_Site."Dimension Code", FASetup."FBM_Site Dimension");
        DimValue_Site.SetFilter(DimValue_Site."Code", CustSite."Site Code");
        if DimValue_Site.FindFirst() then begin
            //update Name
            if DimValue_Site.Name <> CustSite."Site Name" then begin
                //DimValue_Site.Name := CustSite."Site Name";
                DimValue_Site.Name := TrimDimName(CustSite."Site Name");
                DimValue_Site.Modify();
            end;

            //update operator
            //get parent
            /*  ParentChild.Reset();
             ParentChild.SetFilter(ParentChild.Child, FASetup."Site Dimension");
             if ParentChild.FindFirst() then begin
                 if DimValue_Site."Parent Dimension" = ParentChild.Parent then begin
                     if DimValue_Site."Parent Code" <> CustSite.Operator then begin
                         DimValue_Site."Parent Code" := CustSite.Operator;
                         DimValue_Site.Modify();
                     end;
                 end;
             end; */
        end;
        //end;
    end;

    procedure RenameCustOpSite(xCustomerSite: Record FBM_CustomerSite_C;
    CustomerSite: Record FBM_CustomerSite_C)
    var
        COS: Record FBM_CustOpSite;
    begin
        COS.Reset();
        COS.SetFilter(COS."Customer No.", CustomerSite."Customer No.");
        COS.SetFilter(COS."Site Code", xCustomerSite."Site Code");
        if COS.FindFirst() then begin
            if COS."Site Code" <> CustomerSite."Site Code" then COS.Rename(CustomerSite."Customer No.", CustomerSite."Customer No.", CustomerSite."Site Code", customersite.version);
        end;
    end;

    procedure RenameCustOpSite(xCustomerSite: Record FBM_Site;
    CustomerSite: Record FBM_Site)
    var
        COS: Record FBM_CustOpSite;
    begin
        COS.Reset();
        // COS.SetFilter(COS."Customer No.", CustomerSite."Customer No.");
        COS.SetFilter(COS."Site Code", xCustomerSite."Site Code");
        if COS.FindFirst() then begin
            if COS."Site Code" <> CustomerSite."Site Code" then COS.Rename(cos."Customer No.", cos."Customer No.", CustomerSite."Site Code", customersite.version);
        end;
    end;

    procedure RenameSiteDim(xCustSite: Record FBM_CustomerSite_C;
    CustSite: Record FBM_CustomerSite_C)
    var
        DimValue_Site: Record "Dimension Value";
        FASetup: Record "FA Setup";
        companyinfo: Record "Company Information";
        COS: Record FBM_CustOpSite;
    begin
        FASetup.Get();
        //if FASetup."Enable FA Site Tracking" then begin
        DimValue_Site.Reset();
        DimValue_Site.SetFilter(DimValue_Site."Dimension Code", FASetup."FBM_Site Dimension");
        DimValue_Site.SetFilter(DimValue_Site."Code", xCustSite."Site Code");
        if DimValue_Site.FindFirst() then begin
            if DimValue_Site.Code <> CustSite."Site Code" then begin
                DimValue_Site.Rename(FASetup."FBM_Site Dimension", CustSite."Site Code");
            end;
        end;
        //rename entry in CustOpSite table
        if companyinfo.Get() then begin
            if companyinfo.FBM_CustIsOp then RenameCustOpSite(xCustSite, CustSite);
        end;
        // end;
    end;

    procedure RenameSiteDim2(xCustSite: Record FBM_Site;
    CustSite: Record FBM_Site)
    var
        DimValue_Site: Record "Dimension Value";
        FASetup: Record "FA Setup";
        companyinfo: Record "Company Information";
        COS: Record FBM_CustOpSite;
    begin
        FASetup.Get();
        //if FASetup."Enable FA Site Tracking" then begin
        DimValue_Site.Reset();
        DimValue_Site.SetFilter(DimValue_Site."Dimension Code", FASetup."FBM_Site Dimension");
        DimValue_Site.SetFilter(DimValue_Site."Code", xCustSite."Site Code");
        if DimValue_Site.FindFirst() then begin
            if DimValue_Site.Code <> CustSite."Site Code" then begin
                DimValue_Site.Rename(FASetup."FBM_Site Dimension", CustSite."Site Code");
            end;
        end;
        //rename entry in CustOpSite table
        if companyinfo.Get() then begin
            if companyinfo.FBM_CustIsOp then RenameCustOpSite(xCustSite, CustSite);
        end;
        // end;
    end;

    procedure ModifySiteDim("xCust-Site": Record FBM_CustomerSite_C;
    "Cust-Site": Record FBM_CustomerSite_C)
    var
        FASetup: Record "FA Setup";
        DimensionValue_Site: Record "Dimension Value";
        companyinfo: Record "Company Information";
    begin
        FASetup.Get();
        //if FASetup."Enable FA Site Tracking" then begin
        DimensionValue_Site.Reset();
        DimensionValue_Site.SetFilter(DimensionValue_Site."Dimension Code", FASetup."FBM_Site Dimension");
        DimensionValue_Site.SetFilter(DimensionValue_Site."Code", "Cust-Site"."Site Code");
        if DimensionValue_Site.FindFirst() then begin
            if DimensionValue_Site.Name <> "xCust-Site"."Site Name_FF" then begin
                DimensionValue_Site.Validate(DimensionValue_Site.Name, "Cust-Site"."Site Name_FF");
                DimensionValue_Site.Modify();
            end;
        end;
        //no need to update cust-op-site as name is not recorded
        //end;
    end;

    procedure AssignFADimension()
    var
        FA: Record "Fixed Asset";
        //FAMH: Record "FA Movement History";
        DefDim_FA: Record "Default Dimension";
        Customer: Record Customer;
        FASetup: Record "FA Setup";
        CustSite: Record FBM_CustomerSite_C;
        CustOpSite: Record FBM_CustOpSite;
        SDimVal: Record "Dimension Value";
        ODimVal: Record "Dimension Value";
    begin
        FASetup.Get();
        // if FASetup."FBM_Enable FA Site Tracking" then begin
        if FA.FindFirst() then begin
            // repeat begin
            // FAMH.Reset();
            // FAMH.setfilter(FAMH."FA No.", FA."No.");
            // FAMH.SetCurrentKey("Entry No.");
            // if FAMH.FindLast() then begin
            //assign dimensions as default dims. to FA record
            //get site code
            SDimVal.Reset();
            SDimVal.SetFilter(SDimVal."Dimension Code", FASetup."FBM_Site Dimension");
            // SDimVal.SetFilter(SDimVal.Name, FAMH.Site);
            if SDimVal.FindFirst() then begin
                DefDim_FA.Reset();
                DefDim_FA.SetFilter(DefDim_FA."Table ID", '5600');
                DefDim_FA.SetFilter(DefDim_FA."Dimension Code", FASetup."FBM_Site Dimension");
                DefDim_FA.SetFilter(DefDim_FA."No.", FA."No.");
                if not DefDim_FA.FindFirst() then begin
                    DefDim_FA.Init();
                    DefDim_FA."Table ID" := 5600;
                    DefDim_FA."No." := FA."No.";
                    DefDim_FA."Dimension Code" := FASetup."FBM_Site Dimension";
                    DefDim_FA."Dimension Value Code" := SDimVal.Code;
                    DefDim_FA.Insert();
                end
                else begin
                    DefDim_FA."Dimension Value Code" := SDimVal.Code;
                    DefDim_FA.Modify();
                end;
            end;
            //get customer & operator from corporate name
            Customer.Reset();
            // Customer.SetFilter(Customer.Name, FAMH."Customer Name");
            if Customer.FindFirst() then begin
                DefDim_FA.Reset();
                DefDim_FA.SetFilter(DefDim_FA."Table ID", '5600');
                DefDim_FA.SetFilter(DefDim_FA."Dimension Code", FASetup."FBM_Customer Dimension");
                DefDim_FA.SetFilter(DefDim_FA."No.", FA."No.");
                if not DefDim_FA.FindFirst() then begin
                    //customer
                    DefDim_FA.Init();
                    DefDim_FA."Table ID" := 5600;
                    DefDim_FA."No." := FA."No.";
                    DefDim_FA."Dimension Code" := FASetup."FBM_Customer Dimension";
                    DefDim_FA."Dimension Value Code" := Customer."No.";
                    DefDim_FA.Insert();
                end
                else begin
                    DefDim_FA."Dimension Value Code" := Customer."No.";
                    DefDim_FA.Modify();
                end;
                //operator
                ODimVal.Reset();
                ODimVal.SetFilter(ODimVal."Dimension Code", FASetup."FBM_Operator Dimension");
                // ODimVal.SetFilter(ODimVal.Name, FAMH."Corporate Name");
                IF ODimVal.FindFirst() then begin
                    DefDim_FA.Reset();
                    DefDim_FA.SetFilter(DefDim_FA."Table ID", '5600');
                    DefDim_FA.SetFilter(DefDim_FA."Dimension Code", FASetup."FBM_Operator Dimension");
                    DefDim_FA.SetFilter(DefDim_FA."No.", FA."No.");
                    if not DefDim_FA.FindFirst() then begin
                        DefDim_FA.Init();
                        DefDim_FA."Table ID" := 5600;
                        DefDim_FA."No." := FA."No.";
                        DefDim_FA."Dimension Code" := FASetup."FBM_Operator Dimension";
                        DefDim_FA."Dimension Value Code" := ODimVal.Code; //since in FBM scenario, customer = operator
                        DefDim_FA.Insert();
                    end
                    else begin
                        DefDim_FA."Dimension Value Code" := ODimVal.Code;
                        DefDim_FA.Modify();
                    end;
                end;
            end;
        end;
        // end;
        // until (FA.Next = 0);
        // end;
        // end;
    end;

    var /*procedure InsertDimCombination(ChildDim: Code[20]; ChildCode: Code[20]; ParentDim: Code[20]; ParentCode: Code[20])
    var
        DimValueComb: record "Dimension Value Combination";
        ParentDimValues: record "Dimension Value";
        FASetup: Record "FA Setup";
    begin
        DimValueComb.Reset();
        ParentDimValues.Reset;

        ParentDimValues.SetFilter(ParentDimValues."Dimension Code", ParentDim);
        ParentDimValues.SetFilter(ParentDimValues."Code", '<>%1', ParentCode);
        if ParentDimValues.FindSet() then begin
            repeat
            begin
                DimValueComb.Init();
                DimValueComb."Dimension 1 Code" := ChildDim;
                DimValueComb."Dimension 1 Value Code" := ChildCode;
                DimValueComb."Dimension 2 Code" := ParentDimValues."Dimension Code";
                DimValueComb."Dimension 2 Value Code" := ParentDimValues."Code";
                DimValueComb.Insert();
            end;
            until (ParentDimValues.Next = 0);
        end;


    end;*/
    procedure RenameCustDim(xCust: Record Customer;
    Cust: Record Customer)
    var
        DimValCust: Record "Dimension Value";
        FASetup: Record "FA Setup";
        companyinfo: Record "Company Information";
    begin
        FASetup.Get();
        //if FASetup."Enable FA Site Tracking" then begin
        DimValCust.Reset();
        DimValCust.SetFilter(DimValCust."Dimension Code", FASetup."FBM_Customer Dimension");
        DimValCust.SetFilter(DimValCust.Code, xCust."No.");
        if DimValCust.FindFirst() then begin
            DimValCust.Rename(FASetup."FBM_Customer Dimension", Cust."No.");
        end;
        companyinfo.Reset();
        companyinfo.Get();
        if companyinfo.FBM_CustIsOp then begin
            RenameOpDim(xCust, Cust);
        end;
        //end;
    end;

    procedure RenameOpDim(xCustomer: Record Customer;
    Customer: Record Customer)//procedure to use for scenarios where customer = operator
    var
        DimValOp: Record "Dimension Value";
        FASetup: Record "FA Setup";
        companyinfo: Record "Company Information";
    begin
        FASetup.Get();
        //if FASetup."Enable FA Site Tracking" then begin
        DimValOp.Reset();
        DimValOp.SetFilter(DimValOp."Dimension Code", FASetup."FBM_Operator Dimension");
        DimValOp.SetFilter(DimValOp.Code, xCustomer."No.");
        if DimValOp.FindFirst() then begin
            DimValOp.Rename(FASetup."FBM_Operator Dimension", Customer."No.");
        end;
        //end;
    end;
    //DEVOPS #619 -- begin
    procedure ContractDimension(Custsite: Record FBM_CustomerSite_C)
    var
        ContractDim: Record "Dimension Value";
        FASetup: Record "FA Setup";
        CustOpSite: Record FBM_CustOpSite;
    begin
        if FASetup.Get() then begin
            //if FASetup."Enable FA Site Tracking" then begin
            //check if contract dimension exists, if not create it
            ContractDim.Reset();
            if Custsite."Contract Code" <> '' then
                if not ContractDim.Get(FASetup."FBM_Contract Dimension", Custsite."Contract Code") then begin
                    ContractDim.Reset();
                    ContractDim.Init();
                    ContractDim."Dimension Code" := FASetup."FBM_Contract Dimension";
                    ContractDim."Code" := CustSite."Contract Code";
                    ContractDim.Name := CustSite."Contract Code";
                    ContractDim.Insert(true);
                end;
            if Custsite."Contract Code2" <> '' then
                if not ContractDim.Get(FASetup."FBM_Contract Dimension", Custsite."Contract Code2") then begin
                    ContractDim.Reset();
                    ContractDim.Init();
                    ContractDim."Dimension Code" := FASetup."FBM_Contract Dimension";
                    ContractDim."Code" := CustSite."Contract Code2";
                    ContractDim.Name := CustSite."Contract Code2";
                    ContractDim.Insert(true);
                end;
            //end;
        end;
    end;
    //DEVOPS #619 -- end
}
