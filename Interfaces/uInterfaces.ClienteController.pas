unit uInterfaces.ClienteController;

interface

uses
  uModel.Cliente;

type
  IClienteController = interface
    ['{D1A7E9B2-4F3C-4C1F-9B2A-123456789ABC}']
    procedure InserirCliente(ACliente: TCliente);
    procedure AtualizarCliente(ACliente: TCliente);
    procedure ExcluirCliente(AID: Integer);
  end;

implementation

end.
