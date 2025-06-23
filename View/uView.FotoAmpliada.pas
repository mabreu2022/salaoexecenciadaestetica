unit uView.FotoAmpliada;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  TFrmFotoAmpliada = class(TForm)
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure ExibirImagem(const Imagem: TPicture);

  end;

var
  FrmFotoAmpliada: TFrmFotoAmpliada;

implementation

{$R *.dfm}

{ TFrmFotoAmpliada }

class procedure TFrmFotoAmpliada.ExibirImagem(const Imagem: TPicture);
var
  Frm: TFrmFotoAmpliada;
begin
  Frm := TFrmFotoAmpliada.Create(nil);
  try
    Frm.Image1.Picture.Assign(Imagem);
    Frm.ShowModal;
  finally
    Frm.Free;
  end;


end;

end.
