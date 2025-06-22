unit uInterfaces.ProcedimentoController;

interface

uses
  uModel.Procedimento;

type
  IProcedimentoController = interface
    ['{A1B2C3D4-E5F6-47A8-9B0C-000000000003}']
    procedure Inserir(AProcedimento: TProcedimento);
    procedure Atualizar(AProcedimento: TProcedimento);
    procedure Excluir(ID: Integer);
    function BuscarPorID(ID: Integer): TProcedimento;
    function ListarTodos(FiltroDescricao: string = ''): TArray<TProcedimento>;
  end;

implementation

end.
