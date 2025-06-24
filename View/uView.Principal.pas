unit uView.Principal;

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
  Vcl.ComCtrls,
  Vcl.Imaging.jpeg,
  Vcl.ExtCtrls,
  Vcl.Menus,
  uView.CadastroDeClientes,
  System.DateUtils;

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
    Timer1: TTimer;
    Procedimentos2: TMenuItem;
    FotosdosProcedimentos1: TMenuItem;
    procedure Clientes2Click(Sender: TObject);
    procedure CategoriasdeServios1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FotosdosProcedimentos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uView.CadastroCategorias, uDao.Dm, uView.FotoProcedimento;

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

procedure TFrmPrincipal.FotosdosProcedimentos1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmFotoProcedimento, FrmFotoProcedimento);
  try
    FrmFotoProcedimento.ShowModal;
  finally
    FrmFotoProcedimento.Free;
  end;
end;

procedure TFrmPrincipal.Timer1Timer(Sender: TObject);
var
  Saudacao: string;
begin
  case HourOf(Now) of
    0..11: Saudacao := 'Bom dia';
    12..17: Saudacao := 'Boa tarde';
    else Saudacao := 'Boa noite';
  end;

  StatusBar1.Panels[0].Text := Saudacao + ', ' + DataModule1.UsuarioLogado;

  StatusBar1.Panels[1].Text := FormatDateTime('ddd, dd "de" mmmm hh:nn:ss', Now);

end;

end.
