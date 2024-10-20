report 60144 FBM_CheckExchRate_CO
{
    Caption = 'Check Exchange Rate';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;




    trigger

   OnInitReport()
    var
        jobq: record "Job Queue Entry";
        comp: record Company;
    begin
        comp.findfirst;
        repeat
            jobq.ChangeCompany(comp.Name);
            jobq.setrange("Object Type to Run", jobq."Object Type to Run"::Codeunit);
            jobq.SetRange("Object ID to Run", 60102);
            if jobq.FindFirst() then
                if jobq.Status = jobq.Status::Error then
                    jobq.Restart();

            jobq.setrange("Object Type to Run", jobq."Object Type to Run"::Codeunit);
            jobq.SetRange("Object ID to Run", 60201);
            if jobq.FindFirst() then
                if jobq.Status = jobq.Status::Error then
                    jobq.Restart();


        until comp.next = 0;

    end;
}