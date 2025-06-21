unit uModel.Categoria;

interface

type
  TCategoria = class
  private
    FIDCATEGORIA: Integer;
    FDESCRICAO: string;
  public
    property IDCATEGORIA: Integer read FIDCATEGORIA write FIDCATEGORIA;
    property DESCRICAO: string read FDESCRICAO write FDESCRICAO;
  end;

implementation

end.
