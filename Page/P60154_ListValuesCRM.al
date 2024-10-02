page 60154 FBM_ListValue_CO
{
    Caption = ' Values List for CRM';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_ListValues;

    layout
    {


        area(Content)
        {

            group(header)
            {
                field(ptype; ptype)
                {


                    trigger
                    OnValidate()
                    begin
                        rec.SetFilter(type, FORMAT(ptype));
                    end;
                }
            }
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Width = 20;
                }
                field(Ord; Rec.Ord)
                {
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                }

            }


        }
    }

    var
        ptype: option COMMENTTYPE,LEVEL,DEPARTMENT;

    trigger
    OnOpenPage()
    begin
        rec.SetRange(type, 'XYZ');
    end;

    trigger
    OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        REC.TYPE := FORMAT(ptype);
    end;
}