xmlport 60107 FBM_Subsidiary
{
    Direction = Export;
    Format = VariableText;
    FileName = 'Subsidiary.bak';
    schema
    {
        textelement(cust)
        {
            tableelement(FBM_Subsidiary; FBM_Subsidiary)
            {
                fieldattribute(Country; FBM_Subsidiary.Country) { }
                fieldattribute(Lessee; FBM_Subsidiary.Lessee) { }
                fieldattribute(EGM_Property; FBM_Subsidiary.EGM_Property) { }
                fieldattribute(Brand; FBM_Subsidiary.Brand) { }
                fieldattribute(Subsidiary; FBM_Subsidiary.Subsidiary) { }
                fieldattribute(FBM_LastAdquiredDate; FBM_Subsidiary.FBM_LastAdquiredDate) { }
            }
        }
    }
}
