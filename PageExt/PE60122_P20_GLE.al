pageextension 60122 FBM_GLEntriesExt_CO extends "General Ledger Entries"
{
    layout
    {
        modify("G/L Account Name")
        {
            Visible = true;
        }
        modify("Business Unit Code")
        {
            Visible = true;
        }
        addafter("Posting Date")
        {
            //DEVOPS #742 -- begin
            field("Document Date"; rec."Document Date")
            {
                ApplicationArea = All;
            }

            //DEVOPS #742 -- end
        }
        //DEVOPS #622 -- begin
        addafter("External Document No.")
        {
            field("FBM_Period Start"; Rec."FBM_Period Start")
            {
                ApplicationArea = All;
            }
            field("FBM_Period End"; Rec."FBM_Period End")
            {
                ApplicationArea = All;
            }
            field(VendorCode; VendorCode)
            {
                ApplicationArea = All;
            }
            field(VendorName; VendorName)
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Date")
        {
            field("System-Created Entry90050"; Rec."System-Created Entry")
            {
                ApplicationArea = All;
            }
            field(SystemCreatedAt63406; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
            }
            field(SystemCreatedBy51542; Rec.SystemCreatedBy)
            {
                ApplicationArea = All;
            }
        }
        modify("Additional-Currency Amount")
        {
            Visible = true;
        }
    }
    var
        VendorCode: code[20];
        VendorName: text[100];

    trigger OnAfterGetRecord()
    var
        purchheader: record "Purch. Inv. Header";
        purchcrheader: Record "Purch. Cr. Memo Hdr.";
    begin
        VendorCode := '';
        VendorName := '';
        if purchheader.Get(rec."Document No.") then begin
            VendorCode := purchheader."Buy-from Vendor No.";
            VendorName := purchheader."Buy-from Vendor Name"
        end;
        if purchcrheader.Get(rec."Document No.") then begin
            VendorCode := purchcrheader."Buy-from Vendor No.";
            VendorName := purchcrheader."Buy-from Vendor Name"
        end;
    end;
}
