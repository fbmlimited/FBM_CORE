pageextension 60129 "FBM_PurchInvExt_CO" extends "Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("Posting No."; rec."Posting No.")
            {
                ApplicationArea = all;
            }
            field("Receiving No."; rec."Receiving No.")
            {
                ApplicationArea = all;
            }
            field(LYC; glsetup."LCY Code")
            {
                ApplicationArea = All;
                Editable = false;

            }
        }
        addafter("Vendor Invoice No.")
        {
            field("Posting Description89380"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
        }
        modify("IDPIRPF IRPF Group")
        {
            Visible = isvisES;
        }
    }
    actions
    {
        addfirst(processing)
        {
            action("Approval Request Entries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Request Entries';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Open Approval Request Entries page';
                RunObject = Page "FBM_ApprRequest Entries New_CO";
                RunPageLink = "Document No." = field("No.");
            }
        }
    }
    trigger
   OnOpenPage()

    var
        uper: Codeunit "User Permissions";
    begin

        if compinfo.Get() then begin
            isvisES := compinfo."Country/Region Code" = 'ES';
            isvisPH := compinfo."Country/Region Code" = 'PH';
        end;

        glsetup.get
    end;

    var
        glsetup: record "General Ledger Setup";
        isvisES: Boolean;
        isvisPH: Boolean;
        compinfo: record "Company Information";
}