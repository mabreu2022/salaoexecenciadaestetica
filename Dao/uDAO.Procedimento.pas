unit uDAO.Procedimento;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  uModel.Procedimento,
  FireDAC.Comp.Client,
  Data.DB,
  FireDAC.Stan.Param;

type
  TProcedimentoDAO = class
  public
    procedure Inserir(AProc: TProcedimento);
    procedure Atualizar(AProc: TProcedimento);
    procedure Excluir(AID: Integer);
    function BuscarPorID(AID: Integer): TProcedimento;
    function ListarPorCliente(AIDCliente: Integer): TObjectList<TProcedimento>;
    function ListarTodos(FiltroDescricao: string = ''): TObjectList<TProcedimento>;
  end;

implementation

uses
  uDao.Dm;

procedure TProcedimentoDAO.Inserir(AProc: TProcedimento);
begin

  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'INSERT INTO PROCEDIMENTOS (IDCLIENTE, IDSERVICO, DATAHORA, OBSERVACOES, CONCLUIDO) ' +
                'VALUES (:IDCLIENTE, :IDSERVICO, :DATAHORA, :OBSERVACOES, :CONCLUIDO)';
    ParamByName('IDCLIENTE').AsInteger := AProc.IDCLIENTE;
    ParamByName('IDSERVICO').AsInteger := AProc.IDSERVICO;
    ParamByName('DATAHORA').AsDateTime := AProc.DATAHORA;
    ParamByName('OBSERVACOES').AsString := AProc.OBSERVACOES.DataString;
    ParamByName('CONCLUIDO').AsBoolean := AProc.CONCLUIDO;
    ExecSQL;
  finally
    Free;
  end;

end;

procedure TProcedimentoDAO.Atualizar(AProc: TProcedimento);
begin

  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'UPDATE PROCEDIMENTOS SET IDCLIENTE = :IDCLIENTE, IDSERVICO = :IDSERVICO, ' +
                'DATAHORA = :DATAHORA, OBSERVACOES = :OBSERVACOES, CONCLUIDO = :CONCLUIDO ' +
                'WHERE IDPROCEDIMENTO = :ID';
    ParamByName('ID').AsInteger := AProc.IDPROCEDIMENTO;
    ParamByName('IDCLIENTE').AsInteger := AProc.IDCLIENTE;
    ParamByName('IDSERVICO').AsInteger := AProc.IDSERVICO;
    ParamByName('DATAHORA').AsDateTime := AProc.DATAHORA;
    ParamByName('OBSERVACOES').AsString := AProc.OBSERVACOES.DataString;
    ParamByName('CONCLUIDO').AsBoolean := AProc.CONCLUIDO;
    ExecSQL;
  finally
    Free;
  end;

end;

procedure TProcedimentoDAO.Excluir(AID: Integer);
begin

  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'DELETE FROM PROCEDIMENTOS WHERE IDPROCEDIMENTO = :ID';
    ParamByName('ID').AsInteger := AID;
    ExecSQL;
  finally
    Free;
  end;

end;

function TProcedimentoDAO.BuscarPorID(AID: Integer): TProcedimento;
begin

  Result := nil;
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'SELECT * FROM PROCEDIMENTOS WHERE IDPROCEDIMENTO = :ID';
    ParamByName('ID').AsInteger := AID;
    Open;

    if not IsEmpty then
    begin
      Result := TProcedimento.Create;
      Result.IDPROCEDIMENTO := FieldByName('IDPROCEDIMENTO').AsInteger;
      Result.IDCLIENTE := FieldByName('IDCLIENTE').AsInteger;
      Result.IDSERVICO := FieldByName('IDSERVICO').AsInteger;
      Result.DATAHORA := FieldByName('DATAHORA').AsDateTime;
      Result.OBSERVACOES.WriteString(FieldByName('OBSERVACOES').AsString);
      Result.CONCLUIDO := FieldByName('CONCLUIDO').AsBoolean;
    end;
  finally
    Free;
  end;

end;

function TProcedimentoDAO.ListarPorCliente(AIDCliente: Integer): TObjectList<TProcedimento>;
var
  P: TProcedimento;
begin

  Result := TObjectList<TProcedimento>.Create(True);
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'SELECT * FROM PROCEDIMENTOS WHERE IDCLIENTE = :ID ORDER BY DATAHORA DESC';
    ParamByName('ID').AsInteger := AIDCliente;
    Open;

    while not Eof do
    begin
      P := TProcedimento.Create;
      P.IDPROCEDIMENTO := FieldByName('IDPROCEDIMENTO').AsInteger;
      P.IDCLIENTE := FieldByName('IDCLIENTE').AsInteger;
      P.IDSERVICO := FieldByName('IDSERVICO').AsInteger;
      P.DATAHORA := FieldByName('DATAHORA').AsDateTime;
      P.OBSERVACOES.WriteString(FieldByName('OBSERVACOES').AsString);
      P.CONCLUIDO := FieldByName('CONCLUIDO').AsBoolean;
      Result.Add(P);
      Next;
    end;
  finally
    Free;
  end;

end;

function TProcedimentoDAO.ListarTodos(FiltroDescricao: string): TObjectList<TProcedimento>;
var
  P: TProcedimento;
  Q: TFDQuery;
begin

  Result := TObjectList<TProcedimento>.Create(True);

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DataModule1.FDConnection1;

    Q.SQL.Text := 'SELECT * FROM PROCEDIMENTOS';
    if FiltroDescricao <> '' then
      Q.SQL.Add('WHERE LOWER(OBSERVACOES) LIKE :FILTRO');

    Q.SQL.Add('ORDER BY DATAHORA DESC');

    if FiltroDescricao <> '' then
      Q.ParamByName('FILTRO').AsString := '%' + LowerCase(FiltroDescricao) + '%';

    Q.Open;

    while not Q.Eof do
    begin
      P := TProcedimento.Create;
      P.IDPROCEDIMENTO := Q.FieldByName('IDPROCEDIMENTO').AsInteger;
      P.IDCLIENTE := Q.FieldByName('IDCLIENTE').AsInteger;
      P.IDSERVICO := Q.FieldByName('IDSERVICO').AsInteger;
      P.DATAHORA := Q.FieldByName('DATAHORA').AsDateTime;
      P.OBSERVACOES.WriteString(Q.FieldByName('OBSERVACOES').AsString);
      P.CONCLUIDO := Q.FieldByName('CONCLUIDO').AsBoolean;
      Result.Add(P);
      Q.Next;
    end;
  finally
    Q.Free;
  end;

end;

end.