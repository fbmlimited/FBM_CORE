page 60117 FBM_PaymentApprovalM_CO
{
    ApplicationArea = All;
    Caption = 'Payment Approval Multicompany';
    PageType = List;
    SourceTable = FBM_VendorLEM;
    SourceTableView = where("Document Type" = filter(Invoice), Open = filter(true));
    UsageCategory = Lists;
    SourceTableTemporary = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;

                    Editable = false;
                }
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
                    trigger
                    OnValidate()
                    begin
                        if usersetup.get(UserId) then begin
                            if (usersetup."FBM_Approve AP" = false) and (usersetup."FBM_Approve Finance" = false) then
                                Error('Your user is not setup for  approval. Please contact the system administrator.');
                        end;
                    end;
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
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("FBM_Default Bank Account"; Rec."FBM_Default Bank Account")
                {
                    ApplicationArea = All;

                }
                field(FBM_Paid; Rec.FBM_Paid)
                {
                    ApplicationArea = All;
                    ToolTip = 'Paid';
                    Editable = true;
                    trigger
                    OnValidate()
                    begin
                        if usersetup.get(UserId) then begin
                            if (usersetup.FBM_Paid_Enabled = false) then
                                Error('Your user is not setup for  setting paid. Please contact the system administrator.');
                        end;
                    end;
                }


                field(Amount; Rec.FBM_Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the amount field.';
                    Editable = false;
                    Lookup = false;
                }
                field("Remaining Amount"; Rec.FBM_RemAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                    Editable = false;
                }
                field(approved2; Rec.FBM_approved2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the approved Inv. field.';
                    Editable = false;




                }
                field("approved user2"; Rec."FBM_approved user2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the approved user Inv field.';
                    Editable = false;
                }



                field(Status2; Status2)
                {
                    ApplicationArea = All;
                    Caption = 'Status Inv.';
                    Editable = false;
                }
                field("FBM_approved date2"; Rec."FBM_approved date2")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Approved Date Inv.';
                }
                field(approved1; Rec.FBM_approved1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the approved AP field.';
                    Editable = true;
                    trigger OnValidate()
                    var
                        usersetup: Record "User Setup";
                        vendle: record "Vendor Ledger Entry";
                        bam: record FBM_BankAccountTMP;
                    begin

                        bam.SetRange(FBM_Company, rec.Company);
                        bam.SetRange("no.", rec."FBM_Default Bank Account");
                        if usersetup.get(UserId) then begin
                            if usersetup."FBM_Approve AP" = false then
                                Error('Your user is not setup for AP approval. Please contact the system administrator.');
                            if rec.FBM_approved1 then begin
                                if bam.FindFirst() then begin
                                    bam."FBM_Approval Batch Amount2" += rec.FBM_RemAmount;
                                    bam.Modify();
                                end;
                                rec."FBM_approved user1" := UserId;
                                rec."FBM_approved date1" := CurrentDateTime;
                                Status1 := status::Approved;
                            end
                            else begin
                                if bam.FindFirst() then begin
                                    bam."FBM_Approval Batch Amount2" -= rec.FBM_RemAmount;
                                    bam.Modify();
                                end;
                                status1 := status1::Rejected;
                                rec."FBM_approved user1" := '';
                                rec."FBM_approved date1" := 0DT;
                                rec.FBM_approved := false;
                                rec."FBM_approved user" := '';
                                rec."FBM_approved date" := 0DT;
                                rec."FBM_Approver Comment" := '';
                                Status := status::" ";
                            end;
                            CurrPage.SaveRecord();
                            CurrPage.Banks.Page.Upd();




                        end
                        else
                            Error('Your user is not listed in user setup for AP approval. Please contact the system administrator.');

                    end;



                }
                field("approved user1"; Rec."FBM_approved user1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the approved user AP field.';
                    Editable = false;
                }
                field("FBM_Approver Comment1"; Rec."FBM_Approver Comment1")
                {
                    ApplicationArea = All;
                    trigger
                    OnValidate()
                    begin
                        if usersetup.get(UserId) then begin
                            if usersetup."FBM_Approve AP" = false then
                                Error('Your user is not setup for AP approval. Please contact the system administrator.');
                        end;
                    end;
                }
                field(Status1; Status1)
                {
                    ApplicationArea = All;
                    Caption = 'Status AP';
                    Editable = false;
                }
                field("FBM_approved date1"; Rec."FBM_approved date1")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Date AP';
                    Editable = false;
                }
                field(approved; Rec.FBM_approved)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the approved Fin field.';
                    Editable = true;
                    trigger OnValidate()

                    begin
                        if usersetup.get(UserId) then begin
                            if usersetup."FBM_Approve Finance" = false then
                                Error('Your user is not setup for finance approval. Please contact the system administrator.');
                            if rec.FBM_approved then begin
                                rec."FBM_approved user" := UserId;
                                rec."FBM_approved date" := CurrentDateTime;

                                Status := status::Approved;
                            end
                            else begin
                                status := status::Rejected;
                                rec."FBM_approved user" := '';
                                rec."FBM_approved date" := 0DT;

                            end;

                        end;

                    end;



                }
                field("approved user"; Rec."FBM_approved user")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the approved user Fin field.';
                    Editable = false;
                }
                field("FBM_Approver Comment"; Rec."FBM_Approver Comment")
                {
                    ApplicationArea = All;
                    trigger
                    OnValidate()
                    begin
                        if usersetup.get(UserId) then begin
                            if usersetup."FBM_Approve Finance" = false then
                                Error('Your user is not setup for finance approval. Please contact the system administrator.');
                        end;
                    end;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status Fin';
                    Editable = false;
                }
                field("FBM_approved date"; Rec."FBM_approved date")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Date Fin';
                    Editable = false;
                }
            }


        }

        area(factboxes)
        {
            part("Banks"; "FBM_PaymJnlBankListPart2M_CO")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = FBM_Company = field(Company);

            }
        }
    }



    trigger OnOpenPage()


    begin
        bankaccM.DeleteAll();
        rec.DeleteAll();
        comp.FindFirst();
        repeat
            compinfo.ChangeCompany(comp.name);
            compinfo.get;
            if compinfo.FBM_EnAppr then begin
                VLE.ChangeCompany(comp.Name);
                bankacc.ChangeCompany(comp.Name);
                bankacc.FindFirst();

                repeat
                    bankaccM.Init();
                    bankaccM."No." := bankacc."No.";
                    bankaccM.Name := bankacc.Name;
                    bankaccM."Name 2" := bankacc."Name 2";
                    bankaccM.FBM_Company := comp.Name;
                    bankaccM.Amount := bankacc.Amount;
                    bankacc.CalcFields(Balance, "Balance (LCY)", "Balance at Date", "Balance at Date (LCY)", "FBM_Approval Batch Amount_FF", "FBM_Approval Batch Amount2_FF", "Net Change", "Net Change (LCY)", "Debit Amount", "Debit Amount (LCY)", "Credit Amount", "Credit Amount (LCY)");
                    bankaccM.Balance := bankacc.Balance;
                    bankaccM."Balance (LCY)" := bankacc."Balance (LCY)";
                    bankaccM."Balance at Date" := bankacc."Balance at Date";
                    bankaccM."Balance at Date (LCY)" := bankacc."Balance at Date (LCY)";
                    bankaccM."FBM_Approval Batch Amount" := bankacc."FBM_Approval Batch Amount_FF";
                    bankaccM."FBM_Approval Batch Amount2" := bankacc."FBM_Approval Batch Amount2_FF";
                    bankaccM."Net Change" := bankacc."Net Change";
                    bankaccM."Net Change (LCY)" := bankacc."Net Change (LCY)";
                    bankaccM."Debit Amount" := bankacc."Debit Amount";
                    bankaccM."Debit Amount (LCY)" := bankacc."Debit Amount (LCY)";
                    bankaccM."Credit Amount" := bankacc."Credit Amount";
                    bankaccM."Credit Amount (LCY)" := bankacc."Credit Amount (LCY)";
                    bankaccM."Currency Code" := bankacc."Currency Code";
                    bankaccM.IBAN := bankacc.IBAN;
                    bankaccM."Name 2" := bankacc."Name 2";
                    bankaccM."Search Name" := bankacc."Search Name";
                    bankaccM."SWIFT Code" := bankacc."SWIFT Code";


                    bankaccM.Insert();
                until bankacc.Next() = 0;
                vle.SetRange(Open, true);
                vle.setrange("Document Type", vle."Document Type"::Invoice);
                if vle.FindFirst() then
                    repeat
                        vle.CalcFields(Amount, "Remaining Amount");
                        vle.FBM_Amount := rec.Amount;
                        vle.FBM_RemAmount := vle."Remaining Amount";
                        vle.Modify();

                        rec.Init();
                        rec.Company := comp.Name;
                        rec."Entry No." := vle."Entry No.";
                        rec."Vendor No." := vle."Vendor No.";
                        rec."Posting Date" := vle."Posting Date";
                        rec."Document Type" := vle."Document Type";
                        rec."Document No." := vle."Document No.";
                        rec.Description := vle.Description;
                        rec."Vendor Name" := vle."Vendor Name";
                        rec."Currency Code" := vle."Currency Code";
                        vle.CalcFields(Amount);
                        rec.Amount := vle.Amount;
                        vle.CalcFields("Remaining Amount");
                        rec."Remaining Amount" := vle."Remaining Amount";
                        vle.CalcFields("Original Amt. (LCY)");
                        rec."Original Amt. (LCY)" := vle."Original Amt. (LCY)";
                        vle.CalcFields("Remaining Amt. (LCY)");
                        rec."Remaining Amt. (LCY)" := vle."Remaining Amt. (LCY)";
                        vle.CalcFields("Amount (LCY)");
                        rec."Amount (LCY)" := vle."Amount (LCY)";
                        rec."Purchase (LCY)" := vle."Purchase (LCY)";
                        rec."Inv. Discount (LCY)" := vle."Inv. Discount (LCY)";
                        rec."Buy-from Vendor No." := vle."Buy-from Vendor No.";
                        rec."Vendor Posting Group" := vle."Vendor Posting Group";
                        rec."Global Dimension 1 Code" := vle."Global Dimension 1 Code";
                        rec."Global Dimension 2 Code" := vle."Global Dimension 2 Code";
                        rec."Purchaser Code" := vle."Purchaser Code";
                        rec."User ID" := vle."User ID";
                        rec."Source Code" := vle."Source Code";
                        rec."On Hold" := vle."On Hold";
                        rec."Applies-to Doc. Type" := vle."Applies-to Doc. Type";
                        rec."Applies-to Doc. No." := vle."Applies-to Doc. No.";
                        rec.Open := vle.Open;
                        rec."Due Date" := vle."Due Date";
                        rec."Pmt. Discount Date" := vle."Pmt. Discount Date";
                        rec."Orig. Pmt. Disc. Possible(LCY)" := vle."Orig. Pmt. Disc. Possible(LCY)";
                        rec."Pmt. Disc. Rcd.(LCY)" := vle."Pmt. Disc. Rcd.(LCY)";
                        rec."Original Pmt. Disc. Possible" := vle."Original Pmt. Disc. Possible";
                        rec.Positive := vle.Positive;
                        rec."Closed by Entry No." := vle."Closed by Entry No.";
                        rec."Closed at Date" := vle."Closed at Date";
                        rec."Closed by Amount" := vle."Closed by Amount";
                        rec."Applies-to ID" := vle."Applies-to ID";
                        rec."Journal Templ. Name" := vle."Journal Templ. Name";
                        rec."Journal Batch Name" := vle."Journal Batch Name";
                        rec."Reason Code" := vle."Reason Code";
                        rec."Bal. Account Type" := vle."Bal. Account Type";
                        rec."Bal. Account No." := vle."Bal. Account No.";
                        rec."Transaction No." := vle."Transaction No.";
                        rec."Closed by Amount (LCY)" := vle."Closed by Amount (LCY)";
                        vle.CalcFields("Debit Amount");
                        rec."Debit Amount" := vle."Debit Amount";
                        vle.CalcFields("Credit Amount");
                        rec."Credit Amount" := vle."Credit Amount";
                        vle.CalcFields("Debit Amount (LCY)");
                        rec."Debit Amount (LCY)" := vle."Debit Amount (LCY)";
                        vle.CalcFields("Credit Amount (LCY)");
                        vle."Credit Amount (LCY)" := vle."Credit Amount (LCY)";
                        rec."Document Date" := vle."Document Date";
                        rec."External Document No." := vle."External Document No.";
                        rec."No. Series" := vle."No. Series";
                        rec."Closed by Currency Amount" := vle."Closed by Currency Amount";
                        rec."Closed by Currency Code" := vle."Closed by Currency Code";
                        rec."Adjusted Currency Factor" := vle."Adjusted Currency Factor";
                        rec."Original Currency Factor" := vle."Original Currency Factor";
                        vle.CalcFields("Original Amount");
                        rec."Original Amount" := vle."Original Amount";
                        rec."Date Filter" := vle."Date Filter";
                        rec."Remaining Pmt. Disc. Possible" := vle."Remaining Pmt. Disc. Possible";
                        rec."Pmt. Disc. Tolerance Date" := vle."Pmt. Disc. Tolerance Date";
                        rec."Max. Payment Tolerance" := vle."Max. Payment Tolerance";
                        rec."Accepted Payment Tolerance" := vle."Accepted Payment Tolerance";
                        rec."Accepted Pmt. Disc. Tolerance" := vle."Accepted Pmt. Disc. Tolerance";
                        rec."Pmt. Tolerance (LCY)" := vle."Pmt. Tolerance (LCY)";
                        rec."Amount to Apply" := vle."Amount to Apply";
                        rec."IC Partner Code" := vle."IC Partner Code";
                        rec.Prepayment := vle.Prepayment;
                        rec."Applies-to Ext. Doc. No." := vle."Applies-to Ext. Doc. No.";
                        rec."Creditor No." := vle."Creditor No.";
                        rec."Payment Reference" := vle."Payment Reference";
                        rec."Payment Method Code" := vle."Payment Method Code";
                        rec."Recipient Bank Account" := vle."Recipient Bank Account";
                        rec."Message to Recipient" := vle."Message to Recipient";
                        rec."Exported to Payment File" := vle."Exported to Payment File";
                        rec."Dimension Set ID" := vle."Dimension Set ID";
                        rec.FBM_approved := vle.FBM_approved;
                        vendor.ChangeCompany(comp.Name);
                        if vendor.get(vle."Vendor No.") then
                            rec."FBM_Default Bank Account" := vendor."FBM_Default Bank Account";

                        rec."FBM_approved date" := vle."FBM_approved date";
                        rec."FBM_approved user" := vle."FBM_approved user";
                        rec."FBM_Approver Comment" := vle."FBM_Approver Comment";
                        vle.CalcFields(Amount, "Remaining Amount");
                        rec.FBM_Amount := vle.Amount;
                        rec.FBM_Paid := vle.FBM_Paid;
                        rec.FBM_RemAmount := vle."Remaining Amount";
                        rec."Remaining Amount" := vle."Remaining Amount";
                        rec.Amount := vle.Amount;
                        rec.FBM_approved1 := vle.FBM_approved1;
                        rec."FBM_approved date1" := vle."FBM_approved date1";
                        rec."FBM_approved user1" := vle."FBM_approved user1";
                        rec."FBM_Approver Comment1" := vle."FBM_Approver Comment1";
                        rec.FBM_approved2 := vle.FBM_approved2;
                        rec."FBM_approved date2" := vle."FBM_approved date2";
                        rec."FBM_approved user2" := vle."FBM_approved user2";
                        rec."FBM_Approver Comment2" := vle."FBM_Approver Comment2";
                        rec.Insert();



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
            rec.SetRange(Company, comp.Name);
            if rec.FindFirst() then
                repeat
                    vle.ChangeCompany(rec.Company);
                    vle.SetRange("Entry No.", rec."Entry No.");
                    if vle.FindFirst() then begin
                        vle."Entry No." := rec."Entry No.";
                        vle."Vendor No." := rec."Vendor No.";
                        vle."Posting Date" := rec."Posting Date";
                        vle."Document Type" := rec."Document Type";
                        vle."Document No." := rec."Document No.";
                        vle.Description := rec.Description;
                        vle."Vendor Name" := rec."Vendor Name";
                        vle."Currency Code" := rec."Currency Code";

                        vle."Purchase (LCY)" := rec."Purchase (LCY)";
                        vle."Inv. Discount (LCY)" := rec."Inv. Discount (LCY)";
                        vle."Buy-from Vendor No." := rec."Buy-from Vendor No.";
                        vle."Vendor Posting Group" := rec."Vendor Posting Group";
                        vle."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
                        vle."Global Dimension 2 Code" := rec."Global Dimension 2 Code";
                        vle."Purchaser Code" := rec."Purchaser Code";
                        vle."User ID" := rec."User ID";
                        vle."Source Code" := rec."Source Code";
                        vle."On Hold" := rec."On Hold";
                        vle."Applies-to Doc. Type" := rec."Applies-to Doc. Type";
                        vle."Applies-to Doc. No." := rec."Applies-to Doc. No.";
                        vle.Open := rec.Open;
                        vle."Due Date" := rec."Due Date";
                        vle."Pmt. Discount Date" := rec."Pmt. Discount Date";
                        vle."Orig. Pmt. Disc. Possible(LCY)" := rec."Orig. Pmt. Disc. Possible(LCY)";
                        vle."Pmt. Disc. Rcd.(LCY)" := rec."Pmt. Disc. Rcd.(LCY)";
                        vle."Original Pmt. Disc. Possible" := rec."Original Pmt. Disc. Possible";
                        vle.Positive := rec.Positive;
                        vle."Closed by Entry No." := rec."Closed by Entry No.";
                        vle."Closed at Date" := rec."Closed at Date";
                        vle."Closed by Amount" := rec."Closed by Amount";
                        vle."Applies-to ID" := rec."Applies-to ID";
                        vle."Journal Templ. Name" := rec."Journal Templ. Name";
                        vle."Journal Batch Name" := rec."Journal Batch Name";
                        vle."Reason Code" := rec."Reason Code";
                        vle."Bal. Account Type" := rec."Bal. Account Type";
                        vle."Bal. Account No." := rec."Bal. Account No.";
                        VLE."Transaction No." := rec."Transaction No.";
                        vle."Closed by Amount (LCY)" := rec."Closed by Amount (LCY)";

                        vle."Document Date" := rec."Document Date";
                        vle."External Document No." := rec."External Document No.";
                        vle."No. Series" := rec."No. Series";
                        vle."Closed by Currency Amount" := rec."Closed by Currency Amount";
                        vle."Closed by Currency Code" := rec."Closed by Currency Code";
                        vle."Adjusted Currency Factor" := rec."Adjusted Currency Factor";
                        vle."Original Currency Factor" := rec."Original Currency Factor";

                        vle."Date Filter" := rec."Date Filter";
                        vle."Remaining Pmt. Disc. Possible" := rec."Remaining Pmt. Disc. Possible";
                        vle."Pmt. Disc. Tolerance Date" := rec."Pmt. Disc. Tolerance Date";
                        vle."Max. Payment Tolerance" := rec."Max. Payment Tolerance";
                        vle."Accepted Payment Tolerance" := rec."Accepted Payment Tolerance";
                        vle."Accepted Pmt. Disc. Tolerance" := rec."Accepted Pmt. Disc. Tolerance";
                        vle."Pmt. Tolerance (LCY)" := rec."Pmt. Tolerance (LCY)";
                        vle."Amount to Apply" := rec."Amount to Apply";
                        vle."IC Partner Code" := rec."IC Partner Code";
                        vle.Prepayment := rec.Prepayment;
                        vle."Applies-to Ext. Doc. No." := rec."Applies-to Ext. Doc. No.";
                        vle."Creditor No." := rec."Creditor No.";
                        vle."Payment Reference" := rec."Payment Reference";
                        vle."Payment Method Code" := rec."Payment Method Code";
                        vle."Recipient Bank Account" := rec."Recipient Bank Account";
                        vle."Message to Recipient" := rec."Message to Recipient";
                        vle."Exported to Payment File" := rec."Exported to Payment File";
                        vle."Dimension Set ID" := rec."Dimension Set ID";
                        vle.FBM_approved := rec.FBM_approved;
                        vle."FBM_approved date" := rec."FBM_approved date";
                        vle."FBM_approved user" := rec."FBM_approved user";
                        vle."FBM_Approver Comment" := rec."FBM_Approver Comment";
                        vle.FBM_approved1 := rec.FBM_approved1;
                        vle."FBM_approved date1" := rec."FBM_approved date1";
                        vle."FBM_approved user1" := rec."FBM_approved user1";
                        vle."FBM_Approver Comment1" := rec."FBM_Approver Comment1";
                        vle.FBM_approved2 := rec.FBM_approved2;
                        vle."FBM_approved date2" := rec."FBM_approved date2";
                        vle."FBM_approved user2" := rec."FBM_approved user2";
                        vle."FBM_Approver Comment2" := rec."FBM_Approver Comment2";
                        vle.Modify();
                    end;
                until rec.next = 0;
        until comp.next = 0;

    end;


    var
        comp: record Company;
        compinfo: record "Company Information";

        VLE: record "Vendor Ledger Entry";
        PostApprovalEntries: Record "Posted Approval Entry";
        ApproverID: Code[50];



        ApproverID1: Code[50];
        ApproverID2: Code[50];
        Status: enum "Approval Status";
        Status1: enum "Approval Status";
        Status2: enum "Approval Status";
        LastDateTimeModified: DateTime;
        usersetup: Record "User Setup";
        ponum: code[20];
        vendor: record Vendor;
        purchinv: record "Purch. Inv. Header";
        bankacc: record "Bank Account";
        bankaccM: record FBM_BankAccountTMP;


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
        rec.FBM_Amount := rec.Amount;
        rec.FBM_RemAmount := rec."Remaining Amount";
        purchinv.ChangeCompany(rec.Company);
        if purchinv.get(rec."Document No.") then
            ponum := purchinv."Order No.";
        if not rec.FBM_approved then begin
            status := status::" ";
            rec."FBM_approved date" := 0DT;
            rec."FBM_approved user" := '';
        end
        else
            Status := Status::Approved;
        if not rec.FBM_approved1 then begin
            status1 := status::" ";
            rec."FBM_approved date1" := 0DT;
            rec."FBM_approved user1" := '';
        end
        else
            Status1 := Status1::Approved;
        ApproverID2 := '';
        Status2 := enum::"Approval Status"::" ";
        LastDateTimeModified := 0DT;
        PostApprovalEntries.ChangeCompany(rec.Company);
        if ponum = '' then
            PostApprovalEntries.SetRange("Document No.", Rec."Document No.")
        else
            PostApprovalEntries.SetRange("Document No.", ponum);

        if PostApprovalEntries.FindLast() then begin
            rec."FBM_approved user2" := PostApprovalEntries."Approver ID";
            Status2 := PostApprovalEntries.Status;
            rec."FBM_approved date2" := PostApprovalEntries."Last Date-Time Modified";
        end
        else begin
            rec."FBM_approved user2" := '';

            rec."FBM_approved date2" := 0DT;
        end;
    end;
}

