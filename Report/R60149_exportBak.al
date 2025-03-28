report 60149 FBM_ExportBak
{
    Caption = 'Export Backup';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {

        }
    }
    var
        _blob: Codeunit "Temp Blob";
        _inSt: InStream;
        _azureStorageSetup: record "Azure Storage Setup";
        memoryStream: Codeunit "MemoryStream Wrapper";
        client: HttpClient;
        response: HttpResponseMessage;
        content: HttpContent;
        headers: HttpHeaders;
        len: Integer;
        _fullURL: Text;
        outst: OutStream;
        vSuccess: Boolean;

        StorageAccountName: Text;
        AccountAccessKey: Text;
        AccountContainer: Text;
        NAccountContainer: Text;

        campo: Text;
        Names: JsonArray;
        FNames: JsonArray;


    trigger
    OnInitReport()

    var
        xmlcust3: xmlport FBM_CustomerSite;
        xmlcust4: xmlport FBM_Customer;
        xmlcust5: xmlport FBM_Site;
        xmlcust6: xmlport FBM_TermsConditions;
        xmlcust7: xmlport FBM_Subsidiary;
        xmlcust8: xmlport FBM_FAHistory_DD;
        xmlcust9: xmlport FBM_ListValues;
        myJsonObject: JsonObject;
        NameToken, FNameToken, arrayToken : JsonToken;
        i, len : Integer;
        blobExist: Boolean;
        blob_Empty: Boolean;
        blobDelete: Boolean;
        blobName: Text;
        Uri, RecipientUri : Text;
        OK: Boolean;
        xf: Text;




    begin

        clear(client);
        _azureStorageSetup.Get();
        _azureStorageSetup.TestField("Account URL");
        _azureStorageSetup.TestField(Container);
        _azureStorageSetup.TestField("SAS Token");


        StorageAccountName := StrSubstNo('%1', _azureStorageSetup."Account URL");
        AccountAccessKey := StrSubstNo('%1', _azureStorageSetup."SAS Token");
        AccountContainer := StrSubstNo('%1', _azureStorageSetup.Container);

        Uri := StorageAccountName + '/' + '?comp=list&' + AccountAccessKey;

        myJsonObject := ListBlobsInJsonObject(Uri, 'Name');
        myJsonObject.Get('Name', NameToken);

        Message('ListBlobsInJsonObject - Primera vez-  %1', myJsonObject);

        blobExist := CheckBlobContainerExist(NameToken, 'tempbackup');
        if not blobExist then begin
            blobExist := CreateBlobContainer(myJsonObject, Names, 'tempbackup');
        end;


        if blobExist then begin
            Uri := StorageAccountName + '/' + AccountContainer + '?restype=container&comp=list&' + AccountAccessKey;

            myJsonObject := ListBlobsInJsonObject(Uri, 'FileName');
            myJsonObject.Get('FileName', FNameToken);

            Message('ListBlobsInJsonObject -  Segunda vez- %1', myJsonObject);

            Uri := StorageAccountName + '/' + AccountContainer + '/';
            RecipientUri := StorageAccountName + '/' + 'tempbackup' + '/';


            //OK := CopyFilesToBlobContainer(Uri, FNameToken, RecipientUri);
            //ReadContainerfile();

            StorageAccountName := 'blobstoragedbcbackup';
            MoveandDeleteContainerFile(FNameToken);
            //MoveandDeleteContainerFile();

        end;







        /*  _blob.CreateOutStream(outst);
          xmlport.Export(xmlport::FBM_CustomerSite, outst);
          sendtoblob(outst, format(currentdatetime(), 0, '<Year4><Month,2><Day,2>_<Hour,2>_<Minute,2>') + '_' + xmlcust3.Filename);

          _blob.CreateOutStream(outst);
          xmlport.Export(xmlport::FBM_Customer, outst);
          sendtoblob(outst, format(currentdatetime(), 0, '<Year4><Month,2><Day,2>_<Hour,2>_<Minute,2>') + '_' + xmlcust4.Filename);

          _blob.CreateOutStream(outst);
          xmlport.Export(xmlport::FBM_Site, outst);
          sendtoblob(outst, format(currentdatetime(), 0, '<Year4><Month,2><Day,2>_<Hour,2>_<Minute,2>') + '_' + xmlcust5.Filename);

          _blob.CreateOutStream(outst);
          xmlport.Export(xmlport::FBM_TermsConditions, outst);
          sendtoblob(outst, format(currentdatetime(), 0, '<Year4><Month,2><Day,2>_<Hour,2>_<Minute,2>') + '_' + xmlcust6.Filename);

          _blob.CreateOutStream(outst);
          xmlport.Export(xmlport::FBM_Subsidiary, outst);
          sendtoblob(outst, format(currentdatetime(), 0, '<Year4><Month,2><Day,2>_<Hour,2>_<Minute,2>') + '_' + xmlcust7.Filename);

          _blob.CreateOutStream(outst);
          xmlport.Export(xmlport::FBM_FAHistory_DD, outst);
          sendtoblob(outst, format(currentdatetime(), 0, '<Year4><Month,2><Day,2>_<Hour,2>_<Minute,2>') + '_' + xmlcust8.Filename);

          _blob.CreateOutStream(outst);
          xmlport.Export(xmlport::FBM_ListValues, outst);
          sendtoblob(outst, format(currentdatetime(), 0, '<Year4><Month,2><Day,2>_<Hour,2>_<Minute,2>') + '_' + xmlcust9.Filename);*/

        //DeleteFilesInBlobContainer(FNameToken, 'tempbackup');

    end;

    local procedure sendtoblob(_outst: outstream; filename: text)
    begin



        clear(content);
        clear(client);


        _blob.CreateOutStream(_outSt);



        _blob.CreateInStream(_inSt);

        _azureStorageSetup.Get();
        _azureStorageSetup.TestField("Account URL");
        _azureStorageSetup.TestField(Container);
        _azureStorageSetup.TestField("SAS Token");

        client.SetBaseAddress(_azureStorageSetup."Account URL");

        memoryStream.Create(0);
        memoryStream.ReadFrom(_inSt);
        len := memoryStream.Length();
        memoryStream.SetPosition(0);
        memoryStream.GetInStream(_inSt);

        content.WriteFrom(_inSt);
        content.GetHeaders(headers);
        headers.Remove('Content-Type');
        headers.Add('Content-Type', 'application/octet-stream');
        headers.Add('Content-Length', StrSubstNo('%1', len));
        headers.Add('x-ms-blob-type', 'BlockBlob');

        _fullURL := StrSubstNo('%1/%2/%3?%4', _azureStorageSetup."Account URL",
                                              _azureStorageSetup.Container,
                                              fileName,
                                              _azureStorageSetup."SAS Token");

        if not client.Put(_fullURL, content, response) then
            Error(GetLastErrorText());
        if response.IsSuccessStatusCode() then
            Message('Uploaded')
        else
            Error(response.ReasonPhrase);


    end;


    procedure ListBlobsInJsonObject(Uri: Text; camp: Text): JsonObject;
    var
        vHttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        Content: Text;
        ContainersList: List of [Text];
        vJsonObject: JsonObject;
        vJsonArray: List of [JsonToken];
        vSuccess: Boolean;
        vSuccess2: Boolean;
        x: Text;



        Container: JsonToken;
        ContainerName: Text;
    begin
        vHttpClient.Get(Uri, HttpResponse);
        vSuccess := HttpResponse.IsSuccessStatusCode();
        if vSuccess then begin
            vSuccess2 := HttpResponse.Content.ReadAs(Content);
            if Content <> '' then begin
                vJsonObject := ConvertXMLToJson(Content, camp);
            end else begin
                Error('Failed to list blobs. Status code: %1', HttpResponse.IsSuccessStatusCode);
            end;
            // Return the JsonObject
            exit(vJsonObject);
        end;
    end;


    local procedure ReadJson(data: Text) result: JsonObject
    begin
        result.ReadFrom(data);
    end;

    procedure ConvertXMLToJson(xmlContent: Text; camp: Text): JsonObject
    var
        XmlDoc: XmlDocument;
        vXmlNodeList: XmlNodeList;
        vJsonValue: JsonValue;
        vXmlNode: XmlNode;
        vXmlElement: XmlElement;
        i, k : Integer;
        OK: Boolean;
        vText: Text;
        JsonObj: JsonObject;

    begin
        // Load the XML content into XmlDocument
        OK := XmlDocument.ReadFrom(xmlContent, XmlDoc);
        // Get all child nodes of the root
        OK := XmlDoc.GetRoot(vXmlElement);

        vXmlNodeList := vXmlElement.GetChildNodes();
        k := vXmlNodeList.Count;


        // Loop through the nodes and add them to the JSON object
        for i := 1 to vXmlNodeList.Count do begin
            OK := vXmlNodeList.Get(i, vXmlNode);
            vJsonValue := ConvertXMLNodeToJson(vXmlNode, camp);
        end;
        if camp.Contains('FileName') then begin
            JsonObj.Add('FileName', FNames);
        end else begin
            JsonObj.Add('Name', Names);
        end;
        exit(JsonObj);
    end;

    procedure ConvertXMLNodeToJson(vXmlNode: XmlNode; camp: Text): JsonValue
    var
        JsonNodeObj: JsonObject;
        vXmlNodeList: XmlNodeList;
        i, k, h : Integer;
        vJsonValue: JsonValue;
        XmlNodeChild: XmlNode;
        vXmlElement: XmlElement;
        OK, JustNames : Boolean;
        vText: Text;
        vvText: Text;
        Comillas: Boolean;
        vXmlText: XmlText;
    begin
        vXmlElement := vXmlNode.AsXmlElement();
        vvText := vXmlElement.Name;
        vXmlNodeList := vXmlElement.GetChildNodes();
        k := vXmlNodeList.Count;
        for i := 1 to k do begin
            OK := vXmlNodeList.Get(i, XmlNodeChild);
            h := vXmlElement.GetChildNodes().Count;
            if h > 1 then begin
                vJsonValue := ConvertXMLNodeToJson(XmlNodeChild, camp)
            end
            else begin
                vXmlText := XmlNodeChild.AsXmlText();
                vText := vXmlText.Value;

                Comillas := vText.Contains('"');
                if not Comillas then vText := '"' + vText + '"';
                campo := vvText;
                if campo.Contains('Name') then begin
                    if camp.Contains('FileName') then begin

                        if vText.Contains('.bak') then begin
                            Ok := vJsonValue.ReadFrom(vText);
                            FNames.Add(vJsonValue);
                        end;
                    end else begin
                        Ok := vJsonValue.ReadFrom(vText);
                        Names.Add(vJsonValue);
                    end;

                end;
            end;
        end;
        campo := vvText;
        exit(vJsonValue);
    end;

    procedure CheckBlobContainerExist(vNameToken: JsonToken; vblob: Text): Boolean
    var
        blobExist: Boolean;
        i: Integer;
        arrayToken: JsonToken;
        blobName: Text;
    begin

        blobExist := false;
        if vNameToken.IsArray then begin
            len := vNameToken.AsArray().Count;
            for i := 0 to len - 1 do begin
                vNameToken.AsArray().Get(i, arrayToken);
                blobName := arrayToken.AsValue().AsText();
                if blobName = vblob then begin
                    blobExist := true;
                    exit(blobExist)
                end;
            end;
        end;
        exit(blobExist);
    end;

    procedure CreateBlobContainer(JsonObj: JsonObject; vJarray: JsonArray; ContainerName: Text): Boolean
    var
        vNameToken: JsonToken;
        vHttpClient: HttpClient;
        Uri: Text;
        vText: Text;
        vHttpContent: HttpContent;
        HttpResponse: HttpResponseMessage;
        StatusCode: Boolean;


    begin
        // Define the URI for creating a container
        Uri := StorageAccountName + '/' + ContainerName + '?restype=container' + '&' + AccountAccessKey;

        //Uri := 'https://' + StorageAccountName + '.blob.core.windows.net/' + ContainerName + '?restype=container' + '&' + AccountAccessKey;

        // Send the PUT request to create the container
        vHttpClient.Put(Uri, vHttpContent, HttpResponse);

        // Check the status code from the response
        StatusCode := HttpResponse.IsSuccessStatusCode;

        if StatusCode then begin
            vJarray.Add(ContainerName);
            JsonObj.Get('Name', vNameToken);
            exit(true)
        end else
            exit(false);
    end;

    procedure DeleteFilesInBlobContainer(FilesToken: JsonToken; ContainerName: Text): Boolean
    var
        vNameToken: JsonToken;
        vHttpClient: HttpClient;
        DeleteUri: Text;
        vText: Text;
        vHttpContent: HttpContent;
        HttpResponse: HttpResponseMessage;
        StatusCode, OK : Boolean;
        arrayToken: JsonToken;
        i, nFiles : Integer;
        vXmlText: XmlText;
        BlobName: Text;

    begin

        nFiles := FilesToken.AsArray().Count;
        for i := 0 to nFiles - 1 do begin
            FilesToken.AsArray().Get(i, arrayToken);
            BlobName := arrayToken.AsValue().AsText();
            Message('ContainerName: %1', ContainerName);
            Message('BlobName: %1', BlobName);

            // Construct the URI to delete each blob

            DeleteUri := StorageAccountName + '/' + ContainerName + '/' + BlobName + '?' + AccountAccessKey;
            // DeleteUri := 'https://blobstoragedbcbackup.blob.core.windows.net/' + ContainerName + '/' + BlobName + '?' + AccountAccessKey;

            // Send DELETE request to delete the blob
            vHttpClient.Delete(DeleteUri, HttpResponse);

            // Check the response status code
            StatusCode := HttpResponse.IsSuccessStatusCode;
            if StatusCode then begin
                Message('Blob content "%1" deleted successfully.', ContainerName);
                exit(true)
            end else begin
                Error('Failed to delete blob content "%1". Status Code: %2', ContainerName, StatusCode);
                exit(false);
            end;
        end;
    end;


    /* procedure CopyFilesToBlobContainer(UriOrigen: Text; FNameToken: JsonToken; UriDestino: Text): Boolean
     var
         FileName: Text;
         FileContent: HttpContent;
         vHttpClient: HttpClient;
         vHttpResponse: HttpResponseMessage;
         ContentHeaders: HttpHeaders;
         FileStream: InStream;
         FNameTokenArray: JsonArray;
         vToken: JsonToken;
         i: Integer;
         FileUriOrigen, FileUriDestino : Text;
         OK: Boolean;
         FileMgt: Codeunit "File Management";
         LocalFilePath: Label 'D:\temp';

     begin
         FNameTokenArray := FNameToken.AsArray();
         for i := 0 to FNameTokenArray.Count - 1 do begin
             FNameTokenArray.Get(i, vToken);
             FileName := vToken.AsValue().AsText();
             if FileName.Contains('.bak') then begin
                 //De donde se van a tomar los archivos (en este caso del contenedor 'backup')
                 FileUriOrigen := UriOrigen + FileName + '?' + AccountAccessKey;
                 Message('Uri Origen COMPLETA: %1', FileUriOrigen);

                 vHttpClient.Get(FileUriOrigen, vHttpResponse);
                 OK := vHttpResponse.IsSuccessStatusCode;
                 if OK then begin
                     FileContent := vHttpResponse.Content;
                     OK := FileContent.ReadAs(FileStream);
                     if OK then begin
                         OK := FileMgt.DownloadFromStreamHandler(FileStream, 'Download File from Azure', LocalFilePath, '*.bak', FileName);
                         if not Ok then Error('Download Fail')
                     end else
                         Error('Download Fail -  Read as Stream');

                     // Ahora se toman del Local Path para copiarlos en el destino (en este caso hacia el contenedor 'tempbackup')
                     FileUriDestino := UriDestino + FileName + '?' + AccountAccessKey;
                     Message('Uri Destino completa %1', FileUriDestino);

                     //OK := FileMgt.OpenFile(LocalFilePath, FileStream);
                     //if OK then begin
                     // Preparar los encabezados HTTP para la solicitud PUT

                     // ContentHeaders.Add('x-ms-blob-type', 'BlockBlob');  // Tipo de blob (BlockBlob)
                     //ContentHeaders.Add('Content-Type', 'application/octet-stream');  // Tipo de contenido para archivos binarios

                     // Realizar la solicitud PUT para subir el archivo
                     vHttpClient.Put(FileUriDestino, FileContent, vHttpResponse);
                     OK := vHttpResponse.IsSuccessStatusCode;
                     if OK then
                         Message('The file %1 was uploaded to tempbackup.', FileName)
                     else
                         Error('The file %1 was not uploaded to tempbackup.', FileName);
                     //end;
                 end else
                     Error('Fail HTTP GET request to retrieve the file %1 content from Azure Blob Storage.', FileName);

             end;
         end;
     end;*/

    // This one import the file into Azure blob storage container
    local procedure UploadfileintoContainers()
    var
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        ABSBlobClient: Codeunit "ABS Blob Client";
        ABSOperationResponse: Codeunit "ABS Operation Response";
        Authorization: Interface "Storage Service Authorization";
        instr: Instream;
        AccountAccessKey: text;
        AccountName: Text;
        AccountContainer: Text;
        filename: Text;
    begin

        Authorization := StorageServiceAuthorization.CreateSharedKey(AccountAccessKey);
        ABSBlobClient.Initialize(AccountName, AccountContainer, Authorization);
        //filename := Uploadfile(instr);
        ABSOperationResponse := ABSBlobClient.PutBlobBlockBlobStream(filename, instr);
        if ABSOperationResponse.IsSuccessful() then
            Message('File has been imported successfully.');
    end;


    local procedure ReadContainerfile()
    var
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        ABSBlobClient: Codeunit "ABS Blob Client";
        ABSOperationResponse: Codeunit "ABS Operation Response";
        Authorization: Interface "Storage Service Authorization";
        Base64Convert: codeunit "Base64 Convert";
        instr: Instream;
        AccountAccessKeyToText: Text;
        /*AccountAccessKey: text;
        AccountName: Text;
        AccountContainer: Text;
        filename: Text;*/
        ABSContainerContent: Record "ABS Container Content";
    begin
        //AccountAccessKey := 'sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2025-05-31T21:14:07Z&st=2025-02-19T14:14:07Z&sip=195.158.76.70&spr=https&sig=WjPdxcRNErvvAsWqn%2BUoXH%2FPTdbDFAdAUXRmSCvGyx8%3D';
        AccountAccessKeyToText := Base64Convert.ToBase64(AccountAccessKey);
        Authorization := StorageServiceAuthorization.CreateSharedKey(AccountAccessKeyToText);
        ABSBlobClient.Initialize(StorageAccountName, AccountContainer, Authorization);
        ABSOperationResponse := ABSBlobClient.ListBlobs(ABSContainerContent);
        if ABSOperationResponse.IsSuccessful() then begin
            ABSContainerContent.Reset();
            if ABSContainerContent.FindSet() then
                repeat
                    Clear(instr);
                    ABSOperationResponse := ABSBlobClient.GetBlobAsStream(ABSContainerContent.Name, instr);
                    if ABSOperationResponse.IsSuccessful() then
                        Message('File read successfully');



                until ABSContainerContent.Next() = 0;
        end;
    end;

    local procedure MoveandDeleteContainerFile(FNameToken: JsonToken)
    var
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        ABSBlobClient: Codeunit "ABS Blob Client";
        ABSOperationResponse: Codeunit "ABS Operation Response";
        Authorization: Interface "Storage Service Authorization";
        instr: Instream;
        Base64Convert: codeunit "Base64 Convert";
        AccountAccessKeyToText: Text;
        //filename: Text;
        ABSContainerContent: Record "ABS Container Content";
        ProcessContainerName: Text;
        ABSBlobClient_2: Codeunit "ABS Blob Client";
        FNameTokenArray: JsonArray;
        i: Integer;
        FileName: Text;
        vToken: JsonToken;
        OK: Boolean;
        TempBlob: Codeunit "Temp Blob";
    begin
        instr := TempBlob.CreateInStream();
        Clear(Authorization);
        ProcessContainerName := 'tempbackup';
        AccountAccessKeyToText := Base64Convert.ToBase64(AccountAccessKey);
        Message('AccountAccessKeyToText: %1', AccountAccessKeyToText);
        Authorization := StorageServiceAuthorization.CreateSharedKey(AccountAccessKeyToText);
        Message('Authorization: %1', Authorization);

        ABSBlobClient.Initialize('blobstoragedbcbackup', 'backup', Authorization);

        FNameTokenArray := FNameToken.AsArray();
        for i := 0 to FNameTokenArray.Count - 1 do begin
            FNameTokenArray.Get(i, vToken);
            //FileName := 'backup' + '/' + vToken.AsValue().AsText();
            FileName := vToken.AsValue().AsText();
            if FileName.Contains('.bak') then begin
                Message('GET FileName: %1', FileName);

                Clear(instr);

                // Reading the file from output container
                ABSOperationResponse := ABSBlobClient.GetBlobAsStream(FileName, instr);

                OK := ABSOperationResponse.IsSuccessful();
                Message('Reading the file from output container, ABSOperationResponse.IsSuccessful() es: %1', OK);

                Clear(ABSBlobClient_2);
                if ABSOperationResponse.IsSuccessful() then begin
                    // Now Initilize Process container where I will put that file from source container
                    ABSBlobClient_2.Initialize('blobstoragedbcbackup', 'tempbackup', Authorization);
                    //FileName := 'tempbackup' + '/' + vToken.AsValue().AsText();
                    FileName := vToken.AsValue().AsText();
                    Message('PUT FileName: %1', FileName);
                    // Putting file here from source container.
                    ABSOperationResponse := ABSBlobClient_2.PutBlobBlockBlobStream(FileName, instr);
                    if ABSOperationResponse.IsSuccessful() then begin
                        // Deleting the same file from source container.
                        //ABSOperationResponse := ABSBlobClient.DeleteBlob(ABSContainerContent.Name);
                        //if ABSOperationResponse.IsSuccessful() then
                        //Message('File has been deleted from the original container.');
                        Message('El archivo se copió y con estas lineas comentadas no se borra');
                    end;
                end;

            end;
        end;
    end;


    /*local procedure MoveandDeleteContainerFile()
    var
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        ABSBlobClient: Codeunit "ABS Blob Client";
        ABSOperationResponse: Codeunit "ABS Operation Response";
        Authorization: Interface "Storage Service Authorization";
        instr: Instream;
        Base64Convert: codeunit "Base64 Convert";
        AccountAccessKeyToText: Text;
        ABSContainerContent: Record "ABS Container Content";
        ProcessContainerName: Text;
        Filename: Text;
        ABSBlobClient_2: Codeunit "ABS Blob Client";
        StorageAccountNameAndAccountContainer: Text;
        NewAccountContainer: Text;
        OK: Boolean;
    begin
        //AccountAccessKey := 'your key here';
        //AccountName := 'Storage account name';
        //AccountContainer := 'storage container name';
        //StorageAccountNameAndAccountContainer := StorageAccountName + '/' + AccountContainer;
        //NewAccountContainer := AccountContainer + '/';

        ProcessContainerName := 'tempbackup';
        AccountAccessKeyToText := Base64Convert.ToBase64(AccountAccessKey);
        Message('AccountAccessKeyToText: %1', AccountAccessKeyToText);
        Authorization := StorageServiceAuthorization.CreateSharedKey(AccountAccessKeyToText);
        Message('Authorization: %1', Authorization);
        // ABSBlobClient.Initialize(StorageAccountNameAndAccountContainer, StorageAccountNameAndAccountContainer, Authorization);
        Message('StorageAccountName: %1', StorageAccountName);
        Message('AccountContainer: %1', AccountContainer);
        ABSBlobClient.Initialize('blobstoragedbcbackup', 'backup', Authorization);
        ABSOperationResponse := ABSBlobClient.ListBlobs(ABSContainerContent);
        OK := ABSOperationResponse.IsSuccessful();
        Message(' OK:= ABSOperationResponse.IsSuccessful(): %1', OK);
        if ABSOperationResponse.IsSuccessful() then begin
            ABSContainerContent.Reset();
            if ABSContainerContent.FindSet() then
                repeat
                    Clear(instr);
                    // Reading the file from output container
                    ABSOperationResponse := ABSBlobClient.GetBlobAsStream(ABSContainerContent.Name, instr);
                    Clear(ABSBlobClient_2);
                    if ABSOperationResponse.IsSuccessful() then begin
                        // Now Initilize Process container where I will put that file from source container
                        ABSBlobClient_2.Initialize(StorageAccountName, ProcessContainerName, Authorization);
                        // Putting file here from source container.
                        ABSOperationResponse := ABSBlobClient_2.PutBlobBlockBlobStream(ABSContainerContent.Name, instr);
                        if ABSOperationResponse.IsSuccessful() then begin
                            // Deleting the same file from source container.
                            // ABSOperationResponse := ABSBlobClient.DeleteBlob(ABSContainerContent.Name);
                            //if ABSOperationResponse.IsSuccessful() then
                            //Message('File has been deleted from the original container.');
                            Message('El archivo se copió y con estas lineas comentadas no se borra');
                        end;
                    end;
                until ABSContainerContent.Next() = 0;
        end;
    end;*/






}
