unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var Json: String;
    Temp: TStringList;
begin
  try
    Json := IdHTTP1.Get('http://api.rest7.com/v1/ip_to_city.php?ip=' + Edit1.Text);
  except
    ShowMessage('Check Internet connection');
    Exit;
  end;

  if Pos('success":1', Json) < 1 then
  begin
    ShowMessage('IP2City failed');
    Exit;
  end;

  Json := StringReplace(Json, ':', ',', [rfReplaceAll]);

  Temp := TStringList.Create;
  Temp.Delimiter := ',';
  Temp.DelimitedText := Json;


  Memo1.Lines.Add('Country= ' + Temp[1]);
  Memo1.Lines.Add('Region= ' + Temp[3]);
  Memo1.Lines.Add('City= ' + Temp[5]);
  Memo1.Lines.Add('Latitude= ' + Temp[7]);
  Memo1.Lines.Add('Longitude= ' + Temp[9]);

  Temp.Free;
end;

end.
