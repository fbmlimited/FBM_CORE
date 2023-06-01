codeunit 60102 FBM_ExtraCheckBeforePost_CO
{
    /*
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostLines', '', true, true)]
        local procedure CopyNewFieldsSLineToSILine(var SalesLine: Record "Sales Invoice Line")
        var
            GlAccount: Record "G/L Account";
            Valid: Boolean;
        begin
            Valid := true;
            if (SalesLine.Type = SalesLine.Type::"G/L Account") AND (SalesLine."No." <> '') then begin
                GlAccount.SetFilter("No.", SalesLine."No.");
                if GlAccount.FindFirst() then
                    if GlAccount."Periods Required" then
                        if (SalesLine."Period Start" = 0D) OR (SalesLine."Period End" = 0D) then
                            Valid := false
            end;

            if NOT (Valid) then
                Error('The period start or period end date of a G/L Account with Periods Required have been left blank.');
        end;
        */
}
