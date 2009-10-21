{-----------------------------------------------------------------------------
 Purpose: Form to select which help should be showed 
 
 (c) by TheUnknownOnes
 see http://www.TheUnknownOnes.net
-----------------------------------------------------------------------------}

unit uCustomHelpSelector;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  HelpIntfs,
  OleCtrls,
  StdCtrls,
  ExtCtrls,
  ActiveX,
  mshtml,
  ComCtrls,
  CategoryButtons;

type
  TFormHelpSelector = class(TForm)
    catbtnTopics:     TCategoryButtons;
    cbFullTextSearch: TCheckBox;
    grpErrors:        TGroupBox;
    mmoErrors:        TMemo;
    cbbSearchKeyword: TComboBox;
    pnlSearchKeyword: TPanel;
    lblSearchKeyword: TLabel;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBox1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListBox1Editing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure catbtnTopicsDrawText(Sender: TObject; const Button: TButtonItem;
      Canvas: TCanvas; Rect: TRect; State: TButtonDrawState);
    procedure catbtnTopicsButtonClicked(Sender: TObject; const Button: TButtonItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbSearchKeywordCloseUp(Sender: TObject);
  private
    FURL:       string;
    FHelpIndex: Integer;
    procedure InitList(Keywords: TStrings);
    procedure SaveExpanded;
  public
    property URL: string read FURL;
    property SelectedHelpIndex: Integer read FHelpIndex;

    class function Execute(HelpString: string; Keywords: TStrings;
      out SelectedIndex: Integer; out SelectedUrl: string): Boolean; overload; static;
    class function Execute(HelpString: string; Keywords: TStrings;
      out SelectedIndex: Integer; out SelectedUrl: string;
      out SelectedKeyword: string): Boolean; overload; static;
  end;

  //This class must not contain any local fields
  //applies only to BDS 2006
  THelpSelector = class(TInterfacedObject, IHelpSelector, IHelpSelector2)
  protected
    function SelectKeyword(Keywords: TStrings): Integer;
    function TableOfContents(Contents: TStrings): Integer;
    function SelectContext(Viewers: TStrings): Integer;
  end;

implementation

uses
  UrlMon,
  StrUtils,
  ComObj,
  ShellAPI,
  uCustomHelpMain,
  uCustomHelpIDEIntegration,
  Math,
  Registry,
  uCustomHelpKeywordRecorder,
  uCustomHelpIntfs;

{$R *.dfm}

const
  CAPTION_INDEXCHECK    =
    'Index search performed (check me to perform fulltext search next time)';
  CAPTION_FULLTEXTCHECK =
    'Fulltext search performed (uncheck me to perform index search next time)';

type
  TCustomHelpButtonItem = class(TButtonItem)
  private
    FDesc: string;
    FURL:  string;
    FIdx:  Integer;
    FTO:   TNamespaceTrimOption;
  public
    property URL: string read FURL write FURL;
    property Description: string read FDesc write FDesc;
    property HelpIndex: Integer read FIdx write FIdx;
    property TrimOption: TNamespaceTrimOption read FTO write FTO;
  end;

type
  THelpViewerNodeAccess = class(TObject)
  private
    FViewer:   ICustomHelpViewer;
    FViewerID: Integer;
  end;

var
  GlobalCustomHelpViewerNode: THelpViewerNodeAccess;

procedure TFormHelpSelector.catbtnTopicsButtonClicked(Sender: TObject;
  const Button: TButtonItem);
var
  CustomButton: TCustomHelpButtonItem;
begin
  if catbtnTopics.SelectedItem <> Button then
    exit;

  if Button.Category.Collapsed then
    Button.Category.Collapsed := False
  else if Button is TCustomHelpButtonItem then
  begin
    CustomButton := TCustomHelpButtonItem(Button);
    FHelpIndex   := CustomButton.HelpIndex;
    FURL         := CustomButton.URL;
    SaveExpanded;
    ModalResult  := mrOk;
  end;
end;

procedure TFormHelpSelector.catbtnTopicsDrawText(Sender: TObject;
  const Button: TButtonItem; Canvas: TCanvas; Rect: TRect; State: TButtonDrawState);
var
  drawrect: TRect;
  txt:      string;
begin
  drawrect := Rect;
  Canvas.Font.Style := [fsBold];
  txt := TCustomHelpButtonItem(Button).Caption;
  drawRect.Right := drawrect.Left + (catbtnTopics.Width * 2 div 3);
  Canvas.TextRect(drawrect, txt, [tfEndEllipsis]);

  drawrect      := Rect;
  Canvas.Font.Style := [];
  txt           := TCustomHelpButtonItem(Button).Description;
  drawRect.Left := drawrect.Left + (catbtnTopics.Width * 2 div 3);
  Canvas.TextRect(drawrect, txt, [tfEndEllipsis]);
end;

procedure TFormHelpSelector.cbbSearchKeywordCloseUp(Sender: TObject);
begin
  catbtnTopics.SetFocus;
end;

class function TFormHelpSelector.Execute(HelpString: string;
  Keywords: TStrings; out SelectedIndex: Integer; out SelectedUrl: string): Boolean;
var
  SelectedKeyword: string;
begin
  Result := TFormHelpSelector.Execute(HelpString, Keywords, SelectedIndex,
    selectedUrl, SelectedKeyword);
end;

class function TFormHelpSelector.Execute(HelpString: string;
  Keywords: TStrings; out SelectedIndex: Integer; out SelectedUrl: string;
  out SelectedKeyword: string): Boolean;
var
  SearchKeywords: TStrings;
  fhs: TFormHelpSelector;
begin
  Result        := False;
  SelectedIndex := -1;
  SelectedUrl   := '';

  fhs := TFormHelpSelector.Create(Application.MainForm);
  with fhs do
  begin
    try
      GlobalCustomHelpViewerNode.FViewer   := HelpViewerIntf;
      GlobalCustomHelpViewerNode.FViewerID := GlobalCustomHelp.GetViewerID;
      InitList(Keywords);

      with catbtnTopics.Categories[0] do
      begin
        if Items.Count > 0 then
        begin
          ScrollIntoView;
          catbtnTopics.SelectedItem := Items[0];
          catbtnTopics.FocusedItem  := Items[0];
        end;
      end;

      cbbSearchKeyword.Items.Assign(CustomHelpKeywordRecorderIntf.GetKeywordList);
      SearchKeywords           := cbbSearchKeyword.Items;
      pnlSearchKeyword.Visible := SearchKeywords.Count > 1;
      if SearchKeywords.Count = 0 then
        cbbSearchKeyword.Items.Add(HelpString);

      cbbSearchKeyword.ItemIndex := cbbSearchKeyword.Items.IndexOf(HelpString);
      if cbbSearchKeyword.ItemIndex < 0 then
        cbbSearchKeyword.ItemIndex := 0;
      if cbbSearchKeyword.ItemIndex >= 0 then
        cbbSearchKeyword.Text := SearchKeywords[cbbSearchKeyword.ItemIndex];

      // clear keyword history before showing help select form ...
      CustomHelpKeywordRecorderIntf.Reset;
      CustomHelpKeywordRecorderIntf.SetEnabled(False);

      Caption := StringReplace(Caption, '@@HELPSTRING@@', HelpString, [rfReplaceAll]);

      if (ShowModal = mrOk) then
      begin
        Result          := True;
        SelectedIndex   := SelectedHelpIndex;
        SelectedUrl     := URL;
        SelectedKeyword := cbbSearchKeyword.Text;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFormHelpSelector.InitList(Keywords: TStrings);
var
  cat:           TButtonCategory;
  idx:           Integer;
  c, d, u, g, kw: string;
  item:          TCustomHelpButtonItem;
  Reg:           TRegistry;
  CheckExpanded: Boolean;
  TrimOption:    TNamespaceTrimOption;
  ANode:         THelpViewerNodeAccess;
  AProvider:     ICustomHelpProvider;

  function GetCategoryFromLabel(ALabel: string;
    ACreate: Boolean = True): TButtonCategory;
  var
    i: Integer;
  begin
    Result := nil;

    for i := 0 to catbtnTopics.Categories.Count - 1 do
      if catbtnTopics.Categories[i].Caption = ALabel then
      begin
        Result := catbtnTopics.Categories[i];
        break;
      end;

    if not Assigned(Result) and ACreate then
    begin
      Result           := catbtnTopics.Categories.Add;
      Result.Caption   := ALabel;
      Result.Color     := clActiveCaption;
      Result.TextColor := clCaptionText;
      Result.Collapsed := True;
      if CheckExpanded then
        Result.Collapsed := Reg.ReadString(ALabel) = '0';
    end;
  end;

  function CustomURLExists(AURL: string): Boolean;
  var
    jdx: Integer;
  begin
    Result := False;
    if AURL = '' then
      Exit;
    AURL := '|' + AURL + '|';
    for jdx := 0 to Keywords.Count - 1 do
      if Pos(AURL, Keywords[jdx]) > 0 then
      begin
        Result := True;
        Exit;
      end;
  end;

  function GetNode(Index: Integer): THelpViewerNodeAccess;
  begin
    Result := THelpViewerNodeAccess(Keywords.Objects[Index]);
  end;

  procedure GetViewerName(ANode: THelpViewerNodeAccess; var Group: string);
  begin
    if ANode.FViewer <> nil then
      Group := ANode.FViewer.GetViewerName;
  end;

begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;

    CheckExpanded := Reg.OpenKey(REG_ROOT_KEY + EXPANDEDITEMS_SUB_KEY, True);

    for idx := 0 to Keywords.Count - 1 do
    begin
      kw    := Keywords[idx];
      ANode := GetNode(idx);
      if AnsiStartsText(PROTPREFIX_CUSTOMHELP, kw) then
      begin
        if not TCustomHelp.DecodeURL(kw, c, d, u, g, TrimOption) then
          Continue;
      end
      else if CustomURLExists(kw) then
      begin
        // ignore duplicate url
        Continue;
      end
      else if AnsiStartsText(PROTPREFIX_MSHELP, kw) then
      begin
        if not TCustomHelp.DecodeURL(kw, c, d, u, g, TrimOption) then
          Continue;
        if g = GROUP_LABEL_STANDARD then
          GetViewerName(ANode, g);
        // replace default viewer?
        if GlobalCustomHelp.ReplaceDefaultViewer then
          Keywords.Objects[idx] := GlobalCustomHelpViewerNode;
      end
      else if Supports(ANode.FViewer, ICustomHelpProvider, AProvider) then
      begin
        // e.g. madHelp of madCollection
        if not AProvider.TranslateHelpString(kw, c, d, u, g) then
          Continue;
        TrimOption := nstoNoTrim;
        kw         := GlobalCustomHelp.EncodeURL(c, d, u, g, TrimOption);
      end
      else
      begin
        c          := kw;
        d          := '';
        u          := kw;
        g          := GROUP_LABEL_STANDARD;
        GetViewerName(ANode, g);
        TrimOption := nstoNoTrim;
      end;

      cat          := GetCategoryFromLabel(g);
      item         := TCustomHelpButtonItem.Create(cat.Items);
      item.Caption := c;
      item.Description := d;
      item.URL     := kw;
      item.HelpIndex := idx;
      item.TrimOption := TrimOption;
    end;



    // move standard group to end of category button list
    // if the user wishes so
    cat := GetCategoryFromLabel(GROUP_LABEL_DEFAULT, False);
    if (cat <> nil) then
      if not GlobalCustomHelp.ShowOHSAtTop then
        cat.Index := catbtnTopics.Categories.Count - 1
      else
        cat.Index := 0;

    // move default group to end of category button list
    cat := GetCategoryFromLabel(GROUP_LABEL_STANDARD, False);
    if cat <> nil then
      cat.Index := catbtnTopics.Categories.Count - 1;

    Reg.CloseKey;
  finally
    Reg.Free;
  end;
end;

function THelpSelector.SelectContext(Viewers: TStrings): Integer;
begin
  Result := Viewers.IndexOf(HelpViewerIntf.GetViewerName);
end;

function THelpSelector.SelectKeyword(Keywords: TStrings): Integer;
var
  u, l: string;
  SearchKeyword: string;
  hv:  IExtendedHelpViewer;
  prv: ICustomHelpProvider;
begin
  if not TFormHelpSelector.Execute(GlobalCustomHelp.LastHelpCallKeyword,
    Keywords, Result, u, SearchKeyword) then
  begin
    Result := -1;
    Exit;
  end;

  if not GlobalCustomHelp.IsHandledByDefaultViewer(Keywords[Result]) then
  begin
    GlobalCustomHelp.ShowHelp(Keywords[Result], SearchKeyword);
    Result := -1;
    Exit;
  end;

  with THelpViewerNodeAccess(Keywords.Objects[Result]) do
  begin
    if FViewer = HelpViewerIntf then
    begin
      GlobalCustomHelp.ShowHelp(Keywords[Result], SearchKeyword);
      Result := -1;
      Exit;
    end;
    if GlobalCustomHelp.DecodeURL(u, l) then
    begin
      GlobalCustomHelp.ShowHelp(u, SearchKeyword);
      Result := -1;
      Exit;
    end;
    if Supports(FViewer, ICustomHelpProvider, prv) then
    begin
      prv.ShowCustomHelp(Keywords[Result]);
      Result := -1;
      Exit;
    end;
    if Supports(FViewer, IExtendedHelpViewer, hv) then
    begin // fix call of viewer by default help system ...
      hv.DisplayTopic(Keywords[Result]);
      Result := -1;
      Exit;
    end;
  end;
end;

function THelpSelector.TableOfContents(Contents: TStrings): Integer;
begin
  Result := Contents.IndexOf(HelpViewerIntf.GetViewerName);
end;

procedure TFormHelpSelector.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GlobalCustomHelp.PerformFullTextSearch := cbFullTextSearch.Checked;
  Action := caHide;
end;

procedure TFormHelpSelector.FormCreate(Sender: TObject);
begin
  cbFullTextSearch.Checked := GlobalCustomHelp.PerformFullTextSearch;
  if cbFullTextSearch.Checked then
    cbFullTextSearch.Caption := CAPTION_FULLTEXTCHECK
  else
    cbFullTextSearch.Caption := CAPTION_INDEXCHECK;

  mmoErrors.Text    := GlobalCustomHelp.LastHelpErrors;
  grpErrors.Visible := mmoErrors.Text <> '';
  if not grpErrors.Visible then
    Height := Height - grpErrors.Height;
end;

procedure TFormHelpSelector.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ActiveControl = cbbSearchKeyword then
  begin
    if (Key = VK_ESCAPE) then
    begin
      if cbbSearchKeyword.DroppedDown then
        cbbSearchKeyword.DroppedDown := False;
      Key := 0;
    end;
  end
  else
  begin
    if (Key = VK_ESCAPE) then
    begin
      ModalResult := mrCancel;
      Key         := 0;
    end
    else if (Key = VK_INSERT) and cbbSearchKeyword.Visible then
    begin
      cbbSearchKeyword.SetFocus;
      cbbSearchKeyword.DroppedDown := True;
      Key := 0;
    end;
  end;
end;

procedure TFormHelpSelector.FormShow(Sender: TObject);
begin
  catbtnTopics.FocusedItem := catbtnTopics.SelectedItem;
end;

procedure TFormHelpSelector.ListBox1Compare(Sender: TObject;
  Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  Compare := CompareValue(Integer(Item1.Data), Integer(Item2.Data));
end;

procedure TFormHelpSelector.ListBox1Editing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  AllowEdit := False;
end;

procedure TFormHelpSelector.SaveExpanded;
var
  Reg: TRegistry;
  idx: Integer;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;

    if Reg.OpenKey(REG_ROOT_KEY + EXPANDEDITEMS_SUB_KEY, True) then
    begin
      for idx := 0 to catbtnTopics.Categories.Count - 1 do
        Reg.WriteString(catbtnTopics.Categories[idx].Caption,
          ifthen(catbtnTopics.Categories[idx].Collapsed, '0', '1'));

      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

initialization
  GlobalCustomHelpViewerNode := THelpViewerNodeAccess.Create;

finalization
  GlobalCustomHelpViewerNode.Free;

end.
