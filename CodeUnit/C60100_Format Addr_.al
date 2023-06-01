codeunit 60100 "FBM_Format Addr_CO"
{
    Permissions = tabledata "Sales Cr.Memo Header" = rimd;
    trigger OnRun()
    begin
    end;

    var
        FormatAddress: Codeunit "Format Address";
    //copy of standard functions but with the inclusion of Country/Region
    procedure GetCompanyAddrCountry(RespCenterCode: Code[10];
    var ResponsibilityCenter: Record "Responsibility Center";
    var CompanyInfo: Record "Company Information";
    var CompanyAddr: array[8] of Text[100])
    begin
        if ResponsibilityCenter.Get(RespCenterCode) then begin
            RespCenterCountry(CompanyAddr, ResponsibilityCenter);
            CompanyInfo."Phone No." := ResponsibilityCenter."Phone No.";
            CompanyInfo."Fax No." := ResponsibilityCenter."Fax No.";
        end
        else
            CompanyCountry(CompanyAddr, CompanyInfo);
    end;

    procedure CompanyCountry(var AddrArray: array[8] of Text[100];
    var CompanyInfo: Record "Company Information")
    begin
        with CompanyInfo do FormatAddress.FormatAddr(AddrArray, Name, "Name 2", '', Address, "Address 2", City, "Post Code", County, "Country/Region Code");
    end;

    procedure RespCenterCountry(var AddrArray: array[8] of Text[100];
    var RespCenter: Record "Responsibility Center")
    begin
        with RespCenter do FormatAddress.FormatAddr(AddrArray, Name, "Name 2", Contact, Address, "Address 2", City, "Post Code", County, "Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvSellTo', '', true, true)]
    procedure OnBeforeSalesInvSellTo(var AddrArray: array[8] of Text[100]; var SalesInvoiceHeader: Record "Sales Invoice Header"; var Handled: Boolean)
    var
        format: codeunit "Format Address";
    begin
        with SalesInvoiceHeader do
            format.FormatAddr(
              AddrArray, "Sell-to Customer Name", "Sell-to Customer Name 2", '', "Sell-to Address", "Sell-to Address 2",
              "Sell-to City", "Sell-to Post Code", "Sell-to County", "Sell-to Country/Region Code");
        Handled := true;
    end;
}
