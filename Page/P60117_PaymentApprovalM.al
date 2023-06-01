page 60117 FBM_PaymentApprovalM_CO
{
    ApplicationArea = All;
    Caption = 'Payment Approval Multicompany';
    PageType = List;
    SourceTable = FBM_VendorLEM;
    SourceTableView = where("Document Type" = filter(Invoice), Open = filter(true));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document type that the vendor entry belongs to.';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor entry''s document number.';
                    Editable = false;
                }
                field(Company; rec.Company)
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor entry''s posting date.';
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date on the entry.';
                    Editable = true;
                }
                field("Original Due Date"; GetOriginalDueDate(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Original Due Date';
                    ToolTip = 'Specifies the due date on the entry.';
                    Editable = false;
                }
                field("Vendor Name"; GetVendorNAme(Rec))
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the vendor account that the entry is linked to.';
                    Caption = 'Vendor Name';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the vendor entry.';
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    Editable = false;
                }
                field("Default Bank Account"; rec."Default Bank Account")
                {

                }
                field("Approver Comment"; rec."Approver Comment")
                {

                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the amount field.';
                    Editable = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                    Editable = false;
                }
                field(approved; Rec.approved)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the approved field.';
                    Editable = true;
                    trigger OnValidate()
                    var
                        usersetup: Record "User Setup";
                    begin
                        if usersetup.get(UserId) then begin
                            if usersetup."FBM_Approve Finance" = false then
                                Error('Your user is not setup for finance approval. Please contact the system administrator.');
                            CurrPage.Banks.Page.Update(false);
                        end;

                    end;



                }
                field("approved date"; Rec."approved date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the approved date field.';
                    Editable = false;
                }
                field("approved user"; Rec."approved user")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the approved user field.';
                    Editable = false;
                }
                field(ApproverID; ApproverID)
                {
                    ApplicationArea = All;
                    Caption = 'Approver ID';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
                field(LastDateTimeModified; LastDateTimeModified)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Last Date-Time Modified';
                }
            }


        }

        area(factboxes)
        {
            part("Banks"; "FBM_PaymJnl Bank List Part2_CO")
            {
                ApplicationArea = Basic, Suite;

            }
        }
    }
    trigger
    OnInit()
    begin
        vlem.DeleteAll();
    end;

    trigger OnOpenPage()


    begin

        VLEM.DeleteAll();
        comp.FindFirst();
        repeat
            compinfo.ChangeCompany(comp.name);
            compinfo.get;
            if compinfo.FBM_EnAppr then begin
                VLE.ChangeCompany(comp.Name);

                vle.FindFirst();

                repeat
                    VLEM.Init();
                    vlem.Company := compinfo.Name;
                    vlem."Entry No." := vle."Entry No.";
                    vlem."Vendor No." := vle."Vendor No.";
                    vlem."Posting Date" := vle."Posting Date";
                    vlem."Document Type" := vle."Document Type";
                    vlem."Document No." := vle."Document No.";
                    vlem.Description := vle.Description;
                    vlem."Vendor Name" := vle."Vendor Name";
                    vlem."Currency Code" := vle."Currency Code";
                    vle.CalcFields(Amount);
                    vlem.Amount := vle.Amount;
                    vle.CalcFields("Remaining Amount");
                    vlem."Remaining Amount" := vle."Remaining Amount";
                    vle.CalcFields("Original Amt. (LCY)");
                    vlem."Original Amt. (LCY)" := vle."Original Amt. (LCY)";
                    vle.CalcFields("Remaining Amt. (LCY)");
                    vlem."Remaining Amt. (LCY)" := vle."Remaining Amt. (LCY)";
                    vle.CalcFields("Amount (LCY)");
                    vlem."Amount (LCY)" := vle."Amount (LCY)";
                    vlem."Purchase (LCY)" := vle."Purchase (LCY)";
                    vlem."Inv. Discount (LCY)" := vle."Inv. Discount (LCY)";
                    vlem."Buy-from Vendor No." := vle."Buy-from Vendor No.";
                    vlem."Vendor Posting Group" := vle."Vendor Posting Group";
                    vlem."Global Dimension 1 Code" := vle."Global Dimension 1 Code";
                    vlem."Global Dimension 2 Code" := vle."Global Dimension 2 Code";
                    vlem."Purchaser Code" := vle."Purchaser Code";
                    vlem."User ID" := vle."User ID";
                    vlem."Source Code" := vle."Source Code";
                    vlem."On Hold" := vle."On Hold";
                    vlem."Applies-to Doc. Type" := vle."Applies-to Doc. Type";
                    vlem."Applies-to Doc. No." := vle."Applies-to Doc. No.";
                    vlem.Open := vle.Open;
                    vlem."Due Date" := vle."Due Date";
                    vlem."Pmt. Discount Date" := vle."Pmt. Discount Date";
                    vlem."Orig. Pmt. Disc. Possible(LCY)" := vle."Orig. Pmt. Disc. Possible(LCY)";
                    vlem."Pmt. Disc. Rcd.(LCY)" := vle."Pmt. Disc. Rcd.(LCY)";
                    vlem."Original Pmt. Disc. Possible" := vle."Original Pmt. Disc. Possible";
                    vlem.Positive := vle.Positive;
                    vlem."Closed by Entry No." := vle."Closed by Entry No.";
                    vlem."Closed at Date" := vle."Closed at Date";
                    vlem."Closed by Amount" := vle."Closed by Amount";
                    vlem."Applies-to ID" := vle."Applies-to ID";
                    vlem."Journal Templ. Name" := vle."Journal Templ. Name";
                    vlem."Journal Batch Name" := vle."Journal Batch Name";
                    vlem."Reason Code" := vle."Reason Code";
                    vlem."Bal. Account Type" := vle."Bal. Account Type";
                    vlem."Bal. Account No." := vle."Bal. Account No.";
                    VLEM."Transaction No." := vle."Transaction No.";
                    vlem."Closed by Amount (LCY)" := vle."Closed by Amount (LCY)";
                    vle.CalcFields("Debit Amount");
                    vlem."Debit Amount" := vle."Debit Amount";
                    vle.CalcFields("Credit Amount");
                    vlem."Credit Amount" := vle."Credit Amount";
                    vle.CalcFields("Debit Amount (LCY)");
                    vlem."Debit Amount (LCY)" := vle."Debit Amount (LCY)";
                    vle.CalcFields("Credit Amount (LCY)");
                    vle."Credit Amount (LCY)" := vle."Credit Amount (LCY)";
                    vlem."Document Date" := vle."Document Date";
                    vlem."External Document No." := vle."External Document No.";
                    vlem."No. Series" := vle."No. Series";
                    vlem."Closed by Currency Amount" := vle."Closed by Currency Amount";
                    vlem."Closed by Currency Code" := vle."Closed by Currency Code";
                    vlem."Adjusted Currency Factor" := vle."Adjusted Currency Factor";
                    vlem."Original Currency Factor" := vle."Original Currency Factor";
                    vle.CalcFields("Original Amount");
                    vlem."Original Amount" := vle."Original Amount";
                    vlem."Date Filter" := vle."Date Filter";
                    vlem."Remaining Pmt. Disc. Possible" := vle."Remaining Pmt. Disc. Possible";
                    vlem."Pmt. Disc. Tolerance Date" := vle."Pmt. Disc. Tolerance Date";
                    vlem."Max. Payment Tolerance" := vle."Max. Payment Tolerance";
                    vlem."Accepted Payment Tolerance" := vle."Accepted Payment Tolerance";
                    vlem."Accepted Pmt. Disc. Tolerance" := vle."Accepted Pmt. Disc. Tolerance";
                    vlem."Pmt. Tolerance (LCY)" := vle."Pmt. Tolerance (LCY)";
                    vlem."Amount to Apply" := vle."Amount to Apply";
                    vlem."IC Partner Code" := vle."IC Partner Code";
                    vlem.Prepayment := vle.Prepayment;
                    vlem."Applies-to Ext. Doc. No." := vle."Applies-to Ext. Doc. No.";
                    vlem."Creditor No." := vle."Creditor No.";
                    vlem."Payment Reference" := vle."Payment Reference";
                    vlem."Payment Method Code" := vle."Payment Method Code";
                    vlem."Recipient Bank Account" := vle."Recipient Bank Account";
                    vlem."Message to Recipient" := vle."Message to Recipient";
                    vlem."Exported to Payment File" := vle."Exported to Payment File";
                    vlem."Dimension Set ID" := vle."Dimension Set ID";
                    vlem.approved := vle.FBM_approved;
                    vle.CalcFields("FBM_Default Bank Account");
                    vlem."Default Bank Account" := vle."FBM_Default Bank Account";
                    vlem."approved date" := vle."FBM_approved date";
                    vlem."approved user" := vle."FBM_approved user";
                    vlem."Approver Comment" := vle."FBM_Approver Comment";
                    vlem.Insert();



                until vle.Next() = 0;
            end;
        until comp.Next() = 0;
        CurrPage.Update();
    end;

    trigger
        OnQueryClosePage(CloseAction: Action): Boolean
    begin
        comp.FindFirst();
        repeat
            vlem.SetRange(Company, comp.Name);
            if vlem.FindFirst() then
                repeat
                    vle.ChangeCompany(vlem.Company);
                    vle.SetRange("Entry No.", vlem."Entry No.");
                    if vle.FindFirst() then begin
                        vle."Entry No." := vlem."Entry No.";
                        vle."Vendor No." := vlem."Vendor No.";
                        vle."Posting Date" := vlem."Posting Date";
                        vle."Document Type" := vlem."Document Type";
                        vle."Document No." := vlem."Document No.";
                        vle.Description := vlem.Description;
                        vle."Vendor Name" := vlem."Vendor Name";
                        vle."Currency Code" := vlem."Currency Code";
                        // vle.Amount := vlem.Amount;
                        // vle."Remaining Amount" := vlem."Remaining Amount";
                        // vle."Original Amt. (LCY)" := vlem."Original Amt. (LCY)";
                        // vle."Remaining Amt. (LCY)" := vlem."Remaining Amt. (LCY)";
                        // vle."Amount (LCY)" := vlem."Amount (LCY)";
                        vle."Purchase (LCY)" := vlem."Purchase (LCY)";
                        vle."Inv. Discount (LCY)" := vlem."Inv. Discount (LCY)";
                        vle."Buy-from Vendor No." := vlem."Buy-from Vendor No.";
                        vle."Vendor Posting Group" := vlem."Vendor Posting Group";
                        vle."Global Dimension 1 Code" := vlem."Global Dimension 1 Code";
                        vle."Global Dimension 2 Code" := vlem."Global Dimension 2 Code";
                        vle."Purchaser Code" := vlem."Purchaser Code";
                        vle."User ID" := vlem."User ID";
                        vle."Source Code" := vlem."Source Code";
                        vle."On Hold" := vlem."On Hold";
                        vle."Applies-to Doc. Type" := vlem."Applies-to Doc. Type";
                        vle."Applies-to Doc. No." := vlem."Applies-to Doc. No.";
                        vle.Open := vlem.Open;
                        vle."Due Date" := vlem."Due Date";
                        vle."Pmt. Discount Date" := vlem."Pmt. Discount Date";
                        vle."Orig. Pmt. Disc. Possible(LCY)" := vlem."Orig. Pmt. Disc. Possible(LCY)";
                        vle."Pmt. Disc. Rcd.(LCY)" := vlem."Pmt. Disc. Rcd.(LCY)";
                        vle."Original Pmt. Disc. Possible" := vlem."Original Pmt. Disc. Possible";
                        vle.Positive := vlem.Positive;
                        vle."Closed by Entry No." := vlem."Closed by Entry No.";
                        vle."Closed at Date" := vlem."Closed at Date";
                        vle."Closed by Amount" := vlem."Closed by Amount";
                        vle."Applies-to ID" := vlem."Applies-to ID";
                        vle."Journal Templ. Name" := vlem."Journal Templ. Name";
                        vle."Journal Batch Name" := vlem."Journal Batch Name";
                        vle."Reason Code" := vlem."Reason Code";
                        vle."Bal. Account Type" := vlem."Bal. Account Type";
                        vle."Bal. Account No." := vlem."Bal. Account No.";
                        VLE."Transaction No." := vlem."Transaction No.";
                        vle."Closed by Amount (LCY)" := vlem."Closed by Amount (LCY)";
                        // vle."Debit Amount" := vlem."Debit Amount";
                        // vle."Credit Amount" := vlem."Credit Amount";
                        // vle."Debit Amount (LCY)" := vlem."Debit Amount (LCY)";
                        // vle."Credit Amount (LCY)" := vlem."Credit Amount (LCY)";
                        vle."Document Date" := vlem."Document Date";
                        vle."External Document No." := vlem."External Document No.";
                        vle."No. Series" := vlem."No. Series";
                        vle."Closed by Currency Amount" := vlem."Closed by Currency Amount";
                        vle."Closed by Currency Code" := vlem."Closed by Currency Code";
                        vle."Adjusted Currency Factor" := vlem."Adjusted Currency Factor";
                        vle."Original Currency Factor" := vlem."Original Currency Factor";
                        // vle."Original Amount" := vlem."Original Amount";
                        vle."Date Filter" := vlem."Date Filter";
                        vle."Remaining Pmt. Disc. Possible" := vlem."Remaining Pmt. Disc. Possible";
                        vle."Pmt. Disc. Tolerance Date" := vlem."Pmt. Disc. Tolerance Date";
                        vle."Max. Payment Tolerance" := vlem."Max. Payment Tolerance";
                        vle."Accepted Payment Tolerance" := vlem."Accepted Payment Tolerance";
                        vle."Accepted Pmt. Disc. Tolerance" := vlem."Accepted Pmt. Disc. Tolerance";
                        vle."Pmt. Tolerance (LCY)" := vlem."Pmt. Tolerance (LCY)";
                        vle."Amount to Apply" := vlem."Amount to Apply";
                        vle."IC Partner Code" := vlem."IC Partner Code";
                        vle.Prepayment := vlem.Prepayment;
                        vle."Applies-to Ext. Doc. No." := vlem."Applies-to Ext. Doc. No.";
                        vle."Creditor No." := vlem."Creditor No.";
                        vle."Payment Reference" := vlem."Payment Reference";
                        vle."Payment Method Code" := vlem."Payment Method Code";
                        vle."Recipient Bank Account" := vlem."Recipient Bank Account";
                        vle."Message to Recipient" := vlem."Message to Recipient";
                        vle."Exported to Payment File" := vlem."Exported to Payment File";
                        vle."Dimension Set ID" := vlem."Dimension Set ID";
                        vle.FBM_approved := vlem.approved;
                        //vle."Default Bank Account" := vlem."Default Bank Account";
                        vle."FBM_approved date" := vlem."approved date";
                        vle."FBM_approved user" := vlem."approved user";
                        vle."FBM_Approver Comment" := vlem."Approver Comment";
                        vle.Modify();
                    end;
                until vlem.next = 0;
        until comp.next = 0;

    end;

    var
        comp: record Company;
        compinfo: record "Company Information";
        VLEM: record FBM_VendorLEM;
        VLE: record "Vendor Ledger Entry";
        PostApprovalEntries: Record "Posted Approval Entry";
        ApproverID: Code[50];
        Status: enum "Approval Status";
        LastDateTimeModified: DateTime;

    local procedure GetOriginalDueDate(VLE: Record FBM_VendorLEM): Date
    var
        PurchInvHeaderRec: Record "Purch. Inv. Header";
    begin
        if VLE."Document Type" = VLE."Document Type"::Invoice then
            if PurchInvHeaderRec.Get(VLE."Document No.") then
                exit(PurchInvHeaderRec."Due Date");
    end;

    local procedure GetVendorNAme(VLE: Record FBM_VendorLEM): Text
    var
        PurchInvHeaderRec: Record "Purch. Inv. Header";
    begin
        if VLE."Document Type" = VLE."Document Type"::Invoice then
            if PurchInvHeaderRec.Get(VLE."Document No.") then
                exit(PurchInvHeaderRec."Buy-from Vendor Name");
    end;

    trigger OnAfterGetRecord()
    begin
        ApproverID := '';
        Status := enum::"Approval Status"::" ";
        LastDateTimeModified := 0DT;
        PostApprovalEntries.SetRange("Document No.", Rec."Document No.");
        if PostApprovalEntries.FindLast() then begin
            ApproverID := PostApprovalEntries."Approver ID";
            Status := PostApprovalEntries.Status;
            LastDateTimeModified := PostApprovalEntries."Last Date-Time Modified";
        end;
    end;
}
