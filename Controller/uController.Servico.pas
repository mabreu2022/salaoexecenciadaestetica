unit uController.Servico;

interface

uses
  uInterfaces.ServicoController,
  uModel.Servico,
  uDAO.Servico,
  System.Generics.Collections;

type
  TServicoController = class(TInterfacedObject, IServicoController)
  private
    FDAO: TServicoDAO;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Inserir(AServico: TServico);
    procedure Atualizar(AServico: TServico);
    procedure Excluir(ID: Integer);
    function ListarTodos(FiltroDescricao: string = ''): TArray<TServico>;
  end;

implementation

{ TServicoController }

constructor TServicoController.Create;
begin
  inherited;
  FDAO := TServicoDAO.Create;
end;

destructor TServicoController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

procedure TServicoController.Inserir(AServico: TServico);
begin
  FDAO.Inserir(AServico);
end;

procedure TServicoController.Atualizar(AServico: TServico);
begin
  FDAO.Atualizar(AServico);
end;

procedure TServicoController.Excluir(ID: Integer);
begin
  FDAO.Excluir(ID);
end;

function TServicoController.ListarTodos(FiltroDescricao: string):
TArray<TServico>;
begin
  Result := FDAO.ListarTodos(FiltroDescricao).ToArray;
end;

end.
