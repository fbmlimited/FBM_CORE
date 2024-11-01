pageextension 60117 FBM_FACardExt_CO extends "Fixed Asset Card"
{
    layout
    {
        modify("Budgeted Asset")
        {

            Enabled = not isegm;

        }
        modify("Main Asset/Component")
        {

            Enabled = not isegm;

        }
        modify("Component of Main Asset")
        {

            Enabled = not isegm;

        }
        modify("Responsible Employee")
        {

            Enabled = not isegm;

        }
        modify(Inactive)
        {

            Enabled = not isegm;

        }
        modify(Maintenance)
        {

            Visible = false;
        }
        addlast(General)
        {
            field(FBM_Model; Rec.FBM_Model)
            {

                Enabled = isegm;
                Editable = false;
                ApplicationArea = all;
            }
            field(FBM_Segment2; Rec.FBM_Segment2)
            {

                Enabled = isegm;
                Editable = false;
                ApplicationArea = all;
            }
            field(FBM_Brand; Rec.FBM_Brand)
            {
                Caption = 'Brand';
                Enabled = isegm;
                Editable = false;
                ApplicationArea = all;
            }
            field(FBM_Lessee; Rec.FBM_Lessee)
            {
                Caption = 'Lessee';
                Enabled = isegm;
                Editable = false;
                ApplicationArea = all;
            }
            field(FBM_Site; Rec.FBM_Site)
            {
                Caption = 'Site Code';
                ApplicationArea = all;
                Enabled = isegm;
                Editable = false;

            }
#if not JYM
            field(siteloccode; siteloccode)
            {
                Caption = 'Site Loc. Code';
                ApplicationArea = all;
                Enabled = isegm;
                Editable = false;
                ;
            }
            field(LastMovementSite; sitename)
            {
                Caption = 'Site Name';
                ApplicationArea = all;
                Enabled = isegm;
                Editable = false;
                ;
            }
            field(custloccode; custloccode)
            {
                Caption = 'Cust. Loc. Code';
                ApplicationArea = all;
                Enabled = isegm;
                Editable = false;
            }
            field(custname; custname)
            {
                Caption = 'Customer Name';
                ApplicationArea = all;
                Enabled = isegm;
                Editable = false;
            }
            field(oploccode; oploccode)
            {
                Caption = 'Op. Loc. Code';
                ApplicationArea = all;
                Enabled = isegm;
                Editable = false;
            }
            field(opname; opname)
            {
                Caption = 'Operator Name';
                ApplicationArea = all;
                Enabled = isegm;
                Editable = false;
            }
#endif
            field(Status; rec.FBM_Status)
            {
                ApplicationArea = all;
                Enabled = isegm;
                Editable = false;
            }
            field(FBM_DatePrepared; Rec.FBM_DatePrepared)
            {
                ApplicationArea = all;
                Enabled = isegm;

            }
            field(FBM_IsLocalRec; Rec.FBM_IsLocalRec)
            {
                ApplicationArea = all;


            }
            field(Version; Rec.Version)
            {
                ApplicationArea = all;


            }
            field(FBM_ReplicaStatus; Rec.FBM_ReplicaStatus2)
            {
                ApplicationArea = all;
                //Editable = false;


            }


        }
        addafter(BookValue)
        {
            field(AcquisitionDate; rec.FBM_AcquisitionDate)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(AcquisitionCost; Rec.FBM_AcquisitionCost)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(DeprDate; Rec.FBM_DepreciationDate)
            {
                ApplicationArea = all;
                Editable = false;
            }

            field(FBM_Subsidiary; Rec.FBM_Subsidiary)
            {
                ApplicationArea = all;
                Enabled = isegm;
                Editable = false;
            }
        }
        addafter("FA Subclass Code")
        {
            field(Is_EGM; rec.FBM_Is_EGM_FF)
            {
                ApplicationArea = all;
            }

        }



        addafter(General)
        {
            group("Linked FA")
            {

                part(LinkedFA; FBM_LinkedFA_CO)
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = Value = FIELD("Serial No.");
                }
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Set initial record")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                image = Process;
                trigger
                OnAction()
                var
                    hist: record FBM_FAHistory_DD;
                begin
                    hist.DeleteAll();
                    rec.FindFirst();
                    if Rec.FindSet() then
                        repeat
                            hist.Init();
                            hist."No." := rec."No.";
                            hist.Description := rec.Description;
                            hist."FA Class Code" := rec."FA Class Code";
                            hist."FA Subclass Code" := rec."FA Subclass Code";
                            hist."FA Location Code" := rec."FA Location Code";
                            hist."Serial No." := rec."Serial No.";
                            hist.FBM_Model := rec.FBM_Model;
                            hist.FBM_Brand := rec.FBM_Brand;
                            hist.FBM_Lessee := rec.FBM_Lessee;
                            hist.FBM_Segment2 := rec.FBM_Segment2;
                            hist.FBM_Site := rec.FBM_Site;
                            hist.FBM_Status := rec.FBM_Status;
                            hist.FBM_DatePrepared := rec.FBM_DatePrepared;
                            hist.Version := 0;
                            hist.ActiveRec := true;
                            hist.Insert();
                            rec.Version := 0;
                            rec.ActiveRec := true;
                            rec.Modify();


                        until Rec.Next() = 0;
                    rec.Reset();

                end;
            }
            action(RecHistory)
            {
                ApplicationArea = All;
                Image = History;

                caption = 'History';

                trigger OnAction()
                var
                    rpage: record FBM_FAHistory_DD;
                    hpage: page FBM_FAHistory_CO;
                begin
                    rpage.SetRange("No.", rec."No.");
                    hpage.SetTableView(rpage);


                    hpage.Run();
                    clear(hpage);
                end;
            }
        }


        addafter(Dimensions)
        {
            action("FA Dimensions")
            {
                ApplicationArea = Dimensions;
                Caption = 'Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                begin
                    clear(FADimP);
                    DefaultDims.SetFilter(DefaultDims."Table ID", '5600');
                    DefaultDims.SetFilter("No.", Rec."No.");
                    FADimP.Editable := false;
                    FADimP.SetTableView(DefaultDims);
                    FADimP.RunModal();

                end;
            }
        }
        modify(Dimensions)
        {
            Visible = false;
        }
    }
    var

        FADimP: Page "Default Dimensions";
        DefaultDims: Record "Default Dimension";
        FAMHEntryNo: Integer;

        LastMovementDate: Date;
        LastMovementSite: Code[250];
        LastMovementOpName: Text[150];
        LastMovementRemarks: Text[250];
        AcquisitionDate: Date;

        SiteCode: Code[20];
        OperatoreCode: Code[20];
        isegm: Boolean;
        custloccode: code[20];
        custname: text[100];
        oploccode: code[20];
        opname: text[100];
        siteloccode: code[20];
        sitename: text[100];
        cust: record FBM_Customer;
        op: record FBM_Customer;


    trigger
    OnAfterGetRecord()
    var
        cos: record FBM_CustOpSite;
        country: record "Country/Region";
        site: record FBM_Site;
        subs: record FBM_Subsidiary;
        cinfo: record "Company Information";
    begin
#if not JYM
        rec.CalcFields(FBM_Is_EGM_FF);
        isegm := rec.FBM_Is_EGM_FF;
        cos.SetRange("Site Code", rec.FBM_Site);
        cos.SetFilter(Subsidiary, '%1', rec.FBM_Lessee + '*');
        if cos.FindFirst() then
            // if site.get(rec.FBM_Site) then
            //     if country.get(site."Country/Region Code") then

            if cust.get(cos."Customer No.") then
                if country.get(cust."Country/Region Code") then
                    subs.SetRange(Country, country.FBM_Country3);
        // subs.SetRange(Lessee, rec.FBM_Lessee);
        // subs.SetRange(EGM_Property, cinfo."Custom System Indicator Text");
        // if subs.FindFirst() then
        //     cos.SetRange(Subsidiary, subs.Subsidiary);
        // if cos.FindFirst() then begin
        custloccode := cos."Cust Loc Code";
        oploccode := cos."Op Loc Code";
        cust.setrange("No.", cos."Customer No.");
        cust.SetRange(ActiveRec, true);
        if cust.FindFirst() then
            custname := cust.Name;
        op.SetRange("No.", cos."Operator No.");
        op.SetRange(ActiveRec, true);
        if op.FindFirst() then
            opname := op.Name;
        siteloccode := cos."Site Loc Code";
        site.setrange("Site Code", cos."Site Code");
        site.SetRange(ActiveRec, true);
        if site.FindFirst() then
            sitename := site."Site Name";
        // end;

#endif
    end;

    trigger OnOpenPage()
    begin

        //rec.SetRange(ActiveRec, true);
        GetAcquisitionDate(Rec);

    end;



    procedure GetAcquisitionDate(FA: Record "Fixed Asset")
    var
        FALE: record "FA Ledger Entry";
    begin
        FALE.Reset();
        FALE.SetCurrentKey("Posting Date");
        FALE.SetFilter(FALE."FA No.", FA."No.");
        FALE.SetFilter(FALE."FA Posting Type", '%1', FALE."FA Posting Type"::"Acquisition Cost");
        if FALE.FindFirst() then
            AcquisitionDate := FALE."Posting Date"
        else
            AcquisitionDate := 0D;
    end;
}
