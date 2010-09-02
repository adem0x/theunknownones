object ch2FormConfigRSSSearch: Tch2FormConfigRSSSearch
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Configure RSS Search'
  ClientHeight = 510
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 479
    Width = 424
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btn_OK: TButton
      AlignWithMargins = True
      Left = 346
      Top = 3
      Width = 75
      Height = 25
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 418
    Height = 54
    Align = alTop
    Caption = 'Priority'
    TabOrder = 1
    object ed_Prio: TSpinEdit
      Left = 11
      Top = 21
      Width = 70
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = ed_PrioChange
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 63
    Width = 418
    Height = 413
    Align = alClient
    Caption = 'URL'#39's'
    TabOrder = 2
    object LV: TListView
      AlignWithMargins = True
      Left = 5
      Top = 46
      Width = 408
      Height = 269
      Align = alClient
      Columns = <
        item
          Caption = 'Name'
          Width = 100
        end
        item
          AutoSize = True
          Caption = 'URL'
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnAdvancedCustomDrawItem = LVAdvancedCustomDrawItem
      OnSelectItem = LVSelectItem
    end
    object Panel2: TPanel
      Left = 2
      Top = 318
      Width = 414
      Height = 93
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 9
        Top = 6
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object Label3: TLabel
        Left = 9
        Top = 33
        Width = 23
        Height = 13
        Caption = 'URL:'
      end
      object Label6: TLabel
        Left = 206
        Top = 6
        Width = 51
        Height = 13
        Caption = 'ForeColor:'
      end
      object Label7: TLabel
        Left = 206
        Top = 33
        Width = 51
        Height = 13
        Caption = 'BackColor:'
      end
      object Label8: TLabel
        Left = 46
        Top = 57
        Width = 150
        Height = 26
        Caption = '"$(HelpString)" will be replaced with the helpstring'
        WordWrap = True
      end
      object Label9: TLabel
        Left = 216
        Top = 61
        Width = 41
        Height = 13
        Caption = 'Open in:'
      end
      object ed_Name: TEdit
        Left = 46
        Top = 3
        Width = 154
        Height = 21
        TabOrder = 0
        OnChange = ed_NameChange
      end
      object ed_URL: TEdit
        Left = 46
        Top = 30
        Width = 154
        Height = 21
        TabOrder = 1
        OnChange = ed_URLChange
      end
      object cob_URLForeColor: TColorBox
        Left = 263
        Top = 3
        Width = 142
        Height = 22
        NoneColorColor = clNone
        Selected = clNone
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbCustomColor]
        ItemHeight = 16
        TabOrder = 2
        OnChange = cob_URLForeColorChange
      end
      object cob_URLBackColor: TColorBox
        Left = 263
        Top = 30
        Width = 142
        Height = 22
        NoneColorColor = clNone
        Selected = clNone
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbCustomColor]
        ItemHeight = 16
        TabOrder = 3
        OnChange = cob_URLBackColorChange
      end
      object com_Location: TComboBox
        Left = 263
        Top = 58
        Width = 142
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnChange = com_LocationChange
      end
    end
    object ToolBar1: TToolBar
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 408
      Height = 22
      Caption = 'ToolBar1'
      Images = iml_TB
      TabOrder = 2
      object btn_Add: TToolButton
        Left = 0
        Top = 0
        Caption = 'btn_Add'
        ImageIndex = 0
        OnClick = btn_AddClick
      end
      object btn_Del: TToolButton
        Left = 23
        Top = 0
        Caption = 'btn_Del'
        ImageIndex = 1
        OnClick = btn_DelClick
      end
    end
  end
  object iml_TB: TImageList
    Left = 288
    Top = 96
    Bitmap = {
      494C010102000800940010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DADBDB630BB019FF0BB019FF0BB019FF0BB019FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000BB019FF05BF14FF00B20CFF00A806FF56C357FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000BB019FF0DC920FF06BF15FF00B50CFF56CB5BFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000BB019FF1BD334FF10CA20FF07C017FF57D561FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000BB019FF2BDA53FF1BD436FF11CC22FF5CDD68FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000BB019FF39E16AFF2BDA54FF1ED53AFF63E471FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004AE963FF64ED80FF70F392FF75F4
      97FF75F697FF7AEB9FFF45E47BFF3AE16AFF2DDC56FF6AE37EFF63E671FF5DE1
      69FF59DB62FF56D35DFF56CC59FF0BB019FF4AE963FF64ED80FF70F392FF75F4
      97FF75F697FF7AEB9FFF77EB9FFF6FE992FF66E584FF5BE071FF54E463FF5DE1
      69FF59DB62FF56D35DFF56CC59FF0BB019FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000041D64DFF1BD336FF28DA4FFF38E0
      68FF46E47BFF4CE581FF47E47CFF46E47CFF3CE26FFF2FDD59FF21D740FF15CF
      28FF0BC61BFF04BB11FF00B10AFF0BB019FF41D64DFF1BD336FF28DA4FFF38E0
      68FF46E47BFF4CE581FF47E47CFF46E47CFF3CE26FFF2FDD59FF21D740FF15CF
      28FF0BC61BFF04BB11FF00B10AFF0BB019FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003DD249FF11CB22FF1AD331FF27DA
      4EFF36E064FF45E479FF52E789FF52E889FF4BE580FF3DE170FF30DD5BFF22D7
      43FF16D029FF0BC71CFF04BC14FF0BB019FF3DD249FF11CB22FF1AD331FF27DA
      4EFF36E064FF45E479FF52E789FF52E889FF4BE580FF3DE170FF30DD5BFF22D7
      43FF16D029FF0BC71CFF04BC14FF0BB019FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000039CD45FF0AC51BFF10CB21FF18D1
      2FFF25D848FF34DF61FF43E376FF51E787FF54E98BFF55E98CFF4CE681FF3CE2
      6EFF2BDB53FF1BD336FF0FC921FF0BB019FF39CD45FF0AC51BFF10CB21FF18D1
      2FFF25D848FF34DF61FF43E376FF51E787FF54E98BFF55E98CFF4CE681FF3CE2
      6EFF2BDB53FF1BD336FF0FC921FF0BB019FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000039207FF039207FF039207FF0392
      07FF039207FF039207FF32DF5EFF42E376FF4FE685FF77EEA4FF08A412FF08A4
      12FF08A412FF08A412FF08A412FFDADBDB63039207FF039207FF039207FF0392
      07FF039207FF039207FF039207FF039207FF039207FF05980BFF079B0CFF07A0
      0FFF08A411FF08A412FF08A412FFDADBDB630000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000039207FF21D641FF30DD5DFF3FE272FF7AF7A9FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000039207FF14CF27FF20D741FF2DDD57FF6DF299FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000039207FF0EC91FFF14CE27FF1FD63EFF5DEE83FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000039207FF09C318FF0DC81EFF13CC24FF4FE86AFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000039207FF36C942FF39CE46FF3DD24AFF43E053FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F83FFFFF00000000F83FFFFF00000000
      F83FFFFF00000000F83FFFFF00000000F83FFFFF00000000F83FFFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000F83FFFFF00000000F83FFFFF00000000F83FFFFF00000000
      F83FFFFF00000000F83FFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
