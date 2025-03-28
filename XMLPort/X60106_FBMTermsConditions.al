xmlport 60106 FBM_TermsConditions
{
    Direction = Export;
    Format = VariableText;
    FileName = 'TermsConditions.bak';
    schema
    {
        textelement(cust)
        {
            tableelement(FBM_TermsConditions; FBM_TermsConditions)
            {
                fieldattribute(Country; FBM_TermsConditions.Country) { }
                fieldattribute(LineNo; FBM_TermsConditions."Line No.") { }
                fieldattribute(TermsConditions; FBM_TermsConditions."Terms Conditions") { }

                fieldattribute(DocType; FBM_TermsConditions.DocType) { }

            }
        }
    }
}
