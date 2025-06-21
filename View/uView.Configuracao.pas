unit uView.Configuracao;

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
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Inifiles,
  uDao.Dm,
  System.Hash;

type
  TFrmConfiguracao = class(TForm)
    edtServidor: TEdit;
    edtPorta: TEdit;
    edtDatabase: TEdit;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    edtCharSet: TEdit;
    chkPooling: TCheckBox;
    edtMAximoConexoes: TEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    lblServidor: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblMaximoConexoes: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    function GerarHashSHA256(const Texto: string): string;

  public
    { Public declarations }
  end;

var
  FrmConfiguracao: TFrmConfiguracao;

implementation

{$R *.dfm}

procedure TFrmConfiguracao.BitBtn1Click(Sender: TObject);
var
  Ini: TIniFile;
  PathINI: string;
begin
  PathINI := ExtractFilePath(ParamStr(0)) + 'Config.ini';
  Ini := TIniFile.Create(PathINI);
  try
    Ini.WriteString('Database', 'Server', edtServidor.Text);
    Ini.WriteString('Database', 'Port', edtPorta.Text);
    Ini.WriteString('Database', 'Database', edtDatabase.Text);
    Ini.WriteString('Database', 'User_Name', edtUsuario.Text);
    Ini.WriteString('Database', 'Password', GerarHashSHA256(edtSenha.Text));
    Ini.WriteString('Database', 'CharacterSet', edtCharset.Text);
    Ini.WriteBool('Database', 'Pooled', chkPooling.Checked);
    Ini.WriteString('Database', 'POOL_MaximumItems', edtMaximoConexoes.Text);
    ShowMessage('Configurações salvas com sucesso!');
  finally
    Ini.Free;
  end;


end;

procedure TFrmConfiguracao.FormShow(Sender: TObject);
var
  Ini: TIniFile;
  PathINI: string;
begin
  PathINI := ExtractFilePath(ParamStr(0)) + 'Config.ini';
  Ini := TIniFile.Create(PathINI);
  try
    DataModule1.FDConnection1.Params.Clear;
    DataModule1.FDConnection1.Params.Values['DriverID'] := Ini.ReadString('Database', 'DriverID', 'FB');
    DataModule1.FDConnection1.Params.Values['Protocol'] := Ini.ReadString('Database', 'Protocol', 'TCPIP');
    DataModule1.FDConnection1.Params.Values['Server'] := Ini.ReadString('Database', 'Server', 'localhost');
    DataModule1.FDConnection1.Params.Values['Port'] := Ini.ReadString('Database', 'Port', '3050');
    DataModule1.FDConnection1.Params.Values['Database'] := Ini.ReadString('Database', 'Database', '');
    DataModule1.FDConnection1.Params.Values['User_Name'] := Ini.ReadString('Database', 'User_Name', '');
    DataModule1.FDConnection1.Params.Values['Password'] := Ini.ReadString('Database', 'Password', '');
    DataModule1.FDConnection1.Params.Values['CharacterSet'] := Ini.ReadString('Database', 'CharacterSet', 'UTF8');
    DataModule1.FDConnection1.Params.Values['Pooled'] := Ini.ReadString('Database', 'Pooled', 'False');
    DataModule1.FDConnection1.Params.Values['POOL_MaximumItems'] := Ini.ReadString('Database', 'POOL_MaximumItems', '10');

    DataModule1.FDConnection1.LoginPrompt := False;
    DataModule1.FDConnection1.Connected := True;
  finally
    Ini.Free;
  end;


end;

function TFrmConfiguracao.GerarHashSHA256(const Texto: string): string;
begin
  Result := THashSHA2.GetHashString(Texto);
end;

end.
