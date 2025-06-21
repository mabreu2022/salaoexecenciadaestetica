unit uDAO.Cliente;

interface

uses
  System.SysUtils, System.Generics.Collections,
  uModel.Cliente, FireDAC.Comp.Client, Data.DB;

type
  TClienteDAO = class
  public
    procedure Inserir(ACliente: TCliente);
    procedure Atualizar(ACliente: TCliente);
    procedure Excluir(AID: Integer);
    function BuscarPorID(AID: Integer): TCliente;
    function ListarTodos: TObjectList<TCliente>;
  end;

implementation

uses
  uDao.Dm; // onde está FDConnection e FDQueryClientes

procedure TClienteDAO.Inserir(ACliente: TCliente);
begin
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'INSERT INTO CLIENTES (NOME, TELEFONE, EMAIL, ENDERECO, NUMERO, COMPLEMENTO, CEP) ' +
                'VALUES (:NOME, :TELEFONE, :EMAIL, :ENDERECO, :NUMERO, :COMPLEMENTO, :CEP)';
    ParamByName('NOME').AsString        := ACliente.NOME;
    ParamByName('TELEFONE').AsString    := ACliente.TELEFONE;
    ParamByName('EMAIL').AsString       := ACliente.EMAIL;
    ParamByName('ENDERECO').AsString    := ACliente.ENDERECO;
    ParamByName('NUMERO').AsString      := ACliente.NUMERO;
    ParamByName('COMPLEMENTO').AsString := ACliente.COMPLEMENTO;
    ParamByName('CEP').AsString         := ACliente.CEP;
    ExecSQL;
  finally
    Free;
  end;
end;

procedure TClienteDAO.Atualizar(ACliente: TCliente);
begin
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'UPDATE CLIENTES SET NOME = :NOME, TELEFONE = :TELEFONE, EMAIL = :EMAIL, ' +
                'ENDERECO = :ENDERECO, NUMERO = :NUMERO, COMPLEMENTO = :COMPLEMENTO, CEP = :CEP ' +
                'WHERE IDCLIENTE = :ID';
    ParamByName('ID').AsInteger             := ACliente.ID;
    ParamByName('NOME').AsString            := ACliente.NOME;
    ParamByName('TELEFONE').AsString        := ACliente.TELEFONE;
    ParamByName('EMAIL').AsString           := ACliente.EMAIL;
    ParamByName('ENDERECO').AsString        := ACliente.ENDERECO;
    ParamByName('NUMERO').AsString          := ACliente.NUMERO;
    ParamByName('COMPLEMENTO').AsString     := ACliente.COMPLEMENTO;
    ParamByName('CEP').AsString             := ACliente.CEP;
    ExecSQL;
  finally
    Free;
  end;
end;

procedure TClienteDAO.Excluir(AID: Integer);
begin
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'DELETE FROM CLIENTES WHERE IDCLIENTE = :ID';
    ParamByName('ID').AsInteger := AID;
    ExecSQL;
  finally
    Free;
  end;
end;

function TClienteDAO.BuscarPorID(AID: Integer): TCliente;
begin
  Result := nil;
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'SELECT * FROM CLIENTES WHERE IDCLIENTE = :ID';
    ParamByName('ID').AsInteger := AID;
    Open;

    if not IsEmpty then
    begin
      Result := TCliente.Create;
      Result.ID           := FieldByName('ID').AsInteger;
      Result.NOME         := FieldByName('NOME').AsString;
      Result.TELEFONE     := FieldByName('TELEFONE').AsString;
      Result.EMAIL        := FieldByName('EMAIL').AsString;
      Result.ENDERECO     := FieldByName('ENDERECO').AsString;
      Result.NUMERO       := FieldByName('NUMERO').AsString;
      Result.COMPLEMENTO  := FieldByName('COMPLEMENTO').AsString;
      Result.CEP          := FieldByName('CEP').AsString;
    end;
  finally
    Free;
  end;
end;

function TClienteDAO.ListarTodos: TObjectList<TCliente>;
var
  Cliente: TCliente;
begin
  Result := TObjectList<TCliente>.Create(True);
  with TFDQuery.Create(nil) do
  try
    Connection := DataModule1.FDConnection1;
    SQL.Text := 'SELECT * FROM CLIENTES ORDER BY NOME';
    Open;

    while not Eof do
    begin
      Cliente := TCliente.Create;
      Cliente.ID           := FieldByName('ID').AsInteger;
      Cliente.NOME         := FieldByName('NOME').AsString;
      Cliente.TELEFONE     := FieldByName('TELEFONE').AsString;
      Cliente.EMAIL        := FieldByName('EMAIL').AsString;
      Cliente.ENDERECO     := FieldByName('ENDERECO').AsString;
      Cliente.NUMERO       := FieldByName('NUMERO').AsString;
      Cliente.COMPLEMENTO  := FieldByName('COMPLEMENTO').AsString;
      Cliente.CEP          := FieldByName('CEP').AsString;
      Result.Add(Cliente);
      Next;
    end;
  finally
    Free;
  end;
end;

end.
