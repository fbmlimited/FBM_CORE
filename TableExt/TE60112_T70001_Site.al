tableextension 60112 FBM_SiteExt_CO extends FBM_Site
{
    fields
    {

    }
    var
        FADimMgt: Codeunit FBM_FixedAssetDimMgt_CO;
        Text002: Label 'You cannot delete this site - it has been used in posted transactions!';
        Text003: Label 'You cannot delete this site - it is being used in %1!';

    trigger OnInsert()
    begin
        //check for unique site code
        CheckUniqueSite(Rec."Site Code");
        // FADimMgt.CreateSiteDim2(Rec);

    end;

    // trigger OnModify()
    // begin
    //     FADimMgt.UpdateSiteDim2(Rec);
    // end;

    // trigger OnDelete()
    // var
    //     DimensionSetEntry: Record "Dimension Set Entry";
    //     DimensionValue: Record "Dimension Value";
    //     FASetup: Record "FA Setup";
    //     SalesHeader: Record "Sales Header";
    // begin
    //     DimensionSetEntry.Reset();
    //     DimensionValue.Reset();
    //     SalesHeader.Reset();
    //     SalesHeader.Reset();
    //     SalesHeader.SetFilter(fbm_site, Rec."Site Code");
    //     if SalesHeader.FindFirst() then Error(Text003, SalesHeader."No.");
    //     DimensionSetEntry.SetFilter(DimensionSetEntry."Dimension Code", FASetup."FBM_Site Dimension");
    //     DimensionSetEntry.SetFilter(DimensionSetEntry."Dimension Value Code", Rec."Site Code");
    //     if DimensionSetEntry.FindFirst() then error(Text002);
    //     if DimensionValue.Get(FASetup."FBM_Site Dimension", Rec."Site Code") then begin
    //         DimensionValue.Validate(Blocked, true);
    //         DimensionValue.Modify();
    //     end;
    // end;

    // trigger OnRename()
    // begin
    //     FADimMgt.RenameSiteDim2(xRec, Rec);
    // end;


}