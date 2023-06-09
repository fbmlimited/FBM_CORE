pageextension 60135 PageExtension50087 extends "Assembly Order Subform"
{
    layout
    {
        addafter("Appl.-from Item Entry")
        {
            field("Shortcut Dimension 1 Code09863"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Shortcut Dimension 2 Code94792"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
