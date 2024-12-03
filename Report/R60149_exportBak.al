report 60149 FBM_ExportBak
{
    Caption = 'Export Backup';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {

        }
    }

    trigger
    OnInitReport()
    begin
        Xmlport.Run(Xmlport::FBM_Customer, false, false);
        Xmlport.Run(Xmlport::FBM_Site, false, false);
        Xmlport.Run(Xmlport::FBM_CustomerSite, false, false);
    end;
}