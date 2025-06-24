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
    pnlBotoesDasFotos: TPanel;
    btnAdicionarNovaFoto: TBitBtn;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure cbProcedimentoCloseUp(Sender: TObject);
    procedure btnAdicionarNovaFotoClick(Sender: TObject);
    procedure cbclienteCloseUp(Sender: TObject);
    procedure dbgPesquisarDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgPesquisarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgPesquisarMouseLeave(Sender: TObject);
    procedure cbProcedimentoEnter(Sender: TObject);
  private
    { Private declarations }
    ControllerFoto: IFotoProcedimentoController;
    FHoveredRow: Integer;
    FMouseY: Integer; // Guarda a posição vertical do mouse na grid
    procedure AdicionarMiniatura(Foto: TFotoProcedimento);
    procedure ImgMiniaturaDblClick(Sender: TObject);
    procedure CarregarMiniaturasNoFlowPanel;


  public
    { Public declarations }
  end;

var
  FrmFotoProcedimento: TFrmFotoProcedimento;

implementation

{$R *.dfm}

uses uDao.Dm, uView.CadastroDeProcedimento;

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

procedure TFrmFotoProcedimento.btnAdicionarNovaFotoClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then

  QryFotos.Append;
  QryFotos.FieldByName('IDPROCEDIMENTO').AsInteger := cbProcedimento.KeyValue;
  QryFotos.FieldByName('CAMINHOARQUIVO').AsString := OpenPictureDialog1.FileName;

  QryFotos.CreateBlobStream(QryFotos.FieldByName('IMAGEM'), bmWrite)
    .CopyFrom(TFileStream.Create(OpenPictureDialog1.FileName, fmOpenRead), 0);

  QryFotos.Post;

  CarregarMiniaturasNoFlowPanel;

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
//begin
// if (not Assigned(cbProcedimento.ListSource)) or
//     (cbProcedimento.ListSource.DataSet.IsEmpty) or
//     VarIsNull(cbProcedimento.KeyValue) then
//  begin
//    ShowMessage('Selecione um procedimento válido antes de adicionar uma foto.');
//    Exit;
//  end;
//
//  qryFotos.Append;
//  qryFotos.FieldByName('IDPROCEDIMENTO').AsInteger := cbProcedimento.KeyValue;
//  qryFotos.FieldByName('DATAINCLUSAO').AsDateTime := Now;
 var
  IDCliente: Integer;
begin
  if VarIsNull(cbCliente.KeyValue) then
  begin
    ShowMessage('Selecione um cliente antes de cadastrar um procedimento.');
    Exit;
  end;

  IDCliente := cbCliente.KeyValue;

  // Abrir o form de cadastro de procedimentos
  Application.CreateForm(TFrmCadastroProcedimento, FrmCadastroProcedimento);
  try
    FrmCadastroProcedimento.DefinirCliente(IDCliente); // se houver esse método
    FrmCadastroProcedimento.ShowModal;
  finally
    FrmCadastroProcedimento.Free;
  end;

  // Recarrega os procedimentos após o cadastro
  cbClienteCloseUp(cbCliente);


end;

procedure TFrmFotoProcedimento.btnPesquisarClick(Sender: TObject);
var
  FiltroTexto: string;
begin
  qryPesquisa.Close;

  FiltroTexto := Trim(edtPesquisar.Text);
  if FiltroTexto = '' then
    qryPesquisa.ParamByName('FILTRO').Clear
  else
    qryPesquisa.ParamByName('FILTRO').AsString := '%' + FiltroTexto + '%';

  qryPesquisa.ParamByName('DATAINI').AsDateTime := dtInicial.Date;
  qryPesquisa.ParamByName('DATAFIM').AsDateTime := dtFinal.Date + EncodeTime(23, 59, 59, 999);

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

  if VarIsNull(cbCliente.KeyValue) then
  begin
    ShowMessage('Selecione um cliente.');
    Exit;
  end;

  if VarIsNull(cbProcedimento.KeyValue) then
  begin
    ShowMessage('Selecione um procedimento.');
    Exit;
  end;

  if not OpenPictureDialog1.Execute then
    Exit;

  Foto := TFotoProcedimento.Create;
  try
    Foto.IDPROCEDIMENTO := cbProcedimento.KeyValue;
    Foto.DATAINCLUSAO := Now;
    Foto.CarregarImagemDeArquivo(OpenPictureDialog1.FileName);

    ControllerFoto.Inserir(Foto);
    AdicionarMiniatura(Foto);
    ShowMessage('📸 Foto salva com sucesso!');
  finally
    Foto.Free;
  end;

end;

procedure TFrmFotoProcedimento.CarregarMiniaturasNoFlowPanel;
var
  img: TImage;
  stream: TStream;
begin
  FlowPanel1.DestroyComponents;

  QryFotos.First;
  while not QryFotos.Eof do
  begin
    img := TImage.Create(FlowPanel1);
    img.Parent := FlowPanel1;
    img.Width := 100;
    img.Height := 100;
    img.Stretch := True;
    img.Proportional := True;

    stream := QryFotos.CreateBlobStream(QryFotos.FieldByName('IMAGEM'), bmRead);
    try
      img.Picture.LoadFromStream(stream);
    finally
      stream.Free;
    end;

    QryFotos.Next;
  end;


end;

procedure TFrmFotoProcedimento.cbclienteCloseUp(Sender: TObject);
var
  Controller: IFotoProcedimentoController;
begin
  if VarIsNull(cbCliente.KeyValue) then
  begin
    cbProcedimento.KeyValue := Null;
    cbProcedimento.ListSource := nil;

    QryFotos.Close;
    FlowPanel1.DestroyComponents;
    Exit;
  end;

  Controller := TFotoProcedimentoController.Create;

  // Verifica se o cliente tem procedimentos
  if not Controller.ClientePossuiProcedimentos(cbCliente.KeyValue) then
  begin
    cbProcedimento.ListSource := nil;
    cbProcedimento.KeyValue := Null;
    QryFotos.Close;
    FlowPanel1.DestroyComponents;

    if MessageDlg('Este cliente não possui procedimentos ativos.' + sLineBreak +
                  'Deseja cadastrar um novo agora?',
                  mtInformation, [mbYes, mbNo], 0) = mrYes then
    begin
      btnNovo.Click;  //codigo do mesmo ainda a ser definido
    end;

    Exit;
  end;

  cbProcedimento.ListSource := Controller.ListarProcedimentosDoCliente(cbCliente.KeyValue);
  cbProcedimento.KeyValue := Null;

  QryFotos.Close;
  FlowPanel1.DestroyComponents;

end;

procedure TFrmFotoProcedimento.cbProcedimentoCloseUp(Sender: TObject);
begin
  QryFotos.Close;
  QryFotos.ParamByName('IDPROCEDIMENTO').AsInteger := cbProcedimento.KeyValue;
  QryFotos.Open;

  CarregarMiniaturasNoFlowPanel;

end;

procedure TFrmFotoProcedimento.cbProcedimentoEnter(Sender: TObject);
begin
  if not Assigned(cbProcedimento.ListSource) then
    Exit;

  if cbProcedimento.ListSource.DataSet.IsEmpty then
  begin
    if MessageDlg(
      'Este cliente não possui procedimentos cadastrados.' + sLineBreak +
      'Deseja criar um novo agora?',
      mtInformation, [mbYes, mbNo], 0
    ) = mrYes then
    begin
      btnNovoClick(sender);
    end;

    Abort;
  end;

end;

procedure TFrmFotoProcedimento.dbgPesquisarDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const
  CorLinhaPar = $00F0F0F0;
  CorLinhaHover = $00D8E8FF;
var
  Grid: TDBGrid;
  RecNo: Integer;
  LinhaAtualTop, LinhaAtualBottom: Integer;
  EstaLinhaEhHover: Boolean;
begin
  Grid := Sender as TDBGrid;
  RecNo := Grid.DataSource.DataSet.RecNo;

  LinhaAtualTop := Rect.Top;
  LinhaAtualBottom := Rect.Bottom;

  EstaLinhaEhHover := (FMouseY >= LinhaAtualTop) and (FMouseY < LinhaAtualBottom);

  if gdSelected in State then
  begin
    Grid.Canvas.Brush.Color := clHighlight;
    Grid.Canvas.Font.Color := clHighlightText;
  end
  else if EstaLinhaEhHover then
  begin
    Grid.Canvas.Brush.Color := CorLinhaHover;
    Grid.Canvas.Font.Color := clBlack;
  end
  else
  begin
    if RecNo mod 2 = 0 then
      Grid.Canvas.Brush.Color := CorLinhaPar
    else
      Grid.Canvas.Brush.Color := clWhite;
    Grid.Canvas.Font.Color := clBlack;
  end;

  Grid.Canvas.FillRect(Rect);
  Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TFrmFotoProcedimento.dbgPesquisarMouseLeave(Sender: TObject);
begin
  FMouseY := -1;
  (Sender as TDBGrid).Invalidate;

end;

procedure TFrmFotoProcedimento.dbgPesquisarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if FMouseY <> Y then
  begin
    FMouseY := Y;
    (Sender as TDBGrid).Invalidate;
  end;

end;

procedure TFrmFotoProcedimento.FormCreate(Sender: TObject);
begin
  FHoveredRow := -1;
  FMouseY := -1;

  ControllerFoto := TFotoProcedimentoController.Create;

  qryCategorias.Open;

  memCategorias.Close;
  memCategorias.FieldDefs.Clear;
  memCategorias.FieldDefs.Add('IDCATEGORIA', ftInteger);
  memCategorias.FieldDefs.Add('DESCRICAO', ftString, 100);
  memCategorias.CreateDataSet;

  memCategorias.AppendRecord([Null, '(Todas as categorias)']);

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

  cbCategoria.ListSource := dsMemCategorias;
  cbCategoria.KeyField := 'IDCATEGORIA';
  cbCategoria.ListField := 'DESCRICAO';

  QryClientes.Open;

end;

procedure TFrmFotoProcedimento.ImgMiniaturaDblClick(Sender: TObject);
begin
    TFrmFotoAmpliada.ExibirImagem(TImage(Sender).Picture);
end;

end.
