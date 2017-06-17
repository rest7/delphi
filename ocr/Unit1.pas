unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdMultipartFormData;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Image1: TImage;
    Memo1: TMemo;
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
    Params: TIdMultipartFormDataStream;
    PosStart, PosEnd: Integer;
    ImageURL: String;
    AStream: TMemoryStream;
begin
  try
    Params := TIdMultipartFormDataStream.Create;
    Params.AddFile('file', 'tiger.bmp','application/octet-stream');

    Json := IdHTTP1.Post('http://api.rest7.com/v1/ocr.php?format=txt', Params);
  except
    ShowMessage('Upload failed. Check Internet connection');
    Exit;
  end;

  if Pos('file', Json) < 1 then
  begin
    ShowMessage('OCR failed. Format might not be supported');
    Exit;
  end;

  PosStart := Pos('temp\/', Json);
  PosEnd   := Pos('.txt', Json);

  if (PosStart < 1) or (PosEnd < 1) then
  begin
    ShowMessage('Parsing JSON failed');
    Exit;
  end;

  ImageURL := Copy(Json, PosStart+6, PosEnd-PosStart-2);
  ImageURL := StringReplace(ImageURL, '\', '', [rfReplaceAll]);

  try
    AStream := TMemoryStream.Create;
    IdHTTP1.Get('http://api.rest7.com/temp/' + ImageURL, AStream);
    AStream.Position := 0;

    Image1.Picture.LoadFromFile('tiger.bmp');
    Memo1.Lines.LoadFromStream(AStream);
  except
    ShowMessage('Loading text failed');
    Exit;
  end;
end;

end.
