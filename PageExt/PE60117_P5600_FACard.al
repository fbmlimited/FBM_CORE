pageextension 60117 FBM_FACardExt_CO extends "Fixed Asset Card"
{
    layout
    {
        addafter(BookValue)
        {
            field(AcquisitionDate; AcquisitionDate)
            {
                ApplicationArea = all;
            }
            field(Status; rec.FBM_Status)
            {
                ApplicationArea = all;
            }
        }
        addafter("FA Subclass Code")
        {
            field(Is_EGM; rec.FBM_Is_EGM)
            {
                ApplicationArea = all;
            }

        }

        addafter("Responsible Employee")
        {
            field(FBM_DatePrepared; Rec.FBM_DatePrepared)
            {
                ApplicationArea = all;
            }
        }
        addafter(Maintenance)
        {
            group(CustomerSiteTracking)
            {
                Caption = 'Customer - Site Tracking';

                group(LastMovement)
                {
                    Caption = 'Last Movement History';
                    field(FBM_Brand; Rec.FBM_Brand)
                    { Caption = 'Brand'; }
                    field(FBM_Lessee; Rec.FBM_Lessee)
                    { Caption = 'Lessee'; }
                    field(LastMovementDate; LastMovementDate)
                    {
                        Caption = 'Date';
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field(OperatoreCode; OperatoreCode)
                    {
                        Caption = 'Operator Code';
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field(LastMovementOpName; LastMovementOpName)
                    {
                        Caption = 'Operator Name';
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field(SiteCode; SiteCode)
                    {
                        Caption = 'Site Code';
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field(LastMovementSite; LastMovementSite)
                    {
                        Caption = 'Site Name';
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field(LastMovementRemarks; LastMovementRemarks)
                    {
                        Caption = 'Remarks';
                        ApplicationArea = all;
                        Editable = false;
                    }
                }
            }
        }
    }
    actions
    {
        addlast(navigation)
        {
            group("FA History Movement")
            {
                action("Movement History")
                {
                    image = FARegisters;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // Clear(FAMH);
                        // Clear(FAMHP);
                        // FAMH.SetFilter(FAMH."FA No.", Rec."No.");
                        // FAMHP.SetTableView(FAMH);
                        // FAMHP.RunModal();
                    end;
                }
            }
        }
        addafter(Dimensions)
        {
            action("FA Dimensions")
            {
                ApplicationArea = Dimensions;
                Caption = 'Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                begin
                    DefaultDims.SetFilter(DefaultDims."Table ID", '5600');
                    DefaultDims.SetFilter("No.", Rec."No.");
                    FADimP.Editable := false;
                    FADimP.SetTableView(DefaultDims);
                    FADimP.RunModal();
                end;
            }
        }
        modify(Dimensions)
        {
            Visible = false;
        }
    }
    var
        // FAMHP: Page "FA Movement History";
        // FAMH: Record "FA Movement History";
        FADimP: Page "Default Dimensions";
        DefaultDims: Record "Default Dimension";
        FAMHEntryNo: Integer;
        // FAMHInfo: Record "FA Movement History";
        LastMovementDate: Date;
        LastMovementSite: Code[250];
        LastMovementOpName: Text[150];
        LastMovementRemarks: Text[250];
        AcquisitionDate: Date;

        SiteCode: Code[20];
        OperatoreCode: Code[20];

    trigger OnOpenPage()
    begin
        Clear(FAMHEntryNo);
        Clear(LastMovementSite);
        Clear(LastMovementDate);
        Clear(LastMovementOpName);
        clear(LastMovementRemarks);
        // FAMHInfo.Reset();
        FAMHEntryNo := GetLatestMovement(Rec."No.");
        if FAMHEntryNo = 0 then begin
            LastMovementDate := 0D;
            LastMovementOpName := '';
            LastMovementSite := '';
            LastMovementRemarks := '';
            SiteCode := '';
            OperatoreCode := '';
        end
        else begin
            // if FAMHInfo.Get(FAMHEntryNo) then begin
            //     LastMovementDate := FAMHInfo.Date;
            //     LastMovementOpName := FAMHInfo."Corporate Name";
            //     LastMovementSite := FAMHInfo.Site;
            //     LastMovementRemarks := FAMHInfo.Remarks;
            //     SiteCode := FAMHInfo."Site Code";
            //     OperatoreCode := FAMHInfo."Operator Code";
            // end;
        end;
        GetAcquisitionDate(Rec);
    end;

    procedure GetLatestMovement(FANo: Code[20]) EntryNo: Integer
    var
    // MoveHistory: Record "FA Movement History";
    begin
        // MoveHistory.SetCurrentKey(Date);
        // MoveHistory.SetFilter(MoveHistory."FA No.", FANo);
        // if MoveHistory.FindLast() then
        //     EntryNo := MoveHistory."Entry No."
        // else
        //     EntryNo := 0;
    end;

    procedure GetAcquisitionDate(FA: Record "Fixed Asset")
    var
        FALE: record "FA Ledger Entry";
    begin
        FALE.Reset();
        FALE.SetCurrentKey("Posting Date");
        FALE.SetFilter(FALE."FA No.", FA."No.");
        FALE.SetFilter(FALE."FA Posting Type", '%1', FALE."FA Posting Type"::"Acquisition Cost");
        if FALE.FindFirst() then
            AcquisitionDate := FALE."Posting Date"
        else
            AcquisitionDate := 0D;
    end;
}
