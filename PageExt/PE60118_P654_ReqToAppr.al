pageextension 60118 RequestToApproveExt extends "Requests to approve"
{
    layout
    {
        modify("Sender ID")
        {
            Visible = false;
        }
        addafter(Comment)
        {
            field("Sender ID31524"; Rec."Sender ID")
            {
                ApplicationArea = All;
            }
            field("Salespers./Purch. Code88712"; Rec."Salespers./Purch. Code")
            {
                ApplicationArea = All;
            }
            field("Approver ID92297"; Rec."Approver ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Currency Code")
        {
            field(PostingDescription; PostingDescription)
            {
                Caption = 'Posting Description';
                ApplicationArea = all;
            }
            field(BudgetAccount; BudgetAccount)
            {
                Caption = 'Budget Account';
                ApplicationArea = all;
            }
            field(BudgetProject; BudgetProject)
            {
                Caption = 'BudgetProject';
                ApplicationArea = all;
            }
            field(BudgetGroupDimensions; BudgetGroupDimensions)
            {
                Caption = 'Budget Group Dimensions';
                ApplicationArea = all;
            }
        }
    }
    var
        PostingDescription: Text[100];
        BudgetAccount: Code[20];
        BudgetProject: Code[20];
        BudgetGroupDimensions: Code[20];
        getshortdimensions: Codeunit "Get Shortcut Dimension Values";
        ShortcutDimCodeList: array[8] of Code[20];



    trigger OnAfterGetRecord()
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
    begin
        PurchHeader.SetRange("No.", Rec."Document No.");
        PurchHeader.Setfilter("Document Type", '%1|%2', PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice);
        if PurchHeader.FindFirst() then begin
            PostingDescription := PurchHeader."Posting Description";
            PurchLine.SetRange("Document No.", Rec."Document No.");
            PurchLine.Setfilter("Document Type", '%1|%2', PurchLine."Document Type"::Order, PurchLine."Document Type"::Invoice);
            if PurchLine.FindFirst() then begin
                BudgetAccount := PurchLine."Shortcut Dimension 1 Code";
                BudgetProject := PurchLine."Shortcut Dimension 2 Code";
                getshortdimensions.GetShortcutDimensions(PurchLine."Dimension Set ID", ShortcutDimCodeList);
                BudgetGroupDimensions := ShortcutDimCodeList[7];
            end;
        end;
    end;
}