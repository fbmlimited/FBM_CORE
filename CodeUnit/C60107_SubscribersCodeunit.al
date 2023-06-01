codeunit 60107 FBM_MySubscribers_CO
{
    //Set the event subscribers to bind automatically to the event
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, 60106, 'OnReasonCodeChanged', '', true, true)]
    procedure RefreshBanksList(currpage: Page "FBM_PayJnl Bank List Part_CO");
    begin
        currpage.Update(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 231, 'OnBeforeCode', '', true, true)]
    procedure OnBeforeCode(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean);
    begin
        if GenJournalLine.FindSet() then begin
            if GenJournalLine."Journal Batch Name" = 'APPROVALS' then begin
                // Message('APPROVALS');
                GenJournalLine.SetRange("Reason Code", 'APPROVED');

            end;

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 13, 'OnAfterCode', '', true, true)]
    procedure OnAfterCode(var GenJournalLine: Record "Gen. Journal Line"; PreviewMode: Boolean);
    begin
        // GenJournalLine.SetRange("Reason Code", 'REJECTED');
        // if GenJournalLine.FindSet() then begin
        // if GenJournalLine."Journal Batch Name" = 'APPROVALS' then begin
        // Message('APPROVALS');

        // GenJournalLine.DeleteAll();

        // end;

        // end;

    end;


}