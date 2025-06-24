unit uInterfaces.FotoProcedimentoController;

interface

uses
  uModel.FotoProcedimento,
  Data.DB;

type
  IFotoProcedimentoController = interface
    ['{A1B2C3D4-E5F6-47A8-9B0C-000000000002}']
    procedure Inserir(AFoto: TFotoProcedimento);
    procedure Excluir(ID: Integer);
    function ListarPorProcedimento(IDProcedimento: Integer): TArray<TFotoProcedimento>;
    function ListarProcedimentosDoCliente(AIDCliente: Integer): TDataSource;
    function ClientePossuiProcedimentos(AIDCliente: Integer): Boolean;
    procedure InserirNovaFoto(AIDProcedimento: Integer);


  end;

implementation

end.
