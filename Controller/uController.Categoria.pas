unit uController.Categoria;

interface

uses
  uModel.Categoria, uDAO.Categoria, uInterfaces.CategoriasController;

type
  TCategoriaController = class(TInterfacedObject, ICategoriaController)
  private
    FCategoriaDAO: TCategoriaDAO;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Inserir(ACategoria: TCategoria);
    procedure Atualizar(ACategoria: TCategoria);
    procedure Excluir(ID: Integer);
    function BuscarPorID(ID: Integer): TCategoria;
    function ListarTodos(FiltroDescricao: string = ''): TArray<TCategoria>;
  end;

implementation

{ TCategoriaController }

constructor TCategoriaController.Create;
begin
  FCategoriaDAO := TCategoriaDAO.Create;
end;

destructor TCategoriaController.Destroy;
begin
  FCategoriaDAO.Free;
  inherited;
end;

procedure TCategoriaController.Inserir(ACategoria: TCategoria);
begin
  FCategoriaDAO.Inserir(ACategoria);
end;

function TCategoriaController.ListarTodos(
  FiltroDescricao: string): TArray<TCategoria>;
begin
  Result := FCategoriaDAO.ListarTodos(FiltroDescricao).ToArray;
end;

procedure TCategoriaController.Atualizar(ACategoria: TCategoria);
begin
  FCategoriaDAO.Atualizar(ACategoria);
end;

procedure TCategoriaController.Excluir(ID: Integer);
begin
  FCategoriaDAO.Excluir(ID);
end;

function TCategoriaController.BuscarPorID(ID: Integer): TCategoria;
begin
  Result := FCategoriaDAO.BuscarPorID(ID);
end;



end.
