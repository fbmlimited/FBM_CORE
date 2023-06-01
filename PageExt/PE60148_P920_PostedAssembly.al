pageextension 60148 FBM_PostedAssemblyExt_CO extends "Posted Assembly Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {

        // Add changes to page actions here
        addafter("Print")
        {
            action("Export XML")
            {
                trigger OnAction()
                var
                    xml: XmlPort 60100;
                    currentorder: Record "Posted Assembly Header";
                begin

                    SetSelectionFilter(currentorder);
                    xml.SetTableView(currentorder);
                    xml.Run();

                end;

            }

        }
    }

    var
        myInt: Integer;
}