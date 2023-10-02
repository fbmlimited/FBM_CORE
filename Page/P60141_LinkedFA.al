page 60141 FBM_LinkedFA_CO
{
    Caption = 'Local FA';
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Name/Value Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.name)
                {
                    Caption = 'Subsidiary|FA|Site|Status';
                    ApplicationArea = All;
                }
                field(Description; Rec.Value)
                {
                    caption = 'Serial No.';
                    ApplicationArea = All;
                }

            }
        }

    }

    trigger
    OnOpenPage()
    begin
        comp.FindFirst();
        if comp.FindSet() then
            repeat
                cinfo.ChangeCompany(comp.Name);
                cinfo.get;
                //if cinfo.FBM_CustIsOp then begin
                fa.ChangeCompany(comp.Name);
                //csite.setrange(Status, csite.Status::OPERATIONAL);

                if fa.FindFirst() then
                    repeat
                        id += 1;
                        rec.id := id;
                        rec.name := copystr(cinfo."Custom System Indicator Text" + '|' + fa."No." + '|' + fa.fbm_Site + '|' + format(fa.FBM_Status), 1, 250);
                        rec.value := fa."Serial No.";
                        rec.Insert();
                    until fa.Next() = 0;
            //end;
            until comp.Next() = 0;
    end;

    var
        comp: record Company;
        cinfo: record "Company Information";
        fa: record "Fixed Asset";
        id: Integer;
}