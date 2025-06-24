unit uDao.Dm;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.Client,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Phys.IBBase,
  uView.Principal,
  System.IniFiles;


type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDQueryClientes: TFDQuery;
    FDQqueryFotoProcedimento: TFDQuery;
    FDQuery3: TFDQuery;
    FDQuery4: TFDQuery;
    DSClientes: TDataSource;
    dsFotoProcedimento: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    FDTransaction1: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UsuarioLogado: string;
  end;

var
  DataModule1: TDataModule1;
 // UsuarioLogado: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
  Ini: TIniFile;
  PathINI, DefName: string;
  Params: TStringList;
  oDef: IFDStanConnectionDef;
begin
  PathINI := ExtractFilePath(ParamStr(0)) + 'Config.ini';
  Ini := TIniFile.Create(PathINI);
  Params := TStringList.Create;
  try
    // Lê parâmetros do INI
    DefName := 'FB_Pooled'; // nome que daremos à definição de conexão

    Params.Values['DriverID'] := Ini.ReadString('Database', 'DriverID', 'FB');
    Params.Values['Protocol'] := Ini.ReadString('Database', 'Protocol', 'TCPIP');
    Params.Values['Server'] := Ini.ReadString('Database', 'Server', 'localhost');
    Params.Values['Port'] := Ini.ReadString('Database', 'Port', '3050');
    Params.Values['Database'] := Ini.ReadString('Database', 'Database', '');
    Params.Values['User_Name'] := Ini.ReadString('Database', 'User_Name', '');
    Params.Values['Password'] := Ini.ReadString('Database', 'Password', '');
    Params.Values['CharacterSet'] := Ini.ReadString('Database', 'CharacterSet', 'UTF8');
    Params.Values['Pooled'] := Ini.ReadString('Database', 'Pooled', 'True');
    Params.Values['POOL_MaximumItems'] := Ini.ReadString('Database', 'POOL_MaximumItems', '10');

   oDef := FDManager.ConnectionDefs.FindConnectionDef(DefName);
   if Assigned(oDef) then
     oDef.Delete;


    // Registra uma nova definição com pooling ativado
    FDManager.AddConnectionDef(DefName, 'FB', Params);

    // Aponta para a definição registrada
    FDConnection1.Params.Clear;
    FDConnection1.ConnectionDefName := DefName;
    FDConnection1.LoginPrompt := False;
    FDConnection1.Connected := True;
  finally
    Params.Free;
    Ini.Free;
  end;



end;

end.
