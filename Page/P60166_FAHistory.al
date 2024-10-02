page 60166 FBM_FAHistory_CO
{
    Caption = 'FA History';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_FAHistory_DD;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Version; Rec.Version)
                {
                    ApplicationArea = All;
                }
                field(ActiveRec; Rec.ActiveRec)
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("FA Class Code"; Rec."FA Class Code")
                {
                    ApplicationArea = All;
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = All;
                }
                field("FA Location Code"; Rec."FA Location Code")
                {
                    ApplicationArea = All;
                }
                field(FBM_Model; Rec.FBM_Model)
                {
                    ApplicationArea = All;
                }
                field(FBM_Brand; Rec.FBM_Brand)
                {
                    ApplicationArea = All;
                }
                field(FBM_Segment2; Rec.FBM_Segment2)
                {
                    ApplicationArea = All;
                }
                field(FBM_Lessee; Rec.FBM_Lessee)
                {
                    ApplicationArea = All;
                }
                field(FBM_Status; Rec.FBM_Status)
                {
                    ApplicationArea = All;
                }
                field(FBM_Site; Rec.FBM_Site)
                {
                    ApplicationArea = All;
                }

                field(FBM_DatePrepared; Rec.FBM_DatePrepared)
                {
                    ApplicationArea = All;
                }
                field("Valid From"; Rec."Valid From")
                {
                    ApplicationArea = All;
                }
                field("Valid To"; Rec."Valid To")
                {
                    ApplicationArea = All;
                }
                field("Record Owner"; Rec."Record Owner")
                {
                    ApplicationArea = All;
                }
                field("Change Note"; Rec."Change Note")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}