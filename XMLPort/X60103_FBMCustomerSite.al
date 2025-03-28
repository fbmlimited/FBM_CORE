xmlport 60103 FBM_CustomerSite
{
    Direction = Export;
    Format = VariableText;
    FileName = 'CustomerSite.bak';

    schema
    {
        textelement(cust)
        {
            tableelement(FBM_CustomerSite_C; FBM_CustomerSite_C)
            {
                fieldattribute(CustNo; FBM_CustomerSite_C."Customer No.") { }
                fieldattribute(SiteCode; FBM_CustomerSite_C."Site Code") { }
                fieldattribute(SAiteGr; FBM_CustomerSite_C.SiteGrCode) { }

                fieldattribute(Contract; FBM_CustomerSite_C."Contract Code") { }
                fieldattribute(Contract2; FBM_CustomerSite_C."Contract Code2") { }
                fieldattribute(Contact; FBM_CustomerSite_C.Contact) { }
                fieldattribute(Status; FBM_CustomerSite_C.Status) { }
                fieldattribute(VAtNumber; FBM_CustomerSite_C."Vat Number") { }
                fieldattribute(typerec; FBM_CustomerSite_C.Typerec) { }

                fieldattribute(typesite; FBM_CustomerSite_C.TypeSite) { }
                fieldattribute(No; FBM_CustomerSite_C.Version) { }
                fieldattribute(No; FBM_CustomerSite_C.ActiveRec) { }
                fieldattribute(No; FBM_CustomerSite_C."Valid From") { }
                fieldattribute(No; FBM_CustomerSite_C."Valid To") { }
                fieldattribute(No; FBM_CustomerSite_C."Record Owner") { }
                fieldattribute(No; FBM_CustomerSite_C."Change Note") { }


            }
        }
    }
}