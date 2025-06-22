unit uView.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Menus, uView.CadastroDeClientes;

type
  TFrmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Cadastros2: TMenuItem;
    Sair1: TMenuItem;
    Clientes1: TMenuItem;
    Servios1: TMenuItem;
    Servios2: TMenuItem;
    CategoriasdeServios1: TMenuItem;
    Clientes2: TMenuItem;
    Procedimentos1: TMenuItem;
    Deslogarde1: TMenuItem;
    procedure Clientes2Click(Sender: TObject);
    procedure CategoriasdeServios1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uView.CadastroCategorias;

procedure TFrmPrincipal.CategoriasdeServios1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroCategorias, FrmCadastroCategorias);
  try
    FrmCadastroCategorias.ShowModal;
  finally
    FrmCadastroCategorias.Free;
  end;
end;

procedure TFrmPrincipal.Clientes2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroDeClientes, FrmCadastroDeClientes);
  try
    FrmCadastroDeClientes.ShowModal;
  finally
    FrmCadastroDeClientes.Free;
  end;
end;

end.
