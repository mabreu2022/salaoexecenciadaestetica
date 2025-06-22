unit uInterfaces.ServicoController;

interface

uses
  uModel.Servico;

type
  IServicoController = interface
    ['{A1B2C3D4-E5F6-47A8-9B0C-000000000004}']
    procedure Inserir(AServico: TServico);
    procedure Atualizar(AServico: TServico);
    procedure Excluir(ID: Integer);
    function ListarTodos(FiltroDescricao: string = ''): TArray<TServico>;
  end;

implementation

end.
