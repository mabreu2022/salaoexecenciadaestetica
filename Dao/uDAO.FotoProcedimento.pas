unit uDAO.FotoProcedimento;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  uModel.FotoProcedimento,
  FireDAC.Comp.Client,
  Data.DB,
  uModel.Procedimento,
  FireDAC.Stan.Param;

type
  TFotoProcedimentoDAO = class
  public
    procedure Inserir(AFoto: TFotoProcedimento);
    procedure Excluir(AID: Integer);
    function ListarPorProcedimento(AIDProcedimento: Integer): TObjectList<TFotoProcedimento>;
    function ListarPorCliente(AIDCliente: Integer): TObjectList<TProcedimento>;
  end;

implementation

uses
  uDao.Dm;

procedure TFotoProcedimentoDAO.Inserir(AFoto: TFotoProcedimento);
begin

  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'INSERT INTO FOTOSPROCEDIMENTO (IDPROCEDIMENTO, CAMINHOARQUIVO, IMAGEM, DATAINCLUSAO) ' +
                'VALUES (:IDPROCEDIMENTO, :CAMINHOARQUIVO, :IMAGEM, :DATAINCLUSAO)';
    ParamByName('IDPROCEDIMENTO').AsInteger := AFoto.IDPROCEDIMENTO;
    ParamByName('CAMINHOARQUIVO').AsString := AFoto.CAMINHOARQUIVO;
    ParamByName('IMAGEM').LoadFromStream(AFoto.IMAGEM, ftBlob);
    ParamByName('DATAINCLUSAO').AsDateTime := AFoto.DATAINCLUSAO;
    ExecSQL;
  finally
    Free;
  end;

end;

procedure TFotoProcedimentoDAO.Excluir(AID: Integer);
begin

  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'DELETE FROM FOTOSPROCEDIMENTO WHERE IDFOTO = :ID';
    ParamByName('ID').AsInteger := AID;
    ExecSQL;
  finally
    Free;
  end;

end;

function TFotoProcedimentoDAO.ListarPorCliente(
  AIDCliente: Integer): TObjectList<TProcedimento>;
var
  P: TProcedimento;
  Q: TFDQuery;
begin

  Result := TObjectList<TProcedimento>.Create(True);

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DataModule1.FDConnection1;
    Q.SQL.Text := 'SELECT * FROM PROCEDIMENTOS WHERE IDCLIENTE = :ID ORDER BY DATAHORA DESC';
    Q.ParamByName('ID').AsInteger := AIDCliente;
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

function TFotoProcedimentoDAO.ListarPorProcedimento(AIDProcedimento: Integer): TObjectList<TFotoProcedimento>;
var
  Foto: TFotoProcedimento;
begin

  Result := TObjectList<TFotoProcedimento>.Create(True);
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'SELECT * FROM FOTOSPROCEDIMENTO WHERE IDPROCEDIMENTO = :ID ORDER BY DATAINCLUSAO DESC';
    ParamByName('ID').AsInteger := AIDProcedimento;
    Open;

    while not Eof do
    begin
      Foto := TFotoProcedimento.Create;
      Foto.IDFOTO := FieldByName('IDFOTO').AsInteger;
      Foto.IDPROCEDIMENTO := FieldByName('IDPROCEDIMENTO').AsInteger;
      Foto.CAMINHOARQUIVO := FieldByName('CAMINHOARQUIVO').AsString;
      Foto.DATAINCLUSAO := FieldByName('DATAINCLUSAO').AsDateTime;

      Foto.IMAGEM.Clear;
      TBlobField(FieldByName('IMAGEM')).SaveToStream(Foto.IMAGEM);
      Foto.IMAGEM.Position := 0;

      Result.Add(Foto);
      Next;
    end;
  finally
    Free;
  end;

end;

end.
