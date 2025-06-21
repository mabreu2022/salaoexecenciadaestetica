unit uController.Cliente;

interface

uses
  uModel.Cliente,
  System.SysUtils,
  FireDAC.Comp.Client,
  Data.DB,
  uInterfaces.ClienteController,
  FireDAC.Stan.Param;

type
  TClienteController = class(TInterfacedObject, IClienteController)

  public
    procedure InserirCliente(ACliente: TCliente);
    procedure AtualizarCliente(ACliente: TCliente);
    procedure ExcluirCliente(AID: Integer); // 👈 novo método

  end;

implementation

uses
  uDao.Dm; // seu DataModule com FDConnection

{ TClienteController }

procedure TClienteController.ExcluirCliente(AID: Integer);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := DataModule1.FDConnection1;
    Qry.SQL.Text := 'DELETE FROM CLIENTES WHERE IDCLIENTE = :ID';
    Qry.ParamByName('ID').AsInteger := AID;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;

end;

procedure TClienteController.InserirCliente(ACliente: TCliente);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := DataModule1.FDConnection1;
    Qry.SQL.Text :=
      'INSERT INTO CLIENTES (NOME, TELEFONE, EMAIL, DATACADASTRO, ENDERECO, COMPLEMENTO, CEP, NUMERO) ' +
      'VALUES (:NOME, :TELEFONE, :EMAIL, :DATACADASTRO, :ENDERECO, :COMPLEMENTO, :CEP, :NUMERO)';

    Qry.ParamByName('NOME').AsString         := ACliente.Nome;
    Qry.ParamByName('TELEFONE').AsString     := ACliente.Telefone;
    Qry.ParamByName('EMAIL').AsString        := ACliente.Email;
    Qry.ParamByName('DATACADASTRO').AsDate   := Date;
    Qry.ParamByName('ENDERECO').AsString     := ACliente.Endereco;
    Qry.ParamByName('COMPLEMENTO').AsString  := ACliente.Complemento;
    Qry.ParamByName('CEP').AsString          := ACliente.CEP;
    Qry.ParamByName('NUMERO').AsString       := ACliente.Numero;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TClienteController.AtualizarCliente(ACliente: TCliente);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := DataModule1.FDConnection1;
    Qry.SQL.Text :=
      'UPDATE CLIENTES SET ' +
      'NOME = :NOME, TELEFONE = :TELEFONE, EMAIL = :EMAIL, ENDERECO = :ENDERECO, ' +
      'COMPLEMENTO = :COMPLEMENTO, CEP = :CEP, NUMERO = :NUMERO ' +
      'WHERE IDCLIENTE = :ID';

    Qry.ParamByName('ID').AsInteger          := ACliente.ID;
    Qry.ParamByName('NOME').AsString         := ACliente.Nome;
    Qry.ParamByName('TELEFONE').AsString     := ACliente.Telefone;
    Qry.ParamByName('EMAIL').AsString        := ACliente.Email;
    Qry.ParamByName('ENDERECO').AsString     := ACliente.Endereco;
    Qry.ParamByName('COMPLEMENTO').AsString  := ACliente.Complemento;
    Qry.ParamByName('CEP').AsString          := ACliente.CEP;
    Qry.ParamByName('NUMERO').AsString       := ACliente.Numero;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

end.
