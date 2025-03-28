xmlport 60108 FBM_FAHistory_DD
{
    Direction = Export;
    Format = VariableText;
    FileName = 'FAHistory_DD.bak';
    schema
    {
        textelement(cust)
        {
            tableelement(FBM_FAHistory_DD; FBM_FAHistory_DD)
            {
                fieldattribute(No; FBM_FAHistory_DD."No.") { }
                fieldattribute(Description; FBM_FAHistory_DD.Description) { }
                fieldattribute(FAClassCode; FBM_FAHistory_DD."FA Class Code") { }
                fieldattribute(FASubclassCode; FBM_FAHistory_DD."FA Subclass Code") { }
                fieldattribute(FALocationCode; FBM_FAHistory_DD."FA Location Code") { }
                fieldattribute(SerialNo; FBM_FAHistory_DD."Serial No.") { }
                fieldattribute(FBM_Site; FBM_FAHistory_DD.FBM_Site) { }
                fieldattribute(FBM_Status; FBM_FAHistory_DD.FBM_Status) { }
                fieldattribute(FBM_DatePrepared; FBM_FAHistory_DD.FBM_DatePrepared) { }
                fieldattribute(FBM_Brand; FBM_FAHistory_DD.FBM_Brand) { }
                fieldattribute(FBM_Lessee; FBM_FAHistory_DD.FBM_Lessee) { }
                fieldattribute(FBM_Model; FBM_FAHistory_DD.FBM_Model) { }
                fieldattribute(FBM_Segment2; FBM_FAHistory_DD.FBM_Segment2) { }
                fieldattribute(ValidFrom; FBM_FAHistory_DD."Valid From") { }
                fieldattribute(ValidTo; FBM_FAHistory_DD."Valid To") { }
                fieldattribute(RecordOwner; FBM_FAHistory_DD."Record Owner") { }
                fieldattribute(ChangeNote; FBM_FAHistory_DD."Change Note") { }
                fieldattribute(Version; FBM_FAHistory_DD.Version) { }
                fieldattribute(ActiveRec; FBM_FAHistory_DD.ActiveRec) { }
                fieldattribute(FBM_AcquisitionCost; FBM_FAHistory_DD.FBM_AcquisitionCost) { }
                fieldattribute(FBM_AcquisitionDate; FBM_FAHistory_DD.FBM_AcquisitionDate) { }

            }
        }
    }
}
