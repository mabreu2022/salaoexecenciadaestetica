unit uModel.Servico;

interface

type
  TServico = class
  private
    FIDSERVICO: Integer;
    FNOME: string;
    FPRECO: Double;
    FDURACAOMINUTOS: Integer;
    FIDCATEGORIA: Integer;
  public
    property IDSERVICO: Integer read FIDSERVICO write FIDSERVICO;
    property NOME: string read FNOME write FNOME;
    property PRECO: Double read FPRECO write FPRECO;
    property DURACAOMINUTOS: Integer read FDURACAOMINUTOS write FDURACAOMINUTOS;
    property IDCATEGORIA: Integer read FIDCATEGORIA write FIDCATEGORIA;
  end;

implementation

end.
