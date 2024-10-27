page 60168 FBM_FAListNew_CO
{
    Caption = 'FA List New';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Fixed Asset";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

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
                field(FBM_ReplicaStatus; Rec.FBM_ReplicaStatus2)
                {
                    ApplicationArea = All;
                }

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;
                image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                enabled = isnew;

                trigger
                OnAction()
                var
                    lastcode: Integer;
                    newcode: code[20];
                    fa: record "Fixed Asset";
                begin
                    if rec.FBM_ReplicaStatus2 = rec.FBM_ReplicaStatus2::Sent then begin
                        fa.setfilter("No.", '%1', 'FA*');
                        fa.SetFilter("No.", '<%1', 'FA500000');
                        fa.FindLast();
                        evaluate(lastcode, copystr(fa."No.", 4));
                        lastcode += 1;
                        newcode := 'FA' + PADSTR('', 6 - strlen(format(lastcode)), '0') + format(lastcode);


                        rec.FBM_ReplicaStatus2 := FBM_ReplicaStatus_DD::Aquired;
                        rec.rename(newcode);
                        rec.Modify();

                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                enabled = isnew;

                trigger
                OnAction()

                begin
                    if rec.FBM_ReplicaStatus2 = rec.FBM_ReplicaStatus2::Sent then begin
                        rec.FBM_ReplicaStatus2 := FBM_ReplicaStatus_DD::Refused;
                        rec.Modify();
                    end;
                end;
            }
            action("Clean Rejected")
            {
                ApplicationArea = All;
                image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger
                OnAction()

                begin
                    rec.SetRange(FBM_ReplicaStatus2, rec.FBM_ReplicaStatus2::Refused);
                    rec.DeleteAll();
                end;
            }
        }

    }
    trigger
    OnOpenPage()
    begin
        rec.setfilter(FBM_ReplicaStatus2, '%1|%2', rec.FBM_ReplicaStatus2::Sent, rec.FBM_ReplicaStatus2::Refused);

    end;

    trigger
    OnAfterGetRecord()
    begin
        isnew := (copystr(rec."No.", 1, 2) = 'AF') and (rec.FBM_ReplicaStatus2 = rec.FBM_ReplicaStatus2::Sent);
    end;

    var
        isnew: Boolean;
}