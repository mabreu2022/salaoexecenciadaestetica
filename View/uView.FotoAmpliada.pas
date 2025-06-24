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
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmFotoAmpliada = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
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

procedure TFrmFotoAmpliada.btnFecharClick(Sender: TObject);
begin
  Close;
end;

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
