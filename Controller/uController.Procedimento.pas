unit uController.Procedimento;

interface

uses
  uInterfaces.ProcedimentoController,
  uModel.Procedimento,
  uDAO.Procedimento,
  Data.DB, uDAO.Cliente;

type
  TProcedimentoController = class(TInterfacedObject, IProcedimentoController)
  private
    FDAO: TProcedimentoDAO;
    FClienteDAO: TClienteDAO;
  public
    procedure Inserir(AProcedimento: TProcedimento);
    procedure Atualizar(AProcedimento: TProcedimento);
    procedure Excluir(ID: Integer);
    function BuscarPorID(ID: Integer): TProcedimento;
    function ListarTodos(FiltroDescricao: string = ''): TArray<TProcedimento>;
    procedure NovoProcedimento;
    function ListarClientesDataSet: TDataSet;
    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TProcedimentoController }

constructor TProcedimentoController.Create;
begin
  FDAO := TProcedimentoDAO.Create;
end;

destructor TProcedimentoController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

procedure TProcedimentoController.Inserir(AProcedimento: TProcedimento);
begin
  FDAO.Inserir(AProcedimento);
end;

function TProcedimentoController.ListarClientesDataSet: TDataSet;
begin
  Result := FClienteDAO.DataSetTodos;
end;

function TProcedimentoController.ListarTodos(
  FiltroDescricao: string): TArray<TProcedimento>;
begin
  Result := FDAO.ListarTodos(FiltroDescricao).ToArray;
end;

procedure TProcedimentoController.NovoProcedimento;
begin
  // Pode deixar vazio ou preparar algo caso use cache
end;

procedure TProcedimentoController.Atualizar(AProcedimento: TProcedimento);
begin
  FDAO.Atualizar(AProcedimento);
end;

procedure TProcedimentoController.Excluir(ID: Integer);
begin
  FDAO.Excluir(ID);
end;

function TProcedimentoController.BuscarPorID(ID: Integer): TProcedimento;
begin
  Result := FDAO.BuscarPorID(ID);
end;

end.
