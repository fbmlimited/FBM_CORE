report 60147 FBM_ImporFA_CO
{
    Caption = 'Import FA';
    //UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; "Company Information")
        {

        }
    }

    trigger

    OnPreReport()
    begin
        fasetup.Get();
        fa.ChangeCompany(fasetup."FBM_FA Company");
        fa.SetRange("FA Subclass Code", fasetup.FBM_FAsubclassImport);
        if fa.FindFirst() then
            repeat
                faloc.SetRange("No.", fa."No.");
                if faloc.findfirst then begin
                    if fa.version > faloc.Version then begin
                        faloc."No." := fa."No.";
                        faloc.Description := fa.Description;
                        faloc."Serial No." := fa."Serial No.";
                        faloc."FA Class Code" := fa."FA Class Code";
                        faloc."FA Subclass Code" := fa."FA Subclass Code";
                        faloc."FA Location Code" := fa."FA Location Code";
                        faloc.FBM_Model := fa.FBM_Model;
                        faloc.FBM_Segment2 := fa.FBM_Segment2;
                        faloc.FBM_Brand := fa.FBM_Brand;
                        faloc.FBM_Lessee := fa.FBM_Lessee;
                        faloc.FBM_Site := fa.FBM_Site;
                        faloc.FBM_Status := fa.FBM_Status;
                        faloc.FBM_DatePrepared := fa.FBM_DatePrepared;
                        faloc.FBM_AcquisitionCost := fa.FBM_AcquisitionCost;
                        faloc.FBM_AcquisitionDate := fa.FBM_AcquisitionDate;
                        faloc.FBM_DepreciationDate := fa.FBM_DepreciationDate;
                        faloc.Version := fa.Version;
                        faloc.Modify();
                    end;
                end
                else begin
                    faloc.init;
                    faloc."No." := fa."No.";
                    faloc.Description := fa.Description;
                    faloc."Serial No." := fa."Serial No.";
                    faloc."FA Class Code" := fa."FA Class Code";
                    faloc."FA Subclass Code" := fa."FA Subclass Code";
                    faloc."FA Location Code" := fa."FA Location Code";
                    faloc.FBM_Model := fa.FBM_Model;
                    faloc.FBM_Segment2 := fa.FBM_Segment2;
                    faloc.FBM_Brand := fa.FBM_Brand;
                    faloc.FBM_Lessee := fa.FBM_Lessee;
                    faloc.FBM_Site := fa.FBM_Site;
                    faloc.FBM_Status := fa.FBM_Status;
                    faloc.FBM_DatePrepared := fa.FBM_DatePrepared;
                    faloc.FBM_AcquisitionCost := fa.FBM_AcquisitionCost;
                    faloc.FBM_AcquisitionDate := fa.FBM_AcquisitionDate;
                    faloc.FBM_DepreciationDate := fa.FBM_DepreciationDate;
                    faloc.Version := fa.Version;
                    faloc.Insert();
                end;
            until fa.Next() = 0;

    end;

    var
        fasetup: record "FA Setup";
        fa: record "Fixed Asset";
        faloc: record "Fixed Asset";


}