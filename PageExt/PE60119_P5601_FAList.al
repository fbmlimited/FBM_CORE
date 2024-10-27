pageextension 60119 FBM_FAListExt_CO extends "Fixed Asset List"
{
    layout
    {
        addafter("FA Subclass Code")
        {
            field(FBM_ReplicaStatus; Rec.FBM_ReplicaStatus2)
            {
                ApplicationArea = All;
            }
            field(Brand71635; Rec.FBM_Brand)
            {
                ApplicationArea = All;
            }
            field(Lessee77282; Rec.FBM_Lessee)
            {
                ApplicationArea = All;
            }
        }
        modify("FA Location Code")
        {
            Visible = false;
        }
        modify("Responsible Employee")
        {
            Visible = false;
        }
        addafter("Search Description")
        {
            field(FBM_Status; Rec.FBM_Status)
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code80514"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code06138"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Serial No."; rec."Serial No.")
            {
                ApplicationArea = all;
            }
            field(Is_EGM; rec.FBM_Is_EGM_FF)
            {
                ApplicationArea = all;
            }

            field(FBM_Dupecomp; Rec.FBM_Dupecomp)
            {
                ApplicationArea = all;
                Visible = visdupe;
            }
        }

        addafter("FA Class Code")
        {
            field("Fa Posting Group Depr"; rec."FBM_Fa Posting Group Depr_FF")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addlast(navigation)
        {
            action("New FA")
            {
                image = ListPage;
                ApplicationArea = all;

                RunObject = page FBM_FAListNew_CO;

            }
            group("FA History Movement")
            {
                Image = FixedAssetLedger;

                action("Movement History")
                {
                    ApplicationArea = All;
                    Image = FARegisters;

                    trigger OnAction()
                    begin
                        // Clear(FAMH);
                        // Clear(FAMHP);
                        // FAMH.SetFilter(FAMH."FA No.", Rec."No.");
                        // FAMHP.SetTableView(FAMH);
                        // FAMHP.RunModal();
                    end;
                }
                action("Import Movement History - Direct")
                {
                    ApplicationArea = All;
                    Image = ImportLog;

                    trigger OnAction()
                    begin
                        Xmlport.Run(50000);
                    end;
                }
                action("Import Movement History - Branch")
                {
                    ApplicationArea = All;
                    Image = ImportLog;

                    trigger OnAction()
                    begin
                        Xmlport.Run(50002);
                    end;
                }
            }
        }
        addafter(Dimensions)
        {
            action("FA Dimensions")
            {
                //to replace standard action - needs to be non editable
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
        // ImportFAMHCIP: XmlPort "Import FAMH - Cust Is Op";
        // ImportFAMHCNP: XmlPort "Import FAMH - Cust Not Op";
        FADimP: Page "Default Dimensions";
        DefaultDims: Record "Default Dimension";
        FADefDims: Record "Default Dimension";
        FASetup: Record "FA Setup";
        Show: Boolean;

        dupecomp: text[3];
        comp: record Company;
        fa: record "Fixed Asset";
        compinfo: record "Company Information";
        compinfob: record "Company Information";
        uper: Codeunit "User Permissions";
        visdupe: boolean;

    trigger OnAfterGetRecord()
    var
        fale: record "FA Ledger Entry";
    begin
        compinfob.get;
        if comp.FindFirst() and uper.IsSuper(UserSecurityId()) then begin
            visdupe := true;
            repeat
                fa.ChangeCompany(comp.Name);
                compinfo.ChangeCompany(comp.Name);
                if compinfo.Name <> compinfob.Name then begin
                    fa.SetRange("Serial No.", rec."Serial No.");
                    fa.SetRange(FBM_Is_EGM_FF, true);
                    if fa.FindFirst() then begin//and rec.IsActive and fa.IsActive

                        rec.FBM_Dupecomp := compinfo."Custom System Indicator Text";
                        rec.Modify();
                    end;
                end;


            until comp.Next() = 0;
        end;
#if not JYM
        fale.SetRange("FA No.", rec."No.");
        fale.SetRange("FA Posting Type", fale."FA Posting Type"::"Acquisition Cost");

        if fale.FindFirst() then begin
            rec.CalcFields(FBM_AcqCost, FBM_DeprDate);
            if ((rec.FBM_AcquisitionCost <> rec.FBM_AcqCost) or
            (rec.FBM_AcquisitionDate <> fale."FA Posting Date") or
(rec.FBM_DepreciationDate <> rec.FBM_Deprdate))
            then begin
                rec.FBM_AcquisitionCost := rec.FBM_AcqCost;
                rec.FBM_AcquisitionDate := fale."FA Posting Date";
                rec.FBM_DepreciationDate := rec.FBM_DeprDate;
                rec.Modify();
            end;
        end;
#endif
    end;

    trigger OnOpenPage()
    begin
        rec.setfilter(FBM_ReplicaStatus2, '<>%1', rec.FBM_ReplicaStatus2::Sent);
    end;
}
