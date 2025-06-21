unit uInterfaces.FotoProcedimentoController;

interface

uses
  uModel.FotoProcedimento;

type
  IFotoProcedimentoController = interface
    ['{A1B2C3D4-E5F6-47A8-9B0C-000000000002}']
    procedure Inserir(AFoto: TFotoProcedimento);
    procedure Excluir(ID: Integer);
    function ListarPorProcedimento(IDProcedimento: Integer): TArray<TFotoProcedimento>;
  end;

implementation

end.
