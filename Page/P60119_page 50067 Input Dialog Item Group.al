page 60119 "FBM_Input Dialog Post Group_CO"
{


    Caption = 'Input Dialog';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Info; search)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(searchField1; searchField1)
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        IF PAGE.RUNMODAL(0, GenBusinessPostingGroup) = ACTION::LookupOK THEN BEGIN
                            Text := GenBusinessPostingGroup.Code;
                            searchField1 := GenBusinessPostingGroup.Code;
                            EXIT(TRUE);
                        END;
                    end;
                }
                field(searchField2; searchField2)
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        IF PAGE.RUNMODAL(0, GenProductPostingGroup) = ACTION::LookupOK THEN BEGIN
                            Text := GenProductPostingGroup.Code;
                            searchField2 := GenProductPostingGroup.Code;
                            EXIT(TRUE);
                        END;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var

        searchField1: Text;
        searchField2: Text;
        search: Text;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        GenProductPostingGroup: Record "Gen. Product Posting Group";


    procedure SetValues(newsearch: Text; genbusprod: Code[20]; genprod: Code[20]);
    begin
        search := newsearch;
        searchField1 := genbusprod;
        searchField2 := genprod;
    end;

    procedure GetValues(var newsearch: Text; var genbusprod: Code[20]; var genprod: Code[20]);
    begin
        newsearch := search;
        genbusprod := searchField1;
        genprod := searchField2;
    end;
}

