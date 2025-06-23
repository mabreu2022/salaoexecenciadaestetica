unit uController.FotoProcedimento;

interface

uses
  uInterfaces.FotoProcedimentoController,
  uModel.FotoProcedimento,
  uDAO.FotoProcedimento,
  System.Generics.Collections;

type
  TFotoProcedimentoController = class(TInterfacedObject, IFotoProcedimentoController)
  private
    FDAO: TFotoProcedimentoDAO;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Inserir(AFoto: TFotoProcedimento);
    procedure Excluir(ID: Integer);
    function ListarPorProcedimento(IDProcedimento: Integer): TArray<TFotoProcedimento>;

  end;

implementation

{ TFotoProcedimentoController }

constructor TFotoProcedimentoController.Create;
begin
  FDAO := TFotoProcedimentoDAO.Create;
end;

destructor TFotoProcedimentoController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

procedure TFotoProcedimentoController.Inserir(AFoto: TFotoProcedimento);
begin
  FDAO.Inserir(AFoto);
end;

procedure TFotoProcedimentoController.Excluir(ID: Integer);
begin
  FDAO.Excluir(ID);
end;

function TFotoProcedimentoController.ListarPorProcedimento(IDProcedimento: Integer): TArray<TFotoProcedimento>;
begin
  Result := FDAO.ListarPorProcedimento(IDProcedimento).ToArray;
end;

end.
