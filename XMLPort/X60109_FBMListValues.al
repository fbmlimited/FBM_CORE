xmlport 60109 FBM_ListValues
{
    Direction = Export;
    Format = VariableText;
    FileName = 'ListValues.bak';
    schema
    {
        textelement(cust)
        {
            tableelement(FBM_ListValues; FBM_ListValues)
            {
                fieldattribute(Type; FBM_ListValues.Type) { }
                fieldattribute(Ord; FBM_ListValues.Ord) { }
                fieldattribute(Value; FBM_ListValues.Value) { }
                fieldattribute(IsDefault; FBM_ListValues.IsDefault) { }


            }
        }
    }
}
