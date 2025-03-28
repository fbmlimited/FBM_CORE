report 60146 FBM_SendAgedRec_CO
{
    Caption = 'Send Aged Receivable';
    //UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;



    dataset
    {
        dataitem(DataItemName; "Company Information")
        {

        }
    }

    trigger
    OnInitReport()
    begin
        tmpBlob.CreateOutStream(OutStr);
        if Report.SaveAs(Report::"FBM_Aged AccRec New_CO", '', format::Pdf, OutStr, recRef) then begin
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            glsetup.Get();

            emailMsg.Create(glsetup.FBM_EmailAR, 'Aged AR', 'Best Regards');
            emailMsg.AddAttachment('AgedAR.pdf', 'application/pdf', txtB64);
            email.send(emailMsg, enum::"Email Scenario"::Reminder);
        end;
    end;

    var
        glsetup: record "General Ledger Setup";
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        email: Codeunit Email;
        emailMsg: Codeunit "Email Message";
        recRef: RecordRef;
        Customer: Record Customer;
}