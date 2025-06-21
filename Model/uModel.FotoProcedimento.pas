unit uModel.FotoProcedimento;

interface

uses
  System.Classes, System.SysUtils;

type
  TFotoProcedimento = class
  private
    FIDFOTO: Integer;
    FIDPROCEDIMENTO: Integer;
    FCAMINHOARQUIVO: string;
    FIMAGEM: TMemoryStream;
    FDATAINCLUSAO: TDateTime;
  public
    constructor Create;
    destructor Destroy; override;

    property IDFOTO: Integer read FIDFOTO write FIDFOTO;
    property IDPROCEDIMENTO: Integer read FIDPROCEDIMENTO write FIDPROCEDIMENTO;
    property CAMINHOARQUIVO: string read FCAMINHOARQUIVO write FCAMINHOARQUIVO;
    property IMAGEM: TMemoryStream read FIMAGEM write FIMAGEM;
    property DATAINCLUSAO: TDateTime read FDATAINCLUSAO write FDATAINCLUSAO;
  end;

implementation

{ TFotoProcedimento }

constructor TFotoProcedimento.Create;
begin
  FIMAGEM := TMemoryStream.Create;
end;

destructor TFotoProcedimento.Destroy;
begin
  FreeAndNil(FIMAGEM);
  inherited;
end;

end.
