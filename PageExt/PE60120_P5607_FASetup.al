pageextension 60120 FBM_FASetupExt_CO extends "Fixed Asset Setup"
{
    layout
    {


        addafter(Numbering)
        {
            group("FA Import")
            {

                field("FBM_FA Company"; Rec."FBM_FA Company")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Asset Company';
                    //visible = false;
                }
                field(FBM_FAsubclassImport; Rec.FBM_FAsubclassImport)
                {
                    ApplicationArea = All;

                }
            }
            group(CustomerSiteTracking)
            {
                Caption = 'Customer - Site Tracking';
                visible = false;

                group(CSTrackingDimensions)
                {
                    Caption = 'Dimensions';

                    field("FBM_Customer Dimension"; Rec."FBM_Customer Dimension")
                    {
                        ApplicationArea = all;
                    }
                    field("FBM_Site Dimension"; Rec."FBM_Site Dimension")
                    {
                        ApplicationArea = all;
                    }
                    field("FBM_Operator Dimension"; Rec."FBM_Operator Dimension")
                    {
                        ApplicationArea = all;
                    }

                    field("FBM_Contract Dimension"; Rec."FBM_Contract Dimension")
                    {
                        ApplicationArea = all;
                    }

                }
                field("FBM_Enable FA Site Tracking"; Rec."FBM_Enable FA Site Tracking")
                {
                    ApplicationArea = All;
                }

            }
        }

    }
}
