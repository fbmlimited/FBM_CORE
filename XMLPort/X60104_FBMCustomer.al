xmlport 60104 FBM_Customer
{
    Direction = Export;
    Format = VariableText;
    FileName = 'Customer.bak';
    schema
    {
        textelement(cust)
        {
            tableelement(FBM_Customer; FBM_Customer)
            {
                fieldattribute(No; FBM_Customer."No.") { }
                fieldattribute(No; FBM_Customer.Name) { }
                fieldattribute(No; FBM_Customer."Name 2") { }
                fieldattribute(No; FBM_Customer."Search Name") { }
                fieldattribute(No; FBM_Customer.Address) { }
                fieldattribute(No; FBM_Customer."Address 2") { }
                fieldattribute(No; FBM_Customer.City) { }
                fieldattribute(No; FBM_Customer.County) { }
                fieldattribute(No; FBM_Customer."Country/Region Code") { }
                fieldattribute(No; FBM_Customer."Post Code") { }
                fieldattribute(No; FBM_Customer.FBM_Group) { }
                fieldattribute(No; FBM_Customer.FBM_SubGroup) { }
                fieldattribute(No; FBM_Customer."VAT Registration No.") { }
                fieldattribute(No; FBM_Customer.FBM_Company1) { }
                fieldattribute(No; FBM_Customer.FBM_Company2) { }
                fieldattribute(No; FBM_Customer.FBM_Company3) { }
                fieldattribute(No; FBM_Customer.Version) { }
                fieldattribute(No; FBM_Customer.ActiveRec) { }
                fieldattribute(No; FBM_Customer."Valid From") { }
                fieldattribute(No; FBM_Customer."Valid To") { }
                fieldattribute(No; FBM_Customer."Record Owner") { }
                fieldattribute(No; FBM_Customer."Change Note") { }


            }
        }
    }
}