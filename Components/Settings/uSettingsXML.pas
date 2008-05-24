{----------------------------------------------------------------------------- 
 Project: Settings
 Purpose: Contains components for saving and loading Settings in XML
 Created: 21.05.2008 14:46:24

 (c) by TheUnknownOnes
 see http://www.TheUnknownOnes.net
-----------------------------------------------------------------------------}

unit uSettingsXML;

interface

uses
  Classes,
  SysUtils,
  Variants,
  WideStrings,
  uSettingsBase,     
  MSXML,
  uXMLTools;

type
  TCustomSettingsXML = class(TCustomSettings)
  private
    procedure ReadValue(const AXMLNode: IXMLDOMNode; out AValue: Variant);
  protected
    procedure LoadSetting(ASetting: TSetting; AXMLNode: IXMLDOMNode);
    procedure SaveSetting(ASetting : TSetting; AXMLNode : IXMLDOMNode);

    function DoLoad : Boolean; override;
    function DoSave : Boolean; override;

    function DoCreateXMLRoot(out AXMLNode : IXMLDOMNode) : Boolean; virtual; abstract;
    function DoLoadXMLContent(out AXMLNode : IXMLDOMNode) : Boolean; virtual; abstract;
    function DoSaveXMLContent(const AXMLNode : IXMLDOMNode) : Boolean; virtual; abstract;
  end;

  TSettingsXMLFile = class(TCustomSettingsXML)
  private
    FFilename: String;
  protected
    function DoCreateXMLRoot(out AXMLNode : IXMLDOMNode): Boolean; override;
    function DoLoadXMLContent(out AXMLNode : IXMLDOMNode) : Boolean; override;
    function DoSaveXMLContent(const AXMLNode : IXMLDOMNode) : Boolean; override;

  published
    property ParentSettings;
    property ParentMode;

    property FileName : String read FFilename write FFilename;
  end;

implementation

uses
  ComObj;

{ TCustomSettingsXML }

procedure TCustomSettingsXML.ReadValue(const AXMLNode: IXMLDOMNode;
  out AValue: Variant);
var
  ValueType : TVarType;
  tempSmallInt : Smallint;
  tempInteger : Integer;
  tempSingle : Single;
  tempDouble : Double;
  tempDate : TDateTime;
  tempOleStr : WideString;
  tempBoolean : Boolean;
  tempShortInt : Shortint;
  tempByte : Byte;
  tempWord : Word;
  tempLongWord : LongWord;
  tempInt64 : Int64;
  tempString : String;

  attrib : IXMLDOMNode;
begin
  XReadAttribute(AXMLNode, 'VarType', attrib);
  ValueType := attrib.nodeValue;

  case ValueType of
    varEmpty    : VarClear(AValue);
    varNull     : AValue := null;
    varSmallint :
    begin
      tempSmallInt:=StrToInt(AXMLNode.text);
      AValue := tempSmallInt;
    end;
    varInteger  :
    begin
      tempInteger:=StrToInt(AXMLNode.text);
      AValue := tempInteger;
    end;
    varSingle   :
    begin
      tempSingle:=StrToFloat(AXMLNode.text);
      AValue := tempSingle;
    end;
    varDouble   :
    begin
      tempDouble:=StrToFloat(AXMLNode.text);
      AValue := tempDouble;
    end;
    varDate     :
    begin
      tempDate:=StrToDateTime(AXMLNode.text);
      AValue := tempDate;
    end;
    varOleStr   :
    begin
      tempOleStr:=AXMLNode.text;
      AValue := tempOleStr;
    end;
    varBoolean  :
    begin
      tempBoolean := StrToBool(AXMLNode.text);
      AValue := tempBoolean;
    end;
    varShortInt :
    begin
      tempShortInt:=StrToInt(AXMLNode.text);
      AValue := tempShortInt;
    end;
    varByte     :
    begin
      tempByte:=StrToInt(AXMLNode.text);
      AValue := tempByte;
    end;
    varWord     :
    begin
      tempWord:=StrToInt(AXMLNode.text);
      AValue := tempWord;
    end;
    varLongWord :
    begin
      tempLongWord:=StrToInt(AXMLNode.text);
      AValue := tempLongWord;
    end;
    varInt64    :
    begin
      tempInt64:=StrToInt64(AXMLNode.text);
      AValue := tempInt64;
    end;
    varString   :
    begin
      tempString:=AXMLNode.text;
      AValue := tempString;
    end;
  end;
end;

procedure TCustomSettingsXML.LoadSetting(ASetting: TSetting;
  AXMLNode: IXMLDOMNode);
var
  idx : Integer;
  Child : TSetting;
  Value : TSettingValue;
  attrib : IXMLDOMNode;
begin
 if XReadAttribute(AXMLNode, 'Name', attrib) then
    ASetting.Name:=attrib.text;

  ReadValue(AXMLNode, Value);
  ASetting.Value:=Value;

  for idx := 0 to AXMLNode.childNodes.length - 1 do
  begin
    if AXMLNode.childNodes[idx].nodeType<>NODE_TEXT then
    begin
      Child := TSetting.Create(ASetting, EmptyWideStr);

      LoadSetting(Child, AXMLNode.childNodes[idx]);
    end;
  end;
end;

function TCustomSettingsXML.DoLoad: Boolean;
var
  Root : IXMLDOMNode;
begin
  Result:=DoLoadXMLContent(Root);

  if Result then
    LoadSetting(FRootSetting, Root.firstChild);
end;

function TCustomSettingsXML.DoSave: Boolean;
var
  Root : IXMLDOMNode;
begin
  Result:=DoCreateXMLRoot(Root);

  if Result then
  begin
    SaveSetting(FRootSetting, Root);

    Result:=DoSaveXMLContent(Root);
  end;
end;

procedure TCustomSettingsXML.SaveSetting(ASetting: TSetting;
  AXMLNode: IXMLDOMNode);
var
  SettingNode : IXMLDOMNode;
  idx : integer;
begin
  SettingNode := AXMLNode.ownerDocument.createElement('Setting');
  SettingNode := AXMLNode.appendChild(SettingNode);
  
  XAddAttribute(SettingNode, 'VarType', VarType(ASetting.Value));
  XAddAttribute(SettingNode, 'Name', ASetting.Name);
  if ASetting.Value<>Null then
    SettingNode.text:=ASetting.Value;

  for idx := 0 to ASetting.Children.Count - 1 do
    SaveSetting(ASetting.Children[idx], SettingNode);
end;

{ TSettingsXMLFile }

function TSettingsXMLFile.DoCreateXMLRoot(out AXMLNode : IXMLDOMNode): Boolean;
var
  XMLDoc : IXMLDOMDocument;
begin
  XMLDoc:=CreateMSXMLV1Document;
  XMLDoc.loadXML('<?xml version="1.0" encoding="UTF-8"?><Settings />');
  AXMLNode:=XMLDoc.documentElement;

  Result:=Assigned(AXMLNode);
end;


function TSettingsXMLFile.DoLoadXMLContent(out AXMLNode: IXMLDOMNode): Boolean;
var
  doc : IXMLDOMDocument;
begin
  DoCreateXMLRoot(AXMLNode);
  doc:=AXMLNode.ownerDocument;
  Result:=doc.load(FFilename);
  AXMLNode:=doc.documentElement;
end;

function TSettingsXMLFile.DoSaveXMLContent(const AXMLNode: IXMLDOMNode): Boolean;
begin
  AXMLNode.ownerDocument.save(FFilename);
  Result:=True;
end;

end.