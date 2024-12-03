xmlport 60105 FBM_Site
{
    Direction = Export;
    Format = VariableText;
    FileName = 'Site.bak';
    schema
    {
        textelement(cust)
        {
            tableelement(FBM_Site; FBM_Site)
            {
                fieldattribute(SiteCode; FBM_Site."Site Code") { }
                fieldattribute(SiteName; FBM_Site."Site Name") { }
                fieldattribute(SiteName2; FBM_Site."Site Name 2") { }

                fieldattribute(Address; FBM_Site.Address) { }
                fieldattribute(Address2; FBM_Site."Address 2") { }
                fieldattribute(City; FBM_Site.City) { }
                fieldattribute(County; FBM_Site.County) { }
                fieldattribute(Country; FBM_Site."Country/Region Code") { }
                fieldattribute(PostCode; FBM_Site."Post Code") { }

                fieldattribute(VatNumber; FBM_Site."Vat Number") { }
                fieldattribute(C1; FBM_Site.Company1) { }
                fieldattribute(C2; FBM_Site.Company2) { }
                fieldattribute(C3; FBM_Site.Company3) { }
                fieldattribute(Verion; FBM_Site.Version) { }
                fieldattribute(Activerec; FBM_Site.ActiveRec) { }
                fieldattribute(Validfrom; FBM_Site."Valid From") { }
                fieldattribute(Validto; FBM_Site."Valid To") { }
                fieldattribute(RecordOwner; FBM_Site."Record Owner") { }
                fieldattribute(ChangeNote; FBM_Site."Change Note") { }


            }
        }
    }
}