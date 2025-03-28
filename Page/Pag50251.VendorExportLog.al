page 60171 "Vendor Export Logs"
{

    ApplicationArea = All;
    Caption = 'Vendor Export Log';
    PageType = List;
    SourceTable = "Vendor Export Log";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                }
                field("File Created"; Rec."File Created")
                {
                    ToolTip = 'Specifies the value of the File Created field';
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field';
                    ApplicationArea = All;
                }
                field(URL; Rec.URL)
                {
                    ToolTip = 'Specifies the value of the URL field';
                    ApplicationArea = All;
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    begin
                        Hyperlink(Rec.URL);
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(WriteFileInAzure)
            {
                ApplicationArea = All;
                Caption = 'Write File In Azure';
                ToolTip = 'Write File In Azure';
                Image = RefreshLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    memoryStream: Codeunit "MemoryStream Wrapper";
                    client: HttpClient;
                    response: HttpResponseMessage;
                    content: HttpContent;
                    headers: HttpHeaders;
                    len: Integer;
                    _inSt: InStream;
                    _fileName: Text;
                    _fullURL: Text;
                    _azureStorageSetup: Record "Azure Storage Setup";
                    _blob: Codeunit "Temp Blob";
                    _outSt: OutStream;
                    _vendor: Record Vendor;
                begin
                    _filename := 'VendorList' + '-' + Format(Date2DMY(WorkDate(), 2)) + '-' +
                                                    Format(Date2DMY(WorkDate(), 1)) + '-' +
                                                    Format(Date2DMY(WorkDate(), 3)) + '.txt';

                    Rec.SendVendorsToBlob(_outSt, _inSt);
                    _blob.CreateOutStream(_outSt);

                    if _vendor.Findset() then
                        repeat
                            _outSt.WriteText(Format(_vendor));
                        until _vendor.next() = 0;

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
                                                          _fileName,
                                                          _azureStorageSetup."SAS Token");

                    if not client.Put(_fullURL, content, response) then
                        Error(GetLastErrorText());
                    if response.IsSuccessStatusCode() then
                        Message('Uploaded')
                    else
                        Error(response.ReasonPhrase);

                    Rec.InsertLog(_fileName, _fullURL);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
