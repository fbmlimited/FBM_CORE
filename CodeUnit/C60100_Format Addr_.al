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
        FormatAddress.FormatAddr(AddrArray, CompanyInfo.Name, CompanyInfo."Name 2", '', CompanyInfo.Address, CompanyInfo."Address 2", CompanyInfo.City, CompanyInfo."Post Code", CompanyInfo.County, CompanyInfo."Country/Region Code");
    end;

    procedure RespCenterCountry(var AddrArray: array[8] of Text[100];
    var RespCenter: Record "Responsibility Center")
    begin
        FormatAddress.FormatAddr(AddrArray, RespCenter.Name, RespCenter."Name 2", RespCenter.Contact, RespCenter.Address, RespCenter."Address 2", RespCenter.City, RespCenter."Post Code", RespCenter.County, RespCenter."Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvSellTo', '', true, true)]
    procedure OnBeforeSalesInvSellTo(var AddrArray: array[8] of Text[100]; var SalesInvoiceHeader: Record "Sales Invoice Header"; var Handled: Boolean)
    var
        format: codeunit "Format Address";
    begin

        format.FormatAddr(
          AddrArray, SalesInvoiceHeader."Sell-to Customer Name", SalesInvoiceHeader."Sell-to Customer Name 2", '', SalesInvoiceHeader."Sell-to Address", SalesInvoiceHeader."Sell-to Address 2",
          SalesInvoiceHeader."Sell-to City", SalesInvoiceHeader."Sell-to Post Code", SalesInvoiceHeader."Sell-to County", SalesInvoiceHeader."Sell-to Country/Region Code");
        Handled := true;
    end;
}
