unit uModel.Procedimento;

interface

uses
  System.SysUtils, System.Classes;

type
  TProcedimento = class
  private
    FIDPROCEDIMENTO: Integer;
    FIDCLIENTE: Integer;
    FIDSERVICO: Integer;
    FDATAHORA: TDateTime;
    FOBSERVACOES: TStringStream;
    FCONCLUIDO: Boolean;
    FATIVO: String;
    procedure SetATIVO(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;

    property IDPROCEDIMENTO: Integer read FIDPROCEDIMENTO write FIDPROCEDIMENTO;
    property IDCLIENTE: Integer read FIDCLIENTE write FIDCLIENTE;
    property IDSERVICO: Integer read FIDSERVICO write FIDSERVICO;
    property DATAHORA: TDateTime read FDATAHORA write FDATAHORA;
    property OBSERVACOES: TStringStream read FOBSERVACOES write FOBSERVACOES;
    property CONCLUIDO: Boolean read FCONCLUIDO write FCONCLUIDO;
    property ATIVO: String read FATIVO write SetATIVO;
  end;

implementation

{ TProcedimento }

constructor TProcedimento.Create;
begin
  FOBSERVACOES := TStringStream.Create;
end;

destructor TProcedimento.Destroy;
begin
  FOBSERVACOES.Free;
  inherited;
end;

procedure TProcedimento.SetATIVO(const Value: String);
begin
  FATIVO := Value;
end;

end.
