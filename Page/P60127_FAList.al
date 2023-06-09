page 60127 FBM_FAList
{
    Caption = 'Lista A/F';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Fixed Asset";
    SourceTableView = where(Description = filter(<> ''));

    layout
    {
        area(Content)
        {
            field(fromdate; fromdate)
            {
                ApplicationArea = All;
                caption = 'De Fecha';
            }
            field(todate; todate)
            {
                caption = 'A Fecha';
                ApplicationArea = All;
                trigger
                OnValidate()
                begin
                    if (fromdate <> 0D) and (todate <> 0D) then
                        CurrPage.Update();
                end;
            }
            repeater(Group)
            {
                field(lineno; lineno)
                {
                    ApplicationArea = All;
                    caption = 'Nr. Progr.';
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    caption = 'A/F';
                }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = All;
                    caption = 'Nr. de serie';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    caption = 'Inmovilizado';
                }
                field(provider; provider)
                {
                    ApplicationArea = All;
                    caption = 'Proveedor';
                }

                field(NumberOfDepreciationYears; round(FADepreciationBook."No. of Depreciation Years", 1))
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Duracion Años';
                    ToolTip = 'Specifies the length of the depreciation period, expressed in years.';


                }
                field(pct; 100 / round(yearsdepr, 1))
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Porcentaje';
                    ToolTip = 'Specifies the length of the depreciation period, expressed in years.';


                }
                field(DepreciationMethod; FADepreciationBook."Depreciation Method")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Metodo';
                    ToolTip = 'Specifies how depreciation is calculated for the depreciation book.';


                }
                field(AcquisitionDate; AcquisitionDate)
                {
                    ApplicationArea = All;
                    caption = 'Fecha de Compra';
                }
                field(DepreciationStartingDate; FADepreciationBook."Depreciation Starting Date")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fecha de Inicio';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the date on which depreciation of the fixed asset starts.';


                }
                field(AcquisitionAmt; AcquisitionAmt)
                {
                    ApplicationArea = All;
                    caption = 'Valor Inicial';
                }
                field(ResidualAmt; AcquisitionAmt + DepreciationAmt)
                {
                    ApplicationArea = All;
                    caption = 'Valor Residual';
                }
                field(DepreciationAmt; -depryear)
                {
                    ApplicationArea = All;
                    caption = 'Depreciacion';
                }
                field(activeyear; activeyear)
                {
                    ApplicationArea = All;
                    caption = 'Activo';
                }

            }
        }

    }


    trigger
    OnAfterGetRecord()
    begin
        lineno += 1;
        GetAcquisitionDate(rec);
        GetProvider(Rec);
        LoadFADepreciationBooks();
        CurrPage.Update(false);
        FADepreciationBook.Copy(FADepreciationBookOld);
        GetDepreciation(Rec);
        Setactive(Rec);
        if FADepreciationBook."No. of Depreciation Years" = 0 then
            yearsdepr := 1
        else
            yearsdepr := round(FADepreciationBook."No. of Depreciation Years", 1);

    end;


    var
        lineno: Integer;
        fromdate: date;
        todate: date;
        AcquisitionDate: date;
        AcquisitionAmt: Decimal;
        provider: text[250];
        FADepreciationBook: Record "FA Depreciation Book";
        FADepreciationBookOld: Record "FA Depreciation Book";
        AllowEditDepBookCode: Boolean;
        Simple: Boolean;
        DepreciationAmt: Decimal;
        depryear: Decimal;
        activeyear: Boolean;
        yearsdepr: integer;

    procedure GetAcquisitionDate(FA: Record "Fixed Asset")
    var
        FALE: record "FA Ledger Entry";
    begin
        FALE.Reset();
        FALE.SetCurrentKey("Posting Date");
        FALE.SetFilter(FALE."FA No.", FA."No.");
        fale.SetFilter("FA Posting Category", '=%1', fale."FA Posting Category"::" ");
        FALE.SetFilter(FALE."FA Posting Type", '%1', FALE."FA Posting Type"::"Acquisition Cost");
        if FALE.FindFirst() then begin
            AcquisitionDate := FALE."Posting Date";
            AcquisitionAmt := fale."Amount (LCY)";
        end
        else begin
            AcquisitionDate := 0D;
            AcquisitionAmt := 0;
        end;
    end;

    procedure GetProvider(FA: Record "Fixed Asset")
    var
        subclass: record "FA Subclass";
    begin
        if subclass.get(fa."FA Subclass Code") then
            if subclass.FBM_EGM then
                provider := 'FBM Systems and Electronics Inc.'
            else
                provider := '';
    end;

    protected procedure LoadFADepreciationBooks()
    begin
        Clear(FADepreciationBookOld);
        FADepreciationBookOld.SetRange("FA No.", rec."No.");
        if FADepreciationBookOld.Count <= 1 then begin
            if FADepreciationBookOld.FindFirst() then begin
                FADepreciationBookOld.CalcFields("Book Value");
                //ShowAddMoreDeprBooksLbl := true
            end;
            Simple := true;
            AllowEditDepBookCode := FADepreciationBookOld."Depreciation Book Code" = '';
        end else
            Simple := false;

        //OnAfterLoadDepreciationBooks(Rec, Simple);
    end;

    procedure GetDepreciation(FA: Record "Fixed Asset")
    var
        FALE: record "FA Ledger Entry";
    begin
        FALE.Reset();
        FALE.SetCurrentKey("Posting Date");
        FALE.SetFilter(FALE."FA No.", FA."No.");
        fale.SetFilter("FA Posting Category", '=%1', fale."FA Posting Category"::" ");
        FALE.SetFilter(FALE."FA Posting Type", '=%1', FALE."FA Posting Type"::Depreciation);
        fale.CalcSums(Amount);
        if not FALE.IsEmpty then begin
            DepreciationAmt := fale.Amount;
        end
        else begin
            DepreciationAmt := 0;
        end;
        fale.SetRange("Posting Date", fromdate, todate);
        fale.CalcSums(Amount);
        depryear := fale.Amount;

    end;

    procedure SetActive(FA: Record "Fixed Asset")
    var
        glentry: Record "G/L Entry";
    begin
        activeyear := false;
        if AcquisitionDate <= todate then
            if FADepreciationBook."Depreciation Ending Date" >= fromdate then
                activeyear := true;
        glentry.SetRange("Source No.", fa."No.");
        glentry.SetRange("Posting Date", fromdate, todate);
        glentry.SetFilter("G/L Account No.", '213*');
        activeyear := (not glentry.IsEmpty) or activeyear;
    end;

}