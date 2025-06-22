unit uView.CadastroDeServicos;

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
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.DBCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Vcl.Mask,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.Samples.Spin,
  Vcl.Grids,
  Vcl.DBGrids,
  uModel.Categoria,
  uInterfaces.CategoriasController,
  uController.Categoria,
  uController.Servico,
  uModel.Servico,
  uInterfaces.ServicoController;

type
  TFrmCadastrodeServicos = class(TForm)
    PageControl1: TPageControl;
    pnlBotoes: TPanel;
    btnSalvar: TBitBtn;
    btnNovo: TBitBtn;
    BitBtn1: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    DBNavigator1: TDBNavigator;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pnlTopo: TPanel;
    Label3: TLabel;
    edtPesquisa: TEdit;
    btnPesquisar: TBitBtn;
    DBGrid1: TDBGrid;
    edtNome: TEdit;
    spnDuracao: TSpinEdit;
    cbCategoria: TDBLookupComboBox;
    mtServicos: TFDMemTable;
    mtCategorias: TFDMemTable;
    edtPreco: TMaskEdit;
    dsCategorias: TDataSource;
    dsServicos: TDataSource;
    edtIDServico: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastrodeServicos: TFrmCadastrodeServicos;

implementation

{$R *.dfm}

procedure TFrmCadastrodeServicos.BitBtn1Click(Sender: TObject);
begin
  if mtServicos.IsEmpty then
  begin
    ShowMessage('Nenhum serviço selecionado.');
    Exit;
  end;

  edtIDServico.Text := mtServicos.FieldByName('IDSERVICO').AsString;
  edtNome.Text := mtServicos.FieldByName('NOME').AsString;
  edtPreco.Text := FormatFloat('0.00', mtServicos.FieldByName('PRECO').AsFloat);
  spnDuracao.Value := mtServicos.FieldByName('DURACAOMINUTOS').AsInteger;
  cbCategoria.KeyValue := mtServicos.FieldByName('IDCATEGORIA').AsInteger;

end;

procedure TFrmCadastrodeServicos.btnApagarClick(Sender: TObject);
var
  ID: Integer;
  Controller: IServicoController;
begin
  if mtServicos.IsEmpty then
  begin
    ShowMessage('Nenhum serviço selecionado para excluir.');
    Exit;
  end;

  if MessageDlg('Confirma a exclusão do serviço?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ID := mtServicos.FieldByName('IDSERVICO').AsInteger;
    Controller := TServicoController.Create;
    Controller.Excluir(ID);
    ShowMessage('Serviço excluído com sucesso.');
    btnPesquisarClick(nil); // Atualiza a lista
  end;

end;

procedure TFrmCadastrodeServicos.btnNovoClick(Sender: TObject);
begin
  edtIDServico.Text := '';
  edtNome.Clear;
  edtPreco.Clear;
  spnDuracao.Value := 0;
  cbCategoria.KeyValue := null;

  edtNome.SetFocus;

end;

procedure TFrmCadastrodeServicos.btnPesquisarClick(Sender: TObject);
var
  Controller: IServicoController;
  Lista: TArray<TServico>;
  Servico: TServico;
begin
  mtServicos.Close;
  mtServicos.FieldDefs.Clear;
  mtServicos.FieldDefs.Add('IDSERVICO', ftInteger);
  mtServicos.FieldDefs.Add('NOME', ftString, 100);
  mtServicos.FieldDefs.Add('PRECO', ftCurrency);
  mtServicos.FieldDefs.Add('DURACAOMINUTOS', ftInteger);
  mtServicos.FieldDefs.Add('IDCATEGORIA', ftInteger);
  mtServicos.CreateDataSet;

  Controller := TServicoController.Create;
  Lista := Controller.ListarTodos(Trim(edtPesquisa.Text));

  for Servico in Lista do
  begin
    mtServicos.Append;
    mtServicos.FieldByName('IDSERVICO').AsInteger := Servico.IDSERVICO;
    mtServicos.FieldByName('NOME').AsString := Servico.NOME;
    mtServicos.FieldByName('PRECO').AsCurrency := Servico.PRECO;
    mtServicos.FieldByName('DURACAOMINUTOS').AsInteger := Servico.DURACAOMINUTOS;
    mtServicos.FieldByName('IDCATEGORIA').AsInteger := Servico.IDCATEGORIA;
    mtServicos.Post;
  end;


end;

procedure TFrmCadastrodeServicos.btnSalvarClick(Sender: TObject);
var
  Servico: TServico;
  Controller: IServicoController;
begin
  // Validação simples
  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('Informe o nome do serviço.');
    edtNome.SetFocus;
    Exit;
  end;

  if edtPreco.Text = '' then
  begin
    ShowMessage('Informe o preço do serviço.');
    edtPreco.SetFocus;
    Exit;
  end;

  if cbCategoria.KeyValue = null then
  begin
    ShowMessage('Selecione uma categoria.');
    cbCategoria.SetFocus;
    Exit;
  end;

  // Cria e preenche a entidade
  Servico := TServico.Create;
  Controller := TServicoController.Create;
  try
    Servico.NOME := edtNome.Text;
    Servico.PRECO := StrToCurrDef(edtPreco.Text, 0);
    Servico.DURACAOMINUTOS := spnDuracao.Value;
    Servico.IDCATEGORIA := cbCategoria.KeyValue;

    // Aqui você pode definir se é inserção ou edição:
    // if editando then Controller.Atualizar(Servico)
    // else
    Controller.Inserir(Servico);

    ShowMessage('Serviço salvo com sucesso!');
  finally
    Servico.Free;
  end;

end;

procedure TFrmCadastrodeServicos.DBGrid1DblClick(Sender: TObject);
begin
  if mtServicos.IsEmpty then
    Exit;

  edtIDServico.Text := mtServicos.FieldByName('IDSERVICO').AsString;
  edtNome.Text := mtServicos.FieldByName('NOME').AsString;
  edtPreco.Text := FormatFloat('0.00', mtServicos.FieldByName('PRECO').AsFloat);
  spnDuracao.Value := mtServicos.FieldByName('DURACAOMINUTOS').AsInteger;
  cbCategoria.KeyValue := mtServicos.FieldByName('IDCATEGORIA').AsInteger;

  edtNome.SetFocus;

end;

procedure TFrmCadastrodeServicos.FormShow(Sender: TObject);
var
  ControllerCat: ICategoriaController;
  ListaCat: TArray<TCategoria>;
  Cat: TCategoria;
begin
  // Configura mtCategorias
  mtCategorias.Close;
  mtCategorias.FieldDefs.Clear;
  mtCategorias.FieldDefs.Add('IDCATEGORIA', ftInteger);
  mtCategorias.FieldDefs.Add('DESCRICAO', ftString, 100);
  mtCategorias.CreateDataSet;

  // Preenche categorias
  ControllerCat := TCategoriaController.Create;
  ListaCat := ControllerCat.ListarTodos;

  for Cat in ListaCat do
  begin
    mtCategorias.Append;
    mtCategorias.FieldByName('IDCATEGORIA').AsInteger := Cat.IDCATEGORIA;
    mtCategorias.FieldByName('DESCRICAO').AsString := Cat.DESCRICAO;
    mtCategorias.Post;
  end;

  // Configura mtServicos
  mtServicos.Close;
  mtServicos.FieldDefs.Clear;
  mtServicos.FieldDefs.Add('IDSERVICO', ftInteger);
  mtServicos.FieldDefs.Add('NOME', ftString, 100);
  mtServicos.FieldDefs.Add('PRECO', ftCurrency);
  mtServicos.FieldDefs.Add('DURACAOMINUTOS', ftInteger);
  mtServicos.FieldDefs.Add('IDCATEGORIA', ftInteger);
  mtServicos.CreateDataSet;

end;

end.
