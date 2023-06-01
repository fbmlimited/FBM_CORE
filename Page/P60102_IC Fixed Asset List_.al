page 60102 "FBM_IC Fixed Asset List_CO"
{
    AdditionalSearchTerms = 'ic fa list';
    ApplicationArea = FixedAssets;
    Caption = 'IC Fixed Assets';
    //CardPageID = "IC Fixed Asset Card";
    Editable = false;
    PageType = List;
    SourceTable = "Fixed Asset";
    SourceTableTemporary = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("No."; rec."No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies a description of the fixed asset.';
                }
                field("FA Class Code"; rec."FA Class Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the class that the fixed asset belongs to.';
                }
                field("FA Subclass Code"; rec."FA Subclass Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the subclass of the class that the fixed asset belongs to.';
                }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the Serial No. of the Fixed Asset.';
                }
                // field("Depreciation Method";FBMDepBook."Depreciation Method")
                // {
                //   ApplicationArea = FixedAssets;
                //   ToolTip = 'Specifies the Depreciation Method of the Fixed Asset.';
                // }
                // field("Start Dep. Date";FBMDepBook."Depreciation Starting Date")
                // {
                //   ApplicationArea = FixedAssets;
                //   ToolTip = 'Specifies the starting depreciation date of the Fixed Asset.';
                // }
                // field("No. of Depreciation years";FBMDepBook."No. of Depreciation Years")
                // {
                //   ApplicationArea = FixedAssets;
                //   ToolTip = 'Specified the No. of Depreciation Years of the Fixed Asset';
                // }
                // field("End Dep. Date";FBMDepBook."Depreciation Ending Date")
                // {
                //   ApplicationArea = FixedAssets;
                //   ToolTip = 'Specifies the Serial No. of the Fixed Asset.';
                // }
                // field("Book Value";FBMDepBook."Book Value")
                // {
                //   ApplicationArea = FixedAssets;
                //   ToolTip = 'Specifies the Serial No. of the Fixed Asset.';
                // }
                // field("Site";FBMFAMH.Site)
                // {
                //   ApplicationArea = FixedAssets;
                //   ToolTip = 'Last Movement Site of the Fixed Asset.';
                // }
                // field("Customer";FBMFAMH."Customer Name")
                // {
                //   ApplicationArea = FixedAssets;
                //   ToolTip = 'Last Movement Customer of the Fixed Asset.';
                // }
                // field("Operator";FBMFAMH."Corporate Name")
                // {
                //   ApplicationArea = FixedAssets;
                //   ToolTip = 'Last Movement Operator of the Fixed Asset.';
                // }
                // field("Remarks";FBMFAMH.Remarks)
                // {
                //   ApplicationArea = FixedAssets;
                //   ToolTip = 'Last Movement Remarks of the Fixed Asset.';
                // }
                // field("Date";FBMFAMH.Date)
                // {
                //   ApplicationArea = FixedAssets;
                //   Tooltip = 'Last Movement Date of the Fixed Asset.';
                // }
            }
        }
    }
    actions
    {
        /* Do not require to view movement history intercompany.
              area(Navigation)
              {
                  group(MovementHistory)
                  {
                      Caption = 'FA Movement History';
                      Image = FixedAssetLedger;

                      action("Fixed Asset Movement History")
                      {
                          ApplicationArea = all;
                          Image = FixedAssetLedger;

                          trigger OnAction()
                          begin
                              Clear(ICFAMH);
                              Clear(ICFAMHP);
                              FAMHV.SetFANo(Rec."No.");
                              ICFAMHP.RunModal();
                          end;
                      }
                  }
              }
              */
    }
    var
        FBMDepBook: Record "FA Depreciation Book";
        // FBMFAMH: Record "FA Movement History";
        // ICFAMHP: Page "IC FA Movement History";
        // ICFAMH: Record "FA Movement History";
        // FAMHV: Codeunit 50002;
        MHFANo: Code[20];

    trigger OnAfterGetRecord()
    var
        FASetup: Record "FA Setup";
    begin
        //get depreciation details
        FASetup.Get();
        FBMDepBook.Reset();
        FBMDepBook.ChangeCompany(FASetup."FBM_FA Company");
        FBMDepBook.SetFilter(FBMDepBook."FA No.", Rec."No.");
        if FBMDepBook.FindFirst() then begin
            FBMDepBook.CalcFields("Book Value");
        end;
        // FBMFAMH.Reset();
        // FBMFAMH.ChangeCompany(FASetup."FA Company");
        // FBMFAMH.SetFilter(FBMFAMH."FA No.", Rec."No.");
        // if FBMFAMH.FindLast()then begin
        // end;
    end;

    procedure InitTempTable()
    var
        FAFBM: Record "Fixed Asset";
        // FAMH: Record "FA Movement History";
        Customers: array[80] of Text[250];
        Customer: Record Customer;
        i: Integer;
        j: Integer;
        ShowFA: Boolean;
        FASetup: record "FA Setup";
    begin
        FAFBM.reset;
        Clear(Customers);
        i := 0;
        j := 0;
        ShowFA := false;
        FASetup.Get();
        //access company where FAs are held
        FAFBM.ChangeCompany(FASetup."FBM_FA Company");
        // FAMH.ChangeCompany(FASetup."FA Company");
        //fill array with customers
        Customer.Reset();
        if customer.FindFirst() then begin
            repeat begin
                for i := 1 to ArrayLen(Customers) do begin
                    if Customers[i] = '' then begin
                        Customers[i] := Customer.Name;
                        i := ArrayLen(Customers);
                    end;
                end;
            end;
            until (Customer.Next = 0);
        end;
        FAFBM.SetCurrentKey("No.");
        if FAFBM.FindSet() then begin
            repeat //for each fixed asset
            begin
                ShowFA := false;
                // FAMH.Reset();
                // FAMH.SetCurrentKey("Date");
                // FAMH.SetFilter(FAMH."FA No.", FAFBM."No.");
                // if FAMH.FindLast()then begin //find last Movement History entry
                //   //check if FA is at a customer of company the user is currently in
                for j := 1 to ArrayLen(Customers) do begin
                    // if Customers[j] = FAMH."Customer Name" then begin
                    ShowFA := true;
                    j := ArrayLen(Customers);
                    // end;
                end;
                // end;
                //insert temp table with records to show only 
                if ShowFA then begin
                    Rec := FAFBM;
                    rec.Insert();
                end;
            end;
            until (FAFBM.Next = 0)
        end;
    end;

    procedure GetSelectionFilter(): Text
    var
        FixedAsset: Record "Fixed Asset";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(FixedAsset);
        exit(SelectionFilterManagement.GetSelectionFilterForFixedAsset(FixedAsset));
    end;

    trigger OnOpenPage()
    begin
        InitTempTable();
    end;
}
