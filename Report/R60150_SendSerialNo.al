report 60150 FBM_SendSrialNo
{
    Caption = 'SendSerialNo';

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
    var
        HeaderJsonObject: JsonObject;
        JsonArray: JsonArray;

        NewJsonObject: JsonObject;
        instr: InStream;
        nfile: Text;
        text: Text;
        ile: record "Item Ledger Entry";
        ile2: record "Item Ledger Entry";
        csite: record FBM_CustomerSite_C;
        loc: record Location;
        serial: code[50];
        i: integer;
        rese: record "Reservation Entry";
        rec: record "Reservation Entry" temporary;
        item: record Item;
        tmpBlob: Codeunit "Temp Blob";
        invsetup: record "Inventory Setup";
        email: Codeunit Email;
        emailMsg: Codeunit "Email Message";
        cinfo: Record "Company Information";
        country: record "Country/Region";
        ccode: text[3];
        txtB64: Text;
        cnv64: Codeunit "Base64 Convert";
        outstr: OutStream;
        emailitem: record "Email Item";


    begin
        i := 1;
        // from ILE : serial no, location, site
        csite.SetRange(ActiveRec, true);
        if csite.FindFirst() then
            repeat
                ile.SetRange(FBM_Site, csite."Site Code");
                ile.CalcSums(Quantity);
                if (ile.Quantity <> 0) and (ile.findfirst) then
                    repeat
                        ile2.SetRange("Item No.", ile."Item No.");
                        ile2.SetRange(FBM_Site, csite."Site Code");
                        ile2.SetRange("Serial No.", ile."Serial No.");
                        ile2.SetRange("Location Code", ile."Location Code");
                        if ile2.FindFirst() then begin

                            rec.Init();
                            rec."Entry No." := i;
                            rec."Item No." := ile."Item No.";
                            if item.Get(ile."Item No.") then begin
                                rec.Description := item.Description;
                                rec.FBM_MachineType := item.FBM_MachineType;
                            end;
                            rec."Serial No." := ile."Serial No.";
                            rec.FBM_Site := csite."Site Code";
                            rec."Location Code" := ile."Location Code";
                            rec.FBM_Pedimento2 := ile.FBM_Pedimento2;
                            if rese.FindFirst() then
                                rec.FBM_BinCode := rese.FBM_BinCode;
                            ile2.CalcSums(Quantity);
                            if (ile2.Quantity <> 0) and (ile."Serial No." <> '') and (csite."Site Code" <> '') then begin
                                rec.Quantity := ile2.Quantity;
                                if rec.Insert() then begin i += 1; end;
                            end;
                        end;
                    until ile.Next() = 0;
            until csite.next = 0;
        ile.Reset();
        ile2.Reset();
        if loc.FindFirst() then
            repeat

                ile.SetRange("Location Code", loc.Code);
                ile.CalcSums(Quantity);
                if (ile.Quantity <> 0) and (ile.FindFirst()) then
                    repeat
                        ile2.SetRange("Item No.", ile."Item No.");
                        ile2.SetRange("Location Code", loc.Code);
                        ile2.SetRange("Serial No.", ile."Serial No.");
                        if ile2.FindFirst() then begin
                            rese.SetRange("Item Ledger Entry No.", ile."Entry No.");
                            rec.Init();
                            rec."Entry No." := i;
                            rec."Item No." := ile."Item No.";
                            if item.Get(ile."Item No.") then begin
                                rec.Description := item.Description;
                                rec.FBM_MachineType := item.FBM_MachineType;
                            end;
                            rec."Serial No." := ile."Serial No.";
                            rec."Location Code" := loc.Code;
                            rec.FBM_Pedimento2 := ile.FBM_Pedimento2;
                            ile2.CalcSums(Quantity);
                            if (ile2.Quantity <> 0) and (ile."Serial No." <> '') then begin


                                rec.Quantity := ile2.Quantity;
                                if rese.FindFirst() then
                                    rec.FBM_BinCode := rese.FBM_BinCode;
                                if rec.Insert() then begin i += 1; end;
                            end;
                        end;
                    until ile.Next() = 0;
            until loc.next = 0;

        if rec.findset(true) then
            repeat

                clear(HeaderJsonObject);
                HeaderJsonObject.add('EntryNo', rec."Entry No.");
                HeaderJsonObject.add('No', rec."Item No.");
                HeaderJsonObject.add('SerialNo', rec."Serial No.");
                HeaderJsonObject.add('Description', rec.Description);
                HeaderJsonObject.add('Locationcode', rec."Location Code");
                HeaderJsonObject.add('Technician', rec.FBM_BinCode);
                HeaderJsonObject.add('Site', rec.FBM_Site);
                HeaderJsonObject.add('Pedimento', rec.FBM_Pedimento_2);
                HeaderJsonObject.add('MachineType', format(rec.FBM_MachineType));
                JsonArray.add(HeaderJsonObject);

            until rec.Next() = 0;
        NewJsonObject.add('', JsonArray);
        NewJsonObject.WriteTo(text);
        // Content.GetHeaders(HttpHeadersContent);
        tmpBlob.CreateOutStream(outstr);
        outstr.Write(text);
        tmpBlob.CreateInStream(InStr);


        //txtB64 := cnv64.ToBase64(InStr, true);
        nfile := 'serialNo.json';
        //DownloadFromStream(instr, '', '', '', nfile);


        cinfo.get();
        if country.get(cinfo."Country/Region Code") then
            ccode := country.FBM_Country3;
        invsetup.Get();
        emailitem."Send to" := invsetup.FBM_OrionEmail;
        emailitem.Subject := cinfo."Custom System Indicator Text" + ' ' + ccode + '|' + format(CurrentDateTime);
        emailitem.AddAttachment(instr, nfile);
        emailitem.Send(true, enum::"Email Scenario"::Default);

        // emailMsg.Create(invsetup.FBM_OrionEmail, cinfo."Custom System Indicator Text" + ' ' + ccode + '|' + format(CurrentDateTime), 'Best Regards');
        //emailMsg.AddAttachment(nfile, 'text/plain', txtB64);
        //email.send(emailMsg);
    end;
}