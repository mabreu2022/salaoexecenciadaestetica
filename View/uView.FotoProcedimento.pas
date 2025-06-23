unit uView.FotoProcedimento;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.DBCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtDlgs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uModel.FotoProcedimento,
  uController.FotoProcedimento,
  uInterfaces.FotoProcedimentoController,
  Vcl.Grids,
  Vcl.DBGrids,
  uView.FotoAmpliada;

type
  TFrmFotoProcedimento = class(TForm)
    Panel1: TPanel;
    btnSalvar: TBitBtn;
    btnNovo: TBitBtn;
    btnEditar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    DBNavigator1: TDBNavigator;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Label3: TLabel;
    edtPesquisar: TEdit;
    btnPesquisar: TBitBtn;
    FlowPanel1: TFlowPanel;
    Panel3: TPanel;
    lblProcedimento: TLabel;
    cbcliente: TDBLookupComboBox;
    lblCliente: TLabel;
    cbProcedimento: TDBLookupComboBox;
    OpenPictureDialog1: TOpenPictureDialog;
    dsClientes: TDataSource;
    QryClientes: TFDQuery;
    QryProcedimentos: TFDQuery;
    dsProcedimentos: TDataSource;
    QryFotos: TFDQuery;
    dsFotos: TDataSource;
    dbgPesquisar: TDBGrid;
    qryPesquisa: TFDQuery;
    dsPesquisa: TDataSource;
    dtInicial: TDateTimePicker;
    dtFinal: TDateTimePicker;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    cbCategoria: TDBLookupComboBox;
    lblCategoria: TLabel;
    qryCategorias: TFDQuery;
    dsCategorias: TDataSource;
    memCategorias: TFDMemTable;
    dsMemCategorias: TDataSource;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    ControllerFoto: IFotoProcedimentoController;
    procedure AdicionarMiniatura(Foto: TFotoProcedimento);
    procedure ImgMiniaturaDblClick(Sender: TObject);


  public
    { Public declarations }
  end;

var
  FrmFotoProcedimento: TFrmFotoProcedimento;

implementation

{$R *.dfm}

uses uDao.Dm;

procedure TFrmFotoProcedimento.btnEditarClick(Sender: TObject);
begin
  qryFotos.Edit;
end;


procedure TFrmFotoProcedimento.AdicionarMiniatura(Foto: TFotoProcedimento);
var
  Img: TImage;
begin
  Img := TImage.Create(FlowPanel1);
  Img.Parent := FlowPanel1;
  Img.Width := 100;
  Img.Height := 100;
  Img.Stretch := True;
  Img.Proportional := True;
  Img.Align := alNone;
  Img.Margins.SetBounds(5, 5, 5, 5);
  Img.Cursor := crHandPoint;

  Foto.IMAGEM.Position := 0;
  Img.Picture.LoadFromStream(Foto.IMAGEM);

  Img.Tag := Foto.IDFOTO;

  Img.OnDblClick := ImgMiniaturaDblClick;


end;

procedure TFrmFotoProcedimento.btnApagarClick(Sender: TObject);
begin
  if not qryFotos.IsEmpty and
     (MessageDlg('Excluir esta foto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    qryFotos.Delete;
  end;

end;

procedure TFrmFotoProcedimento.btnNovoClick(Sender: TObject);
begin
  qryFotos.Append;
  qryFotos.FieldByName('IDPROCEDIMENTO').AsInteger := cbProcedimento.KeyValue;
  qryFotos.FieldByName('DATAINCLUSAO').AsDateTime := Now;
end;

procedure TFrmFotoProcedimento.btnPesquisarClick(Sender: TObject);
var
  FiltroTexto: string;
begin
  qryPesquisa.Close;

  // 🔤 Filtro de nome do cliente ou observações
  FiltroTexto := Trim(edtPesquisar.Text);
  if FiltroTexto = '' then
    qryPesquisa.ParamByName('FILTRO').Clear
  else
    qryPesquisa.ParamByName('FILTRO').AsString := '%' + FiltroTexto + '%';

  // 🗓️ Intervalo de datas (de...até 23:59:59 do dia final)
  qryPesquisa.ParamByName('DATAINI').AsDateTime := dtInicial.Date;
  qryPesquisa.ParamByName('DATAFIM').AsDateTime := dtFinal.Date + EncodeTime(23, 59, 59, 999);

  // 🏷️ Filtro por categoria, opcional
  if VarIsNull(cbCategoria.KeyValue) then
    qryPesquisa.ParamByName('IDCATEGORIA').Clear
  else
    qryPesquisa.ParamByName('IDCATEGORIA').AsInteger := cbCategoria.KeyValue;

  qryPesquisa.Open;

end;

procedure TFrmFotoProcedimento.btnSalvarClick(Sender: TObject);
var
  Foto: TFotoProcedimento;
begin
  // Verificações básicas
  if cbCliente.KeyValue = Null then
  begin
    ShowMessage('Selecione um cliente.');
    Exit;
  end;

  if cbProcedimento.KeyValue = Null then
  begin
    ShowMessage('Selecione um procedimento.');
    Exit;
  end;

  if not OpenPictureDialog1.Execute then
    Exit;

  Foto := TFotoProcedimento.Create;
  try
    Foto.IDPROCEDIMENTO := cbProcedimento.KeyValue;
    Foto.CAMINHOARQUIVO := OpenPictureDialog1.FileName;
    Foto.DATAINCLUSAO := Now;
    Foto.IMAGEM.LoadFromFile(Foto.CAMINHOARQUIVO);

    ControllerFoto.Inserir(Foto);         // DAO/controller grava a foto no banco
    AdicionarMiniatura(Foto);            // Exibe a miniatura no FlowPanel
    ShowMessage('Foto salva com sucesso!');
  finally
    Foto.Free;
  end;


end;

procedure TFrmFotoProcedimento.FormCreate(Sender: TObject);
begin
  // Instancia o Controller
  ControllerFoto := TFotoProcedimentoController.Create;

  // Abre a query real com os dados da tabela CATEGORIAS
  qryCategorias.Open;

  // Prepara estrutura do TFDMemTable para usar como fonte do cbCategoria
  memCategorias.Close;
  memCategorias.FieldDefs.Clear;
  memCategorias.FieldDefs.Add('IDCATEGORIA', ftInteger);
  memCategorias.FieldDefs.Add('DESCRICAO', ftString, 100);
  memCategorias.CreateDataSet;

  // Adiciona a opção "Todas as categorias"
  memCategorias.AppendRecord([Null, '(Todas as categorias)']);

  // Copia as categorias reais da qryCategorias para o memCategorias
  qryCategorias.First;
  while not qryCategorias.Eof do
  begin
    memCategorias.AppendRecord([
      qryCategorias.FieldByName('IDCATEGORIA').AsInteger,
      qryCategorias.FieldByName('DESCRICAO').AsString
    ]);
    qryCategorias.Next;
  end;

  memCategorias.First;

  // Configura a combo para usar a nova fonte combinada
  cbCategoria.ListSource := dsMemCategorias;
  cbCategoria.KeyField := 'IDCATEGORIA';
  cbCategoria.ListField := 'DESCRICAO';


end;

procedure TFrmFotoProcedimento.ImgMiniaturaDblClick(Sender: TObject);
begin
    TFrmFotoAmpliada.ExibirImagem(TImage(Sender).Picture);
end;

end.
