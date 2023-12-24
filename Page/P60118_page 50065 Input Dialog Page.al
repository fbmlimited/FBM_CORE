page 60118 "FBM_Input Dialog Page_CO"
{
    // version NAVW111.00

    CaptionML = ENU = 'Input Dialog',
                SQI = 'Input Dialog';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            SQI = 'General';
                field(Info; search)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(periodstart; periodstart)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Period Start';
                    Editable = true;
                }
                field(periodend; periodend)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Period End';
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
        periodstart: Date;
        periodend: Date;


    procedure SetValues(newsearch: Text; newperiodstart: Date; newperiodend: Date);
    begin
        search := newsearch;
        periodstart := newperiodstart;
        periodend := newperiodend;
    end;


    procedure GetValues(var newsearch: Text; var newperiodstart: Date; var newperiodend: Date);
    begin
        newsearch := search;
        newperiodstart := periodstart;
        newperiodend := periodend
    end;
}

