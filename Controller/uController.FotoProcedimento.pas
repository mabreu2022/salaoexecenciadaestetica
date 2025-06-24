unit uController.FotoProcedimento;

interface

uses
  uInterfaces.FotoProcedimentoController,
  uModel.FotoProcedimento,
  uDAO.FotoProcedimento,
  System.Generics.Collections,
  Data.DB,
  System.SysUtils,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param;

type
  TFotoProcedimentoController = class(TInterfacedObject, IFotoProcedimentoController)
  private
    FDAO: TFotoProcedimentoDAO;
    FQuery: TFDQuery;
    FDataSource: TDataSource;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Inserir(AFoto: TFotoProcedimento);
    procedure Excluir(ID: Integer);
    function ListarPorProcedimento(IDProcedimento: Integer): TArray<TFotoProcedimento>;
    function ListarProcedimentosDoCliente(AIDCliente: Integer): TDataSource;
    function ClientePossuiProcedimentos(AIDCliente: Integer): Boolean;
    procedure InserirNovaFoto(AIDProcedimento: Integer);
  end;

implementation

{ TFotoProcedimentoController }

uses uDao.Dm;

function TFotoProcedimentoController.ClientePossuiProcedimentos(
  AIDCliente: Integer): Boolean;
begin
  ListarProcedimentosDoCliente(AIDCliente);
  Result := not FQuery.IsEmpty;
end;

constructor TFotoProcedimentoController.Create;
begin

  FDAO := TFotoProcedimentoDAO.Create;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := DataModule1.Fdconnection1;

  FDataSource := TDataSource.Create(nil);
  FDataSource.DataSet := FQuery;


end;

destructor TFotoProcedimentoController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

procedure TFotoProcedimentoController.Inserir(AFoto: TFotoProcedimento);
begin
  FDAO.Inserir(AFoto);
end;

procedure TFotoProcedimentoController.InserirNovaFoto(AIDProcedimento: Integer);
begin
  if AIDProcedimento <= 0 then
    raise Exception.Create('Procedimento inválido. Selecione um procedimento antes de continuar.');

  DataModule1.QryFotosProcedimento.Append;
  DataModule1.QryFotosProcedimento.FieldByName('IDPROCEDIMENTO').AsInteger := AIDProcedimento;
  DataModule1.QryFotosProcedimento.FieldByName('DATAINCLUSAO').AsDateTime := Now;
  DataModule1.QryFotosProcedimento.Post;

end;

procedure TFotoProcedimentoController.Excluir(ID: Integer);
begin
  FDAO.Excluir(ID);
end;

function TFotoProcedimentoController.ListarPorProcedimento(IDProcedimento: Integer): TArray<TFotoProcedimento>;
begin
  Result := FDAO.ListarPorProcedimento(IDProcedimento).ToArray;
end;

function TFotoProcedimentoController.ListarProcedimentosDoCliente(
  AIDCliente: Integer): TDataSource;
begin
  FQuery.Close;
  FQuery.SQL.Text :=
    'SELECT P.IDPROCEDIMENTO, S.NOME AS NOMESERVICO ' +
    'FROM PROCEDIMENTOS P ' +
    'JOIN SERVICOS S ON S.IDSERVICO = P.IDSERVICO ' +
    'WHERE P.ATIVO = ''S'' AND P.IDCLIENTE = :IDCLIENTE ' +
    'ORDER BY S.NOME';
  FQuery.ParamByName('IDCLIENTE').AsInteger := AIDCliente;
  FQuery.Open;

  Result := FDataSource;

end;

end.
