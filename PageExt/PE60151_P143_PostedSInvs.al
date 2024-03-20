pageextension 60151 FBM_PostSInvsExt_CO extends "Posted Sales Invoices"
{

    layout
    {

        addafter("Location Code")
        {
            field("User ID77263"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("Posting Description63170"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {

            field("FBM_Billing Statement"; Rec."FBM_Billing Statement")
            {
                ApplicationArea = all;
            }
        }
        modify("Document Date")
        {
            Visible = true;
        }
        modify("Posting Date")
        {
            Visible = true;
        }

    }
    actions
    {
        addfirst(Navigation)
        {
            action("Print Billing Statement")
            {
                ApplicationArea = all;
                // RunObject = Report "NTT Sales - Billing Statement";

                Image = Print;
                trigger OnAction()
                var
                    rep: report "FBM_NTT Sales - BillStat_CO";
                    currentdoc: Record "Sales Invoice Header";
                    rep1: report "FBM_NTT SALES BILLING NEW_CO";

                begin
                    currentdoc.SetRange("No.", rec."No.");




                    if (currentdoc.FindFirst()) then begin
                        rep.SetTableView(currentdoc);
                        rep1.SetTableView(currentdoc);
                        //Message(CompanyName);
                        if (CompanyName = 'D2R Ltd Branch') then
                            rep1.Run()
                        else
                            rep.Run();

                    end;

                end;

            }
        }
        // addafter(Print)
        // {
        //     action(Print2)
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Caption = '&Print';
        //         Ellipsis = true;
        //         Image = Print;
        //         ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
        //         //Visible = NOT IsOfficeAddin;

        //         trigger OnAction()
        //         var
        //             SalesInvHeader: Record "Sales Invoice Header";
        //         begin
        //             SalesInvHeader := Rec;
        //             CurrPage.SetSelectionFilter(SalesInvHeader);
        //             if SalesInvHeader.count > 1 then
        //                 error('It is allowed printing only one invoice at time .')
        //             else
        //                 SalesInvHeader.PrintRecords(true);
        //         end;
        //     }
        // }
        // modify(Print)
        // {
        //     Visible = false;
        // }
        // addfirst(Category_Category7)
        // {
        //     actionref(Print_Promoted2; Print2)
        //     {
        //     }
        // }

    }

}
