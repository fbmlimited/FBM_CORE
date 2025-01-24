report 60160 FBM_JnlRep
{
    Caption = 'Journals Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './RDLC/R60160_JnlRep.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem(glentry; "G/L Entry")
        {
            RequestFilterFields = "Posting Date";
            column(compname; compname)
            {

            }
            column(filters; filters)
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Entry_No_; "Entry No.")
            {

            }
            column(Document_No_; "Document No.")
            {

            }
            column(Source_Code; "Source Code")
            {

            }
            column(G_L_Account_No_; "G/L Account No.")
            {

            }
            column(G_L_Account_Name; "G/L Account Name")
            {

            }
            column(Amount; Amount)
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            trigger
            OnPreDataItem()
            begin
                glentry.SetFilter("Source Code", '=%1', format(scode));
                filters := glentry.GetFilters();
                cinfo.Get();
                compname := cinfo.Name;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    FIELD(SCODE; SCODE)
                    {
                        ApplicationArea = all;
                        Caption = 'Journal Type: ';


                    }
                }

            }
        }

    }
    VAR
        SCODE: option GENJNL,CASHRECJNL,PAYMENTJNL;
        filters: Text;
        compname: Text;
        cinfo: record "Company Information";
}