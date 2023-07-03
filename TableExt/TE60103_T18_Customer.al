tableextension 60103 FBM_CustomerExt_CO extends Customer
{

    fields
    {


        field(60100; "FBM_Current Month_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_0D Date Filter")));
            Caption = 'Current Month';
            Description = 'Current Month-30D';
            Editable = false;
            FieldClass = FlowField;
        }

        field(60101; "FBM_1 Month_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_30D Date Filter")));
            Caption = '1 Month';
            Description = '30-60D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60102; "FBM_2 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_60D Date Filter")));
            Caption = '2 Months';
            Description = '60-90D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60103; "FBM_3 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_90D Date Filter")));
            Caption = '3 Months';
            Description = '90-120D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60104; "FBM_4 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_120D Date Filter")));
            Caption = '4 Months';
            Description = '120-150D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60105; "FBM_5 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_150D Date Filter")));
            Caption = '5 Months';
            Description = '150-180D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60106; "FBM_6 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_180D Date Filter")));
            Caption = '6 Months';
            Description = '180-210D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60107; "FBM_0D Date Filter"; Date)
        {
            Caption = '0D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60108; "FBM_30D Date Filter"; Date)
        {
            Caption = '30D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60109; "FBM_60D Date Filter"; Date)
        {
            Caption = '60D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60110; "FBM_90D Date Filter"; Date)
        {
            Caption = '90D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60111; "FBM_120D Date Filter"; Date)
        {
            Caption = '120D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60112; "FBM_150D Date Filter"; Date)
        {
            Caption = '150D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60113; "FBM_180D Date Filter"; Date)
        {
            Caption = '180D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60114; "FBM_7 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_210D Date Filter")));
            Caption = '7 Months';
            Description = '210-240D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60115; "FBM_8 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_240D Date Filter")));
            Caption = '8 Months';
            Description = '240-270D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60116; "FBM_9 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_270D Date Filter")));
            Caption = '9 Months';
            Description = '270-300D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60117; "FBM_10 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_300D Date Filter")));
            Caption = '10 Months';
            Description = '300-330D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60118; "FBM_11 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_330D Date Filter")));
            Caption = '11 Months';
            Description = '330-360D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60119; "FBM_12 Months_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = FILTER("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_360D Date Filter")));
            Caption = '12 Months';
            Description = '360-390D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60120; "FBM_210D Date Filter"; Date)
        {
            Caption = '210D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60121; "FBM_240D Date Filter"; Date)
        {
            Caption = '240D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60122; "FBM_270D Date Filter"; Date)
        {
            Caption = '270D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60123; "FBM_300D Date Filter"; Date)
        {
            Caption = '300D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60124; "FBM_330D Date Filter"; Date)
        {
            Caption = '330D Date Filter';

            FieldClass = FlowFilter;
        }
        field(60125; "FBM_360D Date Filter"; Date)
        {
            Caption = '360D Date Filter';

            FieldClass = FlowFilter;
        }


        field(60126; "FBM_Amounts Not Due_FF"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Initial Document Type" = CONST("Invoice"),
                                                                                 "Initial Entry Due Date" = FIELD("FBM_Future Date Filter")));
            Caption = 'Current Month';
            Description = 'Current Month-30D';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60127; "FBM_Future Date Filter"; Date)
        {
            Caption = '0D Date Filter';

            FieldClass = FlowFilter;
        }



    }


}
