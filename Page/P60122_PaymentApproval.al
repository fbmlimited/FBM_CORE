page 60122 "FBM_Payment Approval_CO"
{
    ApplicationArea = All;
    Caption = 'Payment Approval New';
    PageType = List;
    SourceTable = "Vendor Ledger Entry";
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
                field("FBM_Default Bank Account"; Rec."FBM_Default Bank Account_FF")
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
                    begin

                        if usersetup.get(UserId) then begin
                            if usersetup."FBM_Approve AP" = false then
                                Error('Your user is not setup for AP approval. Please contact the system administrator.');
                            if rec.FBM_approved1 then begin
                                rec."FBM_approved user1" := UserId;
                                rec."FBM_approved date1" := CurrentDateTime;
                                Status1 := status::Approved;
                            end
                            else begin
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



                        end;

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
            part("Banks"; "FBM_PaymJnl Bank List Part2_CO")
            {
                ApplicationArea = Basic, Suite;
                UpdatePropagation = Both;


            }
        }
    }


    var
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

    // Pass multiple lookup field schemanames with comma separated.

    local procedure GetOriginalDueDate(VLE: Record "Vendor Ledger Entry"): Date
    var
        PurchInvHeaderRec: Record "Purch. Inv. Header";
    begin
        if VLE."Document Type" = VLE."Document Type"::Invoice then
            if PurchInvHeaderRec.Get(VLE."Document No.") then
                exit(PurchInvHeaderRec."Due Date");
    end;

    local procedure GetVendorNAme(VLE: Record "Vendor Ledger Entry"): Text
    var
        PurchInvHeaderRec: Record "Purch. Inv. Header";
    begin
        if VLE."Document Type" = VLE."Document Type"::Invoice then
            if PurchInvHeaderRec.Get(VLE."Document No.") then
                exit(PurchInvHeaderRec."Buy-from Vendor Name");
    end;

    trigger OnAfterGetRecord()
    var
        purchinv: record "Purch. Inv. Header";
    begin
        rec.CalcFields(Amount, "Remaining Amount");
        rec.FBM_Amount := rec.Amount;
        rec.FBM_RemAmount := rec."Remaining Amount";
        // ApproverID1 := '';
        // Status := enum::"Approval Status"::" ";
        // LastDateTimeModified := 0DT;
        // PostApprovalEntries.SetRange("Document No.", Rec."Document No.");
        // PostApprovalEntries.SetRange("Sequence No.", 1);
        // if PostApprovalEntries.FindLast() then begin
        //     rec."FBM_approved user1" := PostApprovalEntries."Approver ID";
        //     Status1 := PostApprovalEntries.Status;
        //     LastDateTimeModified := PostApprovalEntries."Last Date-Time Modified";
        // end;
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


        LastDateTimeModified := 0DT;
        PostApprovalEntries.Reset();
        if ponum = '' then
            PostApprovalEntries.SetRange("Document No.", Rec."Document No.")
        else
            PostApprovalEntries.SetRange("Document No.", ponum);

        if PostApprovalEntries.FindLast() then begin
            rec.FBM_approved2 := true;
            rec."FBM_approved user2" := PostApprovalEntries."Approver ID";
            Status2 := PostApprovalEntries.Status;
            rec."FBM_approved date2" := PostApprovalEntries."Last Date-Time Modified";
        end
        else begin
            rec."FBM_approved user2" := '';

            rec."FBM_approved date2" := 0DT;
        end;
        rec.Modify();
    end;
}
