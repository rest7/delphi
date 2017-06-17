object Form1: TForm1
  Left = 435
  Top = 263
  Width = 635
  Height = 501
  Caption = 'Load DDS, PNM, PSD, TGA, CIN, PGM, PBM, JPG, PNG, GIF and more'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 521
    Height = 449
  end
  object Button1: TButton
    Left = 536
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Load image'
    TabOrder = 0
    OnClick = Button1Click
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 536
    Top = 40
  end
end
