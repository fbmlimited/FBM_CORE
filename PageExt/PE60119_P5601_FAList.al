pageextension 60119 FBM_FAListExt_CO extends "Fixed Asset List"
{
    layout
    {
        addafter("No.")
        {
            field("Serial No."; rec."Serial No.")
            {
                ApplicationArea = all;
            }
            field(Is_EGM; rec.FBM_Is_EGM)
            {
                ApplicationArea = all;
            }
        }

        addafter("FA Class Code")
        {
            field("Fa Posting Group Depr"; rec."FBM_Fa Posting Group Depr")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addlast(navigation)
        {
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

    trigger OnAfterGetRecord()
    begin
    end;

    trigger OnOpenPage()
    begin
    end;
}
