object ch2FrameHelpItemDecoration: Tch2FrameHelpItemDecoration
  Left = 0
  Top = 0
  Width = 563
  Height = 28
  TabOrder = 0
  TabStop = True
  object Label1: TLabel
    AlignWithMargins = True
    Left = 286
    Top = 3
    Width = 26
    Height = 22
    Align = alRight
    Caption = 'Back:'
    Layout = tlCenter
    ExplicitHeight = 13
  end
  object Label2: TLabel
    AlignWithMargins = True
    Left = 150
    Top = 3
    Width = 26
    Height = 22
    Align = alRight
    Caption = 'Text:'
    Layout = tlCenter
    ExplicitHeight = 13
  end
  object lbl_Caption: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 141
    Height = 22
    Align = alClient
    Alignment = taCenter
    Caption = 'Sample'
    Transparent = False
    Layout = tlCenter
    ExplicitWidth = 34
    ExplicitHeight = 13
  end
  object cb_Bold: TCheckBox
    AlignWithMargins = True
    Left = 422
    Top = 3
    Width = 30
    Height = 22
    Align = alRight
    Caption = 'b'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = cb_BoldClick
  end
  object cb_Italic: TCheckBox
    AlignWithMargins = True
    Left = 458
    Top = 3
    Width = 30
    Height = 22
    Align = alRight
    Caption = 'i '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 1
    OnClick = cb_BoldClick
  end
  object cb_Underline: TCheckBox
    AlignWithMargins = True
    Left = 494
    Top = 3
    Width = 30
    Height = 22
    Align = alRight
    Caption = 'u'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    TabOrder = 2
    OnClick = cb_BoldClick
  end
  object cb_Strike: TCheckBox
    AlignWithMargins = True
    Left = 530
    Top = 3
    Width = 30
    Height = 22
    Align = alRight
    Caption = 's'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsStrikeOut]
    ParentFont = False
    TabOrder = 3
    OnClick = cb_BoldClick
  end
  object cob_Text: TColorBox
    AlignWithMargins = True
    Left = 182
    Top = 3
    Width = 98
    Height = 22
    Align = alRight
    NoneColorColor = clDefault
    Selected = clDefault
    Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColors]
    TabOrder = 4
    OnChange = cob_TextChange
  end
  object cob_Back: TColorBox
    AlignWithMargins = True
    Left = 318
    Top = 3
    Width = 98
    Height = 22
    Align = alRight
    NoneColorColor = clDefault
    Selected = clDefault
    Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColors]
    TabOrder = 5
    OnChange = cob_BackChange
  end
end
