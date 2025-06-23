unit uDAO.Servico;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  uModel.Servico,
  FireDAC.Comp.Client,
  Data.DB,
  FireDAC.Stan.Param;

type
  TServicoDAO = class
  public
    procedure Inserir(AServico: TServico);
    procedure Atualizar(AServico: TServico);
    procedure Excluir(AID: Integer);
    function BuscarPorID(AID: Integer): TServico;
    function ListarTodos(FiltroDescricao: string = ''): TObjectList<TServico>;
  end;

implementation

uses
  uDao.Dm;

procedure TServicoDAO.Inserir(AServico: TServico);
begin
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'INSERT INTO SERVICOS (NOME, PRECO, DURACAOMINUTOS, IDCATEGORIA) ' +
                'VALUES (:NOME, :PRECO, :DURACAO, :IDCATEGORIA)';
    ParamByName('NOME').AsString := AServico.NOME;
    ParamByName('PRECO').AsFloat := AServico.PRECO;
    ParamByName('DURACAO').AsInteger := AServico.DURACAOMINUTOS;
    if AServico.IDCATEGORIA > 0 then
      ParamByName('IDCATEGORIA').AsInteger := AServico.IDCATEGORIA
    else
      ParamByName('IDCATEGORIA').Clear;
    ExecSQL;
  finally
    Free;
  end;
end;

procedure TServicoDAO.Atualizar(AServico: TServico);
begin
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'UPDATE SERVICOS SET NOME = :NOME, PRECO = :PRECO, DURACAOMINUTOS = :DURACAO, ' +
                'IDCATEGORIA = :IDCATEGORIA WHERE IDSERVICO = :ID';
    ParamByName('ID').AsInteger := AServico.IDSERVICO;
    ParamByName('NOME').AsString := AServico.NOME;
    ParamByName('PRECO').AsFloat := AServico.PRECO;
    ParamByName('DURACAO').AsInteger := AServico.DURACAOMINUTOS;
    if AServico.IDCATEGORIA > 0 then
      ParamByName('IDCATEGORIA').AsInteger := AServico.IDCATEGORIA
    else
      ParamByName('IDCATEGORIA').Clear;
    ExecSQL;
  finally
    Free;
  end;
end;

procedure TServicoDAO.Excluir(AID: Integer);
begin
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'DELETE FROM SERVICOS WHERE IDSERVICO = :ID';
    ParamByName('ID').AsInteger := AID;
    ExecSQL;
  finally
    Free;
  end;
end;

function TServicoDAO.BuscarPorID(AID: Integer): TServico;
begin
  Result := nil;
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'SELECT * FROM SERVICOS WHERE IDSERVICO = :ID';
    ParamByName('ID').AsInteger := AID;
    Open;

    if not IsEmpty then
    begin
      Result := TServico.Create;
      Result.IDSERVICO := FieldByName('IDSERVICO').AsInteger;
      Result.NOME := FieldByName('NOME').AsString;
      Result.PRECO := FieldByName('PRECO').AsFloat;
      Result.DURACAOMINUTOS := FieldByName('DURACAOMINUTOS').AsInteger;
      Result.IDCATEGORIA := FieldByName('IDCATEGORIA').AsInteger;
    end;
  finally
    Free;
  end;
end;

function TServicoDAO.ListarTodos(FiltroDescricao: string = ''): TObjectList<TServico>;
var
  S: TServico;
  Q: TFDQuery;
begin
  Result := TObjectList<TServico>.Create(True);

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DataModule1.FDConnection1;

    // Monta SQL com filtro opcional
    Q.SQL.Text := 'SELECT * FROM SERVICOS';

    if FiltroDescricao <> '' then
      Q.SQL.Add('WHERE LOWER(NOME) LIKE :FILTRO');

    Q.SQL.Add('ORDER BY NOME');

    // Define parâmetro, se necessário
    if FiltroDescricao <> '' then
      Q.ParamByName('FILTRO').AsString := '%' + LowerCase(FiltroDescricao) + '%';

    Q.Open;

    // Preenche a lista com os resultados
    while not Q.Eof do
    begin
      S := TServico.Create;
      S.IDSERVICO       := Q.FieldByName('IDSERVICO').AsInteger;
      S.NOME            := Q.FieldByName('NOME').AsString;
      S.PRECO           := Q.FieldByName('PRECO').AsFloat;
      S.DURACAOMINUTOS  := Q.FieldByName('DURACAOMINUTOS').AsInteger;
      S.IDCATEGORIA     := Q.FieldByName('IDCATEGORIA').AsInteger;

      Result.Add(S);
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;


end.
