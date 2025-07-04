﻿unit uView.CadastroCategorias;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.DBCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uModel.Categoria,
  uInterfaces.CategoriasController,
  uController.Categoria,
  System.UITypes;

type
  TFrmCadastroCategorias = class(TForm)
    pnlBotoes: TPanel;
    btnSalvar: TBitBtn;
    btnNovo: TBitBtn;
    BitBtn1: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    DBNavigator1: TDBNavigator;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    grdCategorias: TDBGrid;
    pnlTopo: TPanel;
    Label3: TLabel;
    edtPesquisa: TEdit;
    btnPesquisar: TBitBtn;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    mtCategorias: TFDMemTable;
    dsCategorias: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure grdCategoriasCellClick(Column: TColumn);
    procedure BitBtn1Click(Sender: TObject);
    procedure grdCategoriasDblClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }

    FCodigoSelecionado: Integer;

    procedure LimparCampos;
    procedure PreencherGrid;
    procedure PreencherCamposDaSelecao;
    procedure ConfigurarCamposMemTable;

  public
    { Public declarations }
  end;

var
  FrmCadastroCategorias: TFrmCadastroCategorias;

implementation

{$R *.dfm}

procedure TFrmCadastroCategorias.BitBtn1Click(Sender: TObject);
begin
  if mtCategorias.IsEmpty then
  begin
    ShowMessage('Selecione uma categoria na lista para editar.');
    Exit;
  end;

  PreencherCamposDaSelecao;

end;

procedure TFrmCadastroCategorias.btnApagarClick(Sender: TObject);
var
  Controller: ICategoriaController;
begin

  if FCodigoSelecionado = 0 then Exit;

  if MessageDlg('Deseja excluir esta categoria?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Controller := TCategoriaController.Create;
    Controller.Excluir(FCodigoSelecionado);
    PreencherGrid;
    LimparCampos;
  end;

end;

procedure TFrmCadastroCategorias.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadastroCategorias.btnNovoClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TFrmCadastroCategorias.btnPesquisarClick(Sender: TObject);
var
  Controller: ICategoriaController;
  Lista: TArray<TCategoria>;
  Cat: TCategoria;
  Filtro: string;
begin

  Filtro := Trim(edtPesquisa.Text);
  Controller := TCategoriaController.Create;
  Lista := Controller.ListarTodos(Filtro);

  ConfigurarCamposMemTable;

  for Cat in Lista do
  begin
    mtCategorias.Append;
    mtCategorias.FieldByName('IDCATEGORIA').AsInteger := Cat.IDCATEGORIA;
    mtCategorias.FieldByName('DESCRICAO').AsString := Cat.DESCRICAO;
    mtCategorias.Post;
  end;

  mtCategorias.First;

end;

procedure TFrmCadastroCategorias.btnSalvarClick(Sender: TObject);
var
  Controller: ICategoriaController;
  Categoria: TCategoria;
begin

  Controller := TCategoriaController.Create;
  Categoria := TCategoria.Create;
  try
    Categoria.DESCRICAO := edtDescricao.Text;

    if FCodigoSelecionado = 0 then
      Controller.Inserir(Categoria)
    else
    begin
      Categoria.IDCATEGORIA := FCodigoSelecionado;
      Controller.Atualizar(Categoria);
    end;

    PreencherGrid;
    LimparCampos;
  finally
    Categoria.Free;
  end;


end;

procedure TFrmCadastroCategorias.ConfigurarCamposMemTable;
begin

  mtCategorias.Close;
  mtCategorias.FieldDefs.Clear;

  mtCategorias.FieldDefs.Add('IDCATEGORIA', ftInteger);
  mtCategorias.FieldDefs.Add('DESCRICAO', ftString, 100);

  mtCategorias.CreateDataSet;
  mtCategorias.Open;

end;

procedure TFrmCadastroCategorias.FormShow(Sender: TObject);
begin
  PreencherGrid;
  LimparCampos;
end;

procedure TFrmCadastroCategorias.grdCategoriasCellClick(Column: TColumn);
begin
  PreencherCamposDaSelecao;
end;

procedure TFrmCadastroCategorias.grdCategoriasDblClick(Sender: TObject);
begin
  PreencherCamposDaSelecao;
end;

procedure TFrmCadastroCategorias.LimparCampos;
begin
  edtDescricao.Clear;
  FCodigoSelecionado := 0;

  if edtDescricao.CanFocus then
    edtDescricao.SetFocus;

  PageControl1.ActivePage := TabSheet1;

end;

procedure TFrmCadastroCategorias.PreencherCamposDaSelecao;
begin
  if not mtCategorias.IsEmpty then
  begin
    FCodigoSelecionado := mtCategorias.FieldByName('IDCATEGORIA').AsInteger;
    edtDescricao.Text := mtCategorias.FieldByName('DESCRICAO').AsString;
  end;
end;

procedure TFrmCadastroCategorias.PreencherGrid;
var
  Controller: ICategoriaController;
  Lista: TArray<TCategoria>;
  Cat: TCategoria;
begin

  Controller := TCategoriaController.Create;
  Lista := Controller.ListarTodos;

  mtCategorias.Close;
  mtCategorias.FieldDefs.Clear;
  mtCategorias.FieldDefs.Add('IDCATEGORIA', ftInteger);
  mtCategorias.FieldDefs.Add('DESCRICAO', ftString, 100);
  mtCategorias.CreateDataSet;
  mtCategorias.Open;

  for Cat in Lista do
  begin
    mtCategorias.Append;
    mtCategorias.FieldByName('IDCATEGORIA').AsInteger := Cat.IDCATEGORIA;
    mtCategorias.FieldByName('DESCRICAO').AsString := Cat.DESCRICAO;
    mtCategorias.Post;
  end;

end;

end.
