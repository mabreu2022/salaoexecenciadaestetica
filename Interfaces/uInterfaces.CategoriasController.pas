unit uInterfaces.CategoriasController;

interface

uses
  uModel.Categoria;

type
  ICategoriaController = interface
    ['{A1B2C3D4-E5F6-47A8-9B0C-000000000001}']
    procedure Inserir(ACategoria: TCategoria);
    procedure Atualizar(ACategoria: TCategoria);
    procedure Excluir(ID: Integer);
    function BuscarPorID(ID: Integer): TCategoria;
    function ListarTodos(FiltroDescricao: string = ''): TArray<TCategoria>;
  end;

implementation

end.
