page 60105 "FBM_ApprRequest Entries New_CO"
{

    ApplicationArea = Suite;
    Caption = 'Approval Request Entries New';
    Editable = false;
    PageType = List;
    SourceTable = "Approval Entry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Overdue; Overdue)
                {
                    ApplicationArea = Suite;
                    Caption = 'Overdue';
                    Editable = false;
                    ToolTip = 'Specifies that the approval is overdue.';
                }
                field("Table ID"; rec."Table ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the table where the record that is subject to approval is stored.';
                    Visible = false;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the type of document that an approval entry has been created for. Approval entries can be created for six different types of sales or purchase documents:';
                    Visible = false;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the document number copied from the relevant sales or purchase document, such as a purchase order or a sales quote.';
                    Visible = false;
                }
                field(RecordIDText; RecordIDText)
                {
                    ApplicationArea = Suite;
                    Caption = 'To Approve';
                    ToolTip = 'Specifies the record that you are requested to approve.';
                }
                field("Sequence No."; rec."Sequence No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the order of approvers when an approval workflow involves more than one approver.';
                }
                field("Sender ID"; rec."Sender ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who sent the approval request for the document to be approved.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(rec."Sender ID");
                    end;
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the salesperson or purchaser that was in the document to be approved. It is not a mandatory field, but is useful if a salesperson or a purchaser responsible for the customer/vendor needs to approve the document before it is processed.';
                }
                field("Approver ID"; rec."Approver ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who must approve the document.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(rec."Approver ID");
                    end;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the approval status for the entry:';
                }
                field(Details; RecordDetails2)
                {
                    ApplicationArea = Suite;
                    Caption = 'Details';
                    ToolTip = 'Specifies the record that the approval is related to.';
                }
                field("Date-Time Sent for Approval"; rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date and the time that the document was sent for approval.';
                }
                field("Last Date-Time Modified"; rec."Last Date-Time Modified")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date when the approval entry was last modified. If, for example, the document approval is canceled, this field will be updated accordingly.';
                }
                field("Last Modified By User ID"; rec."Last Modified By User ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who last modified the approval entry. If, for example, the document approval is canceled, this field will be updated accordingly.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(rec."Last Modified By User ID");
                    end;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies whether there are comments relating to the approval of the record. If you want to read the comments, choose the field to open the Approval Comment Sheet window.';
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies when the record must be approved, by one or more approvers.';
                }
                field("Available Credit Limit (LCY)"; rec."Available Credit Limit (LCY)")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the remaining credit (in LCY) that exists for the customer.';
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the total amount (excl. VAT) on the document awaiting approval.';
                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the total amount in LCY (excl. VAT) on the document awaiting approval.';
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code of the currency of the amounts on the sales or purchase lines.';
                }

                field(PostingDescription; PostingDescription)
                {
                    Caption = 'Posting Description';
                }
                field(BudgetAccount; BudgetAccount)
                {
                    Caption = 'Budget Account';
                }
                field(BudgetProject; BudgetProject)
                {
                    Caption = 'BudgetProject';
                }
                field(BudgetGroupDimensions; BudgetGroupDimensions)
                {
                    Caption = 'Budget Group Dimensions';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                Image = View;
                action("Record")
                {
                    ApplicationArea = Suite;
                    Caption = 'Record';
                    Enabled = ShowRecCommentsEnabled;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Open the document, journal line, or card that the approval request is for.';

                    trigger OnAction()
                    begin
                        rec.ShowRecord;
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Enabled = ShowRecCommentsEnabled;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                    begin
                        RecRef.Get(rec."Record ID to Approve");
                        Clear(ApprovalsMgmt);
                        ApprovalsMgmt.GetApprovalCommentForWorkflowStepInstanceID(RecRef, rec."Workflow Step Instance ID");
                    end;
                }
                action("O&verdue Entries")
                {
                    ApplicationArea = Suite;
                    Caption = 'O&verdue Entries';
                    Image = OverdueEntries;
                    ToolTip = 'View approval requests that are overdue.';

                    trigger OnAction()
                    begin
                        rec.SetFilter(Status, '%1|%2', rec.Status::Created, rec.Status::Open);
                        rec.SetFilter("Due Date", '<%1', Today);
                    end;
                }
                action("All Entries")
                {
                    ApplicationArea = Suite;
                    Caption = 'All Entries';
                    Image = Entries;
                    ToolTip = 'View all approval entries.';

                    trigger OnAction()
                    begin
                        rec.SetRange(Status);
                        rec.SetRange("Due Date");
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Delegate")
            {
                ApplicationArea = Suite;
                Caption = '&Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Delegate the approval request to another approver that has been set up as your substitute approver.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    CurrPage.SetSelectionFilter(ApprovalEntry);
                    ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry)
                end;
            }

            action("Approval Request Entries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Request Entries';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create a sales order for the customer.';
                RunObject = Page "Sales Order";
                RunPageLink = "No." = field("Document No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        RecRef: RecordRef;
    begin
        ShowRecCommentsEnabled := RecRef.Get(rec."Record ID to Approve");
    end;

    trigger OnAfterGetRecord()

    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;

        RecordIDText := Format(rec."Record ID to Approve", 0, 1);

        PurchHeader.SetRange("No.", Rec."Document No.");
        PurchHeader.setfilter("Document Type", '%1|%2', PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice);
        if PurchHeader.FindFirst() then begin
            PostingDescription := PurchHeader."Posting Description";
            PurchLine.SetRange("Document No.", Rec."Document No.");
            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
            if PurchLine.FindFirst() then begin
                BudgetAccount := PurchLine."Shortcut Dimension 1 Code";
                BudgetProject := PurchLine."Shortcut Dimension 2 Code";
                getshortdimensions.GetShortcutDimensions(PurchLine."Dimension Set ID", ShortcutDimCodeList);
                BudgetGroupDimensions := ShortcutDimCodeList[7];
            end;
        end;
    end;

    // trigger OnOpenPage()
    // begin
    //     if Usersetup.Get(UserId) then
    //         if not Usersetup."Approval Administrator" then begin
    //             FilterGroup(2);
    //             SetCurrentKey("Sender ID");
    //             SetFilter("Sender ID", '=%1', Usersetup."User ID");
    //             FilterGroup(0);
    //         end;

    //     SetRange(Status);
    //     SetRange("Due Date");
    // end;

    var
        Usersetup: Record "User Setup";
        Overdue: Option Yes," ";
        RecordIDText: Text;
        ShowRecCommentsEnabled: Boolean;

        PostingDescription: Text[100];
        BudgetAccount: Code[20];
        BudgetProject: Code[20];
        BudgetGroupDimensions: Code[20];
        getshortdimensions: Codeunit "Get Shortcut Dimension Values";
        ShortcutDimCodeList: array[8] of Code[20];


    local procedure FormatField(Rec: Record "Approval Entry"): Boolean
    begin
        if rec.Status in [rec.Status::Created, rec.Status::Open] then begin
            if Rec."Due Date" < Today then
                exit(true);

            exit(false);
        end;
    end;

    procedure RecordDetails2() Details: Text
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
        RecRef: RecordRef;
        ChangeRecordDetails: Text;
        IsHandled: Boolean;
        RecNotExistTxt: Label 'The record does not exist.';
    begin
        IsHandled := false;

        if IsHandled then
            exit(Details);

        if not GetRecordToApprove(RecRef) then
            exit(RecNotExistTxt);

        ChangeRecordDetails := rec.GetChangeRecordDetails;

        case RecRef.Number of
            DATABASE::"Sales Header":
                begin
                    RecRef.SetTable(SalesHeader);
                    SalesHeader.CalcFields(Amount);
                    Details :=
                      StrSubstNo(
                        '%1 ; %2: %3', SalesHeader."Sell-to Customer Name", SalesHeader.FieldCaption(Amount), SalesHeader.Amount);
                end;
            DATABASE::"Purchase Header":
                begin
                    RecRef.SetTable(PurchHeader);
                    PurchHeader.CalcFields(Amount);
                    Details :=
                      StrSubstNo(
                        '%1 ; %2: %3', PurchHeader."Buy-from Vendor Name", PurchHeader.FieldCaption(Amount), PurchHeader.Amount);
                end;
            else
                Details := Format(rec."Record ID to Approve", 0, 1) + ChangeRecordDetails;
        end;


    end;

    local procedure GetRecordToApprove(var RecRef: RecordRef) Result: Boolean
    begin
        Result := RecRef.Get(rec."Record ID to Approve");

    end;



}