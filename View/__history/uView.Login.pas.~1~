unit uView.Login;

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
  Vcl.StdCtrls,
  Vcl.Imaging.jpeg,
  Vcl.ExtCtrls,
  Vcl.Mask,
  uSessao,
  FireDAC.Comp.Client,
  Dao.Dm,
  System.Hash,
  FireDAC.Stan.Param, // para TFDParam.SetAsString
  Data.DB,            // para TDataSet.IsEmpty
  uConstantes;

type
  TFrmLogin = class(TForm)
    edtLogin: TEdit;
    edtSenha: TMaskEdit;
    Image1: TImage;
    BtnLogin: TButton;
    Button1: TButton;
    procedure BtnLoginClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function GerarHashSHA256(const Texto: string): string;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
var
  FDQ: TFDQuery;
  SenhaHash: string;
begin
  if Trim(edtLogin.Text) = '' then
  begin
    ShowMessage(MSG_LOGIN_OBRIGATORIO);
    edtLogin.SetFocus;
    Exit;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    ShowMessage(MSG_SENHA_OBRIGATORIA);
    edtSenha.SetFocus;
    Exit;
  end;

  // 🔐 Gerar o hash da senha digitada
  SenhaHash := GerarHashSHA256(edtSenha.Text);

  FDQ := TFDQuery.Create(nil);
  try
    FDQ.Connection := DataModule1.FDConnection1;
    FDQ.SQL.Text :=
      'SELECT IDUsuario, NomeCompleto FROM Usuarios ' +
      'WHERE Login = :login AND SenhaHash = :senha';
    FDQ.ParamByName('login').AsString := edtLogin.Text;
    FDQ.ParamByName('senha').AsString := SenhaHash;
    FDQ.Open;

    if not FDQ.IsEmpty then
    begin
      IDUsuarioLogado := FDQ.FieldByName('IDUsuario').AsInteger;
      NomeUsuarioLogado := FDQ.FieldByName('NomeCompleto').AsString;
      ShowMessage(Format(MSG_BEM_VINDO, [NomeUsuarioLogado]));
      ModalResult := mrOk;
    end
    else
    begin
      ShowMessage(MSG_LOGIN_INVALIDO);
      edtSenha.SetFocus;
    end;
  finally
    FDQ.Free;
  end;


end;

procedure TFrmLogin.Button1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TFrmLogin.GerarHashSHA256(const Texto: string): string;
begin
  Result := THashSHA2.GetHashString(Texto);
end;

end.
