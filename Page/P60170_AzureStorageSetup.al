page 60170 "Azure Storage Setup"
{

    Caption = 'Azure Storage Setup';
    PageType = Card;
    SourceTable = "Azure Storage Setup";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account URL"; Rec."Account URL")
                {
                    ToolTip = 'Specifies the value of the Account URL field';
                    ApplicationArea = All;
                }
                field(Container; Rec.Container)
                {
                    ToolTip = 'Specifies the value of the Container Name field';
                    ApplicationArea = All;
                }
                field("SAS Token"; Rec."SAS Token")
                {
                    ToolTip = 'Specifies the value of the SAS Token field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
